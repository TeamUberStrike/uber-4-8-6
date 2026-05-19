using System.Collections.Generic;
using AnimationOrTween;
using UnityEngine;

public class ReticleView : MonoBehaviour
{
	private List<UISprite> sprites = new List<UISprite>();

	private List<UITweener> tweens = new List<UITweener>();

	private bool _needsColorInit = true;

	private void Awake()
	{
		sprites = new List<UISprite>(base.gameObject.GetComponentsInChildren<UISprite>(true));
		tweens = new List<UITweener>(GetComponentsInChildren<UITweener>(true));
	}

	private void OnEnable()
	{
		// Re-collect in case children were inactive during Awake
		if (sprites.Count == 0)
		{
			sprites = new List<UISprite>(base.gameObject.GetComponentsInChildren<UISprite>(true));
		}
		if (_needsColorInit)
		{
			_needsColorInit = false;
			SetColor(Color.white);
		}
	}

	private void LateUpdate()
	{
		// Continuously enforce full alpha on the first few frames to override
		// any NGUI draw call that resets the serialized mColor alpha.
		if (Time.frameCount % 30 == 0)
		{
			foreach (UISprite el in sprites)
			{
				if (el != null && el.color.a < 0.95f)
				{
					el.color = new Color(el.color.r, el.color.g, el.color.b, 1f);
				}
			}
		}
	}

	public void Shoot()
	{
		tweens.ForEach(delegate(UITweener el)
		{
			if (el.direction == Direction.Reverse)
			{
				el.Toggle();
			}
			else
			{
				el.Play(true);
			}
		});
	}

	public void SetColor(Color color)
	{
		// Force alpha to 1 regardless of input — crosshair must be fully opaque
		color.a = 1f;
		sprites.ForEach(delegate(UISprite el)
		{
			if ((bool)el)
			{
				el.color = color;
			}
		});
	}
}
