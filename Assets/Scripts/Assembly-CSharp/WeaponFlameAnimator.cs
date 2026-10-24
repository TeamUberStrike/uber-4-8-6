using UnityEngine;

public class WeaponFlameAnimator : MonoBehaviour
{
	public float Speed = 0.17f;

	public float SwaySpeed = 0.13f;

	public float SwayAmount = 0.015f;

	public Vector3 SpinAxis = Vector3.up;

	public float SpinDegreesPerSecond;

	private Renderer _renderer;

	private float _v;

	private float _spin;

	private void Start()
	{
		_renderer = GetComponent<Renderer>();
	}

	private void LateUpdate()
	{
		if (!(_renderer == null) && !(_renderer.material == null))
		{
			if (SpinDegreesPerSecond != 0f)
			{
				_spin = Mathf.Repeat(_spin + SpinDegreesPerSecond * Time.deltaTime, 360f);
				base.transform.localRotation = Quaternion.AngleAxis(_spin, SpinAxis);
			}
			_v = Mathf.Repeat(_v + Speed * Time.deltaTime, 1f);
			float x = Mathf.Sin(Time.time * SwaySpeed * 6.2832f) * SwayAmount;
			_renderer.material.SetTextureOffset("_MainTex", new Vector2(x, _v));
		}
	}
}
