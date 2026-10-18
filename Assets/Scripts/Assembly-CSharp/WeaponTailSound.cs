using UnityEngine;

public class WeaponTailSound : BaseWeaponEffect
{
	[SerializeField]
	private AudioClip _tailSound;

	[SerializeField]
	private WeaponHeadAnimation _headAnimation;

	private AudioSource _tailAudioSource;

	private float _tailSoundLength;

	private float _tailSoundMaxLength;

	private void Awake()
	{
		if ((bool)_tailSound)
		{
			// tail on own object next to gun. switch disables gun = cut tail
			_tailAudioSource = new GameObject(base.gameObject.name + " TailAudio").AddComponent<AudioSource>();
			_tailAudioSource.clip = _tailSound;
			_tailAudioSource.playOnAwake = false;
			_tailSoundMaxLength = _tailSound.length * 0.8f;
		}
		else
		{
			Debug.LogError("There is no audio clip signed for WeaponTailSound!");
		}
	}

	private void Update()
	{
		if (_tailSoundLength > 0f)
		{
			if ((bool)_headAnimation)
			{
				_headAnimation.OnShoot();
			}
			_tailSoundLength -= Time.deltaTime;
		}
	}

	public override void OnShoot()
	{
		if ((bool)_tailAudioSource)
		{
			_tailAudioSource.Stop();
		}
		_tailSoundLength = _tailSoundMaxLength;
	}

	public override void OnPostShoot()
	{
		if ((bool)_tailAudioSource)
		{
			Transform t = _tailAudioSource.transform;
			Transform gun = base.transform;
			while ((bool)gun.parent && !gun.GetComponent<BaseWeaponDecorator>())
			{
				gun = gun.parent;
			}
			if (t.parent != gun.parent)
			{
				t.parent = gun.parent;
			}
			t.position = base.transform.position;
			_tailAudioSource.Stop();
			_tailAudioSource.Play();
		}
	}

	public override void Hide()
	{
	}

	private void OnDestroy()
	{
		if ((bool)_tailAudioSource)
		{
			Object.Destroy(_tailAudioSource.gameObject, 3f);
		}
	}

	public override void OnHits(RaycastHit[] hits)
	{
	}
}
