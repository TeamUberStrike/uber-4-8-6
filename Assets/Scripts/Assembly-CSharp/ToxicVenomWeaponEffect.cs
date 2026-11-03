using System;
using UnityEngine;

public sealed class ToxicVenomWeaponEffect : WeaponEmitterEffect
{
	public const int ItemId = 9081;

	private const int GasCount = 18;

	private static readonly Color Bright = new Color(0.7f, 1f, 0.3f);

	private static readonly Color Deep = new Color(0.12f, 0.45f, 0.05f);

	private static readonly Color Acid = new Color(0.55f, 1f, 0.12f);

	protected override int SpriteCount
	{
		get
		{
			return 34;
		}
	}

	public static void Apply(GameObject weaponRoot, int itemId)
	{
		WeaponEmitterEffect.Attach<ToxicVenomWeaponEffect>(weaponRoot, itemId, 9081, "ToxicVenom_Gas", "AWP", 1.477879f);
	}

	protected override Texture2D BuildSpriteTexture()
	{
		return Keep(WeaponEmitterEffect.SoftDot("ToxicVenom_Blob", 2f));
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
		float num = 0.045f * scale;
		float num2 = 0.11f * scale;
		for (int i = 0; i < SpriteCount; i++)
		{
			bool flag = i < 18;
			float num3 = (float)(time * (flag ? 0.3 : 0.55) + (double)WeaponEmitterEffect.Rand(i, 1)) % 1f;
			float t = WeaponEmitterEffect.Rand(i, 2);
			float f = WeaponEmitterEffect.Rand(i, 3) * 6.283f + (float)time * 0.25f;
			float z = Mathf.Lerp(bodyBounds.min.z + bodyBounds.size.z * 0.16f, bodyBounds.min.z + bodyBounds.size.z * 0.88f, t);
			Vector3 vector = new Vector3(Mathf.Cos(f), Mathf.Sin(f), 0f);
			Vector3 vector2 = new Vector3(bodyBounds.center.x + vector.x * num, bodyBounds.center.y + vector.y * num2, z);
			float num4 = (flag ? 0.03f : 0.045f) * scale * num3;
			Vector3 vector3 = new Vector3(0f - vector.y, vector.x, 0f);
			float num5 = Mathf.Sin(num3 * (float)Math.PI * 2f + WeaponEmitterEffect.Rand(i, 4) * 6.283f) * (flag ? 0.012f : 0.006f) * scale;
			float z2 = Mathf.Cos(num3 * (float)Math.PI * 2f + WeaponEmitterEffect.Rand(i, 5) * 6.283f) * 0.01f * scale;
			positions[i] = vector2 + vector * num4 + vector3 * num5 + new Vector3(0f, 0f, z2);
			float num6 = Mathf.Sin(num3 * (float)Math.PI);
			if (flag)
			{
				sizes[i] = (0.011f + num3 * 0.018f) * scale;
				tints[i] = WeaponEmitterEffect.WithAlpha(Color.Lerp(Bright, Deep, num3), 0.12f * num6);
			}
			else
			{
				sizes[i] = (0.0035f + (1f - num3) * 0.004f) * scale;
				tints[i] = WeaponEmitterEffect.WithAlpha(Acid, 0.6f * num6);
			}
		}
	}
}
