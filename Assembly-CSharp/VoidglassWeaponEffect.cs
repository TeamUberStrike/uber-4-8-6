using System;
using UnityEngine;

public sealed class VoidglassWeaponEffect : WeaponEmitterEffect
{
	public const int ItemId = 9085;

	private const int CoreMotes = 6;

	private static readonly Color Violet = new Color(0.51f, 0.18f, 1f);

	private static readonly Color Magenta = new Color(1f, 0.12f, 0.7f);

	private static readonly Color CoolWhite = new Color(0.85f, 0.8f, 1f);

	protected override int SpriteCount
	{
		get
		{
			return 34;
		}
	}

	public static void Apply(GameObject weaponRoot, int itemId)
	{
		WeaponEmitterEffect.Attach<VoidglassWeaponEffect>(weaponRoot, itemId, 9085, "Voidglass_Crystal", "polySurface24", 0.853306f);
	}

	protected override Texture2D BuildSpriteTexture()
	{
		return Keep(WeaponEmitterEffect.SoftBox("Voidglass_Shard", 1.3f));
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
		Vector3 center = bodyBounds.center;
		float num = 0.5f + 0.5f * Mathf.Sin(WeaponEmitterEffect.Phase(time, 0.6, 0.0));
		Quaternion quaternion = Quaternion.Euler(20f, 0f, 15f);
		Quaternion quaternion2 = Quaternion.Euler(20f, 0f, -15f);
		int num2 = SpriteCount - 6;
		for (int i = 0; i < SpriteCount; i++)
		{
			if (i < 6)
			{
				float f = (float)i * ((float)Math.PI / 3f) + (float)time * 0.5f;
				float num3 = 0.01f * scale * (0.4f + WeaponEmitterEffect.Rand(i, 3) * 0.6f);
				center.y = bodyBounds.center.y;
				positions[i] = center + new Vector3(Mathf.Cos(f) * num3, Mathf.Sin(f) * num3 * 0.6f, Mathf.Sin(f) * num3);
				sizes[i] = (0.01f + 0.006f * num) * scale;
				tints[i] = WeaponEmitterEffect.WithAlpha(Color.Lerp(Violet, Magenta, num), 0.1f + 0.12f * num);
			}
			else
			{
				int num4 = i - 6;
				float num5 = (float)num4 * ((float)Math.PI * 2f / (float)num2) + WeaponEmitterEffect.Phase(time, 0.35, 0.0);
				float num6 = (0.045f + (float)(num4 % 3) * 0.01f) * scale;
				Quaternion quaternion3 = ((num4 % 2 == 0) ? quaternion : quaternion2);
				positions[i] = bodyBounds.center + quaternion3 * new Vector3(Mathf.Cos(num5) * num6, 0f, Mathf.Sin(num5) * num6 * 0.7f);
				sizes[i] = (0.0035f + WeaponEmitterEffect.Rand(num4, 1) * 0.0035f) * scale;
				float num7 = Mathf.Pow(0.5f + 0.5f * Mathf.Sin(num5 - (float)time * 2f + WeaponEmitterEffect.Rand(num4, 2) * 6.283f), 8f);
				tints[i] = WeaponEmitterEffect.WithAlpha(Color.Lerp(Violet, CoolWhite, num7), 0.12f + num7 * 0.55f);
			}
		}
	}
}
