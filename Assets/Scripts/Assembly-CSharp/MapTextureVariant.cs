using System;
using System.Collections.Generic;
using UnityEngine;

// ---------------------------------------------------------------------------
//  Bluebox / Normal map "Texture Settings"
// ---------------------------------------------------------------------------
//  In the retail Steam client each of a handful of maps shipped as TWO
//  downloadable assetbundles: e.g. SpacePortAlpha.unity3d (NORMAL, grey-metal)
//  and SpacePortAlphaB.unity3d (BLUEBOX, blue-grid). A server-localized
//  "Texture Settings" popup on map-select chose which bundle to stream.
//
//  Our AssetRipper reconstruction only has ONE built-in scene per map, and for
//  SpacePortAlpha that scene's single wall material ("BlueBox") points at the
//  BLUEBOX texture ("InsideGrayAlt 1_2.png", guid 08ff5191...). The NORMAL
//  grey-metal texture is the byte-identical "InsideGrayAlt 1.png" (guid
//  50b591df...) — a real asset extracted from the retail SpacePortAlpha.unity3d
//  bundle and already present in the project. A Resources copy of it lives at
//  Resources/MapVariants/SpacePortAlpha_WallNormal.png so it can be reached at
//  runtime.
//
//  Verified from the retail bundles: the ONLY per-skin difference for
//  SpacePortAlpha is the pixels of that one wall texture (both variants use the
//  same 10x10 tiling on the same material/mesh). So the "load the chosen
//  variant" step is a single main-texture swap on the shared "BlueBox"
//  material, applied right after the scene finishes loading.
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

	// Popup strings. In the retail client these came from server localization;
	// we use the same literal English text the retail popup showed.
	private const string PopupTitle = "Texture Settings";
	private const string PopupBody = "Please select the map's desired texture!";
	private const string NormalCaption = "Normal";
	private const string BlueBoxCaption = "Bluebox";

	// Name of the shared wall material inside the variant scenes.
	private const string WallMaterialName = "BlueBox";

	// SceneName -> Resources path of the NORMAL main-wall texture for that map.
	// Only maps that actually have a real, extracted normal texture belong here.
	// (SpaceCity / UberZone can be added once their normal textures are imported
	//  the same way; leaving them out simply means no popup for them.)
	private static readonly Dictionary<string, string> NormalTextureByScene =
		new Dictionary<string, string>
		{
			{ "SpacePortAlpha", "MapVariants/SpacePortAlpha_WallNormal" }
		};

	// Cache of the loaded normal texture, keyed by scene name.
	private static readonly Dictionary<string, Texture> _normalCache =
		new Dictionary<string, Texture>();

	// The material's original BLUEBOX texture, captured the first time we see it
	// so we can restore it if the player switches back to Bluebox and Unity kept
	// the mutated shared material alive across a level load.
	private static Texture _capturedBlueBox;

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
			PopupSystem.ShowMessage(
				PopupTitle,
				PopupBody,
				PopupSystem.AlertType.OKCancel,
				delegate
				{
					Selected = Variant.Normal;
					RunSafe(afterChoice);
				},
				NormalCaption,
				delegate
				{
					Selected = Variant.BlueBox;
					RunSafe(afterChoice);
				},
				BlueBoxCaption,
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
					if (mat == null || !IsWallMaterial(mat.name))
					{
						continue;
					}
					if (!mat.HasProperty("_MainTex"))
					{
						continue;
					}
					Texture cur = mat.GetTexture("_MainTex");
					// Capture the bluebox baseline: any main texture that isn't our normal one.
					if (cur != null && cur != normal)
					{
						_capturedBlueBox = cur;
					}
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
						if (_capturedBlueBox != null && cur != _capturedBlueBox)
						{
							mat.SetTexture("_MainTex", _capturedBlueBox);
							swapped++;
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

	private static bool IsWallMaterial(string matName)
	{
		if (string.IsNullOrEmpty(matName))
		{
			return false;
		}
		// Shared material is "BlueBox"; a runtime instance would be "BlueBox (Instance)".
		// Must NOT match sibling materials like "BlueBox_Gray"/"BlueBox_Blue".
		return matName == WallMaterialName || matName.StartsWith(WallMaterialName + " (");
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
}
