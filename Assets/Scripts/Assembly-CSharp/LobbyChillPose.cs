using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

// Legacy-animation driver for the lobby / shop avatar. Loads the full
// set of named AnimationClips from the Unity 4.3 LutzBaseAvatar.fbx
// (copied to Assets/Resources/Character/LutzBaseAvatar.fbx, imported
// as Legacy animationType) and plays them on a legacy Animation
// component that replaces the broken Mecanim Animator on the spawned
// avatar root.
//
// Class name kept as LobbyChillPose so the existing prefab-embedded
// MonoBehaviour script reference in LutzBaseAvatarTPose.prefab
// (script guid f8c3e1a7b2d94f5689a0b1c2d3e4f5a6) continues to resolve.
public class LobbyChillPose : MonoBehaviour
{
	public enum PoseMode
	{
		HomeIdle,
		ShopLargeGun,
		ShopSmallGun,
		ShopMelee
	}

	public static PoseMode CurrentMode = PoseMode.HomeIdle;

	private static List<AnimationClip> _cachedClips;
	private Animation _legacy;
	private Animator _animator;
	private PoseMode _lastApplied = (PoseMode)(-1);

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
	private static void Hook()
	{
		SceneManager.sceneLoaded += OnSceneLoaded;
		AttachToAllAvatars();
	}

	private static void OnSceneLoaded(Scene scene, LoadSceneMode mode)
	{
		AttachToAllAvatars();
	}

	private static void AttachToAllAvatars()
	{
		foreach (Animator a in Object.FindObjectsOfType<Animator>(true))
		{
			if (a == null || a.gameObject == null)
			{
				continue;
			}
			string n = a.gameObject.name;
			if (!(n.Contains("Avatar") || n.Contains("TPose") || n.Contains("Lutz") || n.Contains("Julia")))
			{
				continue;
			}
			if (a.gameObject.GetComponent<LobbyChillPose>() == null)
			{
				a.gameObject.AddComponent<LobbyChillPose>();
			}
		}
	}

	private void Awake()
	{
		_animator = GetComponent<Animator>();
		if (_animator != null)
		{
			_animator.enabled = false;
		}
		_legacy = GetComponent<Animation>();
		if (_legacy == null)
		{
			_legacy = gameObject.AddComponent<Animation>();
		}
		_legacy.playAutomatically = false;
		EnsureClipsLoaded();
		if (_cachedClips != null)
		{
			foreach (AnimationClip clip in _cachedClips)
			{
				if (clip == null)
				{
					continue;
				}
				if (_legacy.GetClip(clip.name) == null)
				{
					clip.legacy = true;
					_legacy.AddClip(clip, clip.name);
				}
			}
		}
	}

	private void OnEnable()
	{
		_lastApplied = (PoseMode)(-1);
	}

	private void LateUpdate()
	{
		if (_animator != null && _animator.enabled)
		{
			_animator.enabled = false;
		}
		if (_legacy == null)
		{
			return;
		}
		if (CurrentMode != _lastApplied)
		{
			PlayFor(CurrentMode);
			_lastApplied = CurrentMode;
		}
		else if (!_legacy.isPlaying)
		{
			PlayFor(CurrentMode);
		}
	}

	private void PlayFor(PoseMode mode)
	{
		string clipName = ClipNameFor(mode);
		if (string.IsNullOrEmpty(clipName))
		{
			return;
		}
		if (_legacy.GetClip(clipName) == null)
		{
			foreach (PoseMode fallback in new[] { PoseMode.HomeIdle, PoseMode.ShopLargeGun, PoseMode.ShopSmallGun, PoseMode.ShopMelee })
			{
				string fn = ClipNameFor(fallback);
				if (_legacy.GetClip(fn) != null)
				{
					clipName = fn;
					break;
				}
			}
		}
		if (_legacy.GetClip(clipName) == null)
		{
			return;
		}
		AnimationState st = _legacy[clipName];
		if (st != null)
		{
			st.wrapMode = WrapMode.Loop;
		}
		_legacy.CrossFade(clipName, 0.25f);
	}

	private static string ClipNameFor(PoseMode mode)
	{
		switch (mode)
		{
			case PoseMode.ShopLargeGun: return "ShopLargeGunAimIdle";
			case PoseMode.ShopSmallGun: return "ShopSmallGunAimIdle";
			case PoseMode.ShopMelee: return "ShopMeleeAimIdle";
			default: return "HomeNoWeaponIdle";
		}
	}

	private static void EnsureClipsLoaded()
	{
		if (_cachedClips != null)
		{
			return;
		}
		AnimationClip[] all = Resources.LoadAll<AnimationClip>("Character/LutzBaseAvatar");
		_cachedClips = new List<AnimationClip>(all != null ? all.Length : 0);
		if (all != null)
		{
			foreach (AnimationClip clip in all)
			{
				if (clip != null)
				{
					_cachedClips.Add(clip);
				}
			}
		}
	}

	public static void SetMode(PoseMode mode)
	{
		CurrentMode = mode;
	}
}
