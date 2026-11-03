using UnityEngine;

public sealed class UberversePlanetCamera : MonoBehaviour
{
	private UberverseWeaponEffect owner;

	private int index;

	public void Set(UberverseWeaponEffect effect, int planetIndex)
	{
		owner = effect;
		index = planetIndex;
	}

	private void OnWillRenderObject()
	{
		if (owner != null)
		{
			owner.FacePlanet(index, Camera.current);
		}
	}
}
