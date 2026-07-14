// DisableOversizedUtilityColliders — TheHangar launch-bug fix (2026-07-08).
//
// Root cause (triple-confirmed against the real Steam client via ForgeRipper/AssetRipper,
// not guessed): props on the "GloballyLit"/"LocallyLit" layer family (layers 8-17 — lighting
// utility layers, e.g. Airco_Vent_*, Fluorescent_Light_A) carry authentic, byte-identical
// BoxColliders that are WAY larger than the visible prop (e.g. Airco_Vent_C: 150x100x150
// units, center offset (-25,~0,-75) from its own small pivot) — confirmed identical in
// Unity6, the UberSteam-Unity4.6.5 reconstruction, AND the real, unmodified Steam client's
// compiled PhysicsManager/scene data. These are NOT corrupted extraction artifacts.
//
// Tried first (didn't work): excluding these layers from colliding with the player's
// layers (Controller/LocalPlayer/RemotePlayer) in Project Settings -> Physics -> Layer
// Collision Matrix, both via direct file edit AND via the Editor UI checkboxes (confirmed
// applied correctly in DynamicsManager.asset afterward). CharacterController.Move()'s
// internal sweep test empirically still generated OnControllerColliderHit against these
// colliders anyway — Unity's CharacterController does not reliably respect the layer
// collision matrix the way regular Rigidbody collision does. Real-game clean behavior is
// presumably driven by original runtime script logic (see IgnoreLayerCollision decompile
// follow-up thread), not just static project settings.
//
// This script instead disables the Collider component directly (non-destructive —
// disabling, not deleting, so it's trivially reversible) on any GameObject whose layer is
// in the GloballyLit/LocallyLit family AND whose BoxCollider has any dimension over
// OVERSIZED_THRESHOLD. Small, legitimately-sized colliders on these same layers (if any)
// are left untouched.
//
// Run via:
//   UberStrike -> Fix -> Disable Oversized Utility Colliders -> Dry Run (report only, active scene)
//   UberStrike -> Fix -> Disable Oversized Utility Colliders -> Apply (active scene)

using UnityEngine;
using UnityEditor;

public static class DisableOversizedUtilityColliders
{
    // Volume-based, not dimension-based: a thin-but-wide legitimate floor slab (e.g.
    // Floor_A, 45.01 x 0.50 x 42.00 = 945 units^3) must NOT match, while the authentic
    // oversized utility blobs (e.g. Airco_Vent_C, 150 x 100 x 150 = 2,250,000 units^3;
    // Door_A, 125 x 250 x 10 = 312,500 units^3) clearly should. Real small props (Crate_A
    // ~12, Pallet_A ~0.7, Arch_A/B 5-10) sit far below this threshold too.
    private const float OVERSIZED_VOLUME_THRESHOLD = 10000f; // cubic units

    private static readonly int[] UtilityLayers = { 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 };

    private static bool IsUtilityLayer(int layer)
    {
        foreach (var l in UtilityLayers)
            if (l == layer) return true;
        return false;
    }

    private static bool IsOversized(BoxCollider bc)
    {
        float volume = Mathf.Abs(bc.size.x * bc.size.y * bc.size.z);
        return volume > OVERSIZED_VOLUME_THRESHOLD;
    }

    [MenuItem("UberStrike/Fix/Disable Oversized Utility Colliders/Dry Run (report only, active scene)")]
    public static void DryRun()
    {
        var boxColliders = Object.FindObjectsByType<BoxCollider>(FindObjectsInactive.Include, FindObjectsSortMode.None);
        int candidates = 0;
        foreach (var bc in boxColliders)
        {
            if (!bc.enabled) continue;
            if (!IsUtilityLayer(bc.gameObject.layer)) continue;
            if (!IsOversized(bc)) continue;
            candidates++;
            Debug.Log(string.Format("  {0} (layer {1}) size={2} center={3}",
                bc.gameObject.name, bc.gameObject.layer, bc.size, bc.center));
        }
        Debug.Log(string.Format("[DisableOversizedUtilityColliders] DRY RUN — {0} enabled BoxColliders on utility layers exceed {1} cubic units in volume (would be disabled). Nothing changed.", candidates, OVERSIZED_VOLUME_THRESHOLD));
    }

    [MenuItem("UberStrike/Fix/Disable Oversized Utility Colliders/Apply (active scene)")]
    public static void Apply()
    {
        var boxColliders = Object.FindObjectsByType<BoxCollider>(FindObjectsInactive.Include, FindObjectsSortMode.None);
        int fixedCount = 0;
        foreach (var bc in boxColliders)
        {
            if (!bc.enabled) continue;
            if (!IsUtilityLayer(bc.gameObject.layer)) continue;
            if (!IsOversized(bc)) continue;
            bc.enabled = false;
            EditorUtility.SetDirty(bc);
            fixedCount++;
        }
        Debug.Log(string.Format("[DisableOversizedUtilityColliders] Apply complete — disabled {0} oversized utility BoxColliders. Save the scene (Ctrl+S) before testing in Play mode.", fixedCount));
    }
}
