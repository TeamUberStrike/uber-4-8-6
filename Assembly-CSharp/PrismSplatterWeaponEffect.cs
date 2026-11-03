using System;
using UnityEngine;

public sealed class PrismSplatterWeaponEffect : WeaponEmitterEffect
{
	public const int ItemId = 9086;

	private static readonly Color Cyan = new Color(0.15f, 0.9f, 1f);

	private static readonly Color Magenta = new Color(1f, 0.15f, 0.8f);

	private static readonly Color Lime = new Color(0.6f, 1f, 0.1f);

	protected override int SpriteCount
	{
		get
		{
			return 26;
		}
	}

	public static void Apply(GameObject weaponRoot, int itemId)
	{
		WeaponEmitterEffect.Attach<PrismSplatterWeaponEffect>(weaponRoot, itemId, 9086, "PrismSplatter_Drops", "SplatterBody", 0.645136f);
	}

	protected override Texture2D BuildSpriteTexture()
	{
		return Keep(WeaponEmitterEffect.SoftDot("PrismSplatter_Drop", 3f));
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
		Vector3 vector = new Vector3(bodyBounds.center.x, bodyBounds.center.y + 0.02f * scale, bodyBounds.max.z);
		for (int i = 0; i < SpriteCount; i++)
		{
			float num = (float)(time * (0.5 + (double)WeaponEmitterEffect.Rand(i, 5) * 0.3) + (double)WeaponEmitterEffect.Rand(i, 1)) % 1f;
			float f = WeaponEmitterEffect.Rand(i, 2) * 6.283f;
			float num2 = 0.25f + WeaponEmitterEffect.Rand(i, 3) * 0.55f;
			Vector3 vector2 = new Vector3(Mathf.Cos(f) * num2, Mathf.Sin(f) * num2 + 0.35f, 0.55f + WeaponEmitterEffect.Rand(i, 4) * 0.5f);
			Vector3 vector3 = vector2 * num + new Vector3(0f, -1.4f, 0f) * (num * num * 0.5f);
			positions[i] = vector + vector3 * (0.11f * scale);
			float num3 = Mathf.Sin(num * (float)Math.PI);
			sizes[i] = (0.0045f + (1f - num) * 0.003f) * scale;
			Color colour = ((i % 3 == 0) ? Cyan : ((i % 3 == 1) ? Magenta : Lime));
			tints[i] = WeaponEmitterEffect.WithAlpha(colour, 0.6f * num3);
		}
	}
}
