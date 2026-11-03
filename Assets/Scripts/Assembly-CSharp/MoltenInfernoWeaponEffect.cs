using UnityEngine;

public sealed class MoltenInfernoWeaponEffect : WeaponEmitterEffect
{
	public const int ItemId = 9082;

	private const int EmberCount = 28;

	private static readonly Color WhiteHot = new Color(1f, 0.95f, 0.8f);

	private static readonly Color Orange = new Color(1f, 0.48f, 0.08f);

	private static readonly Color DeepRed = new Color(0.55f, 0.07f, 0.02f);

	protected override int SpriteCount
	{
		get
		{
			return 32;
		}
	}

	public static void Apply(GameObject weaponRoot, int itemId)
	{
		WeaponEmitterEffect.Attach<MoltenInfernoWeaponEffect>(weaponRoot, itemId, 9082, "MoltenInferno_Embers", "AWP", 1.477879f);
	}

	protected override Texture2D BuildSpriteTexture()
	{
		return Keep(WeaponEmitterEffect.SoftDot("MoltenInferno_Ember", 2.5f));
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
		for (int i = 0; i < SpriteCount; i++)
		{
			bool flag = i >= 28;
			float num = (float)(time * (flag ? 0.3 : 0.6) + (double)WeaponEmitterEffect.Rand(i, 1)) % 1f;
			float t = WeaponEmitterEffect.Rand(i, 2);
			float num2 = WeaponEmitterEffect.Rand(i, 3) - 0.5f;
			Vector3 vector = new Vector3(bodyBounds.center.x + num2 * 0.035f * scale, bodyBounds.max.y, Mathf.Lerp(bodyBounds.min.z + bodyBounds.size.z * 0.22f, bodyBounds.min.z + bodyBounds.size.z * 0.85f, t));
			float num3 = num * (flag ? 0.14f : 0.1f) * scale;
			float x = Mathf.Sin(num * 6.283f + WeaponEmitterEffect.Rand(i, 4) * 6.283f) * 0.015f * scale;
			positions[i] = vector + new Vector3(x, num3 + WeaponEmitterEffect.Rand(i, 5) * 0.01f * scale, 0f);
			float num4 = 0.7f + 0.3f * Mathf.Sin((float)time * 25f + WeaponEmitterEffect.Rand(i, 6) * 30f);
			float num5 = 1f - num;
			Color colour = Color.Lerp(WhiteHot, Color.Lerp(Orange, DeepRed, num), num);
			if (flag)
			{
				sizes[i] = (0.005f + 0.003f * num4) * scale;
				tints[i] = WeaponEmitterEffect.WithAlpha(colour, 0.6f * num5 * num4);
			}
			else
			{
				sizes[i] = (0.0022f + 0.0014f * num4) * scale;
				tints[i] = WeaponEmitterEffect.WithAlpha(colour, 0.75f * num5 * num4);
			}
		}
	}
}
