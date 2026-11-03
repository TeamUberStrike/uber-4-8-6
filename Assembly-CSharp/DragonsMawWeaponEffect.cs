using System;
using UnityEngine;

public sealed class DragonsMawWeaponEffect : WeaponEmitterEffect
{
	public const int ItemId = 9087;

	private const int HazeCount = 8;

	private static readonly Color WhiteHot = new Color(1f, 0.92f, 0.7f);

	private static readonly Color Orange = new Color(1f, 0.45f, 0.07f);

	private static readonly Color DeepRed = new Color(0.55f, 0.07f, 0.02f);

	private static readonly Color Haze = new Color(0.7f, 0.28f, 0.08f);

	protected override int SpriteCount
	{
		get
		{
			return 30;
		}
	}

	public static void Apply(GameObject weaponRoot, int itemId)
	{
		WeaponEmitterEffect.Attach<DragonsMawWeaponEffect>(weaponRoot, itemId, 9087, "DragonsMaw_Breath", "Launcher", 0.783206f);
	}

	protected override Texture2D BuildSpriteTexture()
	{
		return Keep(WeaponEmitterEffect.SoftDot("DragonsMaw_Ember", 2.5f));
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
		Vector3 vector = new Vector3(bodyBounds.center.x, bodyBounds.center.y + 0.01f * scale, bodyBounds.max.z);
		for (int i = 0; i < SpriteCount; i++)
		{
			bool flag = i < 8;
			float num = (float)(time * (flag ? 0.22 : 0.5) + (double)WeaponEmitterEffect.Rand(i, 1)) % 1f;
			float num2 = WeaponEmitterEffect.Rand(i, 2) * 6.283f;
			float num3 = (flag ? 0.04f : 0.03f) * scale;
			float num4 = Mathf.Sin(num * (float)Math.PI * 2f + num2) * num3 * 0.5f;
			positions[i] = vector + new Vector3(Mathf.Cos(num2) * num3 + num4, (0.02f + num * (flag ? 0.12f : 0.09f)) * scale, (0.01f + num * 0.05f) * scale + Mathf.Sin(num * 3f + num2) * 0.004f * scale);
			float num5 = 0.7f + 0.3f * Mathf.Sin((float)time * 22f + WeaponEmitterEffect.Rand(i, 6) * 30f);
			float num6 = Mathf.Sin(num * (float)Math.PI);
			if (flag)
			{
				sizes[i] = (0.014f + num * 0.024f) * scale;
				tints[i] = WeaponEmitterEffect.WithAlpha(Haze, 0.07f * num6);
			}
			else
			{
				Color colour = Color.Lerp(WhiteHot, Color.Lerp(Orange, DeepRed, num), num);
				sizes[i] = (0.0025f + 0.0015f * num5) * scale;
				tints[i] = WeaponEmitterEffect.WithAlpha(colour, 0.7f * (1f - num) * num5);
			}
		}
	}
}
