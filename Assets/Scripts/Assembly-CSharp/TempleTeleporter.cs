using UnityEngine;

[RequireComponent(typeof(BoxCollider))]
public class TempleTeleporter : SecretDoor
{
	[SerializeField]
	private float _activationTime = 15f;

	[SerializeField]
	private Renderer[] _visuals;

	[SerializeField]
	private Transform _spawnpoint;

	[SerializeField]
	private ParticleEmitter _particles;

	private int _doorID;

	private float _timeOut;

	private AudioSource[] _audios;

	public int DoorID
	{
		get
		{
			return _doorID;
		}
	}

	private void Awake()
	{
		_audios = GetComponents<AudioSource>();
		if (_particles != null)
		{
			_particles.emit = false;
		}
		if (_visuals != null)
		{
			foreach (Renderer renderer in _visuals)
			{
				if (renderer != null) renderer.enabled = false;
			}
		}
		_doorID = base.transform.position.GetHashCode();
	}

	private void OnEnable()
	{
		EventHandler.Global.AddListener<GameEvents.DoorOpened>(OnDoorOpenedEvent);
	}

	private void OnDisable()
	{
		EventHandler.Global.RemoveListener<GameEvents.DoorOpened>(OnDoorOpenedEvent);
	}

	private void Update()
	{
		if (_timeOut < Time.time)
		{
			if (_audios != null)
			{
				foreach (AudioSource audioSource in _audios)
				{
					if (audioSource != null) audioSource.Stop();
				}
			}
			if (_particles != null)
			{
				_particles.emit = false;
			}
			if (_visuals != null)
			{
				foreach (Renderer renderer in _visuals)
				{
					if (renderer != null) renderer.enabled = false;
				}
			}
			base.enabled = false;
		}
	}

	private void OnTriggerEnter(Collider c)
	{
		if (c.tag == "Player" && _timeOut > Time.time)
		{
			_timeOut = 0f;
			GameState.Current.Player.SpawnPlayerAt(_spawnpoint.position, _spawnpoint.rotation);
		}
	}

	private void OnDoorOpenedEvent(GameEvents.DoorOpened ev)
	{
		if (DoorID == ev.DoorID)
		{
			OpenDoor();
		}
	}

	public override void Open()
	{
		if (GameState.Current.HasJoinedGame)
		{
			GameState.Current.Actions.OpenDoor(DoorID);
		}
		OpenDoor();
	}

	private void OpenDoor()
	{
		base.enabled = true;
		if (_particles != null)
		{
			_particles.emit = true;
		}
		if (_visuals != null)
		{
			foreach (Renderer renderer in _visuals)
			{
				if (renderer != null) renderer.enabled = true;
			}
		}
		_timeOut = Time.time + _activationTime;
		if (_audios != null)
		{
			foreach (AudioSource audioSource in _audios)
			{
				if (audioSource != null) audioSource.Play();
			}
		}
	}
}
