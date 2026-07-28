using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SunnySummerDay : MonoBehaviour
{
	// Every scene that ships its own baked skybox/RenderSettings.
	// Menu has SkyBox_Cloudy_A (blue sky with clouds) baked in.
	// Gameplay maps have their own space/day/halloween skyboxes.
	// DesktopHUD is loaded additively after gameplay maps.
	// Only unlisted scenes (GlobalScene bootstrap, auth screens) get the
	// procedural sunny-day fallback.
	private static readonly HashSet<string> BlockedScenes = new HashSet<string>
	{
		"ApexTwin", "AqualabResearchHub", "Catalyst", "CuberSpace", "CuberStrike",
		"CuberStrikeBluebox", "DesktopHUD", "FortWinter", "GhostIsland", "GideonsTower",
		"LostParadise2", "Menu", "MonkeyIsland", "SkyGarden", "SpaceCity",
		"SpacePortAlpha", "SuperPRISMReactor", "TempleOfTheRaven", "TheHangar",
		"TheWarehouse", "UberZone", "Volley"
	};

	private static SunnySummerDay _instance;
	private static Material _cachedSkyboxMaterial;

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
	private static void AutoBootstrap()
	{
		SceneManager.sceneLoaded += OnSceneLoaded;
		TryApplyForScene(SceneManager.GetActiveScene().name);
	}

	private static void OnSceneLoaded(Scene scene, LoadSceneMode mode)
	{
		TryApplyForScene(scene.name);
	}

	private static void TryApplyForScene(string sceneName)
	{
		if (BlockedScenes.Contains(sceneName))
		{
			if (_instance != null)
			{
				DestroyImmediate(_instance.gameObject);
				_instance = null;
			}
			return;
		}

		if (_instance != null)
		{
			return;
		}

		// Reuse the procedural skybox material across lobby visits so the look
		// is identical every time (prevents the sunset-on-return glitch).
		if (_cachedSkyboxMaterial == null)
		{
			Shader proc = Shader.Find("Skybox/Procedural");
			if (proc == null) return;
			_cachedSkyboxMaterial = new Material(proc);
			_cachedSkyboxMaterial.name = "SunnySummerDay_Runtime";
		}

		GameObject go = new GameObject("SummerDayManager");
		DontDestroyOnLoad(go);

		// Use an existing directional light if available (Menu scene has one).
		// Only create a fallback if no light exists, to avoid double-brightness.
		Light sun = null;
		float bestIntensity = -1f;
		foreach (Light l in FindObjectsOfType<Light>())
		{
			if (l != null && l.type == LightType.Directional && l.intensity > bestIntensity)
			{
				sun = l;
				bestIntensity = l.intensity;
			}
		}
		if (sun == null)
		{
			GameObject sunGo = new GameObject("SummerDaySun");
			sunGo.transform.SetParent(go.transform);
			sun = sunGo.AddComponent<Light>();
			sun.type = LightType.Directional;
		}

		SunnySummerDay sd = go.AddComponent<SunnySummerDay>();
		_instance = sd;
		sd.sunLight = sun;
		sd.skyboxMaterial = _cachedSkyboxMaterial;

		// Apply immediately — no Start() call needed.
		sd._skipStart = true;
		sd.ApplySummerLook();
		RenderSettings.sun = sun;
	}

	private void OnDestroy()
	{
		if (_instance == this) _instance = null;
	}

	[Header("Sun")]
	public Light sunLight;
	public Vector3 sunRotation = new Vector3(45f, -30f, 0f);
	public Color sunColor = new Color(1f, 0.95f, 0.8f);
	[Range(0f, 2f)] public float sunIntensity = 1.3f;

	[Header("Sky")]
	public Material skyboxMaterial;
	public Color skyTint = new Color(0.5f, 0.5f, 0.5f);
	[Range(0f, 2f)] public float atmosphereThickness = 1.4f;
	[Range(0f, 2f)] public float exposure = 1.3f;

	[Header("Ambient")]
	public Color ambientSkyColor = new Color(0.45f, 0.65f, 1f);
	public Color ambientEquatorColor = new Color(0.75f, 0.85f, 1f);
	public Color ambientGroundColor = new Color(0.55f, 0.5f, 0.4f);

	[Header("Fog")]
	public bool enableFog = true;
	public Color fogColor = new Color(0.7f, 0.85f, 1f);
	[Range(0.0001f, 0.05f)] public float fogDensity = 0.002f;

	[Header("Cloud Motion")]
	public bool animateClouds = true;
	public Vector2 cloudSpeed = new Vector2(0.003f, 0.0015f);

	private Vector2 cloudOffset;
	private bool _skipStart;

	private void Start()
	{
		// TryApplyForScene already called ApplySummerLook(). Skip the redundant
		// Start() call to avoid re-applying with potentially stale state.
		if (_skipStart) return;
		ApplySummerLook();
	}

	private void Update()
	{
		if (animateClouds && skyboxMaterial != null)
		{
			cloudOffset += cloudSpeed * Time.deltaTime;
			if (skyboxMaterial.HasProperty("_MainTex"))
			{
				skyboxMaterial.SetTextureOffset("_MainTex", cloudOffset);
			}
		}
	}

	[ContextMenu("Apply Summer Look")]
	public void ApplySummerLook()
	{
		if (sunLight != null)
		{
			sunLight.type = LightType.Directional;
			sunLight.color = sunColor;
			sunLight.intensity = sunIntensity;
			sunLight.transform.rotation = Quaternion.Euler(sunRotation);
			sunLight.shadows = LightShadows.Soft;
		}

		if (skyboxMaterial != null)
		{
			RenderSettings.skybox = skyboxMaterial;

			if (skyboxMaterial.HasProperty("_SkyTint"))
				skyboxMaterial.SetColor("_SkyTint", skyTint);

			if (skyboxMaterial.HasProperty("_AtmosphereThickness"))
				skyboxMaterial.SetFloat("_AtmosphereThickness", atmosphereThickness);

			if (skyboxMaterial.HasProperty("_Exposure"))
				skyboxMaterial.SetFloat("_Exposure", exposure);

			if (skyboxMaterial.HasProperty("_SunSize"))
				skyboxMaterial.SetFloat("_SunSize", 0.05f);

			if (skyboxMaterial.HasProperty("_SunSizeConvergence"))
				skyboxMaterial.SetFloat("_SunSizeConvergence", 5f);
		}

		RenderSettings.ambientMode = UnityEngine.Rendering.AmbientMode.Trilight;
		RenderSettings.ambientSkyColor = ambientSkyColor;
		RenderSettings.ambientEquatorColor = ambientEquatorColor;
		RenderSettings.ambientGroundColor = ambientGroundColor;

		DynamicGI.UpdateEnvironment();

		RenderSettings.fog = enableFog;
		RenderSettings.fogColor = fogColor;
		RenderSettings.fogMode = FogMode.Exponential;
		RenderSettings.fogDensity = fogDensity;
	}
}
