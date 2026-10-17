using System.Collections.Generic;
using UnityEngine;

// Owns only runtime material instances; shared texture/material caches live for the session.
public sealed class WeaponSkinCleanup : MonoBehaviour
{
	private readonly List<Material> _materials = new List<Material>();

	public static Material GetMaterial(GameObject owner, Renderer renderer)
	{
		Material material = renderer.material;
		Track(owner, material);
		return material;
	}

	public static void Track(GameObject owner, Material material)
	{
		if (owner == null || material == null)
			return;
		WeaponSkinCleanup cleanup = owner.GetComponent<WeaponSkinCleanup>();
		if (cleanup == null)
			cleanup = owner.AddComponent<WeaponSkinCleanup>();
		if (!cleanup._materials.Contains(material))
			cleanup._materials.Add(material);
	}

	private void OnDestroy()
	{
		foreach (Material material in _materials)
			if (material != null)
				Destroy(material);
		_materials.Clear();
	}
}
