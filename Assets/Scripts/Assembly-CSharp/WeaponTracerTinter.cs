using UnityEngine;

public class WeaponTracerTinter : MonoBehaviour
{
	public Color StartColour = Color.white;

	public Color EndColour = Color.white;

	public Color MatTint = Color.white;

	private void LateUpdate()
	{
		Object[] array = Object.FindObjectsOfType(typeof(MoveTrailrendererObject));
		for (int i = 0; i < array.Length; i++)
		{
			MoveTrailrendererObject moveTrailrendererObject = array[i] as MoveTrailrendererObject;
			if (moveTrailrendererObject == null)
			{
				continue;
			}
			LineRenderer lineRenderer = moveTrailrendererObject.GetComponent<LineRenderer>();
			if (lineRenderer == null)
			{
				lineRenderer = moveTrailrendererObject.GetComponentInChildren<LineRenderer>();
			}
			if (!(lineRenderer == null))
			{
				lineRenderer.SetColors(StartColour, EndColour);
				Material material = lineRenderer.material;
				if (material != null && material.HasProperty("_TintColor"))
				{
					Color color = material.GetColor("_TintColor");
					material.SetColor("_TintColor", new Color(MatTint.r, MatTint.g, MatTint.b, color.a));
				}
			}
		}
	}
}
