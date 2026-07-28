using System.Collections;
using System.Text;
using UnityEngine;

[RequireComponent(typeof(Collider))]
public class LevelBoundary : MonoBehaviour
{
	private static float _checkTime;

	private static LevelBoundary _currentLevelBoundary;

	private void Awake()
	{
		if ((bool)base.GetComponent<Renderer>())
		{
			base.GetComponent<Renderer>().enabled = false;
		}
		StartCoroutine(StartCheckingPlayerInBounds(base.GetComponent<Collider>()));
		base.GetComponent<Collider>().isTrigger = true;
	}

	private void OnDisable()
	{
		_checkTime = 0f;
		_currentLevelBoundary = null;
	}

	private void OnTriggerExit(Collider c)
	{
		if (c.tag == "Player" && GameState.Current.HasJoinedGame)
		{
			if (_currentLevelBoundary == this)
			{
				_currentLevelBoundary = null;
			}
			StartCoroutine(StartCheckingPlayer());
		}
	}

	private IEnumerator StartCheckingPlayer()
	{
		// Unity 6 offline test mode: OnTriggerExit kill was firing on spawn
		// because the CharacterController capsule center exits the boundary
		// trigger for 1 frame as it drops to the ground. Disabled the
		// OnTriggerExit kill path entirely — the smart Y-threshold kill in
		// StartCheckingPlayerInBounds below is enough to catch genuine
		// fall-off-the-map cases.
		yield break;
	}

	private IEnumerator StartCheckingPlayerInBounds(Collider c)
	{
		// Smart death zone: only kill when the player's Y drops significantly
		// BELOW the LevelBoundary collider — i.e. they fell off the map, not
		// just walked near the edge. 20-unit margin below the boundary's
		// minimum Y absorbs normal bouncing/ledges. Without this, maps like
		// Sky Garden / Space City / Ghost Island would let the player fall
		// infinitely into the void with no respawn.
		while (true)
		{
			yield return new WaitForSeconds(1f);
			if (c == null) yield break;
			Vector3 pos = GameState.Current.PlayerData.Position;
			float deathY = c.bounds.min.y - 20f;
			if (pos.y < deathY)
			{
				GameState.Current.Actions.KillPlayer();
			}
		}
	}

	private void OnTriggerEnter(Collider c)
	{
		if (c.tag == "Player" && GameState.Current.HasJoinedGame)
		{
			_currentLevelBoundary = this;
		}
	}

	private string PrintHierarchy(Transform t)
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(t.name);
		Transform parent = t.parent;
		while ((bool)parent)
		{
			stringBuilder.Insert(0, parent.name + "/");
			parent = parent.parent;
		}
		return stringBuilder.ToString();
	}

	private string PrintVector(Vector3 v)
	{
		return string.Format("({0:N6},{1:N6},{2:N6})", v.x, v.y, v.z);
	}
}
