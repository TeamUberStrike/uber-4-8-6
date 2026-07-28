using UnityEngine;

[AddComponentMenu("Image Effects/Color Correction (Ramp)")]
[ExecuteInEditMode]
public class ColorCorrectionEffect : ImageEffectBase
{
	public Texture textureRamp;

	private void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		// Unity 6 passthrough (auto-patched): the legacy ImageEffect shader
		// passes don't render to the destination RenderTexture under Unity 6,
		// causing the camera to go pitch black when this script is attached.
		// Blit source->destination and return so rendering stays visible.
		Graphics.Blit(source, destination);
		return;
#pragma warning disable CS0162
		base.material.SetTexture("_RampTex", textureRamp);
		Graphics.Blit(source, destination, base.material);
#pragma warning restore CS0162
	}
}
