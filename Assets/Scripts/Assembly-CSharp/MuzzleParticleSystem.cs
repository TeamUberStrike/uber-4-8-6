using UnityEngine;

public class MuzzleParticleSystem : BaseWeaponEffect
{
	private ParticleSystem _particleSystem;

	private void Awake()
	{
		_particleSystem = GetComponent<ParticleSystem>();
	}

	public override void OnShoot()
	{
		if ((bool)_particleSystem)
		{
			_particleSystem.Play();
		}
	}

	private void OnEnable()
	{
		HideAllEffects();
	}

	public override void OnPostShoot()
	{
	}

	public override void Hide()
	{
		if ((bool)_particleSystem)
		{
			_particleSystem.Stop();
		}
	}

	public override void OnHits(RaycastHit[] hits)
	{
	}
}
