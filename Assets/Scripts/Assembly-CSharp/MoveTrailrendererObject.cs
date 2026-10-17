using UnityEngine;

public class MoveTrailrendererObject : MonoBehaviour
{
	[SerializeField]
	private LineRenderer _lineRenderer;

	[SerializeField]
	private float _duration = 0.1f;

	private float _locationOnPath;

	private bool _move;

	private float _timeToArrive = 1f;

	private float _alpha = 1f;

	private Material _trailMaterial;

	private Material GetTrailMaterial()
	{
		if (_trailMaterial == null && _lineRenderer != null)
		{
			_trailMaterial = _lineRenderer.material;
		}
		return _trailMaterial;
	}

	public void SetTint(Color startColour, Color endColour, Color tint)
	{
		if (_lineRenderer == null)
		{
			return;
		}
		_lineRenderer.SetColors(startColour, endColour);
		Material mat = GetTrailMaterial();
		if (mat != null && mat.HasProperty("_TintColor"))
		{
			Color color = mat.GetColor("_TintColor");
			mat.SetColor("_TintColor", new Color(tint.r, tint.g, tint.b, color.a));
		}
	}

	private void OnDestroy()
	{
		if (_trailMaterial != null)
		{
			Object.Destroy(_trailMaterial);
		}
	}

	public void MoveTrail(Vector3 destination, Vector3 muzzlePosition, float distance)
	{
		if (_lineRenderer != null)
		{
			GetTrailMaterial();
			_alpha = 1f;
			_move = true;
			_lineRenderer.SetPosition(0, muzzlePosition);
			_lineRenderer.SetPosition(1, destination);
			_timeToArrive = Time.time + _duration;
		}
	}

	private void Update()
	{
		if (_move)
		{
			_locationOnPath = 1f - (_timeToArrive - Time.time);
			_alpha = Mathf.Lerp(_alpha, 0f, _locationOnPath);
			Color color = _trailMaterial.GetColor("_TintColor");
			color.a = _alpha;
			_trailMaterial.SetColor("_TintColor", color);
			if (Time.time >= _timeToArrive)
			{
				_move = false;
				Object.Destroy(base.gameObject);
			}
		}
	}
}
