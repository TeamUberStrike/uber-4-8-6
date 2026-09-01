using System;
using System.Collections.Generic;
using UnityEngine;

// ---------------------------------------------------------------------------
//  Bluebox / Normal map "Texture Settings"
// ---------------------------------------------------------------------------
//  In the retail Steam client a handful of maps shipped as TWO downloadable
//  assetbundles (e.g. SpacePortAlpha.unity3d = NORMAL grey-metal,
//  SpacePortAlphaB.unity3d = BLUEBOX blue-grid) and a server-localized
//  "Texture Settings" popup on map-select chose which to stream. Our
//  reconstruction has ONE built-in scene per map; the only per-skin difference
//  is the pixels of that map's shared wall texture, so "load the chosen variant"
//  is a single _MainTex swap on the wall material(s) after the scene loads.
//
//  Per-scene tables below drive three maps:
//    * SpacePortAlpha - baked default BLUEBOX; NORMAL = extracted grey-metal.
//    * CuberStrike    - baked default NORMAL; needs an explicit BLUEBOX texture
//                       (capture-from-scene would otherwise capture the normal).
//    (UberZone has no tab: a single retail bundle, one authentic look baked into its materials.)
//
//  Everything here is best-effort and fully guarded: a failure to prompt or to
//  swap must NEVER prevent a map from loading.
// ---------------------------------------------------------------------------
public static class MapTextureVariant
{
	public enum Variant
	{
		BlueBox = 0,
		Normal = 1
	}

	// The player's current choice. Defaults to BlueBox, which is exactly what
	// the reconstructed scenes already display, so doing nothing is always safe.
	public static Variant Selected = Variant.BlueBox;

	// Popup strings (retail used server localization; same literal English text).
	private const string PopupTitle = "Texture Settings";
	private const string PopupBody = "Please select the map's desired texture!";
	private const string NormalCaption = "Normal";
	private const string BlueBoxCaption = "Bluebox";

	// SceneName -> Resources path of the NORMAL main-wall texture for that map.
	private static readonly Dictionary<string, string> NormalTextureByScene =
		new Dictionary<string, string>
		{
			{ "SpacePortAlpha", "MapVariants/SpacePortAlpha_WallNormal" },
			// CuberStrike's grey-metal normal is byte-identical pixels to
			// SpacePortAlpha's, so it reuses the same Resources copy.
			{ "CuberStrike", "MapVariants/SpacePortAlpha_WallNormal" }
			// UberZone (single retail bundle, no UberZoneB) has one authentic look: the
			// gray BlueBox_D tile on a lit Diffuse, tiled 25x25, per-room tinted, baked into
			// its scene materials -- no Normal/Bluebox variant, so it gets no tab.
		};

	// SceneName -> explicit BLUEBOX main-wall texture, needed only for maps whose
	// baked default is NORMAL (e.g. CuberStrike), where the capture-from-scene
	// path would otherwise capture the normal texture as the "bluebox".
	private static readonly Dictionary<string, string> BlueBoxTextureByScene =
		new Dictionary<string, string>
		{
			{ "CuberStrike", "MapVariants/CuberStrike_WallBlueBox" }
		};

	// SceneName -> the wall material name(s) whose _MainTex we swap in that scene.
	private static readonly Dictionary<string, string[]> WallMaterialsByScene =
		new Dictionary<string, string[]>
		{
			{ "SpacePortAlpha", new string[] { "BlueBox" } },
			{ "CuberStrike", new string[] { "CuberStrike", "CuberStrike2_0" } }
		};

	// Cache of the loaded normal texture, keyed by scene name.
	private static readonly Dictionary<string, Texture> _normalCache =
		new Dictionary<string, Texture>();

	// Cache of the loaded explicit-bluebox texture, keyed by scene name.
	private static readonly Dictionary<string, Texture> _blueBoxCache =
		new Dictionary<string, Texture>();

	// The material's original BLUEBOX texture, captured the first time we see it
	// (for maps whose baked default is bluebox and have no explicit entry above).
	private static Texture _capturedBlueBox;

	// CuberStrike's wall material is a detail shader whose high-frequency _Detail
	// overlay muddies the flat bluebox grid; captured here so we can neutralize it
	// in bluebox mode (multiply by white) and restore it for normal.
	private static Texture _capturedDetail;

	// A 1x1 mid-grey (0.5) neutral for the detail slot. Normal-DiffuseDetail combines
	// _Detail at 2x (albedo = base * detail * 2), so its NEUTRAL value is 0.5 (0.5*2 = 1.0).
	// White (1.0*2 = 2.0) doubled the albedo and washed CuberStrike's bluebox to full-bright.
	// Unity 4.6.5 has no Texture2D.grayTexture, so build one lazily.
	private static Texture2D _neutralDetail;
	private static Texture2D NeutralDetail
	{
		get
		{
			if (_neutralDetail == null)
			{
				_neutralDetail = new Texture2D(1, 1, TextureFormat.RGB24, false);
				_neutralDetail.SetPixel(0, 0, new Color(0.5f, 0.5f, 0.5f, 1f));
				_neutralDetail.Apply();
				_neutralDetail.hideFlags = HideFlags.HideAndDontSave;
			}
			return _neutralDetail;
		}
	}

	/// <summary>True if the given scene has a selectable Bluebox/Normal texture.</summary>
	public static bool HasVariants(string sceneName)
	{
		return !string.IsNullOrEmpty(sceneName) && NormalTextureByScene.ContainsKey(sceneName);
	}

	/// <summary>
	/// Show the "Texture Settings" popup, record the choice, then run
	/// <paramref name="afterChoice"/> (may be null — e.g. when only recording the
	/// preference for a create-game map that loads later). If anything goes wrong
	/// the choice falls back to Bluebox and <paramref name="afterChoice"/> still runs,
	/// so the caller's map load is never blocked.
	/// </summary>
	public static void PromptAndRun(Action afterChoice)
	{
		try
		{
			// Button colours: the popup's OK button takes the coloured (button_green/blue) style
			// via ActionType.Positive; the Cancel button is always grey. Put BLUEBOX on the OK
			// button so it reads blue and NORMAL on Cancel so it reads grey (per the requested
			// swap of "Normal=blue / Bluebox=grey"). This also makes the default choice (Bluebox)
			// the highlighted/positive button, which is the sensible default.
			PopupSystem.ShowMessage(
				PopupTitle,
				PopupBody,
				PopupSystem.AlertType.OKCancel,
				delegate
				{
					Selected = Variant.BlueBox;
					RunSafe(afterChoice);
				},
				BlueBoxCaption,
				delegate
				{
					Selected = Variant.Normal;
					RunSafe(afterChoice);
				},
				NormalCaption,
				PopupSystem.ActionType.Positive);
		}
		catch (Exception e)
		{
			Debug.LogWarning("MapTextureVariant.PromptAndRun failed; defaulting to Bluebox. " + e);
			Selected = Variant.BlueBox;
			RunSafe(afterChoice);
		}
	}

	private static void RunSafe(Action a)
	{
		if (a == null)
		{
			return;
		}
		try
		{
			a();
		}
		catch (Exception e)
		{
			Debug.LogError("MapTextureVariant: post-choice action threw. " + e);
		}
	}

	/// <summary>
	/// Apply the selected texture variant to the freshly-loaded scene. Call this
	/// once the scene's objects exist (see SceneLoader). No-op for scenes without
	/// variants; never throws.
	/// </summary>
	public static void Apply(string sceneName)
	{
		try
		{
			string resPath;
			if (string.IsNullOrEmpty(sceneName) || !NormalTextureByScene.TryGetValue(sceneName, out resPath))
			{
				return;
			}

			Texture normal = LoadNormal(sceneName, resPath);
			Texture blueBox = LoadBlueBox(sceneName); // may be null (bluebox-default maps use capture)

			// Collect the distinct shared wall material(s) in the scene.
			UnityEngine.Object[] rends = UnityEngine.Object.FindObjectsOfType(typeof(Renderer));
			if (rends == null)
			{
				return;
			}
			int swapped = 0;
			for (int i = 0; i < rends.Length; i++)
			{
				Renderer r = rends[i] as Renderer;
				if (r == null)
				{
					continue;
				}
				Material[] mats = r.sharedMaterials;
				if (mats == null)
				{
					continue;
				}
				for (int m = 0; m < mats.Length; m++)
				{
					Material mat = mats[m];
					if (mat == null || !IsWallMaterial(sceneName, mat.name))
					{
						continue;
					}
					if (!mat.HasProperty("_MainTex"))
					{
						continue;
					}
					Texture cur = mat.GetTexture("_MainTex");
					// Capture the bluebox baseline: any main texture that is neither our
					// normal nor our explicit bluebox (covers bluebox-default maps).
					if (cur != null && cur != normal && cur != blueBox)
					{
						_capturedBlueBox = cur;
					}
					// Prefer an explicit bluebox (required for normal-default maps like
					// CuberStrike); otherwise fall back to the captured one.
					Texture blueTarget = (blueBox != null) ? blueBox : _capturedBlueBox;
					if (Selected == Variant.Normal)
					{
						if (normal != null && cur != normal)
						{
							mat.SetTexture("_MainTex", normal);
							swapped++;
						}
					}
					else // Bluebox
					{
						if (blueTarget != null && cur != blueTarget)
						{
							mat.SetTexture("_MainTex", blueTarget);
							swapped++;
						}
					}
					// Detail-shader maps (CuberStrike) overlay a grainy _Detail texture
					// that muddies the flat bluebox grid. Neutralize it (multiply by
					// white) in bluebox mode; restore the captured detail for normal.
					if (mat.HasProperty("_Detail"))
					{
						Texture curDetail = mat.GetTexture("_Detail");
						if (_capturedDetail == null && curDetail != null && curDetail != NeutralDetail)
						{
							_capturedDetail = curDetail;
						}
						if (Selected == Variant.BlueBox)
						{
							if (curDetail != NeutralDetail)
							{
								mat.SetTexture("_Detail", NeutralDetail);
							}
						}
						else if (_capturedDetail != null && curDetail != _capturedDetail)
						{
							mat.SetTexture("_Detail", _capturedDetail);
						}
					}
				}
			}
			Debug.LogWarning("MapTextureVariant: applied " + Selected + " to '" + sceneName +
				"' (" + swapped + " material(s) changed).");
		}
		catch (Exception e)
		{
			Debug.LogWarning("MapTextureVariant.Apply failed (map still loads fine): " + e);
		}
	}

	private static bool IsWallMaterial(string sceneName, string matName)
	{
		if (string.IsNullOrEmpty(matName))
		{
			return false;
		}
		string[] names;
		if (string.IsNullOrEmpty(sceneName) || !WallMaterialsByScene.TryGetValue(sceneName, out names))
		{
			return false;
		}
		for (int i = 0; i < names.Length; i++)
		{
			// Match the shared material or a runtime "Name (Instance)" clone.
			if (matName == names[i] || matName.StartsWith(names[i] + " ("))
			{
				return true;
			}
		}
		return false;
	}

	private static Texture LoadNormal(string sceneName, string resPath)
	{
		Texture tex;
		if (_normalCache.TryGetValue(sceneName, out tex) && tex != null)
		{
			return tex;
		}
		tex = Resources.Load(resPath, typeof(Texture)) as Texture;
		if (tex == null)
		{
			Debug.LogWarning("MapTextureVariant: normal texture not found at Resources/" + resPath +
				" — leaving scene as bluebox.");
		}
		_normalCache[sceneName] = tex;
		return tex;
	}

	private static Texture LoadBlueBox(string sceneName)
	{
		string resPath;
		if (string.IsNullOrEmpty(sceneName) || !BlueBoxTextureByScene.TryGetValue(sceneName, out resPath))
		{
			return null;
		}
		Texture tex;
		if (_blueBoxCache.TryGetValue(sceneName, out tex) && tex != null)
		{
			return tex;
		}
		tex = Resources.Load(resPath, typeof(Texture)) as Texture;
		if (tex == null)
		{
			Debug.LogWarning("MapTextureVariant: bluebox texture not found at Resources/" + resPath + ".");
		}
		_blueBoxCache[sceneName] = tex;
		return tex;
	}
}
