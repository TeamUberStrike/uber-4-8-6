using UnityEngine;

public sealed class UberverseRibbonCamera : MonoBehaviour
{
	public UberverseWeaponEffect Owner;

	private void OnWillRenderObject()
	{
		if (Owner != null)
		{
			Owner.FaceRibbons(Camera.current);
		}
	}
}
