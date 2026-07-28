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
		// No-op: PlanarReflection + WaterBase helper-camera renders are
		// Pro-only on Unity 4.6 Free and silent-fail per Scene+Game camera,
		// generating "Shader wants normals" warnings per renderer per frame.
		// FX/Water cubemap reflection covers the visual. See
		// feedback_unity_4_6_free_planar_reflection_spam.md.
	}
}
