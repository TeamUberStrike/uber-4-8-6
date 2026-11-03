// ApplySpacePortAlphaAcceleratorRefData — ground-truth counterpart of the same-named tool in
// UberStrike_Unity6. Fixes the SAME confirmed bug HERE, at the source: SpacePortAlpha's 5
// AcceleratorPad objects are stuck at world (0,0,0) in this project too — the parent container,
// the object's own Transform, AND its render-mesh child are all at local (0,0,0), all the way up
// the chain. This is the master reference project everything else diffs against, so fixing it
// here keeps it consistent for any future work.
//
// Data provenance (2026-07-10): 4 of 5 positions cross-referenced from the separate, working
// UberStrike 4.3.8 client (Downloads/uber-client-4-3-8-unity_2022_working, confirmed a clean
// byte-exact clone of origin/main) — its own SpacePortAlpha scene has real, functional
// jumpPad/AcceleratorPad data as PrefabInstance modification blocks. Validated before trusting:
// composing that project's 6 jumpPad/jumpPad_Top positions with its "Props" container's own
// world offset (0,-1,0) landed exactly on the already-applied, already-confirmed-working U6
// jumpPad fix from earlier the same night — strong independent confirmation.
//
// The 5th AcceleratorPad (this map's 4.3.8 build only has 4, a real design difference between
// versions) has no cross-reference source — its position is INFERRED from its render mesh's own
// m_LocalAABB center (split_36f2fdfd_sub15.asset), trusted under the baked-absolute-mesh
// convention established all session. Cross-checked two independent ways before applying: (1)
// spatially near-mirrored on X vs the already-fixed pad #1, a plausible mirrored-pair level
// design; (2) this object's own already-intact script data (_direction: {1,1,0}) is the exact
// X-mirror of pad #1's (_direction: {-1,1,0}) — confirmed correct via playtest on the U6 port
// before being carried over here.
//
// Uses Unity 4.6.5-compatible APIs (EditorApplication.currentScene, Resources.
// FindObjectsOfTypeAll, plain .parent assignment instead of Transform.SetParent) — see existing
// Assets/Editor/Bots/*.cs for the established conventions this mirrors.
//
// Run via:
//   UberStrike → Fix → SpacePortAlpha AcceleratorPad Ref Data → Dry Run (report only, active scene)
//   UberStrike → Fix → SpacePortAlpha AcceleratorPad Ref Data → Apply (active scene)

using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public static class ApplySpacePortAlphaAcceleratorRefData
{
    private static readonly Vector3[] TargetPositions = new[]
    {
        new Vector3(13.5029745f, 23.7087955f, -22.3332443f),
        new Vector3(-8.87912178f, 5.57954931f, 65.8640289f),
        new Vector3(9.03121758f, 5.57954931f, 65.8640289f),
        new Vector3(-0.182397485f, -1.505853653f, 26.0211887f),
        new Vector3(-14.547428f, 22.977001f, -22.259157f), // inferred, see file header
    };

    private const float Epsilon = 0.01f;

    private static List<Transform> FindAcceleratorPads()
    {
        var results = new List<Transform>();
        foreach (var o in Resources.FindObjectsOfTypeAll(typeof(GameObject)))
        {
            var go = o as GameObject;
            if (go == null) continue;
            if (EditorUtility.IsPersistent(go)) continue; // skip prefab assets, only live scene objects
            if (go.name == "AcceleratorPad") results.Add(go.transform);
        }
        results.Sort((a, b) => a.GetInstanceID().CompareTo(b.GetInstanceID()));
        return results;
    }

    private struct Match
    {
        public Transform pad;
        public Vector3 target; // Vector3 with x = float.PositiveInfinity sentinel = no target available
    }

    private static List<Match> ComputeMatches(List<Transform> pads)
    {
        var usedTargets = new HashSet<int>();
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
            bool alreadyFixed = pad.position.magnitude > Epsilon;
            if (alreadyFixed)
            {
                results.Add(new Match { pad = pad, target = pad.position });
            }
            else if (freeIdx < freeTargets.Count)
            {
                results.Add(new Match { pad = pad, target = freeTargets[freeIdx] });
                freeIdx++;
            }
            else
            {
                results.Add(new Match { pad = pad, target = new Vector3(float.PositiveInfinity, 0, 0) });
            }
        }
        return results;
    }

    [MenuItem("UberStrike/Fix/SpacePortAlpha AcceleratorPad Ref Data/Dry Run (report only, active scene)")]
    public static void DryRun()
    {
        string sceneName = System.IO.Path.GetFileNameWithoutExtension(EditorApplication.currentScene);
        if (sceneName.IndexOf("spaceportalpha", StringComparison.OrdinalIgnoreCase) < 0)
        {
            Debug.LogWarning("[ApplySpacePortAlphaAcceleratorRefData] Active scene doesn't look like SpacePortAlpha (" + EditorApplication.currentScene + ") — this tool is hardcoded for that map only. Aborting.");
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
        string sceneName = System.IO.Path.GetFileNameWithoutExtension(EditorApplication.currentScene);
        if (sceneName.IndexOf("spaceportalpha", StringComparison.OrdinalIgnoreCase) < 0)
        {
            Debug.LogWarning("[ApplySpacePortAlphaAcceleratorRefData] Active scene doesn't look like SpacePortAlpha (" + EditorApplication.currentScene + ") — this tool is hardcoded for that map only. Aborting.");
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
                // Detach children first (plain .parent assignment preserves world position by
                // default, same effect as SetParent(parent, true) on newer Unity), move this
                // now-childless object directly, then reattach children — repositions the
                // script/collider without disturbing the render-mesh child at all.
                var originalParent = t.parent;
                var children = new List<Transform>();
                for (int c = 0; c < t.childCount; c++) children.Add(t.GetChild(c));

                foreach (var child in children)
                    child.parent = originalParent;

                t.position = m.target;

                foreach (var child in children)
                    child.parent = t;

                EditorUtility.SetDirty(t.gameObject);
                fixedCount++;
            }
            catch (Exception ex)
            {
                Debug.LogError("[ApplySpacePortAlphaAcceleratorRefData] Failed to fix " + t.name + ": " + ex.Message);
            }
        }

        Debug.Log(string.Format("[ApplySpacePortAlphaAcceleratorRefData] APPLY complete. Fixed {0}, already correct {1}, no reference data {2} (of {3} total). SAVE THE SCENE (File -> Save Scene), then test.",
            fixedCount, alreadyOk, noData, pads.Count));
    }
}
