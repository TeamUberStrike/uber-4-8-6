// FixDeadMeshColliderRefs — repairs MeshColliders whose mesh reference resolves to nothing.
//
// Root cause (confirmed via direct GUID comparison against UberSteam-Unity4.6.5 ground truth,
// 2026-07-09): ForgeRipper's conversion failed to resolve/extract the real collision mesh for
// a subset of objects across a few maps, leaving a dead placeholder GUID
// (0000000deadbeef15deadf00d0000000 — a programmer sentinel value, not a real asset) instead of
// the correct mesh reference. `MeshCollider.sharedMesh` is null at runtime for these — visually
// identical to the render mesh being present and correct (since the render uses a SEPARATE,
// unaffected MeshFilter reference), but with zero actual collision, indistinguishable from
// having no collider at all. Root-caused on SpacePortAlpha's "JumpPark" (actually the map's main
// floor, misleadingly named) — the player fell straight through it every time, despite the floor
// rendering perfectly and AutoColliderFix reporting 0 diverging colliders (the Transform was
// already correct; the mesh DATA was the problem, a completely different bug class).
//
// Confirmed scope (grep across every map's .unity file for the placeholder GUID): SpaceCity (3
// occurrences), SpacePortAlpha (53), UberZone (109) — and SpacePortAlpha/UberZone are exactly
// the two maps flagged with "falls under the ground at spawn." None of the maps already fixed
// this session (ApexTwin, AqualabResearchHub, Catalyst, GhostIsland, MonkeyIsland) are affected.
//
// Fix: for any MeshCollider whose sharedMesh is null, if the SAME GameObject also has a
// MeshFilter with a valid sharedMesh, copy that mesh reference onto the MeshCollider — the
// established, ground-truth-confirmed convention for this class of object (collision mesh =
// render mesh). Objects with no MeshFilter at all (a dead MeshCollider with nothing to recover
// from) are reported but left untouched — they need a different fix, not this one.
//
// Run via:
//   UberStrike → Fix → Dead MeshCollider Refs → Dry Run (report only, active scene)
//   UberStrike → Fix → Dead MeshCollider Refs → Apply (active scene)

using UnityEngine;
using UnityEditor;

public static class FixDeadMeshColliderRefs
{
    private struct Candidate
    {
        public GameObject go;
        public MeshCollider mc;
        public Mesh recoverableMesh; // null if no MeshFilter to recover from
    }

    private static System.Collections.Generic.List<Candidate> FindCandidates(out int noRecovery)
    {
        var candidates = new System.Collections.Generic.List<Candidate>();
        noRecovery = 0;
        var allColliders = Object.FindObjectsByType<MeshCollider>(FindObjectsInactive.Include, FindObjectsSortMode.None);
        foreach (var mc in allColliders)
        {
            if (mc.sharedMesh != null) continue; // has a real mesh, not affected

            var mf = mc.GetComponent<MeshFilter>();
            Mesh recoverable = (mf != null) ? mf.sharedMesh : null;
            if (recoverable == null) noRecovery++;

            candidates.Add(new Candidate { go = mc.gameObject, mc = mc, recoverableMesh = recoverable });
        }
        return candidates;
    }

    [MenuItem("UberStrike/Fix/Dead MeshCollider Refs/Dry Run (report only, active scene)")]
    public static void DryRun()
    {
        var candidates = FindCandidates(out int noRecovery);
        Debug.Log(string.Format(
            "[FixDeadMeshColliderRefs] DRY RUN — {0} MeshColliders have a null/broken mesh reference, {1} have no MeshFilter to recover from (would be left untouched). Nothing changed.",
            candidates.Count, noRecovery));
        foreach (var c in candidates)
        {
            string status = c.recoverableMesh != null
                ? "would copy MeshFilter mesh '" + c.recoverableMesh.name + "'"
                : "NO MeshFilter on this object — cannot recover, needs manual attention";
            Debug.Log(string.Format("  {0}: {1}", c.go.name, status));
        }
    }

    [MenuItem("UberStrike/Fix/Dead MeshCollider Refs/Apply (active scene)")]
    public static void Apply()
    {
        var candidates = FindCandidates(out int noRecovery);
        int fixedCount = 0;
        foreach (var c in candidates)
        {
            if (c.recoverableMesh == null) continue;
            c.mc.sharedMesh = c.recoverableMesh;
            EditorUtility.SetDirty(c.mc);
            fixedCount++;
        }
        Debug.Log(string.Format(
            "[FixDeadMeshColliderRefs] APPLY complete — fixed {0} of {1} dead MeshColliders ({2} had no MeshFilter to recover from, left untouched). SAVE THE SCENE (Ctrl+S), then test.",
            fixedCount, candidates.Count, noRecovery));
    }
}
