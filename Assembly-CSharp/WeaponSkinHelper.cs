using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using UnityEngine;

public static class WeaponSkinHelper
{
	public enum FlameMode
	{
		Surface,
		Helix,
		Shell
	}

	public struct TextureBinding
	{
		public string Property;

		public string ResourcePath;

		public bool IsCubemap;

		public TextureBinding(string property, string resourcePath, bool isCubemap)
		{
			Property = property;
			ResourcePath = resourcePath;
			IsCubemap = isCubemap;
		}
	}

	public struct ColorBinding
	{
		public string Property;

		public Color Value;

		public ColorBinding(string property, Color value)
		{
			Property = property;
			Value = value;
		}
	}

	public struct FloatBinding
	{
		public string Property;

		public float Value;

		public FloatBinding(string property, float value)
		{
			Property = property;
			Value = value;
		}
	}

	public class MaterialBindings
	{
		public TextureBinding[] Textures;

		public ColorBinding[] Colors;

		public FloatBinding[] Floats;
	}

	public struct SleeveSpec
	{
		public float RadiusMult;

		public int Ribbons;

		public float RibbonArc;

		public float Twist;

		public float Start;

		public float MaxLenFrac;

		public float VRepeat;
	}

	public struct TracerSpec
	{
		public ParticleConfigurationType Effect;

		public Color Start;

		public Color End;

		public Color MatTint;
	}

	public struct MuzzleTintSpec
	{
		public bool HasLight;

		public Color LightColour;

		public bool HasParticles;

		public Color ParticleTint;

		public string[] ParticleObjects;

		public string[] TintRenderers;
	}

	public class SkinDef
	{
		public string SkinTextures;

		public float? SkinShellScale;

		public FlameMode? SkinFlameModes;

		public string[] SkinShaders;

		public string SkinShaderResources;

		public MaterialBindings SkinMaterialBindings;

		public Color? SkinReflectTints;

		public Color? SkinFlameTints;

		public SleeveSpec? SkinSleeves;

		public string SkinFlames;

		public string IconTextures;

		public TracerSpec? TracerOverrides;

		public MuzzleTintSpec? MuzzleTints;
	}

	public static readonly Dictionary<int, string> SkinTextures;

	public static readonly Dictionary<int, float> SkinShellScale;

	public static readonly Dictionary<int, FlameMode> SkinFlameModes;

	public const string WaterShader = "CMune/Water/Opaque_Flowing";

	private const string WaterMainTexPath = "items/shared/textures/water_a_nm";

	private const string WaterBumpMapPath = "items/shared/textures/water_b_nm";

	private const string WaterCausticsPath = "items/shared/textures/caustics_a_dm";

	private const string WaterCubePath = "items/shared/cubemaps/studio_a";

	private const string WaterShaderPath = "items/shared/shaders/water_flowing_a";

	public static readonly Dictionary<int, string[]> SkinShaders;

	public static readonly Dictionary<int, string> SkinShaderResources;

	private static readonly TextureBinding[] WaterTextureSet;

	private static readonly MaterialBindings WaterBindings;

	private static readonly MaterialBindings LavaBindings;

	private static readonly MaterialBindings GlassIceBindings;

	private static readonly MaterialBindings GlassMatteBindings;

	public static readonly Dictionary<int, MaterialBindings> SkinMaterialBindings;

	public static readonly Dictionary<int, Color> SkinReflectTints;

	public static readonly Dictionary<int, Color> SkinFlameTints;

	public static readonly Dictionary<int, SleeveSpec> SkinSleeves;

	public static readonly Dictionary<int, string> SkinFlames;

	public static readonly Dictionary<int, string> IconTextures;

	public static readonly Dictionary<int, TracerSpec> TracerOverrides;

	public static readonly Dictionary<int, MuzzleTintSpec> MuzzleTints;

	private static readonly Dictionary<int, Texture2D> _skinCache;

	private static readonly Dictionary<int, Texture2D> _iconCache;

	private const string ResourcePrefix = "WeaponSkins.";

	private static readonly Dictionary<string, Texture> _resourceTexCache;

	private static readonly Dictionary<string, bool> _reportedMissingProps;

	private const string FlameChildName = "__SkinFlameOverlay";

	private const float FLAME_MIN_PART_FRAC = 0.15f;

	private static readonly Dictionary<string, bool> _reportedFlameSkips;

	private static readonly Dictionary<Mesh, Mesh> _flameMeshCache;

	private static readonly Dictionary<string, Mesh> _sleeveCache;

	private static readonly Dictionary<string, Vector3> _sleeveAxis;

	private static readonly Dictionary<string, Vector3> _sleeveCentre;

	private const int SLEEVE_RINGS = 22;

	private const int SLEEVE_RIBBONS = 2;

	private const int SLEEVE_ARC_SEGMENTS = 5;

	private const float SLEEVE_RIBBON_ARC = 0.5f;

	private const float SLEEVE_RADIUS_MULT = 2f;

	private const float SLEEVE_MIN_LEN_FRAC = 0.025f;

	private const float SLEEVE_MAX_LEN_FRAC = 0.042f;

	private const float SLEEVE_TIP_SCALE = 0.55f;

	private const float SLEEVE_TWIST_TURNS = 2.1f;

	private const float SLEEVE_START = 0.3f;

	private static readonly bool MUZZLE_DEBUG;

	public static readonly Dictionary<int, SkinDef> Skins;

	private static byte[] ReadEmbedded(string fileName)
	{
		string text = "WeaponSkins." + fileName;
		try
		{
			Assembly executingAssembly = Assembly.GetExecutingAssembly();
			using (Stream stream = executingAssembly.GetManifestResourceStream(text))
			{
				if (stream == null)
				{
					return null;
				}
				byte[] array = new byte[stream.Length];
				int i;
				int num;
				for (i = 0; i < array.Length; i += num)
				{
					num = stream.Read(array, i, array.Length - i);
					if (num <= 0)
					{
						break;
					}
				}
				if (i != array.Length)
				{
					Debug.LogError("WeaponSkinHelper: short read on embedded " + text + " (" + i + " of " + array.Length + " bytes)");
					return null;
				}
				return array;
			}
		}
		catch (Exception ex)
		{
			Debug.LogError("WeaponSkinHelper: could not read embedded " + text + ": " + ex.Message);
			return null;
		}
	}

	private static Texture2D LoadSkinFile(string fileName)
	{
		string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(fileName);
		string text = fileNameWithoutExtension + ".jpg";
		string text2 = fileNameWithoutExtension + ".alpha.png";
		byte[] array = ReadEmbedded(text);
		if (array != null)
		{
			Texture2D texture2D = DecodeTexture(array, text);
			if (texture2D == null)
			{
				return null;
			}
			byte[] array2 = ReadEmbedded(text2);
			if (array2 == null)
			{
				return texture2D;
			}
			Texture2D texture2D2 = DecodeTexture(array2, text2);
			if (texture2D2 == null)
			{
				return texture2D;
			}
			if (texture2D2.width != texture2D.width || texture2D2.height != texture2D.height)
			{
				Debug.LogError("WeaponSkinHelper: alpha mask size " + texture2D2.width + "x" + texture2D2.height + " does not match colour " + texture2D.width + "x" + texture2D.height + " for " + fileNameWithoutExtension);
				return texture2D;
			}
			bool flag = fileNameWithoutExtension != null && fileNameWithoutExtension.IndexOf("Uberverse", StringComparison.OrdinalIgnoreCase) >= 0;
			Texture2D texture2D3 = new Texture2D(texture2D.width, texture2D.height, TextureFormat.RGBA32, flag);
			Color[] pixels = texture2D.GetPixels();
			Color[] pixels2 = texture2D2.GetPixels();
			for (int i = 0; i < pixels.Length; i++)
			{
				pixels[i].a = pixels2[i].r;
			}
			texture2D3.SetPixels(pixels);
			texture2D3.Apply(flag);
			if (flag)
			{
				texture2D3.filterMode = FilterMode.Trilinear;
			}
			return texture2D3;
		}
		byte[] array3 = ReadEmbedded(fileName);
		if (array3 == null)
		{
			Debug.LogError("WeaponSkinHelper: skin not embedded as \"WeaponSkins." + fileName + "\"");
			return null;
		}
		return DecodeTexture(array3, fileName);
	}

	private static Texture2D DecodeTexture(byte[] data, string label)
	{
		if (data == null)
		{
			return null;
		}
		Texture2D texture2D = new Texture2D(2, 2, TextureFormat.RGBA32, false);
		if (!texture2D.LoadImage(data))
		{
			Debug.LogError("WeaponSkinHelper: Texture2D.LoadImage failed for " + label);
			return null;
		}
		return texture2D;
	}

	public static Texture2D GetSkinTexture(int itemId)
	{
		Texture2D value;
		if (_skinCache.TryGetValue(itemId, out value) && value != null)
		{
			return value;
		}
		string value2;
		if (!SkinTextures.TryGetValue(itemId, out value2))
		{
			return null;
		}
		Texture2D texture2D = LoadSkinFile(value2);
		if (texture2D != null)
		{
			_skinCache[itemId] = texture2D;
		}
		return texture2D;
	}

	public static Texture2D GetIconTexture(int itemId)
	{
		Texture2D value;
		if (_iconCache.TryGetValue(itemId, out value) && value != null)
		{
			return value;
		}
		string value2;
		if (!IconTextures.TryGetValue(itemId, out value2))
		{
			return null;
		}
		Texture2D texture2D = LoadSkinFile(value2);
		if (texture2D != null)
		{
			_iconCache[itemId] = texture2D;
		}
		return texture2D;
	}

	private static bool IsEffectRenderer(Renderer r)
	{
		if (!UberverseWeaponEffect.Owns(r) && !UberverseV1Effect.Owns(r) && !UberverseV12Effect.Owns(r))
		{
			return WeaponEmitterEffect.Owns(r);
		}
		return true;
	}

	public static void ApplyToWeapon(GameObject weaponRoot, int itemId)
	{
		if (weaponRoot == null)
		{
			return;
		}
		UberverseWeaponEffect.Apply(weaponRoot, itemId);
		UberverseV1Effect.Apply(weaponRoot, itemId);
		UberverseV12Effect.Apply(weaponRoot, itemId);
		CyberNeonWeaponEffect.Apply(weaponRoot, itemId);
		ToxicVenomWeaponEffect.Apply(weaponRoot, itemId);
		MoltenInfernoWeaponEffect.Apply(weaponRoot, itemId);
		VoidglassWeaponEffect.Apply(weaponRoot, itemId);
		PrismSplatterWeaponEffect.Apply(weaponRoot, itemId);
		DragonsMawWeaponEffect.Apply(weaponRoot, itemId);
		ApplyTracer(weaponRoot, itemId);
		ApplyMuzzleTint(weaponRoot, itemId);
		Texture2D skinTexture = GetSkinTexture(itemId);
		bool flag = SkinMaterialBindings.ContainsKey(itemId);
		if (skinTexture == null && !flag)
		{
			return;
		}
		Renderer[] componentsInChildren = weaponRoot.GetComponentsInChildren<Renderer>(true);
		Renderer[] array = componentsInChildren;
		foreach (Renderer renderer in array)
		{
			if (renderer == null || IsEffectRenderer(renderer))
			{
				continue;
			}
			Material sharedMaterial = renderer.sharedMaterial;
			if (sharedMaterial == null)
			{
				continue;
			}
			Shader shader = sharedMaterial.shader;
			if ((shader != null && shader.name != null && shader.name.IndexOf("Particle", StringComparison.OrdinalIgnoreCase) >= 0) || renderer.material == null)
			{
				continue;
			}
			if (skinTexture != null)
			{
				renderer.material.mainTexture = skinTexture;
				if (renderer.material.HasProperty("_MainTex"))
				{
					renderer.material.SetTexture("_MainTex", skinTexture);
				}
			}
			ApplyShaderOverride(renderer, itemId);
		}
		ApplyFlames(weaponRoot, itemId);
	}

	private static void ApplyShaderOverride(Renderer r, int itemId)
	{
		string[] value;
		if (!SkinShaders.TryGetValue(itemId, out value) || value == null || value.Length == 0)
		{
			return;
		}
		Shader shader = null;
		string text = null;
		for (int i = 0; i < value.Length; i++)
		{
			shader = Shader.Find(value[i]);
			if (shader != null)
			{
				text = "Shader.Find('" + value[i] + "')" + ((i > 0) ? (" (fell back; '" + value[0] + "' is not in this build)") : "");
				break;
			}
		}
		string value2;
		if (shader == null && SkinShaderResources.TryGetValue(itemId, out value2) && !string.IsNullOrEmpty(value2))
		{
			shader = Resources.Load(value2, typeof(Shader)) as Shader;
			if (shader != null)
			{
				text = "Resources.Load('" + value2 + "') -- Shader.Find missed '" + value[0] + "'";
			}
		}
		if (shader == null)
		{
			Debug.LogError("WeaponSkinHelper: skin " + itemId + " found NONE of its shaders in this build (tried Shader.Find on '" + string.Join("', '", value) + "'" + (SkinShaderResources.ContainsKey(itemId) ? (" then Resources.Load on '" + SkinShaderResources[itemId] + "'") : "") + "). Leaving the renderer on its previous material.");
			return;
		}
		MaterialBindings value3;
		if (!SkinMaterialBindings.TryGetValue(itemId, out value3))
		{
			value3 = null;
		}
		Texture[] array = null;
		if (value3 != null && value3.Textures != null)
		{
			array = new Texture[value3.Textures.Length];
			for (int j = 0; j < value3.Textures.Length; j++)
			{
				TextureBinding tb = value3.Textures[j];
				Texture texture = LoadResourceTexture(tb);
				if (texture == null)
				{
					Debug.LogError("WeaponSkinHelper: skin " + itemId + " NOT applied -- could not bind " + tb.Property + " from Resources path '" + tb.ResourcePath + "' as a " + (tb.IsCubemap ? "Cubemap" : "Texture2D") + ". Refusing to bind '" + shader.name + "' with " + tb.Property + " unassigned, because that renders a wrong-but-plausible weapon instead of an obviously unskinned one. Leaving the renderer on its previous material.");
					return;
				}
				array[j] = texture;
			}
		}
		r.material.shader = shader;
		if (value3 != null)
		{
			ApplyMaterialBindings(r.material, value3, array, itemId);
		}
		if (r.material.HasProperty("_ReflectColor") && !BindsColor(value3, "_ReflectColor"))
		{
			Color value4;
			if (!SkinReflectTints.TryGetValue(itemId, out value4))
			{
				value4 = new Color(0.55f, 0.75f, 0.95f, 0.08f);
			}
			r.material.SetColor("_ReflectColor", value4);
		}
		Debug.Log(string.Format("WeaponSkinHelper: skin {0} bound shader '{1}' via {2}; bindings={3} _Color={4} _ReflectColor={5}", itemId, shader.name, text, (value3 == null) ? "NONE" : "yes", r.material.HasProperty("_Color") ? r.material.GetColor("_Color").ToString() : "(absent)", r.material.HasProperty("_ReflectColor") ? r.material.GetColor("_ReflectColor").ToString() : "(absent)"));
	}

	private static bool BindsColor(MaterialBindings bind, string property)
	{
		if (bind == null || bind.Colors == null)
		{
			return false;
		}
		for (int i = 0; i < bind.Colors.Length; i++)
		{
			if (bind.Colors[i].Property == property)
			{
				return true;
			}
		}
		return false;
	}

	private static Texture LoadResourceTexture(TextureBinding tb)
	{
		Texture value;
		if (_resourceTexCache.TryGetValue(tb.ResourcePath, out value))
		{
			return value;
		}
		Texture texture = Resources.Load(tb.ResourcePath, tb.IsCubemap ? typeof(Cubemap) : typeof(Texture2D)) as Texture;
		_resourceTexCache[tb.ResourcePath] = texture;
		return texture;
	}

	private static void ApplyMaterialBindings(Material m, MaterialBindings bind, Texture[] resolved, int itemId)
	{
		if (m == null || bind == null)
		{
			return;
		}
		if (bind.Textures != null && resolved != null)
		{
			for (int i = 0; i < bind.Textures.Length; i++)
			{
				TextureBinding textureBinding = bind.Textures[i];
				if (!m.HasProperty(textureBinding.Property))
				{
					ReportMissingProperty(m, itemId, textureBinding.Property, "texture '" + textureBinding.ResourcePath + "'");
				}
				else
				{
					m.SetTexture(textureBinding.Property, resolved[i]);
				}
			}
		}
		if (bind.Colors != null)
		{
			for (int j = 0; j < bind.Colors.Length; j++)
			{
				ColorBinding colorBinding = bind.Colors[j];
				if (!m.HasProperty(colorBinding.Property))
				{
					string property = colorBinding.Property;
					Color value = colorBinding.Value;
					ReportMissingProperty(m, itemId, property, "colour " + value.ToString());
				}
				else
				{
					m.SetColor(colorBinding.Property, colorBinding.Value);
				}
			}
		}
		if (bind.Floats == null)
		{
			return;
		}
		for (int k = 0; k < bind.Floats.Length; k++)
		{
			FloatBinding floatBinding = bind.Floats[k];
			if (!m.HasProperty(floatBinding.Property))
			{
				ReportMissingProperty(m, itemId, floatBinding.Property, "float " + floatBinding.Value);
			}
			else
			{
				m.SetFloat(floatBinding.Property, floatBinding.Value);
			}
		}
	}

	private static void ReportMissingProperty(Material m, int itemId, string property, string what)
	{
		string text = ((m.shader != null) ? m.shader.name : "<null shader>");
		string key = text + "|" + property;
		if (!_reportedMissingProps.ContainsKey(key))
		{
			_reportedMissingProps[key] = true;
			Debug.Log("WeaponSkinHelper: skin " + itemId + " skipped " + property + " (" + what + ") -- shader '" + text + "' does not declare that property, so assigning it would do nothing. The rest of the material was bound normally.");
		}
	}

	private static void ApplyFlames(GameObject weaponRoot, int itemId)
	{
		string value;
		if (!SkinFlames.TryGetValue(itemId, out value))
		{
			return;
		}
		Texture2D texture2D = LoadSkinFile(value);
		if (texture2D == null)
		{
			return;
		}
		texture2D.wrapMode = TextureWrapMode.Repeat;
		Shader shader = Shader.Find("Particles/Additive");
		if (shader == null)
		{
			Debug.LogWarning("WeaponSkinHelper: 'Particles/Additive' missing, no flames for " + itemId);
			return;
		}
		Renderer[] componentsInChildren = weaponRoot.GetComponentsInChildren<Renderer>(true);
		FlameMode value2;
		if (!SkinFlameModes.TryGetValue(itemId, out value2))
		{
			value2 = FlameMode.Helix;
		}
		float num = ((value2 == FlameMode.Helix) ? LongestOverlayExtent(componentsInChildren) : 0f);
		Renderer[] array = componentsInChildren;
		foreach (Renderer renderer in array)
		{
			if (renderer == null || IsEffectRenderer(renderer))
			{
				continue;
			}
			Material sharedMaterial = renderer.sharedMaterial;
			if (sharedMaterial == null)
			{
				continue;
			}
			Shader shader2 = sharedMaterial.shader;
			if (shader2 != null && shader2.name != null && shader2.name.IndexOf("Particle", StringComparison.OrdinalIgnoreCase) >= 0)
			{
				continue;
			}
			SkinnedMeshRenderer skinnedMeshRenderer = renderer as SkinnedMeshRenderer;
			MeshFilter component = renderer.GetComponent<MeshFilter>();
			Mesh mesh = ((skinnedMeshRenderer != null) ? skinnedMeshRenderer.sharedMesh : ((component != null) ? component.sharedMesh : null));
			if (mesh == null || renderer.transform.FindChild("__SkinFlameOverlay") != null)
			{
				continue;
			}
			if (num > 0f)
			{
				Vector3 size = mesh.bounds.size;
				float num2 = Mathf.Max(size.x, Mathf.Max(size.y, size.z));
				if (num2 < num * 0.15f)
				{
					ReportFlamePartSkip(itemId, weaponRoot, renderer, mesh, num2, num);
					continue;
				}
			}
			Vector3 axis = Vector3.up;
			Vector3 centre = Vector3.zero;
			float value3 = 1f;
			Mesh mesh2;
			switch (value2)
			{
			case FlameMode.Surface:
				mesh2 = WhiteVertexCopy(mesh);
				break;
			case FlameMode.Shell:
				mesh2 = mesh;
				if (!SkinShellScale.TryGetValue(itemId, out value3) || value3 <= 1f)
				{
					value3 = 1.08f;
				}
				centre = mesh.bounds.center * (1f - value3);
				break;
			default:
				mesh2 = BuildFlameSleeve(mesh, itemId, out axis, out centre);
				break;
			}
			if (mesh2 == null)
			{
				ReportFlameSkip(itemId, weaponRoot, renderer, mesh);
				continue;
			}
			if (value2 == FlameMode.Shell && skinnedMeshRenderer != null && skinnedMeshRenderer.bones != null && skinnedMeshRenderer.bones.Length != 0)
			{
				Debug.LogWarning(string.Format("WeaponSkinHelper: skin {0} on {1} asks for Shell flames, but '{2}' is a SkinnedMeshRenderer ({3} bones). A skinned renderer ignores transform scale, so the shell would be invisible. Skipping this renderer -- use Surface mode for skinned weapons, or scale the shell in the mesh itself.", itemId, (weaponRoot != null) ? weaponRoot.name : "?", renderer.gameObject.name, skinnedMeshRenderer.bones.Length));
				continue;
			}
			GameObject gameObject = new GameObject("__SkinFlameOverlay");
			gameObject.layer = renderer.gameObject.layer;
			gameObject.transform.parent = renderer.transform;
			gameObject.transform.localPosition = centre;
			gameObject.transform.localRotation = Quaternion.identity;
			gameObject.transform.localScale = Vector3.one * value3;
			Renderer renderer2;
			if (skinnedMeshRenderer != null && skinnedMeshRenderer.bones != null && skinnedMeshRenderer.bones.Length != 0 && mesh2.bindposes != null && mesh2.bindposes.Length != 0)
			{
				SkinnedMeshRenderer skinnedMeshRenderer2 = gameObject.AddComponent<SkinnedMeshRenderer>();
				skinnedMeshRenderer2.sharedMesh = mesh2;
				skinnedMeshRenderer2.bones = skinnedMeshRenderer.bones;
				skinnedMeshRenderer2.rootBone = skinnedMeshRenderer.rootBone;
				skinnedMeshRenderer2.quality = skinnedMeshRenderer.quality;
				skinnedMeshRenderer2.localBounds = skinnedMeshRenderer.localBounds;
				renderer2 = skinnedMeshRenderer2;
			}
			else
			{
				MeshFilter meshFilter = gameObject.AddComponent<MeshFilter>();
				meshFilter.sharedMesh = mesh2;
				renderer2 = gameObject.AddComponent<MeshRenderer>();
			}
			Material material = new Material(shader);
			material.mainTexture = texture2D;
			if (material.HasProperty("_TintColor"))
			{
				Color value4;
				if (!SkinFlameTints.TryGetValue(itemId, out value4))
				{
					switch (value2)
					{
					case FlameMode.Surface:
						value4 = new Color(0.18f, 0.26f, 0.32f, 0.5f);
						break;
					case FlameMode.Shell:
						value4 = new Color(0.1f, 0.17f, 0.3f, 0.5f);
						break;
					default:
						value4 = new Color(0.4f, 0.47f, 0.52f, 0.5f);
						break;
					}
				}
				material.SetColor("_TintColor", value4);
			}
			float y = 2f;
			SleeveSpec value5;
			if (SkinSleeves.TryGetValue(itemId, out value5) && value5.VRepeat > 0f)
			{
				y = value5.VRepeat;
			}
			material.SetTextureScale("_MainTex", (value2 == FlameMode.Surface || value2 == FlameMode.Shell) ? new Vector2(1f, 4f) : new Vector2(1f, y));
			material.renderQueue = 3100;
			renderer2.material = material;
			renderer2.castShadows = false;
			renderer2.receiveShadows = false;
			WeaponFlameAnimator weaponFlameAnimator = gameObject.AddComponent<WeaponFlameAnimator>();
			weaponFlameAnimator.SpinAxis = axis;
		}
	}

	private static float LongestOverlayExtent(Renderer[] renderers)
	{
		float num = 0f;
		if (renderers == null)
		{
			return 0f;
		}
		foreach (Renderer renderer in renderers)
		{
			if (renderer == null)
			{
				continue;
			}
			Material sharedMaterial = renderer.sharedMaterial;
			if (sharedMaterial == null)
			{
				continue;
			}
			Shader shader = sharedMaterial.shader;
			if (shader != null && shader.name != null && shader.name.IndexOf("Particle", StringComparison.OrdinalIgnoreCase) >= 0)
			{
				continue;
			}
			SkinnedMeshRenderer skinnedMeshRenderer = renderer as SkinnedMeshRenderer;
			MeshFilter component = renderer.GetComponent<MeshFilter>();
			Mesh mesh = ((skinnedMeshRenderer != null) ? skinnedMeshRenderer.sharedMesh : ((component != null) ? component.sharedMesh : null));
			if (!(mesh == null))
			{
				Vector3 size = mesh.bounds.size;
				float num2 = Mathf.Max(size.x, Mathf.Max(size.y, size.z));
				if (num2 > num)
				{
					num = num2;
				}
			}
		}
		return num;
	}

	private static void ReportFlamePartSkip(int itemId, GameObject weaponRoot, Renderer src, Mesh sourceMesh, float longest, float weaponLongest)
	{
		string text = ((weaponRoot != null) ? weaponRoot.name : "<null weapon>");
		string text2 = ((src != null) ? src.name : "<null renderer>");
		string text3 = ((sourceMesh != null) ? sourceMesh.name : "<null mesh>");
		string key = "small|" + itemId + "|" + text + "|" + text2 + "|" + text3;
		if (!_reportedFlameSkips.ContainsKey(key))
		{
			_reportedFlameSkips[key] = true;
			Debug.Log("WeaponSkinHelper: skin " + itemId + " gives no helix sleeve to " + text + "/" + text2 + " (mesh '" + text3 + "', longest extent " + longest.ToString("F4") + " = " + (longest / weaponLongest * 100f).ToString("F1") + "% of the weapon's " + weaponLongest.ToString("F4") + ", under the " + 15.000001f.ToString("F0") + "% floor). A sleeve is built from the PART's own bounding box, so on a small off-axis part it detaches from the weapon entirely. The rest of the skin is unaffected.");
		}
	}

	private static void ReportFlameSkip(int itemId, GameObject weaponRoot, Renderer src, Mesh sourceMesh)
	{
		string text = ((weaponRoot != null) ? weaponRoot.name : "<null weapon>");
		string text2 = ((src != null) ? src.name : "<null renderer>");
		string text3 = ((sourceMesh != null) ? sourceMesh.name : "<null mesh>");
		string key = itemId + "|" + text + "|" + text2 + "|" + text3;
		if (!_reportedFlameSkips.ContainsKey(key))
		{
			_reportedFlameSkips[key] = true;
			Debug.LogWarning("WeaponSkinHelper: skin " + itemId + " gets NO flame overlay on " + text + "/" + text2 + " (mesh '" + text3 + "') -- the overlay geometry could not be built, almost always because the mesh is not readable on the CPU. The skin's texture and shader are unaffected; only its flames are missing.");
		}
	}

	private static Mesh BuildFlameSleeve(Mesh source, int itemId, out Vector3 axis, out Vector3 centre)
	{
		axis = Vector3.up;
		centre = Vector3.zero;
		if (source == null)
		{
			return null;
		}
		string key = source.GetInstanceID() + "|" + itemId;
		Mesh value;
		if (_sleeveCache.TryGetValue(key, out value) && value != null)
		{
			axis = _sleeveAxis[key];
			centre = _sleeveCentre[key];
			return value;
		}
		Bounds bounds = source.bounds;
		Vector3 size = bounds.size;
		int num = 0;
		if (size.y > size.x)
		{
			num = 1;
		}
		if (size.z > size[num])
		{
			num = 2;
		}
		Vector3 vector;
		switch (num)
		{
		default:
			vector = Vector3.forward;
			break;
		case 1:
			vector = Vector3.up;
			break;
		case 0:
			vector = Vector3.right;
			break;
		}
		axis = vector;
		Vector3 vector2 = ((num == 0) ? Vector3.up : Vector3.right);
		Vector3 vector3 = ((num == 2) ? Vector3.up : Vector3.forward);
		float num2 = size[num] * 0.5f;
		if (num2 <= 1E-05f)
		{
			return null;
		}
		SleeveSpec value2;
		if (!SkinSleeves.TryGetValue(itemId, out value2))
		{
			value2.RadiusMult = 2f;
			value2.Ribbons = 2;
			value2.RibbonArc = 0.5f;
			value2.Twist = 2.1f;
			value2.Start = 0.3f;
			value2.MaxLenFrac = 0.042f;
			value2.VRepeat = 2f;
		}
		float num3 = Mathf.Min(size[(num + 1) % 3], size[(num + 2) % 3]) * 0.5f;
		float num4 = num2 * 2f;
		float num5 = Mathf.Clamp(num3 * value2.RadiusMult, num4 * 0.025f, num4 * value2.MaxLenFrac);
		float num6 = ((bounds.center[num] >= 0f) ? 1f : (-1f));
		float num7 = bounds.center[num] - num6 * num2;
		float num8 = bounds.center[num] + num6 * num2;
		float num9 = Mathf.Lerp(num7, num8, value2.Start);
		float num10 = num8;
		Vector3 center = bounds.center;
		centre = bounds.center;
		centre[num] = (num9 + num10) * 0.5f;
		Vector3[] array = new Vector3[22];
		Vector3[] array2 = null;
		try
		{
			array2 = source.vertices;
		}
		catch
		{
			array2 = null;
		}
		double[] array3 = new double[22];
		double[] array4 = new double[22];
		int[] array5 = new int[22];
		float num11 = Mathf.Min(num9, num10);
		float num12 = Mathf.Max(num9, num10);
		if (array2 != null && array2.Length != 0 && num12 > num11)
		{
			for (int i = 0; i < array2.Length; i++)
			{
				float num13 = array2[i][num];
				if (!(num13 < num11) && !(num13 > num12))
				{
					int num14 = Mathf.Clamp((int)((num13 - num11) / (num12 - num11) * 21f + 0.5f), 0, 21);
					array3[num14] += Vector3.Dot(array2[i], vector2);
					array4[num14] += Vector3.Dot(array2[i], vector3);
					array5[num14]++;
				}
			}
		}
		float num15 = Vector3.Dot(center, vector2);
		float num16 = Vector3.Dot(center, vector3);
		for (int j = 0; j < 22; j++)
		{
			if (array5[j] > 2)
			{
				num15 = (float)(array3[j] / (double)array5[j]);
				num16 = (float)(array4[j] / (double)array5[j]);
			}
			array[j] = vector2 * num15 + vector3 * num16;
		}
		Vector3[] array6 = new Vector3[22];
		for (int k = 0; k < 22; k++)
		{
			Vector3 vector4 = array[k] * 2f;
			float num17 = 2f;
			if (k > 0)
			{
				vector4 += array[k - 1];
				num17 += 1f;
			}
			if (k < 21)
			{
				vector4 += array[k + 1];
				num17 += 1f;
			}
			array6[k] = vector4 / num17;
		}
		array = array6;
		centre = Vector3.zero;
		int num18 = 6;
		int num19 = 22 * num18;
		int num20 = num19 * value2.Ribbons;
		Vector3[] array7 = new Vector3[num20];
		Vector2[] array8 = new Vector2[num20];
		Color[] array9 = new Color[num20];
		for (int l = 0; l < value2.Ribbons; l++)
		{
			float num21 = (float)l / (float)value2.Ribbons * (float)Math.PI * 2f;
			for (int m = 0; m < 22; m++)
			{
				float num22 = (float)m / 21f;
				float num23 = Mathf.Lerp(num9, num10, num22);
				float num24 = Mathf.Lerp(1f, 0.55f, Mathf.Pow(num22, 2.5f));
				float num25 = value2.Twist * (float)Math.PI * 2f * num22 + num21;
				for (int n = 0; n < num18; n++)
				{
					float num26 = (float)n / 5f - 0.5f;
					float f = num25 + num26 * value2.RibbonArc;
					int num27 = l * num19 + m * num18 + n;
					array7[num27] = axis * num23 + array[m] + vector2 * (Mathf.Cos(f) * num5 * num24) + vector3 * (Mathf.Sin(f) * num5 * num24);
					array8[num27] = new Vector2((float)n / 5f, num22);
					array9[num27] = Color.white;
				}
			}
		}
		int[] array10 = new int[value2.Ribbons * 21 * 5 * 6];
		int num28 = 0;
		for (int num29 = 0; num29 < value2.Ribbons; num29++)
		{
			int num30 = num29 * num19;
			for (int num31 = 0; num31 < 21; num31++)
			{
				for (int num32 = 0; num32 < 5; num32++)
				{
					int num33 = num30 + num31 * num18 + num32;
					int num34 = num33 + 1;
					int num35 = num33 + num18;
					int num36 = num35 + 1;
					array10[num28++] = num33;
					array10[num28++] = num35;
					array10[num28++] = num34;
					array10[num28++] = num34;
					array10[num28++] = num35;
					array10[num28++] = num36;
				}
			}
		}
		Mesh mesh = new Mesh();
		mesh.name = source.name + "__flameSleeve";
		mesh.vertices = array7;
		mesh.uv = array8;
		mesh.colors = array9;
		mesh.triangles = array10;
		mesh.RecalculateBounds();
		_sleeveCache[key] = mesh;
		_sleeveAxis[key] = axis;
		_sleeveCentre[key] = centre;
		string[] obj2 = new string[14]
		{
			"WeaponSkinHelper: flame sleeve for ", source.name, " axis=", null, null, null, null, null, null, null,
			null, null, null, null
		};
		Vector3 vector5 = axis;
		obj2[3] = vector5.ToString();
		obj2[4] = " radius=";
		obj2[5] = num5.ToString("F3");
		obj2[6] = " (thin half=";
		obj2[7] = num3.ToString("F3");
		obj2[8] = ", len=";
		obj2[9] = num4.ToString("F3");
		obj2[10] = ") span=";
		obj2[11] = (num10 - num9).ToString("F3");
		obj2[12] = " curve=";
		obj2[13] = (array[21] - array[0]).magnitude.ToString("F3");
		Debug.Log(string.Concat(obj2));
		return mesh;
	}

	private static bool CanCopyMesh(Mesh m)
	{
		try
		{
			if (m.vertexCount <= 0)
			{
				return false;
			}
			Vector3[] vertices = m.vertices;
			return vertices != null && vertices.Length != 0;
		}
		catch (Exception ex)
		{
			Debug.LogWarning("WeaponSkinHelper: mesh '" + m.name + "' is not CPU-readable: " + ex.Message);
			return false;
		}
	}

	private static Mesh WhiteVertexCopy(Mesh source)
	{
		if (source == null)
		{
			return null;
		}
		Mesh value;
		if (_flameMeshCache.TryGetValue(source, out value) && value != null)
		{
			return value;
		}
		if (!CanCopyMesh(source))
		{
			Debug.LogWarning("WeaponSkinHelper: mesh '" + source.name + "' cannot be copied on the CPU, so no flame overlay for it. The skin itself is unaffected.");
			_flameMeshCache[source] = null;
			return null;
		}
		Mesh mesh;
		try
		{
			mesh = new Mesh();
			mesh.name = source.name + "__flameOverlay";
			mesh.vertices = source.vertices;
			mesh.triangles = source.triangles;
			Vector2[] uv = source.uv;
			if (uv != null && uv.Length == mesh.vertexCount)
			{
				mesh.uv = uv;
			}
			Color[] array = new Color[mesh.vertexCount];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = Color.white;
			}
			mesh.colors = array;
			BoneWeight[] boneWeights = source.boneWeights;
			Matrix4x4[] bindposes = source.bindposes;
			if (boneWeights != null && boneWeights.Length == mesh.vertexCount && bindposes != null && bindposes.Length != 0)
			{
				mesh.boneWeights = boneWeights;
				mesh.bindposes = bindposes;
			}
			mesh.RecalculateBounds();
		}
		catch (Exception ex)
		{
			Debug.LogWarning("WeaponSkinHelper: could not rebuild '" + source.name + "' for the flame overlay (" + ex.Message + "); skipping flames for it.");
			_flameMeshCache[source] = null;
			return null;
		}
		_flameMeshCache[source] = mesh;
		return mesh;
	}

	public static void ApplyTracer(GameObject weaponRoot, int itemId)
	{
		TracerSpec value;
		if (!TracerOverrides.TryGetValue(itemId, out value))
		{
			return;
		}
		BaseWeaponDecorator component = weaponRoot.GetComponent<BaseWeaponDecorator>();
		if (!(component == null))
		{
			component.SetSurfaceEffect(value.Effect);
			WeaponTracerTinter weaponTracerTinter = weaponRoot.GetComponent<WeaponTracerTinter>();
			if (weaponTracerTinter == null)
			{
				weaponTracerTinter = weaponRoot.AddComponent<WeaponTracerTinter>();
			}
			weaponTracerTinter.StartColour = value.Start;
			weaponTracerTinter.EndColour = value.End;
			weaponTracerTinter.MatTint = value.MatTint;
		}
	}

	public static void ApplyMuzzleTint(GameObject weaponRoot, int itemId)
	{
		MuzzleTintSpec value;
		if (!MuzzleTints.TryGetValue(itemId, out value))
		{
			return;
		}
		if (value.HasLight)
		{
			Light[] componentsInChildren = weaponRoot.GetComponentsInChildren<Light>(true);
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				if (!(componentsInChildren[i] == null))
				{
					componentsInChildren[i].color = value.LightColour;
				}
			}
		}
		if (MUZZLE_DEBUG)
		{
			Light[] componentsInChildren2 = weaponRoot.GetComponentsInChildren<Light>(true);
			ParticleSystem[] componentsInChildren3 = weaponRoot.GetComponentsInChildren<ParticleSystem>(true);
			string text = "";
			for (int j = 0; j < componentsInChildren3.Length; j++)
			{
				text = text + ((j > 0) ? ", " : "") + componentsInChildren3[j].gameObject.name;
			}
			string text2 = "";
			for (int k = 0; k < componentsInChildren2.Length; k++)
			{
				text2 = text2 + ((k > 0) ? ", " : "") + componentsInChildren2[k].gameObject.name;
			}
			Debug.Log(string.Format("WeaponSkinHelper: muzzle tint {0} on '{1}' -- {2} light(s) [{3}], {4} particle system(s) [{5}]; wanted [{6}]", itemId, weaponRoot.name, componentsInChildren2.Length, text2, componentsInChildren3.Length, text, (value.ParticleObjects == null) ? "" : string.Join(", ", value.ParticleObjects)));
			Renderer[] componentsInChildren4 = weaponRoot.GetComponentsInChildren<Renderer>(true);
			for (int l = 0; l < componentsInChildren4.Length; l++)
			{
				Material sharedMaterial = componentsInChildren4[l].sharedMaterial;
				Debug.Log(string.Format("WeaponSkinHelper:   renderer '{0}' [{1}] mat '{2}' shader '{3}' enabled={4}", componentsInChildren4[l].gameObject.name, componentsInChildren4[l].GetType().Name, (sharedMaterial != null) ? sharedMaterial.name : "(null)", (sharedMaterial != null && sharedMaterial.shader != null) ? sharedMaterial.shader.name : "(null)", componentsInChildren4[l].enabled));
			}
			BaseWeaponEffect[] componentsInChildren5 = weaponRoot.GetComponentsInChildren<BaseWeaponEffect>(true);
			for (int m = 0; m < componentsInChildren5.Length; m++)
			{
				Debug.Log(string.Format("WeaponSkinHelper:   effect '{0}' [{1}]", componentsInChildren5[m].gameObject.name, componentsInChildren5[m].GetType().Name));
			}
		}
		if (value.HasParticles)
		{
			Component[] componentsInChildren6 = weaponRoot.GetComponentsInChildren<BaseWeaponEffect>(true);
			Component[] array = componentsInChildren6;
			for (int n = 0; n < array.Length; n++)
			{
				if (array[n] == null)
				{
					continue;
				}
				string name = array[n].GetType().Name;
				if (name != "BulletTrail" && name != "MuzzleParticleSystem" && name != "MuzzleHeatWave")
				{
					continue;
				}
				Renderer[] componentsInChildren7 = array[n].GetComponentsInChildren<Renderer>(true);
				for (int num = 0; num < componentsInChildren7.Length; num++)
				{
					if (componentsInChildren7[num] == null)
					{
						continue;
					}
					Material material = componentsInChildren7[num].material;
					if (!(material == null) && material.HasProperty("_TintColor"))
					{
						Color color = material.GetColor("_TintColor");
						material.SetColor("_TintColor", new Color(value.ParticleTint.r, value.ParticleTint.g, value.ParticleTint.b, color.a));
						if (MUZZLE_DEBUG)
						{
							Debug.Log(string.Format("WeaponSkinHelper: muzzle {0} tinted {1} renderer '{2}'", itemId, name, componentsInChildren7[num].gameObject.name));
						}
					}
				}
			}
		}
		if (value.TintRenderers != null)
		{
			Renderer[] componentsInChildren8 = weaponRoot.GetComponentsInChildren<Renderer>(true);
			for (int num2 = 0; num2 < componentsInChildren8.Length; num2++)
			{
				if (componentsInChildren8[num2] == null)
				{
					continue;
				}
				for (int num3 = 0; num3 < value.TintRenderers.Length; num3++)
				{
					if (componentsInChildren8[num2].gameObject.name != value.TintRenderers[num3])
					{
						continue;
					}
					Material material2 = componentsInChildren8[num2].material;
					if (material2 != null && material2.HasProperty("_TintColor"))
					{
						Color color2 = material2.GetColor("_TintColor");
						material2.SetColor("_TintColor", new Color(value.ParticleTint.r, value.ParticleTint.g, value.ParticleTint.b, color2.a));
						if (MUZZLE_DEBUG)
						{
							Debug.Log(string.Format("WeaponSkinHelper: muzzle {0} tinted renderer '{1}' (shader '{2}')", itemId, componentsInChildren8[num2].gameObject.name, (material2.shader != null) ? material2.shader.name : "(null)"));
						}
					}
					break;
				}
			}
		}
		if (!value.HasParticles || value.ParticleObjects == null)
		{
			return;
		}
		ParticleSystem[] componentsInChildren9 = weaponRoot.GetComponentsInChildren<ParticleSystem>(true);
		for (int num4 = 0; num4 < componentsInChildren9.Length; num4++)
		{
			if (componentsInChildren9[num4] == null)
			{
				continue;
			}
			for (int num5 = 0; num5 < value.ParticleObjects.Length; num5++)
			{
				if (componentsInChildren9[num4].gameObject.name != value.ParticleObjects[num5])
				{
					continue;
				}
				componentsInChildren9[num4].startColor = value.ParticleTint;
				Renderer component = componentsInChildren9[num4].GetComponent<Renderer>();
				if (component != null)
				{
					Material material3 = component.material;
					string text3 = ((material3 != null && material3.shader != null) ? material3.shader.name : "(null)");
					bool flag = material3 != null && material3.HasProperty("_TintColor");
					if (flag)
					{
						Color color3 = material3.GetColor("_TintColor");
						material3.SetColor("_TintColor", new Color(value.ParticleTint.r, value.ParticleTint.g, value.ParticleTint.b, color3.a));
					}
					if (MUZZLE_DEBUG)
					{
						Debug.Log(string.Format("WeaponSkinHelper: muzzle {0} '{1}' shader '{2}' _TintColor={3}", itemId, componentsInChildren9[num4].gameObject.name, text3, flag ? "SET" : "ABSENT -- shader has no _TintColor"));
					}
				}
				break;
			}
		}
	}

	static WeaponSkinHelper()
	{
		SkinTextures = new Dictionary<int, string>();
		SkinShellScale = new Dictionary<int, float>();
		SkinFlameModes = new Dictionary<int, FlameMode>();
		SkinShaders = new Dictionary<int, string[]>();
		SkinShaderResources = new Dictionary<int, string>();
		WaterTextureSet = new TextureBinding[4]
		{
			new TextureBinding("_MainTex", "items/shared/textures/water_a_nm", false),
			new TextureBinding("_BumpMap", "items/shared/textures/water_b_nm", false),
			new TextureBinding("_Caustics", "items/shared/textures/caustics_a_dm", false),
			new TextureBinding("_Cube", "items/shared/cubemaps/studio_a", true)
		};
		WaterBindings = new MaterialBindings
		{
			Textures = WaterTextureSet,
			Colors = new ColorBinding[3]
			{
				new ColorBinding("_Color", new Color(0f, 0.4392157f, 1f, 1f)),
				new ColorBinding("_WaterColor_Dark", new Color(0f, 13f / 85f, 0.47843137f, 1f)),
				new ColorBinding("_ReflectColor", new Color(0.41960785f, 0.8392157f, 1f, 0.5019608f))
			},
			Floats = new FloatBinding[5]
			{
				new FloatBinding("_Tiling", 0.5f),
				new FloatBinding("_Gloss", 1f),
				new FloatBinding("_Specular", 2f),
				new FloatBinding("_CausticsTiling", 2.25f),
				new FloatBinding("_CausticsDeform", 0.1f)
			}
		};
		LavaBindings = new MaterialBindings
		{
			Textures = WaterTextureSet,
			Colors = new ColorBinding[3]
			{
				new ColorBinding("_Color", new Color(0f, 0f, 0f, 1f)),
				new ColorBinding("_WaterColor_Dark", new Color(0.11764706f, 2f / 85f, 0f, 1f)),
				new ColorBinding("_ReflectColor", new Color(1f, 0.41568628f, 1f / 17f, 0.5019608f))
			},
			Floats = new FloatBinding[3]
			{
				new FloatBinding("_Tiling", 0.5f),
				new FloatBinding("_Gloss", 1f),
				new FloatBinding("_Specular", 2f)
			}
		};
		GlassIceBindings = new MaterialBindings
		{
			Colors = new ColorBinding[2]
			{
				new ColorBinding("_Color", new Color(0.78f, 0.88f, 0.96f, 1f)),
				new ColorBinding("_ReflectColor", new Color(0.35f, 0.72f, 1f, 0.5019608f))
			}
		};
		GlassMatteBindings = new MaterialBindings
		{
			Colors = new ColorBinding[2]
			{
				new ColorBinding("_Color", new Color(0.56f, 0.64f, 0.72f, 0.86f)),
				new ColorBinding("_ReflectColor", new Color(0.05f, 0.07f, 0.09f, 0.5019608f))
			}
		};
		SkinMaterialBindings = new Dictionary<int, MaterialBindings>();
		SkinReflectTints = new Dictionary<int, Color>();
		SkinFlameTints = new Dictionary<int, Color>();
		SkinSleeves = new Dictionary<int, SleeveSpec>();
		SkinFlames = new Dictionary<int, string>();
		IconTextures = new Dictionary<int, string>();
		TracerOverrides = new Dictionary<int, TracerSpec>();
		MuzzleTints = new Dictionary<int, MuzzleTintSpec>();
		_skinCache = new Dictionary<int, Texture2D>();
		_iconCache = new Dictionary<int, Texture2D>();
		_resourceTexCache = new Dictionary<string, Texture>();
		_reportedMissingProps = new Dictionary<string, bool>();
		_reportedFlameSkips = new Dictionary<string, bool>();
		_flameMeshCache = new Dictionary<Mesh, Mesh>();
		_sleeveCache = new Dictionary<string, Mesh>();
		_sleeveAxis = new Dictionary<string, Vector3>();
		_sleeveCentre = new Dictionary<string, Vector3>();
		MUZZLE_DEBUG = false;
		Skins = new Dictionary<int, SkinDef> { 
		{
			2010,
			new SkinDef
			{
				SkinTextures = "2010_HazardousShotgun.png",
				IconTextures = "2010_HazardousShotgun_Icon.png"
			}
		} };
		foreach (KeyValuePair<int, SkinDef> skin in Skins)
		{
			int key = skin.Key;
			SkinDef value = skin.Value;
			if (value.SkinTextures != null)
			{
				SkinTextures[key] = value.SkinTextures;
			}
			if (value.SkinShellScale.HasValue)
			{
				SkinShellScale[key] = value.SkinShellScale.Value;
			}
			if (value.SkinFlameModes.HasValue)
			{
				SkinFlameModes[key] = value.SkinFlameModes.Value;
			}
			if (value.SkinShaders != null)
			{
				SkinShaders[key] = value.SkinShaders;
			}
			if (value.SkinShaderResources != null)
			{
				SkinShaderResources[key] = value.SkinShaderResources;
			}
			if (value.SkinMaterialBindings != null)
			{
				SkinMaterialBindings[key] = value.SkinMaterialBindings;
			}
			if (value.SkinReflectTints.HasValue)
			{
				SkinReflectTints[key] = value.SkinReflectTints.Value;
			}
			if (value.SkinFlameTints.HasValue)
			{
				SkinFlameTints[key] = value.SkinFlameTints.Value;
			}
			if (value.SkinSleeves.HasValue)
			{
				SkinSleeves[key] = value.SkinSleeves.Value;
			}
			if (value.SkinFlames != null)
			{
				SkinFlames[key] = value.SkinFlames;
			}
			if (value.IconTextures != null)
			{
				IconTextures[key] = value.IconTextures;
			}
			if (value.TracerOverrides.HasValue)
			{
				TracerOverrides[key] = value.TracerOverrides.Value;
			}
			if (value.MuzzleTints.HasValue)
			{
				MuzzleTints[key] = value.MuzzleTints.Value;
			}
		}
	}
}
