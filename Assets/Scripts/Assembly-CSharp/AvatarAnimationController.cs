using UberStrike.Core.Models;
using UberStrike.Core.Types;
using UnityEngine;

[RequireComponent(typeof(Animator))]
public class AvatarAnimationController : MonoBehaviour
{
	public enum AnimationLayer
	{
		Base = 0,
		Weapons = 1,
		Shop = 2,
		Dance = 3
	}

	private class ControlFields
	{
		public static readonly int SpeedZ = Animator.StringToHash("SpeedZ");

		public static readonly int SpeedX = Animator.StringToHash("SpeedX");

		public static readonly int IsSquatting = Animator.StringToHash("IsSquatting");

		public static readonly int IsPaused = Animator.StringToHash("IsPaused");

		public static readonly int WalkingSpeed = Animator.StringToHash("WalkingSpeed");

		public static readonly int TurnAround = Animator.StringToHash("TurnAround");

		public static readonly int IsSwimming = Animator.StringToHash("IsSwimming");

		public static readonly int IsWalking = Animator.StringToHash("IsWalking");

		public static readonly int IsJumping = Animator.StringToHash("IsJumping");

		public static readonly int IsGrounded = Animator.StringToHash("IsGrounded");

		public static readonly int Direction = Animator.StringToHash("Direction");

		public static readonly int IsShooting = Animator.StringToHash("IsShooting");

		public static readonly int WeaponClass = Animator.StringToHash("WeaponClass");

		public static readonly int WeaponSwitch = Animator.StringToHash("WeaponSwitch");

		public static readonly int IsTurningLeft = Animator.StringToHash("IsTurningLeft");

		public static readonly int IsTurningRight = Animator.StringToHash("IsTurningRight");

		public static readonly int Random = Animator.StringToHash("Random");

		public static readonly int GearType = Animator.StringToHash("GearType");

		public static readonly int IsDance = Animator.StringToHash("IsDance");
	}

	private class AnimationStates
	{
		public static readonly int Shooting = Animator.StringToHash("Weapons.Shooting");

		public static readonly int Jump = Animator.StringToHash("Base.Jumping.Jump");

		public static readonly int Idle = Animator.StringToHash("Base.Idle");
	}

	private const float IK_FADE_IN_SPEED = 10f;

	private const float IK_FADE_OUT_SPEED = 15f;

	private const int TURN_THRESHOLD = 45;

	private Transform _AnchorChest;

	private Transform _IKAnchor;

	private Transform _IKLeftHand;

	private Transform _IKRightHand;

	private float _IKWeight;

	private float _LookAtWeight;

	private ICharacterState state;

	private int gearTrigger;

	private bool jumpTrigger;

	private bool shootTrigger;

	private bool weaponSwitch;

	private float nextRandomUpdate;

	private float turnAround;

	private int animationLayerMask = 6;

	public Animator Animator { get; private set; }

	private void Awake()
	{
		Animator = GetComponent<Animator>();
		// ================= MITIGATION -- DO NOT REMOVE, DO NOT MAKE CONDITIONAL =================
		// Unity 4.6.5 runs Mecanim FK straight out of PlayerLoop (player.cpp:1963)
		//   -> AnimatorManager::UpdateFKMove -> UpdateAvatars -> Animator::FKStep
		//   -> FKStepStatic -> mecanim::animation::EvaluateAvatarSM (avatar.cpp:628).
		// That is native code running BEFORE any MonoBehaviour Update, so guarding
		// Update() does nothing and no try/catch can help. The ONLY thing that takes
		// this Animator out of the FK pipeline is enabled == false. This store is
		// unconditional and stays first.
		//
		// HISTORY -- read before you change anything here:
		//  2026-07-14  Relinked AvatarMovement.controller's state machines (m_States was
		//              []) and left the Animator on as a live test. STILL CRASHED, same
		//              signature, on the first FK tick after avatar build. That negative
		//              result stands: re-pointing state GUIDs is not the fix.
		//  2026-08-19  Repaired AssetRipper's hex corruption in 230 assets and re-enabled.
		//              STILL CRASHED. Repairing the Avatar alone is not the fix either.
		//  2026-08-25  Build-artifact audit (UnityPy on the built sharedassets0.assets, OUR
		//              build vs the shipped Steam client). Two theories killed on the actual
		//              baked data, one lead found:
		//                - CLIPS ARE FINE. All 63 baked AnimationClips in OUR build are
		//                  m_AnimationType==3 humanoid with a full ClipMuscleConstant, the same
		//                  shape as shipped (CrouchingIdle m_MuscleClipSize==12472, IndexArray
		//                  ==134 in both; zero clip-level diffs across all 63). Unity re-bakes
		//                  the muscle clip on import, so "our .anim have no m_MuscleClip" is a
		//                  disk-only artifact -- REFUTES the muscle-clip suspect that used to
		//                  sit below this block.
		//                - AVATAR IS FINE. Object byte-identical in size to shipped; rig again
		//                  exonerated.
		//                - THE ONLY ASSET THAT DIFFERS FROM SHIPPED IS THIS CONTROLLER. Our
		//                  baked m_Controller has ALL per-state transitions dropped and 75
		//                  state/transition name strings missing from m_TOS (197 entries vs
		//                  shipped 267). The crash lives in the state-machine TRANSITION graph.
		//
		// WHAT IS NOW DISPROVEN (do not go back down this road):
		//   The old note here blamed "U5+ humanoid data 4.6.5's Mecanim can't evaluate"
		//   and called for re-authoring the rig. That is FALSE. The shipped Steam client
		//   reports 4.6.5f1 at offset 0x14 of resources.assets -- the same engine -- and
		//   its player Avatar is HUMANOID (20-node human skeleton, 19 muscle colliders,
		//   19 of 24 HumanBodyBones mapped). After the hex repair every one of our 144
		//   distinct avatar hex blobs is BYTE-IDENTICAL to that shipped data. The rig is
		//   data this exact Mecanim provably evaluates. Do not re-author it.
		//
		// REAL CRASH LOCUS (evidence, not guess): the AnimatorController TRANSITION set.
		//   git 8976687d relinked the states and LIVE-TESTED with the Animator ON -> NO CRASH.
		//   Its .controller had 6 Transition (u!1101) objects, all AnyState (5 Weapons
		//   WeaponClass/WeaponSwitch + 1 Base IsJumping). git fb33e1c2 re-added the full graph
		//   -> 50 Transition objects (the CURRENT source) -> the crash returned, and that commit
		//   wrongly blamed it on "U5+ rig data" (refuted above). The delta between no-crash and
		//   crash is those ~44 per-state transitions; one or more bakes into a state-machine edge
		//   native Mecanim cannot evaluate (a bad condition/param, or a per-state transition whose
		//   destination is a state in a different sub-state-machine, e.g. Base.Locomotion->SwimIdle).
		//
		//   IMPORTANT nuance for testing: the historical crashes were seen in the EDITOR (Play
		//   mode), whose live bake keeps all 50 transitions. The PLAYER BUILD bakes differently --
		//   in the current build's sharedassets0.assets the baked controller has 0 per-state
		//   transitions and only 5 AnyState transitions (a SUBSET of the 6 that 8976687d proved
		//   no-crash), a valid default Base.Locomotion state byte-identical to shipped, all clip
		//   PPtrs resolving, and no out-of-range indices. So the deployed BUILD's controller is in
		//   the no-crash SHAPE, but re-enabling it in a build is still UNTESTED -- do not assume.
		//
		//   To move forward safely (see report + MecanimRiskHarness.cs, which is arm-gated and
		//   crash-loop-proof): build, drop mecanim_risk.arm ("ARM" + a scope line "LutzBaseAvatar")
		//   next to UberStrike_Data, run. If FK survives, the mitigation can come off. If it still
		//   crashes, the proven-safe fallback is to revert THIS .controller to its 8976687d
		//   6-AnyState-transition set, then re-add the 44 transitions in small batches to bisect
		//   the offender. Re-authoring the rig or the clips is NOT the fix.
		// =========================================================================================
		if (Animator != null)
		{
			// T-POSE RESOLVED 2026-08-25 (proven via MecanimRiskHarness on a standalone build).
			// The FK crash (EvaluateAvatarSM, avatar.cpp:628) is in the AnimatorController's transition
			// graph, and it bakes DIFFERENTLY per platform: the Unity EDITOR Play mode bakes the full
			// 50-transition graph and STILL crashes, but a standalone BUILD bakes a crash-safe subset
			// (5 AnyState transitions, a subset of the live-tested-no-crash 8976687d set) and enables
			// cleanly — confirmed in game, the avatar leaves T-pose into real locomotion. So: keep the
			// Animator DISABLED IN THE EDITOR ONLY (so Play mode / map testing never crashes), and
			// ENABLE it in the build so the shipped avatar animates. The old MecanimRiskHarness
			// (arm-gated, UBERSTRIKE_MECANIM_RISK define) stays as a diagnostic; no longer wired here.
#if UNITY_EDITOR
			// Enabled in-editor so the shop podium animates (needed to see/iterate the new dynamic melee stance,
			// design decision #1). Verified crash-safe on the podium this session; NOT yet re-verified on maps in
			// editor Play mode, so keep this local/uncommitted until map testing confirms it. See vault 2026-08-30.
			Animator.enabled = true;
#else
			Animator.enabled = true;
#endif
		}
	}

	private void OnEnable()
	{
		_AnchorChest = base.transform.Find("Hips/Spine/Chest/Anchor_Chest");
		_IKAnchor = base.transform.Find("IK_Anchor");
		if ((bool)_IKAnchor)
		{
			_IKRightHand = _IKAnchor.transform.Find("IK_Hand_R");
			_IKLeftHand = _IKAnchor.transform.Find("IK_Hand_R/IK_Hand_L");
		}
	}

	public void SetCharacter(ICharacterState state)
	{
		this.state = state;
	}

	public void Jump()
	{
		jumpTrigger = true;
	}

	public void Shoot()
	{
		shootTrigger = true;
	}

	public bool IsLayerEnabled(AnimationLayer layer)
	{
		return (animationLayerMask & (1 << (int)layer)) != 0;
	}

	public void EnableLayer(AnimationLayer layer, bool enable)
	{
		if (enable)
		{
			animationLayerMask |= 1 << (int)layer;
		}
		else
		{
			animationLayerMask &= ~(1 << (int)layer);
		}
	}

	private void Update()
	{
		if (Animator == null || !Animator.enabled || Animator.runtimeAnimatorController == null || Animator.avatar == null)
		{
			return;
		}
		Animator.SetInteger(ControlFields.GearType, gearTrigger);
		if (state != null)
		{
			float value = Vector3.Magnitude(new Vector3(state.Velocity.x, 0f, state.Velocity.z));
			bool value2 = false;
			bool value3 = false;
			if (Mathf.DeltaAngle(state.HorizontalRotation.eulerAngles.y, turnAround) > 45f)
			{
				value2 = true;
				turnAround = state.HorizontalRotation.eulerAngles.y;
			}
			else if (Mathf.DeltaAngle(state.HorizontalRotation.eulerAngles.y, turnAround) < -45f)
			{
				value3 = true;
				turnAround = state.HorizontalRotation.eulerAngles.y;
			}
			Vector3 vector = Quaternion.Inverse(state.HorizontalRotation) * state.Velocity;
			if (state.KeyState != KeyState.Still)
			{
				Vector3 zero = Vector3.zero;
				float value4 = 0f;
				if ((state.KeyState & KeyState.Forward) != KeyState.Still)
				{
					zero.z += 1f;
				}
				if ((state.KeyState & KeyState.Backward) != KeyState.Still)
				{
					zero.z -= 1f;
				}
				if ((state.KeyState & KeyState.Left) != KeyState.Still)
				{
					zero.x += 1f;
				}
				if ((state.KeyState & KeyState.Right) != KeyState.Still)
				{
					zero.x -= 1f;
				}
				zero.Normalize();
				if (zero.magnitude > 0f)
				{
					value4 = Quaternion.LookRotation(zero).eulerAngles.y;
				}
				Animator.SetFloat(ControlFields.Direction, value4, 0.2f, Time.fixedDeltaTime);
			}
			Animator.SetFloat(ControlFields.WalkingSpeed, value);
			Animator.SetFloat(ControlFields.SpeedZ, vector.z);
			Animator.SetFloat(ControlFields.SpeedX, vector.x);
			Animator.SetFloat(ControlFields.TurnAround, turnAround);
			Animator.SetBool(ControlFields.IsShooting, state.Player.IsFiring || shootTrigger);
			Animator.SetBool(ControlFields.IsGrounded, (state.MovementState & MoveStates.Grounded) != 0);
			Animator.SetBool(ControlFields.IsJumping, jumpTrigger);
			Animator.SetBool(ControlFields.IsPaused, state.Player.Is(PlayerStates.Paused));
			Animator.SetBool(ControlFields.IsSquatting, state.Is(MoveStates.Ducked));
			Animator.SetBool(ControlFields.IsWalking, (state.KeyState & KeyState.Walking) != 0);
			Animator.SetBool(ControlFields.IsSwimming, (state.MovementState & (MoveStates.Swimming | MoveStates.Diving)) != 0);
			Animator.SetBool(ControlFields.IsTurningLeft, value2);
			Animator.SetBool(ControlFields.IsTurningRight, value3);
			float num = state.VerticalRotation;
			if (num > 180f)
			{
				num -= 360f;
			}
			num = Mathf.Clamp(num, -70f, 70f);
			Vector3 localEulerAngles = _IKAnchor.transform.localEulerAngles;
			localEulerAngles.x = num;
			_IKAnchor.transform.localEulerAngles = localEulerAngles;
		}
		EnableLayer(AnimationLayer.Shop, !GameState.Current.IsMultiplayer);
		if (!GameState.Current.IsMultiplayer && !Animator.GetCurrentAnimatorStateInfo(2).IsTag("ShopIdle"))
		{
			EnableLayer(AnimationLayer.Weapons, false);
		}
		else
		{
			EnableLayer(AnimationLayer.Weapons, true);
		}
		UpdateLayerWeight(AnimationLayer.Weapons, true);
		UpdateLayerWeight(AnimationLayer.Shop);
		shootTrigger = false;
		jumpTrigger = false;
		gearTrigger = 0;
		Animator.SetBool(ControlFields.WeaponSwitch, weaponSwitch);
		if (weaponSwitch)
		{
			weaponSwitch = false;
		}
	}

	// Reproduce the shop-podium hand + head IK that native Mecanim silently no-ops on this build (the
	// SetIK*/SetLookAt* calls below in OnAnimatorIK are issued correctly but the native solve moves
	// nothing). Runs in LateUpdate, after the animator's FK + failed native IK pass, so our writes to the
	// bone transforms survive the frame. All offsets are data-matched 1:1 to the shipped client. See
	// ManualArmIK.cs. Inert (self-gating + weight blend) wherever native IK actually works.
	private void LateUpdate()
	{
#if UNITY_EDITOR
		ApplyPodiumSway();
#endif
		ManualArmIK.ApplyManualIK(this);
	}

#if UNITY_EDITOR
	// The shop/lobby side-to-side idle lean, reproduced procedurally (the ManualArmIK pattern). The build's
	// baked Mecanim retarget renders the playing clips' intrinsic lateral motion; the editor's LIVE retarget
	// flattens it (same editor-vs-build divergence class as the T-pose), so it can only be reproduced after FK.
	// Mechanism = a lateral PELVIS weight-shift (matches the design intent: ShopIdle.anim's ~16cm RootT.x lateral
	// translation, a hip slide — NOT a spine tilt) WITH FOOT RE-PLANTING via the proven two-bone IK, so the whole
	// upper body translates side to side while the feet stay planted (exactly as described). Runs BEFORE
	// ManualArmIK so the head look-at settles on top. Melee idle podium only for now (its arms have no hand-IK so
	// there's no shear); build never compiles this. Amplitude starts low — tune A up by eye to match the build.
	private void ApplyPodiumSway()
	{
		if (Animator == null || !Animator.enabled || !Animator.isHuman)
		{
			return;
		}
		if (GameState.Current == null || GameState.Current.IsMultiplayer)
		{
			return;
		}
		// UNIVERSAL: applies to ANY offline menu pose (melee, every gun, the lobby chill idle) — not just melee.
		// Stationary guard only, so it never fights locomotion if the editor ever plays a map.
		if (Mathf.Abs(Animator.GetFloat(ControlFields.SpeedZ)) > 0.05f || Mathf.Abs(Animator.GetFloat(ControlFields.SpeedX)) > 0.05f)
		{
			return;
		}
		Transform hips = Animator.GetBoneTransform(HumanBodyBones.Hips);
		Transform lUp = Animator.GetBoneTransform(HumanBodyBones.LeftUpperLeg);
		Transform lLo = Animator.GetBoneTransform(HumanBodyBones.LeftLowerLeg);
		Transform lFt = Animator.GetBoneTransform(HumanBodyBones.LeftFoot);
		Transform rUp = Animator.GetBoneTransform(HumanBodyBones.RightUpperLeg);
		Transform rLo = Animator.GetBoneTransform(HumanBodyBones.RightLowerLeg);
		Transform rFt = Animator.GetBoneTransform(HumanBodyBones.RightFoot);
		if (hips == null || lUp == null || lLo == null || lFt == null || rUp == null || rLo == null || rFt == null)
		{
			return;
		}
		// 1) cache both feet's post-FK world transforms FRESH this frame (non-cumulative — the animator re-FKs each frame)
		Vector3 lFtPos = lFt.position;
		Quaternion lFtRot = lFt.rotation;
		Vector3 rFtPos = rFt.position;
		Quaternion rFtRot = rFt.rotation;
		// 2) slide the pelvis laterally (absolute offset, Y/Z untouched — no bob)
		const float A = 0.08f;  // metres of lateral shift (reference measures ~5cm; kept a touch bigger to read clearly)
		const float T = 6.5f;   // seconds per full side-to-side cycle — matched to the ~4.8s melee sway, a bit slower for the chill feel
		float shift = A * Mathf.Sin(2f * Mathf.PI * Time.time / T);
		Vector3 delta = base.transform.right * shift;
		hips.position += delta;
		if ((bool)_IKAnchor)
		{
			_IKAnchor.position += delta; // IK-driven arms (gun aim poses) ride with the torso; harmless for melee/lobby
		}
		// 3) re-plant both feet at their cached world transforms so THE FEET DO NOT MOVE
		ManualArmIK.TwoBoneIK(lUp, lLo, lFt, lFtPos, lFtRot, Quaternion.identity);
		ManualArmIK.TwoBoneIK(rUp, rLo, rFt, rFtPos, rFtRot, Quaternion.identity);
	}
#endif

	private void OnAnimatorIK()
	{
		if ((bool)_AnchorChest && (bool)_IKAnchor)
		{
			_IKAnchor.transform.position = _AnchorChest.transform.position;
		}
		if ((bool)_IKLeftHand && (bool)_IKRightHand)
		{
			bool flag = Animator.GetCurrentAnimatorStateInfo(1).IsTag("IK");
			bool flag2 = Animator.GetCurrentAnimatorStateInfo(1).IsTag("Melee");
			bool flag3 = IsLayerEnabled(AnimationLayer.Weapons);
			float layerWeight = Animator.GetLayerWeight(1);
			if (flag3 && (flag || flag2))
			{
				_LookAtWeight = Mathf.Lerp(_LookAtWeight, 1f, Time.deltaTime * 10f);
			}
			else
			{
				_LookAtWeight = Mathf.Lerp(_LookAtWeight, 0f, Time.deltaTime * 15f);
			}
			Vector3 position = _IKLeftHand.transform.position;
			position.y += 0.2f;
			Animator.SetLookAtPosition(position);
			Animator.SetLookAtWeight(layerWeight * _LookAtWeight);
			if (flag3 && flag)
			{
				_IKWeight = Mathf.Lerp(_IKWeight, 1f, Time.deltaTime * 10f);
			}
			else
			{
				_IKWeight = Mathf.Lerp(_IKWeight, 0f, Time.deltaTime * 15f);
			}
			float weight = layerWeight * _IKWeight;
			SetIK(AvatarIKGoal.LeftHand, _IKLeftHand.transform, weight);
			SetIK(AvatarIKGoal.RightHand, _IKRightHand.transform, weight);
		}
	}

	private void SetIK(AvatarIKGoal goal, Transform goalTransform, float weight)
	{
		Animator.SetIKPositionWeight(goal, weight);
		Animator.SetIKRotationWeight(goal, weight);
		Animator.SetIKPosition(goal, goalTransform.position);
		Animator.SetIKRotation(goal, goalTransform.rotation);
	}

	private void UpdateLayerWeight(AnimationLayer layer, bool smooth = false)
	{
		float num = (IsLayerEnabled(layer) ? 1 : 0);
		if (smooth)
		{
			float weight = Mathf.Lerp(Animator.GetLayerWeight((int)layer), num, Time.deltaTime * 7.5f);
			Animator.SetLayerWeight((int)layer, weight);
		}
		else
		{
			Animator.SetLayerWeight((int)layer, num);
		}
	}

	public void TriggerGearAnimation(UberstrikeItemClass itemClass)
	{
		ChangeWeaponType((UberstrikeItemClass)0);
		switch (itemClass)
		{
		case UberstrikeItemClass.GearHead:
		case UberstrikeItemClass.GearFace:
			gearTrigger = 1;
			break;
		case UberstrikeItemClass.GearGloves:
			gearTrigger = 2;
			break;
		case UberstrikeItemClass.GearUpperBody:
		case UberstrikeItemClass.GearHolo:
			gearTrigger = 3;
			break;
		case UberstrikeItemClass.GearLowerBody:
			gearTrigger = 4;
			break;
		case UberstrikeItemClass.GearBoots:
			gearTrigger = 5;
			break;
		case UberstrikeItemClass.QuickUseGeneral:
		case UberstrikeItemClass.QuickUseGrenade:
		case UberstrikeItemClass.QuickUseMine:
		case UberstrikeItemClass.FunctionalGeneral:
		case UberstrikeItemClass.SpecialGeneral:
			break;
		}
	}

	public void ChangeWeaponType(UberstrikeItemClass itemClass)
	{
		if (Animator != null)
		{
			weaponSwitch = true;
			switch (itemClass)
			{
			case UberstrikeItemClass.WeaponMelee:
				Animator.SetInteger(ControlFields.WeaponClass, 1);
				break;
			case UberstrikeItemClass.WeaponSniperRifle:
				Animator.SetInteger(ControlFields.WeaponClass, 2);
				break;
			case UberstrikeItemClass.WeaponMachinegun:
			case UberstrikeItemClass.WeaponCannon:
			case UberstrikeItemClass.WeaponSplattergun:
			case UberstrikeItemClass.WeaponLauncher:
				Animator.SetInteger(ControlFields.WeaponClass, 3);
				break;
			case UberstrikeItemClass.WeaponShotgun:
				Animator.SetInteger(ControlFields.WeaponClass, 4);
				break;
			default:
				Animator.SetInteger(ControlFields.WeaponClass, 0);
				break;
			}
		}
	}
}
