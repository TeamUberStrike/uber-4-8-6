using System;
using System.IO;
using System.Text;
using UnityEngine;

// ---------------------------------------------------------------------------
// MecanimRiskHarness -- the ONLY sanctioned way to re-enable an avatar Animator.
//
// Unity 4.6.5 hard-crashes (native AV in mecanim::animation::EvaluateAvatarSM,
// avatar.cpp:628) when the player avatar's Animator is left enabled. The
// mitigation in AvatarAnimationController.Awake() sets Animator.enabled = false
// unconditionally and FIRST; this class can only ever flip it back after three
// independent locks have all been opened:
//
//   LOCK 1  compile-time  -- scripting define UBERSTRIKE_MECANIM_RISK.
//                           Absent by default, so the call site emits no IL.
//   LOCK 2  one-shot arm  -- a file <project>/mecanim_risk.arm containing "ARM".
//                           It is CONSUMED (rewritten to DISARMED) BEFORE the
//                           enable, so a hard crash can never crash-loop.
//   LOCK 3  pre-flight    -- Validate() below, which runs entirely while the
//                           Animator is still disabled and touches nothing in
//                           the FK pipeline.
//
// Nothing here ever deletes a file. The arm token is rewritten in place.
//
// NOTE ON THE VALIDATOR'S CEILING: avatar.isValid only reports whether Unity's
// own avatar builder succeeded. It can return true for data that still kills FK.
// The strictly stronger check is offline: diff the repaired asset bytes against
// the shipped client (sharedassets0.assets). Prefer that; this is a backstop.
// ---------------------------------------------------------------------------
public static class MecanimRiskHarness
{
	private const string ArmFileName = "mecanim_risk.arm";

	private const string CrumbFileName = "mecanim_risk.lastrun.txt";

	private const string ArmToken = "ARM";

	// Skeleton transform paths this humanoid Avatar binds to, taken verbatim from
	// m_TOS in Assets/Avatar/T-Pose With RiggingAvatar.asset and byte-verified
	// against the shipped 4.6.5f1 client (sharedassets0.assets @0x02274d74).
	// The gear roots that also appear in m_TOS -- LutzHeadAndFace, DefaultHead,
	// DefaultUpperBody, DefaultLowerBody, DefaultGloves, DefaultBoots -- are
	// deliberately NOT listed: SkinnedMeshCombiner destroys those GameObjects, so
	// requiring them would fail a correctly built avatar.
	public static readonly string[] RequiredBonePaths = new string[]
	{
		"Hips",
		"Hips/Spine",
		"Hips/Spine/Chest",
		"Hips/Spine/Chest/Neck",
		"Hips/Spine/Chest/Neck/Head",
		"Hips/Spine/Chest/LeftShoulder",
		"Hips/Spine/Chest/LeftShoulder/LeftArm",
		"Hips/Spine/Chest/LeftShoulder/LeftArm/LeftForeArm",
		"Hips/Spine/Chest/LeftShoulder/LeftArm/LeftForeArm/LeftHand",
		"Hips/Spine/Chest/RightShoulder",
		"Hips/Spine/Chest/RightShoulder/RightArm",
		"Hips/Spine/Chest/RightShoulder/RightArm/RightForeArm",
		"Hips/Spine/Chest/RightShoulder/RightArm/RightForeArm/RightHand",
		"Hips/LeftUpLeg",
		"Hips/LeftUpLeg/LeftLeg",
		"Hips/LeftUpLeg/LeftLeg/LeftFoot",
		"Hips/RightUpLeg",
		"Hips/RightUpLeg/RightLeg",
		"Hips/RightUpLeg/RightLeg/RightFoot"
	};

	private static string ProjectRoot
	{
		get { return Directory.GetParent(Application.dataPath).FullName; }
	}

	public static string ArmFilePath
	{
		get { return Path.Combine(ProjectRoot, ArmFileName); }
	}

	public static string CrumbFilePath
	{
		get { return Path.Combine(ProjectRoot, CrumbFileName); }
	}

	// ---------------- LOCK 3: pre-flight ----------------
	// Pure managed code. Runs while the Animator is still DISABLED.
	// Animator.isInitialized does NOT exist in Unity 4.6.5 -- do not add it.
	// Animator.layerCount / GetBoneTransform / GetCurrentAnimatorStateInfo all
	// need a live mecanim instance (an ENABLED Animator) and must never be
	// called from here.
	public static bool Validate(Animator animator, bool expectHuman, out string report)
	{
		StringBuilder sb = new StringBuilder();
		bool ok = true;
		if (animator == null)
		{
			report = "FAIL: Animator is null.";
			return false;
		}

		// Fully qualified on purpose: Assets/Scripts/Assembly-CSharp/Avatar.cs
		// declares a global-namespace "class Avatar" that shadows UnityEngine.Avatar.
		UnityEngine.Avatar av = animator.avatar;
		if (av == null)
		{
			sb.AppendLine("FAIL: Animator.avatar is null.");
			ok = false;
		}
		else
		{
			if (!av.isValid)
			{
				sb.AppendLine("FAIL: avatar.isValid == false (" + av.name + ")");
				ok = false;
			}
			else
			{
				sb.AppendLine("ok  : avatar.isValid (" + av.name + ")");
			}
			if (av.isHuman != expectHuman)
			{
				sb.AppendLine("FAIL: avatar.isHuman == " + av.isHuman + ", expected " + expectHuman);
				ok = false;
			}
			else
			{
				sb.AppendLine("ok  : avatar.isHuman == " + av.isHuman);
			}
		}

		if (animator.runtimeAnimatorController == null)
		{
			sb.AppendLine("FAIL: Animator.runtimeAnimatorController is null.");
			ok = false;
		}
		else
		{
			sb.AppendLine("ok  : runtimeAnimatorController == " + animator.runtimeAnimatorController.name);
		}

		// The check that corresponds to the observed crash shape: an Avatar that
		// names bones this hierarchy does not contain resolves to a null bone
		// pointer inside FKStep.
		if (expectHuman)
		{
			int missing = 0;
			Transform root = animator.transform;
			for (int i = 0; i < RequiredBonePaths.Length; i++)
			{
				if (root.Find(RequiredBonePaths[i]) == null)
				{
					sb.AppendLine("FAIL: missing bone transform '" + RequiredBonePaths[i] + "'");
					missing++;
					if (missing >= 5)
					{
						sb.AppendLine("FAIL: ...(further missing bones not listed)");
						break;
					}
				}
			}
			if (missing > 0)
			{
				ok = false;
			}
			else
			{
				sb.AppendLine("ok  : all " + RequiredBonePaths.Length + " required bone transforms present");
			}
		}

		sb.AppendLine(ok ? "RESULT: PASS" : "RESULT: FAIL");
		report = sb.ToString();
		return ok;
	}

	// ---------------- LOCK 2, then the enable ----------------
	public static void TryEnable(MonoBehaviour owner, Animator animator)
	{
		try
		{
			if (animator == null || owner == null)
			{
				return;
			}

			string armPath = ArmFilePath;
			if (!File.Exists(armPath))
			{
				return;
			}

			string[] armLines = File.ReadAllLines(armPath);
			if (armLines.Length == 0 || armLines[0].Trim() != ArmToken)
			{
				return;
			}

			// Optional second line scopes the arm to one GameObject by name prefix,
			// so arming does not enable every avatar-bearing prefab at once.
			if (armLines.Length > 1)
			{
				string want = armLines[1].Trim();
				if (want.Length > 0 && !owner.gameObject.name.StartsWith(want))
				{
					return;
				}
			}

			// CONSUME BEFORE ENABLING. If the next FK tick hard-crashes the Editor
			// the token is already spent on disk, so relaunching cannot crash-loop.
			// Rewrite, never delete.
			File.WriteAllText(armPath, "DISARMED " + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "\r\n" + "consumed by " + owner.gameObject.name + "\r\n" + "To re-arm: replace this whole file with the single line  ARM\r\n");

			string report;
			bool pass = Validate(animator, true, out report);

			// Breadcrumb hits the disk BEFORE the enable: Debug.Log is buffered and a
			// native AV inside PlayerLoop will not flush output_log.txt.
			File.WriteAllText(CrumbFilePath, "MecanimRiskHarness " + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "\r\n" + "GameObject : " + owner.gameObject.name + "\r\n" + "Avatar     : " + ((animator.avatar != null) ? animator.avatar.name : "<null>") + "\r\n" + "Controller : " + ((animator.runtimeAnimatorController != null) ? animator.runtimeAnimatorController.name : "<null>") + "\r\n" + report + "\r\n" + (pass ? "ABOUT TO SET Animator.enabled = true.\r\nIf this is the last line and the Editor died, the crash is still in the FK pipeline.\r\n" : "VALIDATION FAILED - Animator left disabled.\r\n"));

			if (!pass)
			{
				Debug.LogWarning("[MecanimRiskHarness] pre-flight FAILED, Animator stays disabled:\n" + report);
				return;
			}

			Debug.LogWarning("[MecanimRiskHarness] pre-flight PASSED, enabling Animator on '" + owner.gameObject.name + "'. Breadcrumb: " + CrumbFilePath);
			animator.enabled = true;
		}
		catch (Exception ex)
		{
			// Any failure at all -> return to the known-safe state.
			if (animator != null)
			{
				animator.enabled = false;
			}
			Debug.LogWarning("[MecanimRiskHarness] disabled (harness error: " + ex.Message + ")");
		}
	}
}
