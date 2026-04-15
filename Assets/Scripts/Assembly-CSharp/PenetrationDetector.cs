using UnityEngine;

[RequireComponent(typeof(Rigidbody), typeof(Collider))]
public class PenetrationDetector : MonoBehaviour
{
	[SerializeField]
	private CharacterController controller;

	private void OnTriggerEnter(Collider c)
	{
		// Original Unity 4 behavior: this script lived on a child of the Player
		// with a small trigger collider on an isolated layer that only touched
		// geometry when the CharacterController was genuinely STUCK inside a
		// wall. The layer collision matrix fix (ProjectSettings/DynamicsManager
		// matrix -> all-f permissive) broke that isolation — now every touching
		// wall triggers this as the player walks normally, killing them instantly.
		//
		// Disable the instant-kill path entirely. The proper fix is to restore
		// the Unity 4 per-layer collision isolation, but until then this no-op
		// is safe because CharacterController already prevents deep penetration
		// via its skinWidth / slopeLimit, and LevelBoundary.cs still catches
		// out-of-bounds cases.
		if (!c.isTrigger)
		{
			// Invoke("KillPlayer", 0f);
		}
	}

	private void KillPlayer()
	{
		if ((bool)controller)
		{
			controller.transform.position -= 0.5f * controller.velocity.normalized;
		}
		GameState.Current.Actions.KillPlayer();
	}
}
