using System.Collections;
using System.Collections.Generic;
using UberStrike.Core.Models.Views;
using UberStrike.Core.Types;
using UnityEngine;

[RequireComponent(typeof(AudioSource))]
public abstract class BaseWeaponDecorator : MonoBehaviour
{
	[SerializeField]
	private Transform _muzzlePosition;

	[SerializeField]
	private AudioClip[] _shootSounds;

	private Vector3 _defaultPosition;

	private Vector3 _ironSightPosition;

	private ParticleConfigurationType _effectType;

	private MoveTrailrendererObject _trailRenderer;

	private Transform _parent;

	private ParticleSystem _particles;

	private bool _isEnabled = true;

	private bool _isShootAnimationEnabled;

	protected AudioSource _mainAudioSource;

	private Dictionary<string, SurfaceEffectType> _effectMap;

	private List<BaseWeaponEffect> _effects = new List<BaseWeaponEffect>();

	public static bool _noAmmoSoundPlaying;

	public bool IsEnabled
	{
		get
		{
			return _isEnabled;
		}
		set
		{
			if (base.gameObject.activeSelf != value)
			{
				_isEnabled = value;
				base.gameObject.SetActive(_isEnabled);
				HideAllWeaponEffect();
			}
		}
	}

	public bool EnableShootAnimation
	{
		get
		{
			return _isShootAnimationEnabled;
		}
		set
		{
			_isShootAnimationEnabled = value;
			if (!_isShootAnimationEnabled)
			{
				WeaponShootAnimation weaponShootAnimation = _effects.Find((BaseWeaponEffect p) => p is WeaponShootAnimation) as WeaponShootAnimation;
				if ((bool)weaponShootAnimation)
				{
					_effects.Remove(weaponShootAnimation);
					Object.Destroy(weaponShootAnimation);
				}
			}
		}
	}

	public bool HasShootAnimation { get; private set; }

	public Vector3 MuzzlePosition
	{
		get
		{
			if ((bool)_muzzlePosition)
			{
				return _muzzlePosition.position;
			}
			return Vector3.zero;
		}
	}

	public Vector3 DefaultPosition
	{
		get
		{
			return _defaultPosition;
		}
		set
		{
			_defaultPosition = value;
			base.transform.localPosition = _defaultPosition;
		}
	}

	public Vector3 CurrentPosition
	{
		get
		{
			return base.transform.localPosition;
		}
		set
		{
			base.transform.localPosition = value;
		}
	}

	public Quaternion CurrentRotation
	{
		get
		{
			return base.transform.localRotation;
		}
		set
		{
			base.transform.localRotation = value;
		}
	}

	public Vector3 IronSightPosition
	{
		get
		{
			return _ironSightPosition;
		}
		set
		{
			_ironSightPosition = value;
		}
	}

	public Vector3 DefaultAngles { get; set; }

	public UberstrikeItemClass WeaponClass { get; set; }

	public MoveTrailrendererObject TrailRenderer
	{
		get
		{
			return _trailRenderer;
		}
	}

	public bool IsMelee { get; protected set; }

	public void HideAllWeaponEffect()
	{
		if (_effects == null)
		{
			return;
		}
		foreach (BaseWeaponEffect effect in _effects)
		{
			effect.Hide();
		}
	}

	protected virtual void Awake()
	{
		_parent = base.transform.parent;
		_mainAudioSource = GetComponent<AudioSource>();
		if ((bool)_mainAudioSource)
		{
			_mainAudioSource.priority = 0;
		}
		_effects.AddRange(GetComponentsInChildren<BaseWeaponEffect>(true));
		if ((bool)_muzzlePosition)
		{
			_particles = _muzzlePosition.GetComponent<ParticleSystem>();
		}
		HasShootAnimation = _effects.Exists((BaseWeaponEffect e) => e is WeaponShootAnimation);
		InitEffectMap();
	}

	protected virtual void Start()
	{
		HideAllWeaponEffect();
	}

	public BaseWeaponDecorator Clone()
	{
		return Object.Instantiate(this) as BaseWeaponDecorator;
	}

	public virtual void ShowShootEffect(RaycastHit[] hits)
	{
		if (!IsEnabled || hits == null)
		{
			return;
		}
		if ((bool)_muzzlePosition)
		{
			Vector3 position = _muzzlePosition.position;
			for (int i = 0; i < hits.Length; i++)
			{
				Vector3 normalized = (hits[i].point - position).normalized;
				float distance = Vector3.Distance(position, hits[i].point);
				ShowImpactEffects(hits[i], normalized, position, distance, i == 0);
			}
		}
		foreach (BaseWeaponEffect effect in _effects)
		{
			effect.OnShoot();
			effect.OnHits(hits);
		}
		if ((bool)_particles)
		{
			_particles.Stop();
			_particles.Play(_isShootAnimationEnabled);
		}
		PlayShootSound();
	}

	public virtual void PostShoot()
	{
		if (!IsEnabled || _effects == null)
		{
			return;
		}
		foreach (BaseWeaponEffect effect in _effects)
		{
			effect.OnPostShoot();
		}
	}

	protected virtual void ShowImpactEffects(RaycastHit hit, Vector3 direction, Vector3 muzzlePosition, float distance, bool playSound)
	{
		EmitImpactParticles(hit, direction, muzzlePosition, distance, playSound);
	}

	private static void Play3dAudioClip(AudioSource audioSource, AudioClip soundEffect, float delay = 0f)
	{
		try
		{
			audioSource.clip = soundEffect;
			ulong delay2 = (ulong)(delay * (float)audioSource.clip.frequency);
			audioSource.Play(delay2);
		}
		catch
		{
			Debug.LogError("Play3dAudioClip: " + (((object)soundEffect != null) ? soundEffect.ToString() : null) + " failed.");
		}
	}

	public virtual void StopSound()
	{
		_mainAudioSource.Stop();
	}

	public void PlayShootSound()
	{
		if ((bool)_mainAudioSource && _shootSounds != null && _shootSounds.Length != 0)
		{
			int num = Random.Range(0, _shootSounds.Length);
			AudioClip audioClip = _shootSounds[num];
			if ((bool)audioClip)
			{
				_mainAudioSource.volume = ((!ApplicationDataManager.ApplicationOptions.AudioEnabled) ? 0f : ApplicationDataManager.ApplicationOptions.AudioEffectsVolume);
				_mainAudioSource.PlayOneShot(audioClip);
			}
		}
	}

	private void InitEffectMap()
	{
		_effectMap = new Dictionary<string, SurfaceEffectType>();
		_effectMap.Add("Wood", SurfaceEffectType.WoodEffect);
		_effectMap.Add("SolidWood", SurfaceEffectType.WoodEffect);
		_effectMap.Add("Stone", SurfaceEffectType.StoneEffect);
		_effectMap.Add("Metal", SurfaceEffectType.MetalEffect);
		_effectMap.Add("Sand", SurfaceEffectType.SandEffect);
		_effectMap.Add("Grass", SurfaceEffectType.GrassEffect);
		_effectMap.Add("Avatar", SurfaceEffectType.Splat);
		_effectMap.Add("Water", SurfaceEffectType.WaterEffect);
		_effectMap.Add("NoTarget", SurfaceEffectType.None);
		_effectMap.Add("Cement", SurfaceEffectType.StoneEffect);
	}

	public void SetSurfaceEffect(ParticleConfigurationType effect)
	{
		_effectType = effect;
	}

	public virtual void PlayEquipSound()
	{
		AutoMonoBehaviour<SfxManager>.Instance.PlayInGameAudioClip(GameAudio.WeaponSwitch, 0uL);
	}

	public virtual void PlayHitSound()
	{
		Debug.LogError("Not Implemented: Should play WeaponHit sound!");
	}

	public void PlayOutOfAmmoSound(UberStrikeItemWeaponView _weapon)
	{
		if (!_noAmmoSoundPlaying)
		{
			StartCoroutine(StopAmmoTimer(_weapon));
			try
			{
				Play3dAudioClip(_mainAudioSource, GameAudio.OutOfAmmoClick);
			}
			catch
			{
				AudioClip outOfAmmoClick = GameAudio.OutOfAmmoClick;
				Debug.LogError("Play3dAudioClip: " + (((object)outOfAmmoClick != null) ? outOfAmmoClick.ToString() : null) + " failed.");
			}
		}
	}

	private IEnumerator StopAmmoTimer(UberStrikeItemWeaponView _weapon)
	{
		_noAmmoSoundPlaying = true;
		yield return new WaitForSeconds(WeaponConfigurationHelper.GetRateOfFire(_weapon));
		_noAmmoSoundPlaying = false;
	}

	public void PlayImpactSoundAt(HitPoint point)
	{
		if (point != null)
		{
			float num = ((!_muzzlePosition) ? 0f : _muzzlePosition.position.y);
			float num2 = num;
			float num3 = ((!(GameState.Current.Map != null) || !GameState.Current.Map.HasWaterPlane) ? num2 : GameState.Current.Map.WaterPlaneHeight);
			if ((!(num2 > num3) || !(point.Point.y < num3)) && (!(num2 < num3) || !(point.Point.y > num3)))
			{
				EmitImpactSound(point.Tag, point.Point);
				return;
			}
			Vector3 point2 = point.Point;
			point2.y = 0f;
			AutoMonoBehaviour<SfxManager>.Instance.PlayImpactSound("Water", point2);
		}
	}

	protected virtual void EmitImpactSound(string impactType, Vector3 position)
	{
		AutoMonoBehaviour<SfxManager>.Instance.PlayImpactSound(impactType, position);
	}

	protected void EmitImpactParticles(RaycastHit hit, Vector3 direction, Vector3 muzzlePosition, float distance, bool playSound)
	{
		string key = TagUtil.GetTag(hit.collider);
		Vector3 point = hit.point;
		Vector3 hitNormal = hit.normal;
		SurfaceEffectType value = SurfaceEffectType.Default;
		if (!_effectMap.TryGetValue(key, out value))
		{
			return;
		}
		if (GameState.Current.Map != null && GameState.Current.Map.HasWaterPlane && ((_muzzlePosition.position.y > GameState.Current.Map.WaterPlaneHeight && point.y < GameState.Current.Map.WaterPlaneHeight) || (_muzzlePosition.position.y < GameState.Current.Map.WaterPlaneHeight && point.y > GameState.Current.Map.WaterPlaneHeight)))
		{
			value = SurfaceEffectType.WaterEffect;
			key = "Water";
			hitNormal = Vector3.up;
			point.y = GameState.Current.Map.WaterPlaneHeight;
			if (!Mathf.Approximately(direction.y, 0f))
			{
				float waterPlaneHeight = GameState.Current.Map.WaterPlaneHeight;
				float num = (waterPlaneHeight - hit.point.y) / direction.y * direction.x;
				point.x = num + hit.point.x;
				float waterPlaneHeight2 = GameState.Current.Map.WaterPlaneHeight;
				float num2 = (waterPlaneHeight2 - hit.point.y) / direction.y * direction.z;
				point.z = num2 + hit.point.z;
			}
		}
		ParticleEffectController.ShowHitEffect(_effectType, value, direction, point, hitNormal, muzzlePosition, distance, ref _trailRenderer, _parent);
	}

	public void SetMuzzlePosition(Transform muzzle)
	{
		_muzzlePosition = muzzle;
	}

	public void SetWeaponSounds(AudioClip[] sounds)
	{
		if (sounds != null)
		{
			_shootSounds = new AudioClip[sounds.Length];
			sounds.CopyTo(_shootSounds, 0);
		}
	}
}
