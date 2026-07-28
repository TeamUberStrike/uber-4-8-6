using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MenuPageManager : MonoBehaviour
{
	private IDictionary<PageType, PageScene> _pageByPageType;

	private static PageType _currentPageType;

	private EaseType _transitionType = EaseType.InOut;

	private int _lastScreenWidth;

	private int _lastScreenHeight;

	public static MenuPageManager Instance { get; private set; }

	public float LeftAreaGUIOffset { get; set; }

	private void Awake()
	{
		_pageByPageType = new Dictionary<PageType, PageScene>();
	}

	private void OnEnable()
	{
		Instance = this;
		EventHandler.Global.AddListener<GlobalEvents.ScreenResolutionChanged>(OnScreenResolutionEvent);
	}

	private void OnDisable()
	{
		Instance = null;
		EventHandler.Global.RemoveListener<GlobalEvents.ScreenResolutionChanged>(OnScreenResolutionEvent);
	}

	private void Start()
	{
		// Diagnostic: scan children for PageScene MBs. If 0, the GameObject
		// hierarchy under MenuPageManager isn't what AssetRipper emitted.
		PageScene[] componentsInChildren = GetComponentsInChildren<PageScene>(true);
		Debug.LogWarning("[MenuPageManager] Start() — found " + componentsInChildren.Length + " PageScene component(s) under '" + base.name + "' (Application.loadedLevelName='" + Application.loadedLevelName + "')");

		if (componentsInChildren.Length == 0)
		{
			// Fall back to a scene-wide scan (FindObjectsOfType) so PageScene
			// MBs placed under sibling GameObjects still register.
			PageScene[] sceneWide = (PageScene[])Resources.FindObjectsOfTypeAll(typeof(PageScene));
			Debug.LogWarning("[MenuPageManager] No children found; scene-wide scan returned " + sceneWide.Length + " PageScene(s).");
			componentsInChildren = sceneWide;
		}

		foreach (PageScene pageScene in componentsInChildren)
		{
			if (_pageByPageType.ContainsKey(pageScene.PageType))
			{
				Debug.LogWarning("[MenuPageManager] Skipping duplicate PageScene for type " + pageScene.PageType + " on '" + pageScene.name + "'");
				continue;
			}
			Debug.LogWarning("[MenuPageManager]   registered PageType." + pageScene.PageType + " -> GameObject '" + pageScene.name + "' (active=" + pageScene.gameObject.activeSelf + ")");
			_pageByPageType.Add(pageScene.PageType, pageScene);
		}
		if ((bool)GlobalUIRibbon.Instance)
		{
			GlobalUIRibbon.Instance.Show();
		}
	}

	private void OnScreenResolutionEvent(GlobalEvents.ScreenResolutionChanged ev)
	{
		int pagePanelWidth = GetPagePanelWidth(_currentPageType);
		AutoMonoBehaviour<CameraRectController>.Instance.SetAbsoluteWidth(Screen.width - pagePanelWidth);
	}

	private IEnumerator StartPageTransition(PageScene newPage, float time)
	{
		newPage.Load();
		if (newPage.HaveMouseOrbitCamera)
		{
			MouseOrbit.Instance.enabled = true;
			Vector3 offset = MouseOrbit.Instance.OrbitOffset;
			Vector3 config = MouseOrbit.Instance.OrbitConfig;
			float t = 0f;
			while (t < time && newPage.PageType == _currentPageType)
			{
				t += Time.deltaTime;
				MouseOrbit.Instance.OrbitConfig = Vector3.Lerp(config, newPage.MouseOrbitConfig, Mathfx.Ease(t / time, _transitionType));
				MouseOrbit.Instance.OrbitOffset = Vector3.Lerp(offset, newPage.MouseOrbitPivot, Mathfx.Ease(t / time, _transitionType));
				MouseOrbit.Instance.yPanningOffset = Mathf.Lerp(MouseOrbit.Instance.yPanningOffset, 0f, Mathfx.Ease(t / time, _transitionType));
				yield return new WaitForEndOfFrame();
			}
			if (newPage.PageType == _currentPageType)
			{
				MouseOrbit.Instance.OrbitOffset = newPage.MouseOrbitPivot;
				MouseOrbit.Instance.OrbitConfig = newPage.MouseOrbitConfig;
			}
		}
		else
		{
			MouseOrbit.Instance.enabled = false;
		}
	}

	private int GetPagePanelWidth(PageType type)
	{
		PageScene value;
		if (_pageByPageType.TryGetValue(type, out value))
		{
			return value.GuiWidth;
		}
		return 0;
	}

	private IEnumerator AnimateCameraPixelRect(PageType type, float time, bool immediate)
	{
		if (immediate)
		{
			AutoMonoBehaviour<CameraRectController>.Instance.SetAbsoluteWidth(Screen.width - GetPagePanelWidth(_currentPageType));
			yield return new WaitForEndOfFrame();
			yield break;
		}
		float t = time * 0.1f;
		float oldCameraWidth = AutoMonoBehaviour<CameraRectController>.Instance.PixelWidth;
		int panelWidth = GetPagePanelWidth(type);
		RenderSettingsController.Instance.DisableImageEffects();
		for (; t < time; t += Time.deltaTime)
		{
			if (type != _currentPageType)
			{
				break;
			}
			AutoMonoBehaviour<CameraRectController>.Instance.SetAbsoluteWidth(Mathf.Lerp(oldCameraWidth, Screen.width - panelWidth, t / time * (t / time)));
			yield return new WaitForEndOfFrame();
		}
		AutoMonoBehaviour<CameraRectController>.Instance.SetAbsoluteWidth(Screen.width - GetPagePanelWidth(_currentPageType));
		RenderSettingsController.Instance.EnableImageEffects();
	}

	public bool IsCurrentPage(PageType type)
	{
		return _currentPageType == type;
	}

	public PageType GetCurrentPage()
	{
		return _currentPageType;
	}

	public void UnloadCurrentPage()
	{
		PageScene value;
		if (_pageByPageType.TryGetValue(_currentPageType, out value) && (bool)value)
		{
			value.Unload();
			_currentPageType = PageType.None;
			MouseOrbit.Instance.enabled = false;
			AutoMonoBehaviour<CameraRectController>.Instance.SetAbsoluteWidth(Screen.width);
		}
	}

	public void LoadPage(PageType pageType, bool forceReload = false)
	{
		Debug.LogWarning("[MenuPageManager] LoadPage(" + pageType + ", forceReload=" + forceReload + ") — dict has " + _pageByPageType.Count + " entries, current=" + _currentPageType);
		LeftAreaGUIOffset = 0f;
		if ((bool)PanelManager.Instance)
		{
			PanelManager.Instance.CloseAllPanels();
		}
		if (pageType == PageType.Home)
		{
			GameData.Instance.MainMenu.Value = MainMenuState.Home;
		}
		if (pageType == _currentPageType && !forceReload)
		{
			Debug.LogWarning("[MenuPageManager]   short-circuit: already on " + pageType);
			return;
		}
		PageScene value = null;
		if (_pageByPageType.TryGetValue(pageType, out value))
		{
			Debug.LogWarning("[MenuPageManager]   activating PageScene '" + value.name + "' (was active=" + value.gameObject.activeSelf + ")");
			PageScene value2 = null;
			_pageByPageType.TryGetValue(_currentPageType, out value2);
			if ((bool)value2 && !forceReload)
			{
				value2.Unload();
			}
			bool flag = (_currentPageType == PageType.Home && pageType == PageType.Shop) || (_currentPageType == PageType.Home && pageType == PageType.Stats);
			_currentPageType = pageType;
			StartCoroutine(AnimateCameraPixelRect(value.PageType, 0.25f, !flag));
			MouseOrbit.Instance.enabled = false;
			Instance.StartCoroutine(StartPageTransition(value, 1f));
		}
		else
		{
			string keys = "";
			foreach (PageType k in _pageByPageType.Keys) { keys += k + ","; }
			Debug.LogError("[MenuPageManager] LoadPage(" + pageType + ") FAILED — no entry. Dict keys: [" + keys + "]");
		}
	}

	private bool IsScreenResolutionChanged()
	{
		if (Screen.width != _lastScreenWidth || Screen.height != _lastScreenHeight)
		{
			_lastScreenWidth = Screen.width;
			_lastScreenHeight = Screen.height;
			return true;
		}
		return false;
	}
}
