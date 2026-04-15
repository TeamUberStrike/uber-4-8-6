using UnityEngine;

[AddComponentMenu("Image Effects/UnderWater")]
[ExecuteInEditMode]
public class UnderWaterEffect : ImageEffectBase
{
	public Texture textureRamp;

	public float fadeDistance = 10f;

	public Vector2 center = new Vector2(0.5f, 0.5f);

	public Vector2 radius = new Vector2(0.5f, 0.5f);

	public float maxAngle = 7f;

	private float effectWeight;

	public float Weight
	{
		set
		{
			effectWeight = value;
		}
	}

	private void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		// Unity 6 passthrough (auto-patched): the legacy ImageEffect shader
		// passes don't render to the destination RenderTexture under Unity 6,
		// causing the camera to go pitch black when this script is attached.
		// Blit source->destination and return so rendering stays visible.
		Graphics.Blit(source, destination);
		return;
#pragma warning disable CS0162
		if ((bool)Camera.main)
		{
			Camera.main.depthTextureMode |= DepthTextureMode.Depth;
		}
		float num = base.GetComponent<Camera>().farClipPlane - base.GetComponent<Camera>().nearClipPlane;
		float value = fadeDistance / num;
		float angle = Mathf.Cos(Time.time) * maxAngle;
		base.material.SetTexture("_RampTex", textureRamp);
		base.material.SetFloat("_FadeDistance", value);
		base.material.SetFloat("_EffectWeight", effectWeight);
		ImageEffects.RenderDistortion(base.material, source, destination, angle, center, radius);
#pragma warning restore CS0162
	}

	public void Update()
	{
	}
}
