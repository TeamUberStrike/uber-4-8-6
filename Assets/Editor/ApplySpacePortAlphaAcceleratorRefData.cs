// ApplySpacePortAlphaAcceleratorRefData — one-off, NOT a general tool like AutoColliderFix.
//
// Root cause recap: SpacePortAlpha's 5 AcceleratorPad objects are stuck at world (0,0,0) in
// BOTH the Unity6 port AND the ground-truth UberSteam-Unity4.6.5 project — an honest ceiling,
// since ground truth itself has zero recoverable position data anywhere in the object chain
// (parent container, the object's own Transform, and its render-mesh child are all at local
// (0,0,0) — confirmed 2026-07-10, see session memory). The live Steam retail build was also a
// dead end (its .unity3d bundles use a legacy LZMA-compressed WebPlayer format that the current
// AssetRipper build can't parse — confirmed via a genuine bug in its own decompressor).
//
// Recovery source: the separate UberStrike 4.3.8 client (Downloads/uber-client-4-3-8-
// unity_2022_working, confirmed 2026-07-10 to be a clean, byte-exact clone of origin/main) has
// its own working SpacePortAlpha (Assets/Scenes/LevelSpaceportAlpha.unity) with real, functional
// AcceleratorPad + jumpPad data. Cross-validated: extracting the 6 jumpPad/jumpPad_Top positions
// from that scene's PrefabInstance modification blocks (composed with the "Props" container's
// world offset (0,-1,0)) landed EXACTLY on the already-applied, already-confirmed-working U6
// jumpPad fix from earlier tonight (e.g. (20.9458, 9.7617, -3.0904) vs our applied
// (20.95, 9.76, -3.09)) — strong confirmation the two game versions share the same underlying
// level layout, and that this AcceleratorPad data is trustworthy to transfer across.
//
// Coverage: the 4.3.8 client's SpacePortAlpha only has 4 AcceleratorPad instances (not 5 like
// the Steam/Unity6 version) — a real design difference between versions, not a search miss
// (confirmed: no other PrefabInstance block in that scene matches the AcceleratorPad prefab
// GUID). So only 4 of the 5 U6 AcceleratorPad objects get fixed here; the 5th stays an honest
// ceiling until reference data for it is found some other way.
//
// Fix mechanism: identical to AutoColliderFix v14's "detach children, move in place, reattach"
// — AcceleratorPad has a script (ForceField-equivalent) + BoxCollider that must move as a unit,
// but also a render-mesh child ("Accelerator") that must not get dragged by a naive in-place
// move. No ground-truth diffing involved here since there's nothing to diff against; the 4
// target positions below are hardcoded from the 4.3.8 cross-reference above.
//
// Run via:
//   UberStrike → Fix → SpacePortAlpha AcceleratorPad Ref Data → Dry Run (report only, active scene)
//   UberStrike → Fix → SpacePortAlpha AcceleratorPad Ref Data → Apply (active scene)

using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEditor;
using UnityEngine.SceneManagement;

public static class ApplySpacePortAlphaAcceleratorRefData
{
    // World positions derived 2026-07-10 from Downloads/uber-client-4-3-8-unity_2022_working's
    // Assets/Scenes/LevelSpaceportAlpha.unity (PrefabInstance fids 998-1001, local position +
    // Props container's world offset (0,-1,0)). See file header for full provenance.
    private static readonly Vector3[] TargetPositions = new[]
    {
        new Vector3(13.5029745f, 23.7087955f, -22.3332443f),
        new Vector3(-8.87912178f, 5.57954931f, 65.8640289f),
        new Vector3(9.03121758f, 5.57954931f, 65.8640289f),
        new Vector3(-0.182397485f, -1.505853653f, 26.0211887f),
        // 5th candidate (2026-07-10) — INFERRED, not sourced from the 4.3.8 cross-reference like
        // the 4 above (that project only has 4 AcceleratorPads). This is the render mesh's own
        // local AABB center (split_36f2fdfd_sub15.asset, the "Accelerator" child of go=75, the
        // one AcceleratorPad with no 4.3.8 reference data) — trusted under the same
        // baked-absolute-mesh convention used all session. Cross-checked two independent ways
        // before applying: (1) spatially near-mirrored on X vs already-fixed pad #1
        // (13.50, 23.71, -22.33) — a plausible mirrored-pair level-design pattern; (2) go=75's
        // OWN already-intact script data (_direction: {1,1,0}) is the exact X-mirror of pad #1's
        // (_direction: {-1,1,0}) — independent confirmation via script data no one had touched.
        new Vector3(-14.547428f, 22.977001f, -22.259157f),
    };

    private const float Epsilon = 0.01f;

    private static List<Transform> FindAcceleratorPads()
    {
        return UnityEngine.Object.FindObjectsByType<Transform>(FindObjectsInactive.Include, FindObjectsSortMode.None)
            .Where(t => t.gameObject.name == "AcceleratorPad")
            .OrderBy(t => t.GetInstanceID())
            .ToList();
    }

    // v2 (2026-07-10): re-running this tool after a partial Apply (4 of 5 pads already fixed by
    // an earlier run, e.g. adding the 5th inferred candidate afterward) is unsafe with naive
    // index-based matching — pads[i] no longer lines up with TargetPositions[i] once some pads
    // have moved. Instead: only match pads that are STILL at (0,0,0) (unfixed) against target
    // positions that AREN'T already occupied by some other pad (already applied). This makes
    // repeated runs idempotent regardless of how many candidates have already been fixed.
    private struct Match
    {
        public Transform pad;
        public Vector3 target; // Vector3.positiveInfinity sentinel = no target available
    }

    private static List<Match> ComputeMatches(List<Transform> pads)
    {
        var usedTargets = new HashSet<int>(); // indices into TargetPositions already occupied by some pad's CURRENT position
        for (int t = 0; t < TargetPositions.Length; t++)
        {
            foreach (var pad in pads)
            {
                if (Vector3.Distance(pad.position, TargetPositions[t]) < Epsilon)
                {
                    usedTargets.Add(t);
                    break;
                }
            }
        }

        var freeTargets = new List<Vector3>();
        for (int t = 0; t < TargetPositions.Length; t++)
            if (!usedTargets.Contains(t)) freeTargets.Add(TargetPositions[t]);

        var results = new List<Match>();
        int freeIdx = 0;
        foreach (var pad in pads)
        {
            bool alreadyFixed = pad.position.magnitude > Epsilon; // not at origin -> already has SOME real position (either a prior fix or something else)
            if (alreadyFixed)
            {
                results.Add(new Match { pad = pad, target = pad.position }); // no-op, already correct
            }
            else if (freeIdx < freeTargets.Count)
            {
                results.Add(new Match { pad = pad, target = freeTargets[freeIdx] });
                freeIdx++;
            }
            else
            {
                results.Add(new Match { pad = pad, target = Vector3.positiveInfinity }); // no data left
            }
        }
        return results;
    }

    [MenuItem("UberStrike/Fix/SpacePortAlpha AcceleratorPad Ref Data/Dry Run (report only, active scene)")]
    public static void DryRun()
    {
        string scenePath = SceneManager.GetActiveScene().path;
        if (!scenePath.Contains("spaceportalpha", StringComparison.OrdinalIgnoreCase))
        {
            Debug.LogWarning("[ApplySpacePortAlphaAcceleratorRefData] Active scene doesn't look like SpacePortAlpha (" + scenePath + ") — this tool is hardcoded for that map only. Aborting.");
            return;
        }

        var pads = FindAcceleratorPads();
        var matches = ComputeMatches(pads);
        Debug.Log(string.Format("[ApplySpacePortAlphaAcceleratorRefData] Found {0} AcceleratorPad objects, {1} reference positions total:", pads.Count, TargetPositions.Length));
        for (int i = 0; i < matches.Count; i++)
        {
            var m = matches[i];
            bool alreadyFixed = m.pad.position.magnitude > Epsilon;
            if (alreadyFixed)
            {
                Debug.Log(string.Format("  [{0}] {1} current WORLD pos={2} -> already correct, no change", i, m.pad.name, m.pad.position));
            }
            else if (float.IsInfinity(m.target.x))
            {
                Debug.Log(string.Format("  [{0}] {1} current WORLD pos={2} -> NO REFERENCE DATA left, honest ceiling", i, m.pad.name, m.pad.position));
            }
            else
            {
                Debug.Log(string.Format("  [{0}] {1} current WORLD pos={2} -> reference WORLD pos={3}", i, m.pad.name, m.pad.position, m.target));
            }
        }
        Debug.Log("[ApplySpacePortAlphaAcceleratorRefData] Dry run complete — nothing changed. Run Apply when ready.");
    }

    [MenuItem("UberStrike/Fix/SpacePortAlpha AcceleratorPad Ref Data/Apply (active scene)")]
    public static void Apply()
    {
        string scenePath = SceneManager.GetActiveScene().path;
        if (!scenePath.Contains("spaceportalpha", StringComparison.OrdinalIgnoreCase))
        {
            Debug.LogWarning("[ApplySpacePortAlphaAcceleratorRefData] Active scene doesn't look like SpacePortAlpha (" + scenePath + ") — this tool is hardcoded for that map only. Aborting.");
            return;
        }

        var pads = FindAcceleratorPads();
        var matches = ComputeMatches(pads);
        int fixedCount = 0, alreadyOk = 0, noData = 0;
        foreach (var m in matches)
        {
            var t = m.pad;
            bool alreadyFixed = t.position.magnitude > Epsilon;
            if (alreadyFixed) { alreadyOk++; continue; }
            if (float.IsInfinity(m.target.x)) { noData++; continue; }

            try
            {
                // Same safe pattern as AutoColliderFix v14: detach children first (preserving
                // their current world position), move this now-childless object directly, then
                // reattach children — repositions the script/collider without disturbing the
                // render-mesh child at all.
                var originalParent = t.parent;
                var children = new List<Transform>();
                for (int c = 0; c < t.childCount; c++) children.Add(t.GetChild(c));

                foreach (var child in children)
                    child.SetParent(originalParent, true);

                t.position = m.target;

                foreach (var child in children)
                    child.SetParent(t, true);

                EditorUtility.SetDirty(t.gameObject);
                fixedCount++;
            }
            catch (Exception ex)
            {
                Debug.LogError("[ApplySpacePortAlphaAcceleratorRefData] Failed to fix " + t.name + ": " + ex.Message);
            }
        }

        Debug.Log(string.Format("[ApplySpacePortAlphaAcceleratorRefData] APPLY complete. Fixed {0}, already correct {1}, no reference data {2} (of {3} total). SAVE THE SCENE (File -> Save), then test.",
            fixedCount, alreadyOk, noData, pads.Count));
    }
}
