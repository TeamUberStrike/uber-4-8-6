// RebakeBlueBaseMeshes — fixes the render-side half of the BLUE_Base rotation bug.
//
// Context: BLUE_Base's root container Transform is missing a 180*Y rotation that exists
// in the UberSteam-Unity4.6.5 ground truth (verified: the entire ancestor chain up to
// scene root matches identically in both projects otherwise, zero position/identity
// rotation at every level, so BLUE_Base's own rotation is the sole divergence and world
// origin (0,0,0) is the correct pivot). AutoColliderFix's rotation fix on that container
// (applied live, not yet saved) correctly relocates every COLLIDER under BLUE_Base, since
// colliders compose live through the Transform hierarchy.
//
// But BLUE_Base's RENDER meshes are ForgeRipper's baked-world-space "split meshes"
// (Assets/Mesh/SplitMeshes/split_*.asset) — their vertices are baked directly into
// absolute world-space coordinates, completely decoupled from any Transform, including
// the one we just fixed. ForgeRipper baked them while BLUE_Base's rotation was already
// broken (identity instead of 180*Y), so the baked vertices are permanently wrong —
// sitting exactly where RED_Base's mirrored geometry is, causing z-fighting overlap.
//
// Fix: for every SplitMesh asset used exclusively under BLUE_Base, rotate its baked
// vertices (and normals/tangents) by the same missing 180* around Y, about world origin.
// Assets referenced by anything OUTSIDE BLUE_Base are treated as shared and skipped —
// rotating a shared asset would break whatever else uses it.
//
// Run via:
//   UberStrike -> Rebake -> Dry Run (report only, active scene)
//   UberStrike -> Rebake -> Apply (active scene)
//
// This mutates asset files on disk (git-tracked -> revertible via `git checkout` if
// something looks wrong after testing). Not idempotent — running Apply twice undoes it.

using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEditor;

public static class RebakeBlueBaseMeshes
{
    private const string BlueBaseObjectName = "BLUE_Base";
    private const string SplitMeshFolder = "Mesh/SplitMeshes/";

    private struct Candidate
    {
        public string assetPath;
        public Mesh mesh;
        public List<string> usedByNames;
    }

    private static Transform FindBlueBase()
    {
        foreach (var t in Object.FindObjectsByType<Transform>(FindObjectsInactive.Include, FindObjectsSortMode.None))
        {
            if (t.name == BlueBaseObjectName && t.parent != null && t.parent.name == "Level")
                return t;
        }
        return null;
    }

    private static List<Candidate> FindCandidates(out int skippedShared)
    {
        skippedShared = 0;
        var blueBase = FindBlueBase();
        if (blueBase == null)
        {
            Debug.LogError("[RebakeBlueBaseMeshes] Could not find BLUE_Base (expected a child of 'Level').");
            return new List<Candidate>();
        }

        var blueBaseFilters = blueBase.GetComponentsInChildren<MeshFilter>(true);
        var blueBaseMeshSet = new HashSet<Mesh>();
        var meshToNames = new Dictionary<Mesh, List<string>>();

        foreach (var mf in blueBaseFilters)
        {
            var mesh = mf.sharedMesh;
            if (mesh == null) continue;
            string path = AssetDatabase.GetAssetPath(mesh);
            if (string.IsNullOrEmpty(path) || !path.Contains(SplitMeshFolder)) continue;

            blueBaseMeshSet.Add(mesh);
            if (!meshToNames.TryGetValue(mesh, out var names))
            {
                names = new List<string>();
                meshToNames[mesh] = names;
            }
            names.Add(mf.gameObject.name);
        }

        // Safety check: exclude any of these meshes if ALSO referenced by a MeshFilter
        // outside BLUE_Base anywhere in the loaded scene (shared asset -> unsafe to rotate).
        var allFilters = Object.FindObjectsByType<MeshFilter>(FindObjectsInactive.Include, FindObjectsSortMode.None);
        var sharedMeshes = new HashSet<Mesh>();
        foreach (var mf in allFilters)
        {
            if (mf.transform.IsChildOf(blueBase)) continue;
            var mesh = mf.sharedMesh;
            if (mesh != null && blueBaseMeshSet.Contains(mesh))
                sharedMeshes.Add(mesh);
        }

        var result = new List<Candidate>();
        foreach (var mesh in blueBaseMeshSet)
        {
            if (sharedMeshes.Contains(mesh))
            {
                skippedShared++;
                Debug.LogWarning("[RebakeBlueBaseMeshes] Skipping shared asset (used outside BLUE_Base too): " +
                    AssetDatabase.GetAssetPath(mesh));
                continue;
            }
            result.Add(new Candidate
            {
                assetPath = AssetDatabase.GetAssetPath(mesh),
                mesh = mesh,
                usedByNames = meshToNames[mesh],
            });
        }
        return result;
    }

    private static Vector3 RotY180(Vector3 v) => new Vector3(-v.x, v.y, -v.z);

    [MenuItem("UberStrike/Rebake/Dry Run (report only, active scene)")]
    public static void DryRun()
    {
        var candidates = FindCandidates(out int skippedShared);
        Debug.Log(string.Format(
            "[RebakeBlueBaseMeshes] DRY RUN — {0} SplitMesh assets under BLUE_Base would be rotated 180deg around Y (world origin), {1} skipped as shared with other objects:",
            candidates.Count, skippedShared));
        foreach (var c in candidates)
        {
            Debug.Log(string.Format("  {0}  (vertices={1}, used by: {2})",
                c.assetPath, c.mesh.vertexCount, string.Join(", ", c.usedByNames.Distinct())));
        }
        Debug.Log("[RebakeBlueBaseMeshes] Dry run complete — nothing changed. Run Apply when ready.");
    }

    [MenuItem("UberStrike/Rebake/Apply (active scene)")]
    public static void Apply()
    {
        var candidates = FindCandidates(out int skippedShared);
        int fixedCount = 0, failed = 0;

        foreach (var c in candidates)
        {
            try
            {
                var mesh = c.mesh;
                var verts = mesh.vertices;
                for (int i = 0; i < verts.Length; i++)
                    verts[i] = RotY180(verts[i]);
                mesh.vertices = verts;

                if (mesh.normals != null && mesh.normals.Length == verts.Length)
                {
                    var normals = mesh.normals;
                    for (int i = 0; i < normals.Length; i++)
                        normals[i] = RotY180(normals[i]);
                    mesh.normals = normals;
                }

                if (mesh.tangents != null && mesh.tangents.Length == verts.Length)
                {
                    var tangents = mesh.tangents;
                    for (int i = 0; i < tangents.Length; i++)
                    {
                        var t = tangents[i];
                        var rotated = RotY180(new Vector3(t.x, t.y, t.z));
                        tangents[i] = new Vector4(rotated.x, rotated.y, rotated.z, t.w);
                    }
                    mesh.tangents = tangents;
                }

                mesh.RecalculateBounds();
                EditorUtility.SetDirty(mesh);
                fixedCount++;
            }
            catch (System.Exception ex)
            {
                Debug.LogError("[RebakeBlueBaseMeshes] Failed to rebake " + c.assetPath + ": " + ex.Message);
                failed++;
            }
        }

        AssetDatabase.SaveAssets();
        Debug.Log(string.Format(
            "[RebakeBlueBaseMeshes] APPLY complete — rebaked={0} failed={1} skippedShared={2}. " +
            "These are ASSET file changes (already saved to disk via AssetDatabase). Test in Play mode, " +
            "then `git status` to review the changed .asset files before committing.",
            fixedCount, failed, skippedShared));
    }
}
