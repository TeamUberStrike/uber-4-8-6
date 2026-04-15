using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SunnySummerDay : MonoBehaviour
{
	// Scenes that ship their own baked RenderSettings — ambient, fog, skybox,
	// directional lights — that ForgeRipper migrated from the Steam client.
	// SunnySummerDay must NOT run on these, or it stomps every map's atmosphere.
	// All other scenes (Menu/lobby, GlobalScene bootstrap, any non-listed name)
	// get the procedural sunny-day setup.
	private static readonly HashSet<string> GameplayMapScenes = new HashSet<string>
	{
		"ApexTwin", "AqualabResearchHub", "Catalyst", "CuberSpace", "CuberStrike",
		"CuberStrikeBluebox", "FortWinter", "GhostIsland", "GideonsTower", "LostParadise2",
		"MonkeyIsland", "SkyGarden", "SpaceCity", "SpacePortAlpha", "SuperPRISMReactor",
		"TempleOfTheRaven", "TheHangar", "TheWarehouse", "UberZone", "Volley"
	};

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
	private static void AutoBootstrap()
	{
		SceneManager.sceneLoaded += OnSceneLoaded;
		// On the very first fire (bootstrap), use whatever the active scene is.
		TryApplyForScene(SceneManager.GetActiveScene().name);
	}

	private static void OnSceneLoaded(Scene scene, LoadSceneMode mode)
	{
		// Use the scene parameter (the scene that JUST loaded), not
		// SceneManager.GetActiveScene() which may still reference the previous
		// active scene during the async transition.
		TryApplyForScene(scene.name);
	}

	private static void TryApplyForScene(string sceneName)
	{
		// Blacklist: if this is a gameplay map, skip + clean up any leaked manager.
		// Whitelist would have been wrong because we don't know every non-gameplay
		// scene name (Menu, GlobalScene, Auth, etc.).
		if (GameplayMapScenes.Contains(sceneName))
		{
			// Defensive cleanup: if a SummerDayManager leaked in from a previous
			// non-gameplay scene via DontDestroyOnLoad, destroy it so its Update()
			// loop stops mutating shared materials while a map is active.
			GameObject leaked = GameObject.Find("SummerDayManager");
			if (leaked != null)
			{
				Object.Destroy(leaked);
			}
			return;
		}
		if (GameObject.Find("SummerDayManager") != null)
		{
			return;
		}
		GameObject go = new GameObject("SummerDayManager");
		Object.DontDestroyOnLoad(go);
		SunnySummerDay sd = go.AddComponent<SunnySummerDay>();
		Light best = null;
		float bestIntensity = -1f;
		foreach (Light l in Object.FindObjectsOfType<Light>())
		{
			if (l != null && l.type == LightType.Directional && l.intensity > bestIntensity)
			{
				best = l;
				bestIntensity = l.intensity;
			}
		}
		sd.sunLight = best;
		Shader proc = Shader.Find("Skybox/Procedural");
		if (proc == null)
		{
			return;
		}
		Material mat = new Material(proc);
		mat.name = "SunnySummerDay_Runtime";
		sd.skyboxMaterial = mat;
		sd.skyTint = new Color(0.5f, 0.5f, 0.5f);
		sd.atmosphereThickness = 1.4f;
		sd.exposure = 1.3f;
		sd.sunIntensity = 1.3f;
		sd.ApplySummerLook();
		if (best != null)
		{
			RenderSettings.sun = best;
		}
	}

	[Header("Sun")]
	public Light sunLight;
	public Vector3 sunRotation = new Vector3(45f, -30f, 0f);
	public Color sunColor = new Color(1f, 0.95f, 0.8f);
	[Range(0f, 2f)] public float sunIntensity = 1.2f;

	[Header("Sky")]
	public Material skyboxMaterial;
	public Color skyTint = new Color(0.4f, 0.65f, 1f);
	[Range(0f, 2f)] public float atmosphereThickness = 0.8f;
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

	private void Start()
	{
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
