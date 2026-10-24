using UnityEngine;

public sealed class UberverseV1RibbonCamera : MonoBehaviour
{
	public UberverseV1Effect Owner;

	private void OnWillRenderObject()
	{
		if (Owner != null)
		{
			Owner.FaceRibbons(Camera.current);
		}
	}
}
