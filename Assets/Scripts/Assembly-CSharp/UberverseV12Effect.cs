using System;
using System.Collections.Generic;
using UnityEngine;

public sealed class UberverseV12Effect : MonoBehaviour
{
	public const int ItemId = 9084;

	public const string RootName = "UberverseV12_OrbitalSystem";

	private const int PlanetCount = 3;

	private const int RibbonSegments = 64;

	private const int RibbonCount = 7;

	private const int SpriteCount = 36;

	private readonly List<UnityEngine.Object> owned = new List<UnityEngine.Object>();

	private readonly List<Renderer> renderers = new List<Renderer>();

	private readonly Transform[] planets = new Transform[3];

	private readonly Vector3[] planetPositions = new Vector3[3];

	private readonly Vector3[] spritePositions = new Vector3[36];

	private readonly float[] spriteSizes = new float[36];

	private readonly Color[] spriteColours = new Color[36];

	private static readonly Color Gold = new Color(1f, 0.65f, 0.2f, 1f);

	private static readonly Color Cyan = new Color(0.2f, 0.85f, 1f, 1f);

	private static readonly Color[] Palette = new Color[3]
	{
		new Color(0.43f, 0.16f, 1f),
		new Color(1f, 0.12f, 0.55f),
		new Color(0.08f, 0.64f, 1f)
	};

	private Renderer source;

	private Mesh ribbons;

	private Mesh sprites;

	private Vector3[] ribbonVertices;

	private Vector3[] spriteVertices;

	private Vector3[] ribbonStarts;

	private Vector3[] ribbonEnds;

	private float[] ribbonWidths;

	private Color[] ribbonColours;

	private Color[] spriteVertexColours;

	private double clock;

	private float scale;

	private Vector3 anchor;

	private bool ready;

	public static bool Owns(Renderer renderer)
	{
		if (renderer == null)
		{
			return false;
		}
		Transform parent = renderer.transform;
		while (parent != null)
		{
			if (parent.GetComponent<UberverseV12Effect>() != null)
			{
				return true;
			}
			parent = parent.parent;
		}
		return false;
	}

	public static void Apply(GameObject weaponRoot, int itemId)
	{
		if (weaponRoot == null)
		{
			return;
		}
		UberverseV12Effect[] componentsInChildren = weaponRoot.GetComponentsInChildren<UberverseV12Effect>(true);
		bool flag = false;
		UberverseV12Effect[] array = componentsInChildren;
		foreach (UberverseV12Effect uberverseV12Effect in array)
		{
			if (itemId == 9084 && uberverseV12Effect.ready && uberverseV12Effect.source != null && !flag)
			{
				flag = true;
				continue;
			}
			uberverseV12Effect.ready = false;
			uberverseV12Effect.gameObject.SetActive(false);
			UnityEngine.Object.Destroy(uberverseV12Effect.gameObject);
		}
		if (itemId != 9084 || flag)
		{
			return;
		}
		MeshFilter[] componentsInChildren2 = weaponRoot.GetComponentsInChildren<MeshFilter>(true);
		foreach (MeshFilter meshFilter in componentsInChildren2)
		{
			if (meshFilter.sharedMesh == null || meshFilter.sharedMesh.name != "AWP")
			{
				continue;
			}
			Renderer component = meshFilter.GetComponent<Renderer>();
			if (!(component == null) && !Owns(component))
			{
				GameObject gameObject = new GameObject("UberverseV12_OrbitalSystem");
				gameObject.transform.parent = component.transform;
				gameObject.transform.localPosition = Vector3.zero;
				gameObject.transform.localRotation = Quaternion.identity;
				gameObject.transform.localScale = Vector3.one;
				gameObject.layer = component.gameObject.layer;
				UberverseV12Effect uberverseV12Effect2 = gameObject.AddComponent<UberverseV12Effect>();
				try
				{
					uberverseV12Effect2.Initialize(component, meshFilter.sharedMesh.bounds);
					return;
				}
				catch (Exception ex)
				{
					gameObject.SetActive(false);
					UnityEngine.Object.Destroy(gameObject);
					Debug.LogError("Uberverse effects: " + ex.Message);
					return;
				}
			}
		}
		Debug.LogWarning("Uberverse effects: AWP body mesh not found; no effects attached.");
	}

	private T Keep<T>(T resource) where T : UnityEngine.Object
	{
		owned.Add(resource);
		return resource;
	}

	private void Initialize(Renderer body, Bounds bounds)
	{
		source = body;
		scale = bounds.size.z / 1.477879f;
		anchor = new Vector3(bounds.center.x, bounds.max.y + 0.045f * scale, bounds.min.z + bounds.size.z * 0.39f);
		Shader shader = FindSupported("Particles/Additive", "Particles/Alpha Blended");
		Shader shader2 = FindSupported("Self-Illumin/Diffuse", "Diffuse");
		if (shader2 == null)
		{
			throw new InvalidOperationException("Neither legacy illuminated nor diffuse planet shader is available.");
		}
		Mesh mesh = Keep(BuildSphere());
		for (int i = 0; i < 3; i++)
		{
			Material material = Keep(new Material(shader2));
			material.name = "Uberverse_Planet_" + i;
			material.mainTexture = Keep(BuildPlanetTexture(i));
			if (material.HasProperty("_Color"))
			{
				material.SetColor("_Color", Color.white);
			}
			if (material.HasProperty("_Illum"))
			{
				material.SetTexture("_Illum", material.mainTexture);
			}
			planets[i] = NewRenderer("Planet_" + i, mesh, material).transform;
			planets[i].localScale = Vector3.one * PlanetRadius(i);
		}
		if (shader != null)
		{
			Material material2 = Keep(new Material(shader));
			material2.name = "Uberverse_Nebula";
			material2.mainTexture = Keep(BuildFalloff(false));
			if (material2.HasProperty("_TintColor"))
			{
				material2.SetColor("_TintColor", new Color(0.5f, 0.5f, 0.5f, 0.5f));
			}
			Material material3 = Keep(new Material(shader));
			material3.name = "Uberverse_OrbitGold";
			material3.mainTexture = Keep(BuildFalloff(true));
			if (material3.HasProperty("_TintColor"))
			{
				material3.SetColor("_TintColor", new Color(0.5f, 0.5f, 0.5f, 0.7f));
			}
			ribbons = Keep(NewQuadMesh(448, out ribbonVertices, out ribbonColours));
			ribbonStarts = new Vector3[448];
			ribbonEnds = new Vector3[ribbonStarts.Length];
			ribbonWidths = new float[ribbonStarts.Length];
			Renderer renderer = NewRenderer("Golden_Orbits", ribbons, material3);
			renderer.gameObject.AddComponent<UberverseV12RibbonCamera>().Owner = this;
			sprites = Keep(NewQuadMesh(36, out spriteVertices, out spriteVertexColours));
			base.gameObject.AddComponent<MeshFilter>().sharedMesh = sprites;
			MeshRenderer meshRenderer = base.gameObject.AddComponent<MeshRenderer>();
			Configure(meshRenderer, material2);
		}
		else
		{
			Debug.LogWarning("Uberverse: particle shaders unavailable; showing shaded planets only.");
		}
		ready = true;
		Animate(0.0);
		UpdateBillboards(Vector3.right, Vector3.up);
	}

	private static Shader FindSupported(string preferred, string fallback)
	{
		Shader shader = Shader.Find(preferred);
		if (shader != null && shader.isSupported)
		{
			return shader;
		}
		shader = Shader.Find(fallback);
		if (!(shader != null) || !shader.isSupported)
		{
			return null;
		}
		return shader;
	}

	private Renderer NewRenderer(string label, Mesh mesh, Material material)
	{
		GameObject gameObject = new GameObject(label);
		gameObject.layer = base.gameObject.layer;
		gameObject.transform.parent = base.transform;
		gameObject.transform.localPosition = Vector3.zero;
		gameObject.transform.localRotation = Quaternion.identity;
		gameObject.transform.localScale = Vector3.one;
		gameObject.AddComponent<MeshFilter>().sharedMesh = mesh;
		MeshRenderer result = gameObject.AddComponent<MeshRenderer>();
		Configure(result, material);
		return result;
	}

	private void Configure(Renderer renderer, Material material)
	{
		renderer.sharedMaterial = material;
		renderer.castShadows = false;
		renderer.receiveShadows = false;
		renderer.enabled = source.enabled;
		renderers.Add(renderer);
	}

	private float PlanetRadius(int i)
	{
		float num;
		switch (i)
		{
		default:
			num = 0.0095f;
			break;
		case 1:
			num = 0.013f;
			break;
		case 0:
			num = 0.018f;
			break;
		}
		return num * scale;
	}

	private Vector3 Orbit(int i, float angle)
	{
		float num = (0.044f + (float)i * 0.016f) * scale;
		Vector3 vector = new Vector3(Mathf.Cos(angle) * num, Mathf.Sin(angle) * (0.012f + (float)i * 0.0025f) * scale, Mathf.Sin(angle) * (0.066f + (float)i * 0.011f) * scale);
		return anchor + vector + new Vector3(0f, (float)i * 0.015f * scale, (float)(i - 1) * 0.015f * scale);
	}

	private void LateUpdate()
	{
		if (!ready)
		{
			return;
		}
		if (source == null)
		{
			base.gameObject.SetActive(false);
			UnityEngine.Object.Destroy(base.gameObject);
			return;
		}
		bool flag = source.enabled && source.gameObject.activeInHierarchy;
		base.gameObject.layer = source.gameObject.layer;
		foreach (Renderer renderer in renderers)
		{
			renderer.gameObject.layer = base.gameObject.layer;
			renderer.enabled = flag;
		}
		if (flag)
		{
			clock += Time.deltaTime;
			Animate(clock);
		}
	}

	private static float Phase(double time, double speed, double offset)
	{
		return (float)((time * speed + offset) % (Math.PI * 2.0));
	}

	private void Animate(double time)
	{
		int num = 0;
		for (int i = 0; i < 3; i++)
		{
			float num2 = Phase(time, 0.1 + (double)i * 0.05, (double)i * 2.094395);
			planetPositions[i] = Orbit(i, num2);
			planets[i].localPosition = planetPositions[i];
			planets[i].localRotation = Quaternion.Euler(18f + (float)i * 16f, (float)(time * (3.0 + (double)i * 2.0) % 360.0), 24f);
			for (int j = 0; j < 64; j++)
			{
				float angle = (float)j * (float)Math.PI * 2f / 64f;
				float angle2 = (float)(j + 1) * (float)Math.PI * 2f / 64f;
				RibbonQuad(num++, Orbit(i, angle), Orbit(i, angle2), 0.00065f * scale, new Color(Gold.r, Gold.g, Gold.b, 0.32f));
			}
			for (int k = 0; k < 64; k++)
			{
				float num3 = (float)k / 64f;
				float angle3 = num2 - (1f - num3) * 0.95f;
				float angle4 = num2 - (1f - ((float)k + 1f) / 64f) * 0.95f;
				RibbonQuad(num++, Orbit(i, angle3), Orbit(i, angle4), (0.0005f + num3 * 0.0011f) * scale, new Color(1f, 0.72f + num3 * 0.18f, 0.32f + num3 * 0.38f, num3 * num3 * 0.85f));
			}
			spritePositions[i] = planetPositions[i];
			spriteSizes[i] = PlanetRadius(i) * 3.4f;
			spriteColours[i] = WithAlpha(Color.Lerp(Palette[i], Cyan, 0.28f), 0.42f);
		}
		Quaternion quaternion = Quaternion.Euler(24f, 0f, -22f);
		for (int l = 0; l < 64; l++)
		{
			float f = (float)l * (float)Math.PI * 2f / 64f;
			float f2 = (float)(l + 1) * (float)Math.PI * 2f / 64f;
			Vector3 vector = quaternion * new Vector3(Mathf.Cos(f), 0f, Mathf.Sin(f)) * 0.03f * scale;
			Vector3 vector2 = quaternion * new Vector3(Mathf.Cos(f2), 0f, Mathf.Sin(f2)) * 0.03f * scale;
			RibbonQuad(num++, planetPositions[0] + vector, planetPositions[0] + vector2, 0.0018f * scale, new Color(1f, 0.73f, 0.38f, 0.65f));
		}
		if (ribbons != null)
		{
			ribbons.vertices = ribbonVertices;
			ribbons.colors = ribbonColours;
		}
		for (int m = 3; m < 36; m++)
		{
			int num4 = m - 3;
			float f3 = Phase(time, (m < 12) ? 0.05 : 0.1, (double)num4 * 2.399963);
			float num5 = 0.5f + 0.5f * Mathf.Sin(Phase(time, 0.5, (double)num4 * 1.7));
			if (m < 12)
			{
				spritePositions[m] = anchor + new Vector3(Mathf.Cos(f3) * 0.04f, -0.075f + Mathf.Sin(f3) * 0.018f, -0.13f + (float)num4 * 0.043f) * scale;
				spriteSizes[m] = (0.062f + 0.012f * num5) * scale;
				spriteColours[m] = WithAlpha(Palette[num4 % 3], 0.055f + num5 * 0.02f);
			}
			else
			{
				spritePositions[m] = anchor + new Vector3(Mathf.Cos(f3) * (0.05f + (float)(num4 % 4) * 0.011f), -0.035f + Mathf.Sin(Phase(time, 0.14, (double)num4 * 2.399963 * 1.4)) * 0.06f, -0.13f + (float)(num4 % 13) * 0.024f) * scale;
				spriteSizes[m] = (0.0019f + 0.0011f * num5 + ((num4 % 9 == 0) ? 0.0014f : 0f)) * scale;
				spriteColours[m] = WithAlpha((num4 % 3 == 0) ? Gold : Cyan, 0.2f + num5 * 0.45f);
			}
		}
	}

	private static Color WithAlpha(Color colour, float alpha)
	{
		colour.a = alpha;
		return colour;
	}

	private void RibbonQuad(int quad, Vector3 a, Vector3 b, float width, Color colour)
	{
		if (!(ribbons == null))
		{
			ribbonStarts[quad] = a;
			ribbonEnds[quad] = b;
			ribbonWidths[quad] = width;
			Vector3 vector = Vector3.Cross((b - a).normalized, Vector3.up).normalized * width;
			int num = quad * 4;
			ribbonVertices[num] = a - vector;
			ribbonVertices[num + 1] = a + vector;
			ribbonVertices[num + 2] = b + vector;
			ribbonVertices[num + 3] = b - vector;
			for (int i = 0; i < 4; i++)
			{
				ribbonColours[num + i] = colour;
			}
		}
	}

	internal void FaceRibbons(Camera camera)
	{
		if (!ready || ribbons == null || camera == null)
		{
			return;
		}
		Vector3 vector = base.transform.InverseTransformPoint(camera.transform.position);
		Vector3 normalized = base.transform.InverseTransformVector(-camera.transform.forward).normalized;
		Vector3 normalized2 = base.transform.InverseTransformVector(camera.transform.up).normalized;
		for (int i = 0; i < ribbonStarts.Length; i++)
		{
			Vector3 vector2 = ribbonStarts[i];
			Vector3 vector3 = ribbonEnds[i];
			Vector3 normalized3 = (vector3 - vector2).normalized;
			Vector3 rhs = (camera.orthographic ? normalized : (vector - (vector2 + vector3) * 0.5f).normalized);
			Vector3 vector4 = Vector3.Cross(normalized3, rhs);
			if (vector4.sqrMagnitude < 1E-06f)
			{
				vector4 = Vector3.Cross(normalized3, normalized2);
			}
			vector4 = vector4.normalized * ribbonWidths[i];
			int num = i * 4;
			ribbonVertices[num] = vector2 - vector4;
			ribbonVertices[num + 1] = vector2 + vector4;
			ribbonVertices[num + 2] = vector3 + vector4;
			ribbonVertices[num + 3] = vector3 - vector4;
		}
		ribbons.vertices = ribbonVertices;
	}

	private void OnWillRenderObject()
	{
		if (ready && !(Camera.current == null))
		{
			UpdateBillboards(base.transform.InverseTransformVector(Camera.current.transform.right).normalized, base.transform.InverseTransformVector(Camera.current.transform.up).normalized);
		}
	}

	private void UpdateBillboards(Vector3 right, Vector3 up)
	{
		if (sprites == null)
		{
			return;
		}
		for (int i = 0; i < 36; i++)
		{
			Vector3 vector = right * spriteSizes[i];
			Vector3 vector2 = up * spriteSizes[i];
			Vector3 vector3 = spritePositions[i];
			int num = i * 4;
			spriteVertices[num] = vector3 - vector - vector2;
			spriteVertices[num + 1] = vector3 + vector - vector2;
			spriteVertices[num + 2] = vector3 + vector + vector2;
			spriteVertices[num + 3] = vector3 - vector + vector2;
			for (int j = 0; j < 4; j++)
			{
				spriteVertexColours[num + j] = spriteColours[i];
			}
		}
		sprites.vertices = spriteVertices;
		sprites.colors = spriteVertexColours;
	}

	private Mesh NewQuadMesh(int quads, out Vector3[] vertices, out Color[] colours)
	{
		Mesh mesh = new Mesh();
		mesh.name = "Uberverse_Dynamic";
		mesh.MarkDynamic();
		vertices = new Vector3[quads * 4];
		colours = new Color[quads * 4];
		Vector2[] array = new Vector2[quads * 4];
		int[] array2 = new int[quads * 6];
		for (int i = 0; i < quads; i++)
		{
			int num = i * 4;
			int num2 = i * 6;
			array[num] = new Vector2(0f, 0f);
			array[num + 1] = new Vector2(1f, 0f);
			array[num + 2] = new Vector2(1f, 1f);
			array[num + 3] = new Vector2(0f, 1f);
			array2[num2] = num;
			array2[num2 + 1] = num + 1;
			array2[num2 + 2] = num + 2;
			array2[num2 + 3] = num;
			array2[num2 + 4] = num + 2;
			array2[num2 + 5] = num + 3;
		}
		mesh.vertices = vertices;
		mesh.uv = array;
		mesh.colors = colours;
		mesh.triangles = array2;
		mesh.bounds = new Bounds(anchor + Vector3.forward * 0.12f * scale, Vector3.one * 1.5f * scale);
		return mesh;
	}

	private static Mesh BuildSphere()
	{
		Vector3[] array = new Vector3[325];
		Vector2[] array2 = new Vector2[array.Length];
		int[] array3 = new int[1728];
		for (int i = 0; i <= 12; i++)
		{
			for (int j = 0; j <= 24; j++)
			{
				float num = (float)j / 24f;
				float num2 = (float)i / 12f;
				float f = num2 * (float)Math.PI;
				float f2 = num * (float)Math.PI * 2f;
				int num3 = i * 25 + j;
				array[num3] = new Vector3(Mathf.Sin(f) * Mathf.Cos(f2), Mathf.Cos(f), Mathf.Sin(f) * Mathf.Sin(f2));
				array2[num3] = new Vector2(num, num2);
				if (j != 24 && i != 12)
				{
					int num4 = (i * 24 + j) * 6;
					int num5 = num3 + 24 + 1;
					array3[num4] = num3;
					array3[num4 + 1] = num3 + 1;
					array3[num4 + 2] = num5;
					array3[num4 + 3] = num3 + 1;
					array3[num4 + 4] = num5 + 1;
					array3[num4 + 5] = num5;
				}
			}
		}
		Mesh mesh = new Mesh();
		mesh.name = "Uberverse_PlanetSphere";
		mesh.vertices = array;
		mesh.normals = array;
		mesh.uv = array2;
		mesh.triangles = array3;
		mesh.RecalculateBounds();
		return mesh;
	}

	private static Texture2D BuildFalloff(bool ribbon)
	{
		Texture2D texture2D = new Texture2D(64, 64, TextureFormat.RGBA32, true);
		texture2D.filterMode = FilterMode.Trilinear;
		texture2D.name = (ribbon ? "Uberverse_SoftThread" : "Uberverse_SoftHalo");
		texture2D.wrapMode = TextureWrapMode.Clamp;
		Color[] array = new Color[4096];
		for (int i = 0; i < 64; i++)
		{
			for (int j = 0; j < 64; j++)
			{
				float num = (float)j / 63f * 2f - 1f;
				float num2 = (float)i / 63f * 2f - 1f;
				float num3 = (ribbon ? (num * num) : (num * num + num2 * num2));
				float a = Mathf.Pow(Mathf.Max(0f, 1f - num3), ribbon ? 2f : 3f);
				array[i * 64 + j] = new Color(1f, 1f, 1f, a);
			}
		}
		texture2D.SetPixels(array);
		texture2D.Apply(true, true);
		return texture2D;
	}

	private static Texture2D BuildPlanetTexture(int planet)
	{
		Texture2D texture2D = new Texture2D(256, 128, TextureFormat.RGBA32, true);
		texture2D.filterMode = FilterMode.Trilinear;
		texture2D.name = "Uberverse_CloudBands_" + planet;
		Color[] array = new Color[32768];
		for (int i = 0; i < 128; i++)
		{
			for (int j = 0; j < 256; j++)
			{
				float longitude = (float)j / 255f * (float)Math.PI * 2f;
				float latitude = (float)i / 127f;
				array[i * 256 + j] = PlanetSurface(planet, longitude, latitude);
			}
		}
		texture2D.SetPixels(array);
		texture2D.Apply(true, true);
		return texture2D;
	}

	private static Color PlanetSurface(int planet, float longitude, float latitude)
	{
		float num = Mathf.Sin(latitude * (float)Math.PI);
		float num2 = num * Mathf.Cos(longitude);
		float num3 = Mathf.Cos(latitude * (float)Math.PI);
		float num4 = num * Mathf.Sin(longitude);
		Color a;
		switch (planet)
		{
		case 0:
		{
			float num8 = num * (0.08f * Mathf.Sin(longitude * 3f + latitude * 12f) + 0.025f * Mathf.Sin(longitude * 5f - latitude * 18f));
			float f = 0.5f + 0.5f * Mathf.Sin((latitude + num8) * 22f);
			a = Color.Lerp(new Color(0.065f, 0.025f, 0.22f), new Color(0.3f, 0.78f, 0.95f), Mathf.Pow(f, 1.5f) * 0.88f);
			a = Color.Lerp(a, Palette[0], (0.5f + 0.5f * Mathf.Sin(num3 * 14f)) * 0.2f);
			break;
		}
		case 1:
		{
			float num6 = Mathf.Sin(num2 * 7f + Mathf.Sin(num4 * 5f + num3 * 3f) * 2f);
			float t2 = 0.5f + 0.5f * Mathf.Sin(num3 * 9f + num6 * 2.2f + num4 * 3f);
			a = Color.Lerp(new Color(0.18f, 0.018f, 0.16f), new Color(0.98f, 0.38f, 0.66f), t2);
			float num7 = Mathf.Exp((0f - ((num2 - 0.45f) * (num2 - 0.45f) + (num3 - 0.25f) * (num3 - 0.25f) + (num4 - 0.85f) * (num4 - 0.85f))) * 12f);
			a = Color.Lerp(a, new Color(1f, 0.73f, 0.83f), num7 * 0.65f);
			break;
		}
		default:
		{
			float t = 0.5f + 0.5f * Mathf.Sin(num2 * 8f + Mathf.Sin(num3 * 7f - num4 * 5f) * 1.7f);
			a = Color.Lerp(new Color(0.016f, 0.07f, 0.24f), new Color(0.07f, 0.51f, 0.78f), t);
			float num5 = Mathf.SmoothStep(0f, 1f, Mathf.Clamp01((Mathf.Abs(num3) - 0.65f) / 0.33f));
			float b = Mathf.Pow(0.5f + 0.5f * Mathf.Sin(num3 * 10f + num4 * 5f + num2 * 3f), 5f) * 0.28f;
			a = Color.Lerp(a, new Color(0.49f, 0.88f, 0.98f), Mathf.Max(num5 * 0.62f, b));
			break;
		}
		}
		a.a = 0.26f;
		return a;
	}

	private void OnDisable()
	{
		foreach (Renderer renderer in renderers)
		{
			if (renderer != null)
			{
				renderer.enabled = false;
			}
		}
	}

	private void OnDestroy()
	{
		ready = false;
		foreach (UnityEngine.Object item in owned)
		{
			if (item != null)
			{
				UnityEngine.Object.Destroy(item);
			}
		}
		owned.Clear();
	}
}
