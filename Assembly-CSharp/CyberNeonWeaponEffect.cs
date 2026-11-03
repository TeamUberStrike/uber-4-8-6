using System;
using UnityEngine;

public sealed class CyberNeonWeaponEffect : WeaponEmitterEffect
{
	public const int ItemId = 9080;

	private static readonly Color Cyan = new Color(0.15f, 0.9f, 1f);

	private static readonly Color Magenta = new Color(1f, 0.18f, 0.8f);

	protected override int SpriteCount
	{
		get
		{
			return 30;
		}
	}

	public static void Apply(GameObject weaponRoot, int itemId)
	{
		WeaponEmitterEffect.Attach<CyberNeonWeaponEffect>(weaponRoot, itemId, 9080, "CyberNeon_HoloRing", "AWP", 1.477879f);
	}

	protected override Texture2D BuildSpriteTexture()
	{
		return Keep(WeaponEmitterEffect.SoftBox("CyberNeon_Node", 1.4f));
	}

	protected override void ConfigureMaterial(Material material)
	{
		if (material.HasProperty("_TintColor"))
		{
			material.SetColor("_TintColor", new Color(0.5f, 0.5f, 0.5f, 0.5f));
		}
	}

	protected override void Emit(double time)
	{
		Vector3 vector = new Vector3(bodyBounds.center.x, bodyBounds.max.y + 0.05f * scale, bodyBounds.center.z + bodyBounds.size.z * 0.12f);
		Quaternion quaternion = Quaternion.Euler(72f, 0f, 0f);
		float num = (float)(time * 0.7);
		int spriteCount = SpriteCount;
		for (int i = 0; i < spriteCount; i++)
		{
			float num2 = (float)i * ((float)Math.PI * 2f / (float)spriteCount) + num;
			float num3 = ((i % 2 == 0) ? 0.05f : 0.066f) * scale;
			positions[i] = vector + quaternion * new Vector3(Mathf.Cos(num2) * num3, 0f, Mathf.Sin(num2) * num3);
			float num4 = Mathf.Pow(0.5f + 0.5f * Mathf.Cos(num2 - (float)time * 2.2f), 10f);
			sizes[i] = (0.0038f + num4 * 0.0052f) * scale;
			tints[i] = WeaponEmitterEffect.WithAlpha((i % 2 == 0) ? Cyan : Magenta, 0.3f + num4 * 0.6f);
		}
	}
}
