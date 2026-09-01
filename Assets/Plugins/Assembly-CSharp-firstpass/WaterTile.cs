using UnityEngine;

[ExecuteInEditMode]
public class WaterTile : MonoBehaviour
{
	public PlanarReflection reflection;

	public WaterBase waterBase;

	public void Start()
	{
		AcquireComponents();
	}

	private void AcquireComponents()
	{
		if (!reflection)
		{
			if ((bool)base.transform.parent)
			{
				reflection = base.transform.parent.GetComponent<PlanarReflection>();
			}
			else
			{
				reflection = base.transform.GetComponent<PlanarReflection>();
			}
		}
		if (!waterBase)
		{
			if ((bool)base.transform.parent)
			{
				waterBase = base.transform.parent.GetComponent<WaterBase>();
			}
			else
			{
				waterBase = base.transform.GetComponent<WaterBase>();
			}
		}
	}

	public void OnWillRenderObject()
	{
		// RESTORED (1:1 with the shipped Water4): drive the planar-reflection helper camera and
		// the depth-texture setup for whichever camera is about to render this tile. The reflection
		// camera excludes the Water layer, so no recursion; PlanarReflection guards to one render/frame.
		if ((bool)reflection)
		{
			reflection.WaterTileBeingRendered(base.transform, Camera.current);
		}
		if ((bool)waterBase)
		{
			waterBase.WaterTileBeingRendered(base.transform, Camera.current);
		}
	}
}
