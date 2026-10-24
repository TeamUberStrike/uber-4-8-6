using System;
using System.Collections.Generic;
using UnityEngine;

public abstract class WeaponEmitterEffect : MonoBehaviour
{
	private readonly List<UnityEngine.Object> owned = new List<UnityEngine.Object>();

	private readonly List<Renderer> renderers = new List<Renderer>();

	protected Vector3[] positions;

	protected float[] sizes;

	protected Color[] tints;

	private Mesh spriteMesh;

	private Vector3[] spriteVertices;

	private Color[] spriteColours;

	private Renderer source;

	protected float scale;

	protected Vector3 anchor;

	protected Bounds bodyBounds;

	protected double clock;

	private bool ready;

	protected abstract int SpriteCount { get; }

	public static bool Owns(Renderer renderer)
	{
		if (renderer == null)
		{
			return false;
		}
		Transform parent = renderer.transform;
		while (parent != null)
		{
			if (parent.GetComponent<WeaponEmitterEffect>() != null)
			{
				return true;
			}
			parent = parent.parent;
		}
		return false;
	}

	protected static void Attach<T>(GameObject weaponRoot, int itemId, int expectedId, string rootName, string meshName, float refLength) where T : WeaponEmitterEffect
	{
		if (weaponRoot == null)
		{
			return;
		}
		T[] componentsInChildren = weaponRoot.GetComponentsInChildren<T>(true);
		bool flag = false;
		T[] array = componentsInChildren;
		foreach (T val in array)
		{
			if (itemId == expectedId && val.ready && val.source != null && !flag)
			{
				flag = true;
				continue;
			}
			val.ready = false;
			val.gameObject.SetActive(false);
			UnityEngine.Object.Destroy(val.gameObject);
		}
		if (itemId != expectedId || flag)
		{
			return;
		}
		MeshFilter[] componentsInChildren2 = weaponRoot.GetComponentsInChildren<MeshFilter>(true);
		foreach (MeshFilter meshFilter in componentsInChildren2)
		{
			if (meshFilter.sharedMesh == null || meshFilter.sharedMesh.name != meshName)
			{
				continue;
			}
			Renderer component = meshFilter.GetComponent<Renderer>();
			if (!(component == null) && !Owns(component))
			{
				GameObject gameObject = new GameObject(rootName);
				gameObject.transform.parent = component.transform;
				gameObject.transform.localPosition = Vector3.zero;
				gameObject.transform.localRotation = Quaternion.identity;
				gameObject.transform.localScale = Vector3.one;
				gameObject.layer = component.gameObject.layer;
				T val2 = gameObject.AddComponent<T>();
				try
				{
					val2.Initialize(component, meshFilter.sharedMesh.bounds, refLength);
					break;
				}
				catch (Exception ex)
				{
					gameObject.SetActive(false);
					UnityEngine.Object.Destroy(gameObject);
					Debug.LogError(rootName + ": " + ex.Message);
					break;
				}
			}
		}
	}

	protected T Keep<T>(T resource) where T : UnityEngine.Object
	{
		owned.Add(resource);
		return resource;
	}

	private void Initialize(Renderer body, Bounds bounds, float refLength)
	{
		source = body;
		bodyBounds = bounds;
		scale = bounds.size.z / refLength;
		anchor = new Vector3(bounds.center.x, bounds.max.y + 0.02f * scale, bounds.center.z);
		Shader shader = Shader.Find("Particles/Additive");
		if (shader == null || !shader.isSupported)
		{
			shader = Shader.Find("Particles/Alpha Blended");
		}
		if (shader == null || !shader.isSupported)
		{
			throw new InvalidOperationException("No additive particle shader available.");
		}
		Material material = Keep(new Material(shader));
		material.name = GetType().Name + "_Mat";
		material.mainTexture = Keep(BuildSpriteTexture());
		ConfigureMaterial(material);
		positions = new Vector3[SpriteCount];
		sizes = new float[SpriteCount];
		tints = new Color[SpriteCount];
		spriteMesh = Keep(NewQuadMesh(SpriteCount, out spriteVertices, out spriteColours));
		base.gameObject.AddComponent<MeshFilter>().sharedMesh = spriteMesh;
		MeshRenderer meshRenderer = base.gameObject.AddComponent<MeshRenderer>();
		Configure(meshRenderer, material);
		ready = true;
		Emit(0.0);
		UpdateBillboards(Vector3.right, Vector3.up);
	}

	protected abstract Texture2D BuildSpriteTexture();

	protected abstract void ConfigureMaterial(Material material);

	protected abstract void Emit(double time);

	private void Configure(Renderer renderer, Material material)
	{
		renderer.sharedMaterial = material;
		renderer.castShadows = false;
		renderer.receiveShadows = false;
		renderer.enabled = source.enabled;
		renderers.Add(renderer);
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
			Emit(clock);
		}
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
		if (spriteMesh == null)
		{
			return;
		}
		for (int i = 0; i < SpriteCount; i++)
		{
			Vector3 vector = right * sizes[i];
			Vector3 vector2 = up * sizes[i];
			Vector3 vector3 = positions[i];
			int num = i * 4;
			spriteVertices[num] = vector3 - vector - vector2;
			spriteVertices[num + 1] = vector3 + vector - vector2;
			spriteVertices[num + 2] = vector3 + vector + vector2;
			spriteVertices[num + 3] = vector3 - vector + vector2;
			for (int j = 0; j < 4; j++)
			{
				spriteColours[num + j] = tints[i];
			}
		}
		spriteMesh.vertices = spriteVertices;
		spriteMesh.colors = spriteColours;
	}

	protected Mesh NewQuadMesh(int quads, out Vector3[] vertices, out Color[] colours)
	{
		Mesh mesh = new Mesh();
		mesh.name = GetType().Name + "_Dynamic";
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
		mesh.bounds = new Bounds(anchor, Vector3.one * 2f * scale);
		return mesh;
	}

	protected static Color WithAlpha(Color colour, float alpha)
	{
		colour.a = alpha;
		return colour;
	}

	protected static float Phase(double time, double speed, double offset)
	{
		return (float)((time * speed + offset) % (Math.PI * 2.0));
	}

	protected static float Rand(int i, int salt)
	{
		float num = Mathf.Sin((float)i * 12.9898f + (float)salt * 78.233f) * 43758.547f;
		return num - Mathf.Floor(num);
	}

	protected static Texture2D SoftDot(string name, float power)
	{
		Texture2D texture2D = new Texture2D(64, 64, TextureFormat.RGBA32, true);
		texture2D.filterMode = FilterMode.Trilinear;
		texture2D.wrapMode = TextureWrapMode.Clamp;
		texture2D.name = name;
		Color[] array = new Color[4096];
		for (int i = 0; i < 64; i++)
		{
			for (int j = 0; j < 64; j++)
			{
				float num = (float)j / 63f * 2f - 1f;
				float num2 = (float)i / 63f * 2f - 1f;
				float a = Mathf.Pow(Mathf.Max(0f, 1f - (num * num + num2 * num2)), power);
				array[i * 64 + j] = new Color(1f, 1f, 1f, a);
			}
		}
		texture2D.SetPixels(array);
		texture2D.Apply(true, true);
		return texture2D;
	}

	protected static Texture2D SoftBox(string name, float power)
	{
		Texture2D texture2D = new Texture2D(64, 64, TextureFormat.RGBA32, true);
		texture2D.filterMode = FilterMode.Trilinear;
		texture2D.wrapMode = TextureWrapMode.Clamp;
		texture2D.name = name;
		Color[] array = new Color[4096];
		for (int i = 0; i < 64; i++)
		{
			for (int j = 0; j < 64; j++)
			{
				float f = (float)j / 63f * 2f - 1f;
				float f2 = (float)i / 63f * 2f - 1f;
				float num = Mathf.Max(Mathf.Abs(f), Mathf.Abs(f2));
				float a = Mathf.Pow(Mathf.Max(0f, 1f - num), power);
				array[i * 64 + j] = new Color(1f, 1f, 1f, a);
			}
		}
		texture2D.SetPixels(array);
		texture2D.Apply(true, true);
		return texture2D;
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
