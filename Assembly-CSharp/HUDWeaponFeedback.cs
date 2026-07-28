using System.Collections;
using UnityEngine;

public class HUDWeaponFeedback : MonoBehaviour
{
	[SerializeField]
	private float onScreenTime = 2.5f;

	[SerializeField]
	private float fadeInTime = 0.2f;

	[SerializeField]
	private float fadeOutTime = 1f;

	[SerializeField]
	private UILabel feedbackLabel;

	// IMGUI fallback: the NGUI UILabel in the additively-loaded DesktopHUD scene
	// renders as garbled black/white squares due to broken font atlas draw call
	// binding in Unity 6. Render via OnGUI instead which works reliably.
	private string _weaponName = string.Empty;
	private float _alpha;
	private GUIStyle _style;

	private void OnEnable()
	{
		StopAllCoroutines();
		_alpha = 0f;
		// Disable the broken NGUI UILabel so it stops rendering garbled squares
		if (feedbackLabel != null)
		{
			feedbackLabel.enabled = false;
			feedbackLabel.gameObject.SetActive(false);
		}
		GameState.Current.PlayerData.ActiveWeapon.Fire();
	}

	private void Start()
	{
		if (feedbackLabel != null)
		{
			feedbackLabel.enabled = false;
			feedbackLabel.gameObject.SetActive(false);
		}
		GameState.Current.PlayerData.ActiveWeapon.AddEventAndFire(HandleSelectedLoadoutChanged, this);
	}

	private void HandleSelectedLoadoutChanged(WeaponSlot weapon)
	{
		if (weapon != null)
		{
			LoadoutSlotType slot = weapon.Slot;
			if (GameState.Current.PlayerData.LoadoutWeapons.Value.ContainsKey(slot))
			{
				_weaponName = GameState.Current.PlayerData.LoadoutWeapons.Value[slot].Name;
				StopAllCoroutines();
				StartCoroutine(FadeAnimation());
			}
		}
	}

	private IEnumerator FadeAnimation()
	{
		float t = 0f;
		while (t < fadeInTime)
		{
			t += Time.deltaTime;
			_alpha = Mathf.Clamp01(t / fadeInTime);
			yield return null;
		}
		_alpha = 1f;
		yield return new WaitForSeconds(onScreenTime);
		t = 0f;
		while (t < fadeOutTime)
		{
			t += Time.deltaTime;
			_alpha = 1f - Mathf.Clamp01(t / fadeOutTime);
			yield return null;
		}
		_alpha = 0f;
	}

	private void OnGUI()
	{
		if (_alpha <= 0f || string.IsNullOrEmpty(_weaponName))
			return;

		if (_style == null)
		{
			_style = new GUIStyle(BlueStonez.label_interparkbold_13pt);
			_style.alignment = TextAnchor.MiddleCenter;
		}

		Vector2 size = _style.CalcSize(new GUIContent(_weaponName));
		size.x = Mathf.Max(size.x + 16f, 100f);
		float x = (Screen.width - size.x) * 0.5f;
		float y = Screen.height - size.y - 60f;

		GUI.color = new Color(0f, 0f, 0f, _alpha * 0.6f);
		GUI.Label(new Rect(x + 1f, y + 1f, size.x, size.y), _weaponName, _style);
		GUI.color = new Color(1f, 1f, 1f, _alpha);
		GUI.Label(new Rect(x, y, size.x, size.y), _weaponName, _style);
		GUI.color = Color.white;
	}
}
