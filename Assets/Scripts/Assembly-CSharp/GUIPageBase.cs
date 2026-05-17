using System;
using System.Collections;
using UnityEngine;

public class GUIPageBase : MonoBehaviour
{
	[SerializeField]
	public float dismissDuration = 0.2f;

	[SerializeField]
	public float bringInDuration = 0.8f;

	public IEnumerator AnimateAlpha(float to, float duration, params UIButton[] buttons)
	{
		yield return StartCoroutine(AnimateAlpha(to, duration, Array.ConvertAll(buttons, (UIButton el) => el.GetComponent<UIPanel>())));
	}

	public IEnumerator AnimateAlpha(float to, float duration, params UIEventReceiver[] buttons)
	{
		yield return StartCoroutine(AnimateAlpha(to, duration, Array.ConvertAll(buttons, (UIEventReceiver el) => el.GetComponent<UIPanel>())));
	}

	public IEnumerator AnimateAlpha(float to, float duration, params GameObject[] objects)
	{
		yield return StartCoroutine(AnimateAlpha(to, duration, Array.ConvertAll(objects, (GameObject el) => el.GetComponent<UIPanel>())));
	}

	public IEnumerator AnimateAlpha(float to, float duration, params UIPanel[] buttons)
	{
		// AssetRipper decomp bug: original lambda captured outer `to` and `duration`,
		// but emitted code wrote `default(float)` (=0) for both. Result: every UIPanel
		// tween starts with duration=0, target=0 -> all page widgets instantly become
		// invisible the moment OnBringIn fires (lobby Play/Shop/Chat/Quit buttons,
		// every panel animation in the menu). Restore the outer-scope captures.
		TweenAlpha[] tweens = Array.ConvertAll(buttons, (UIPanel uIPanel) =>
			TweenAlpha.Begin(uIPanel.gameObject, duration, to));
		foreach (TweenAlpha el in tweens)
		{
			while (el != null && el.enabled)
			{
				yield return 0;
			}
		}
	}

	public void Dismiss(Action onFinished)
	{
		StopAllCoroutines();
		StartCoroutine(DismissCrt(onFinished));
	}

	private IEnumerator DismissCrt(Action onFinished)
	{
		yield return StartCoroutine(OnDismiss());
		if (onFinished != null)
		{
			onFinished();
		}
	}

	protected virtual IEnumerator OnDismiss()
	{
		yield return 0;
	}

	public void BringIn()
	{
		StopAllCoroutines();
		StartCoroutine(OnBringIn());
	}

	protected virtual IEnumerator OnBringIn()
	{
		yield return 0;
	}
}
