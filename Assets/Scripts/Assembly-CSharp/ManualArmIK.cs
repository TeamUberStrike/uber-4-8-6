using System;
using UnityEngine;

// Manual humanoid hand + head IK for the shop podium (Unity 4.6.5 / Mono net40).
//
// WHY: On this reconstruction build the native Mecanim IK solve is a proven NO-OP — hand IK
// (SetIKPosition/SetIKRotation) and the head look-at (SetLookAt*) are all called with the correct
// goals/weights in AvatarAnimationController.OnAnimatorIK, yet Unity moves nothing (validated with a
// live pose probe: hand->goal distance identical before and after the solve; the shipped client's
// collapses to 0). So the shop-aim pose came out wrong — weapon pitched ~+7.5deg, head looking down.
// The rig, controller and clips are byte-identical to shipped; the failure is inside native ProcessIK
// and is unreachable from managed code. Rather than chase it, we reproduce the pose ourselves.
//
// HOW: two-bone analytic arm IK to each hand goal + the fixed avatar hand-frame rotation offset, plus a
// head look-at — every constant DATA-MATCHED 1:1 to the working Steam client. Call from
// AvatarAnimationController.LateUpdate() (after the animator's FK + the no-op native IK pass) so our
// writes to the bone transforms survive the frame. Self-gating + weight/look-at blends make it inert on
// any client where native IK already works and ease it in from the lobby pose without snapping.
public static class ManualArmIK
{
    const float kSkipDist = 0.02f;   // hand already this close to goal -> do nothing (inert where native IK works)
    const float kEps = 1e-6f;

    // Avatar hand-frame offsets (Unity's SetIKRotation does NOT set hand.worldRot = goalRot; it applies a
    // fixed per-avatar offset). Derived from Steam (native IK on): handRot = goalRot * offset.
    //   right: goal IK_Hand_R wE=(352,110,300) -> hand wE=(357,8.2,7)
    //   left : goal IK_Hand_L wE=(352,110,85)  -> hand wE=(28.6,19.4,173.9)
    // Relative rotations, so yaw-invariant: one sample holds at every podium turntable angle.
    static readonly Quaternion HAND_FROM_GOAL =
        Quaternion.Inverse(Quaternion.Euler(352.0f, 110.0f, 300.0f)) * Quaternion.Euler(357.0f, 8.2f, 7.0f);
    static readonly Quaternion HAND_FROM_GOAL_L =
        Quaternion.Inverse(Quaternion.Euler(352.0f, 110.0f, 85.0f)) * Quaternion.Euler(28.6f, 19.4f, 173.9f);
    // Head look-at: at root wE=(0,110,0) the shipped head was wE=(3.6,117.1,356.0) (forward, down the scope).
    // The look is fixed in the body frame, so headRot = root.rotation * HEAD_FROM_ROOT holds at any angle.
    static readonly Quaternion HEAD_FROM_ROOT =
        Quaternion.Inverse(Quaternion.Euler(0f, 110f, 0f)) * Quaternion.Euler(3.6f, 117.1f, 356.0f);
    // Melee (and other non-aim) head look, data-matched from Steam: root(0,110,0) -> head(4.8,114.2,1.5).
    // The look-at is active for melee too (_LookAtWeight=1) even though there's no hand IK there.
    static readonly Quaternion HEAD_FROM_ROOT_MELEE =
        Quaternion.Inverse(Quaternion.Euler(0f, 110f, 0f)) * Quaternion.Euler(4.8f, 114.2f, 1.5f);

    public static void ApplyManualIK(MonoBehaviour self)
    {
        if ((object)self == null) return;
        Animator anim = self.GetComponent<Animator>();
        if ((object)anim == null) anim = self.GetComponentInChildren<Animator>();
        if ((object)anim == null) return;

        // The controller runs two independent refinements: hand IK (weight = layerW*_IKWeight, aim weapons
        // only) and the head look-at (weight = layerW*_LookAtWeight, active for melee too). Handle each on
        // its own weight so melee — which has NO hand IK but DOES look-at — still gets its head corrected.
        float layerW = (anim.layerCount > 1) ? anim.GetLayerWeight(1) : 1f;
        float handW = Mathf.Clamp01(layerW * ReflectFloat(self, "_IKWeight", 1f));
        float lookW = Mathf.Clamp01(layerW * ReflectFloat(self, "_LookAtWeight", 1f));
        if (handW <= 0f && lookW <= 0f) return;

        Transform rt = self.transform;

        if (handW > 0f)
        {
            // RIGHT hand holds the weapon (offset levels the barrel); LEFT hand onto the foregrip.
            SolveArm(anim, rt, HumanBodyBones.RightUpperArm, "RightArm", HumanBodyBones.RightLowerArm, "RightForeArm",
                     HumanBodyBones.RightHand, "RightHand", ReflectTransform(self, "_IKRightHand"), handW, HAND_FROM_GOAL);
            SolveArm(anim, rt, HumanBodyBones.LeftUpperArm, "LeftArm", HumanBodyBones.LeftLowerArm, "LeftForeArm",
                     HumanBodyBones.LeftHand, "LeftHand", ReflectTransform(self, "_IKLeftHand"), handW, HAND_FROM_GOAL_L);
        }

        // HEAD look-at: forward (down the scope for aim, at the camera for melee). Blend by the look-at
        // ramp so it eases in. Aim-tagged states use the sniper look; everything else uses the melee look.
        if (lookW > 0f)
        {
            Transform head = anim.isHuman ? anim.GetBoneTransform(HumanBodyBones.Head) : null;
            if ((object)head == null) head = FindDeep(rt, "Head");
            if ((object)head != null)
            {
                bool aimIK = anim.layerCount > 1 && anim.GetCurrentAnimatorStateInfo(1).IsTag("IK");
                Quaternion headTarget = rt.rotation * (aimIK ? HEAD_FROM_ROOT : HEAD_FROM_ROOT_MELEE);
                head.rotation = Quaternion.Slerp(head.rotation, headTarget, lookW);
            }
        }
    }

    // Two-bone arm to the goal position, hand set to goalRot * handFromGoal, blended toward the animated
    // pose by weight so it ramps in like the native solve.
    static void SolveArm(Animator anim, Transform rootT, HumanBodyBones rootB, string rootN,
                         HumanBodyBones midB, string midN, HumanBodyBones endB, string endN,
                         Transform goal, float weight, Quaternion handFromGoal)
    {
        if ((object)goal == null) return;
        Transform root = Resolve(anim, rootT, rootB, rootN);
        Transform mid = Resolve(anim, rootT, midB, midN);
        Transform end = Resolve(anim, rootT, endB, endN);
        if ((object)root == null || (object)mid == null || (object)end == null) return;

        Vector3 targetPos = goal.position;
        if (Vector3.Distance(end.position, targetPos) < kSkipDist) return;   // inert where native IK already reached

        Quaternion root0 = root.rotation, mid0 = mid.rotation, end0 = end.rotation;
        TwoBoneIK(root, mid, end, targetPos, goal.rotation, handFromGoal);
        if (weight >= 0.999f) return;
        root.rotation = Quaternion.Slerp(root0, root.rotation, weight);
        mid.rotation = Quaternion.Slerp(mid0, mid.rotation, weight);
        end.rotation = Quaternion.Slerp(end0, end.rotation, weight);
    }

    // Analytic two-bone IK (law of cosines). Preserves the current elbow bend plane (no flip); clamps an
    // unreachable target. root = upper arm, mid = elbow, end = hand. World-space Transform rotations.
    internal static void TwoBoneIK(Transform root, Transform mid, Transform end, Vector3 targetPos, Quaternion targetRot, Quaternion handFromGoal)
    {
        Vector3 a = root.position, b = mid.position, c = end.position;
        float upperLen = Vector3.Distance(a, b), lowerLen = Vector3.Distance(b, c);
        if (upperLen < kEps || lowerLen < kEps) { end.rotation = targetRot * handFromGoal; return; }

        float targetDist = (targetPos - a).magnitude;
        if (targetDist < kEps) { end.rotation = targetRot * handFromGoal; return; }
        float maxReach = (upperLen + lowerLen) * 0.9999f;
        float minReach = Mathf.Abs(upperLen - lowerLen) + 1e-4f;
        float reach = Mathf.Clamp(targetDist, minReach, maxReach);

        // Phase 1: bend the elbow so |shoulder->hand| == reach, about the current bone-plane normal.
        Vector3 ba = a - b, bc = c - b;
        float curElbow = SafeAngle(ba, bc);
        float cosDes = (upperLen * upperLen + lowerLen * lowerLen - reach * reach) / (2f * upperLen * lowerLen);
        float desElbow = Mathf.Acos(Mathf.Clamp(cosDes, -1f, 1f));
        Vector3 bendAxis = Vector3.Cross(ba, bc);
        if (bendAxis.sqrMagnitude < kEps) bendAxis = PickFallbackAxis(bc); else bendAxis.Normalize();
        float elbowDeltaDeg = (desElbow - curElbow) * Mathf.Rad2Deg;
        if (Mathf.Abs(elbowDeltaDeg) > 1e-4f)
            mid.rotation = Quaternion.AngleAxis(elbowDeltaDeg, bendAxis) * mid.rotation;

        // Phase 2: swing the whole arm at the shoulder so the hand points at the target.
        Vector3 curDir = end.position - a, wantDir = targetPos - a;
        if (curDir.sqrMagnitude > kEps && wantDir.sqrMagnitude > kEps)
        {
            curDir.Normalize(); wantDir.Normalize();
            float swingDeg = Mathf.Acos(Mathf.Clamp(Vector3.Dot(curDir, wantDir), -1f, 1f)) * Mathf.Rad2Deg;
            if (swingDeg > 1e-4f)
            {
                Vector3 swingAxis = Vector3.Cross(curDir, wantDir);
                if (swingAxis.sqrMagnitude < kEps) swingAxis = PickFallbackAxis(curDir); else swingAxis.Normalize();
                root.rotation = Quaternion.AngleAxis(swingDeg, swingAxis) * root.rotation;
            }
        }

        // Phase 3: match the hand orientation to the goal via the avatar hand-frame offset.
        end.rotation = targetRot * handFromGoal;
    }

    static Transform Resolve(Animator anim, Transform root, HumanBodyBones bone, string name)
    {
        Transform t = anim.isHuman ? anim.GetBoneTransform(bone) : null;   // enum first, name fallback
        if ((object)t == null) t = FindDeep(root, name);
        return t;
    }

    static float SafeAngle(Vector3 u, Vector3 v)
    {
        float m = u.magnitude * v.magnitude;
        if (m < kEps) return 0f;
        return Mathf.Acos(Mathf.Clamp(Vector3.Dot(u, v) / m, -1f, 1f));
    }

    static Vector3 PickFallbackAxis(Vector3 dir)
    {
        Vector3 axis = Vector3.Cross(dir, Vector3.up);
        if (axis.sqrMagnitude < kEps) axis = Vector3.Cross(dir, Vector3.right);
        if (axis.sqrMagnitude < kEps) axis = Vector3.forward;
        axis.Normalize();
        return axis;
    }

    static Transform FindDeep(Transform t, string name)
    {
        if (t.name == name) return t;
        for (int i = 0; i < t.childCount; i++)
        {
            Transform r = FindDeep(t.GetChild(i), name);
            if ((object)r != null) return r;
        }
        return null;
    }

    // Read a private Transform/float field off the AvatarAnimationController (walks base types).
    static Transform ReflectTransform(object obj, string field)
    {
        System.Reflection.FieldInfo fi = FindField(obj, field);
        if ((object)fi == null) return null;
        return fi.GetValue(obj) as Transform;
    }

    static float ReflectFloat(object obj, string field, float fallback)
    {
        System.Reflection.FieldInfo fi = FindField(obj, field);
        if ((object)fi == null) return fallback;
        object v = fi.GetValue(obj);
        if (v is float) return (float)v;
        return fallback;
    }

    static System.Reflection.FieldInfo FindField(object obj, string field)
    {
        if ((object)obj == null) return null;
        Type t = obj.GetType();
        System.Reflection.BindingFlags bf = System.Reflection.BindingFlags.Instance
            | System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Public;
        while ((object)t != null)   // net40 Mono: `Type != null` hits a missing op_Inequality — cast to object
        {
            System.Reflection.FieldInfo fi = t.GetField(field, bf);
            if ((object)fi != null) return fi;
            t = t.BaseType;
        }
        return null;
    }
}
