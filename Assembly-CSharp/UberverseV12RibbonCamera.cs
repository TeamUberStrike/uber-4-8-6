using UnityEngine;

public sealed class UberverseV12RibbonCamera : MonoBehaviour
{
	public UberverseV12Effect Owner;

	private void OnWillRenderObject()
	{
		if (Owner != null)
		{
			Owner.FaceRibbons(Camera.current);
		}
	}
}
