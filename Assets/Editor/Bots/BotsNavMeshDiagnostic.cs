// BotsNavMeshDiagnostic — SAFE, read-only scan for the kind of degenerate/
// oversized MeshCollider data that has previously crashed Unity 4.6.5's
// native code on this project's AssetRipper-emitted geometry (see
// feedback_unity_4_6_mecanim_default_avatar_crash / feedback_tpose_mecanim_
// crash_mitigation — same overall pattern, different subsystem: Mecanim
// there, NavMesh voxelizer here).
//
// Does NOT call NavMeshBuilder.BuildNavMesh() or anything else that could
// crash. Just walks every MeshCollider in the active scene and reports:
//   - vertex/triangle counts (huge colliders are exactly what the existing
//     BotsMapGeometryExporter already defends against for BOUNDS purposes —
//     this checks the same class of object for MESH INTEGRITY instead)
//   - degenerate vertices (NaN/Infinity)
//   - zero-area / degenerate triangles
//   - non-readable mesh data (collider mesh not marked Read/Write enabled
//     — importing state, not itself a crash cause, but worth flagging)
//
// Run via  UberStrike → Server Bots → Diagnose MeshColliders (active scene)

using System;
using System.Collections.Generic;
using System.Text;
using UnityEditor;
using UnityEngine;

namespace UberStrike.Editor.Bots
{
    public static class BotsNavMeshDiagnostic
    {
        [MenuItem("UberStrike/Server Bots/Diagnose MeshColliders (active scene)")]
        public static void DiagnoseActiveScene()
        {
            var sb = new StringBuilder();
            sb.AppendLine("BotsNavMeshDiagnostic — " + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
            sb.AppendLine("========================================================");

            var roots = GetSceneRoots();
            int totalColliders = 0, meshColliders = 0, flaggedHuge = 0, flaggedDegenVerts = 0,
                flaggedDegenTris = 0, flaggedUnreadable = 0;

            // Terrain check — a completely separate native code path from
            // MeshCollider (heightmap-based, not triangle-mesh-based). Never
            // checked before now. AssetRipper's terrain re-export is
            // historically one of its most fragile features.
            int terrainCount = 0;
            foreach (var root in roots)
            {
                foreach (var terrain in root.GetComponentsInChildren<Terrain>(true))
                {
                    terrainCount++;
                    var td = terrain.terrainData;
                    string path = HierarchyPath(terrain.transform);
                    if (td == null)
                    {
                        sb.AppendLine(string.Format("[TERRAIN NULL DATA] {0}", path));
                        continue;
                    }
                    sb.AppendLine(string.Format(
                        "[TERRAIN]        {0}  heightmapRes={1}x{1}  size={2:F0}x{3:F0}x{4:F0}m  alphamapRes={5}x{5}  detailRes={6}x{6}  splatCount={7}",
                        path, td.heightmapResolution, td.size.x, td.size.y, td.size.z,
                        td.alphamapResolution, td.detailResolution, td.splatPrototypes != null ? td.splatPrototypes.Length : 0));

                    // Sanity-check the heightmap array itself.
                    try
                    {
                        var heights = td.GetHeights(0, 0, td.heightmapWidth, td.heightmapHeight);
                        bool anyNaN = false;
                        float minH = float.MaxValue, maxH = float.MinValue;
                        foreach (var h in heights)
                        {
                            if (float.IsNaN(h) || float.IsInfinity(h)) { anyNaN = true; }
                            if (h < minH) minH = h;
                            if (h > maxH) maxH = h;
                        }
                        sb.AppendLine(string.Format(
                            "                 heightmap read OK — range=[{0:F4}..{1:F4}] NaN/Inf={2}",
                            minH, maxH, anyNaN));
                    }
                    catch (Exception ex)
                    {
                        sb.AppendLine("                 [HEIGHTMAP READ FAILED] " + ex.Message);
                    }

                    var tc = terrain.GetComponent<TerrainCollider>();
                    sb.AppendLine(string.Format("                 TerrainCollider present={0}", tc != null));
                }
            }

            // NavMesh baking doesn't ONLY read MeshColliders — any GameObject
            // flagged "Navigation Static" contributes its RENDER mesh
            // (MeshFilter.sharedMesh) too, whether or not it has a Collider
            // at all. This is exactly how large ground/floor meshes are
            // commonly set up (visual + nav-contributing, no runtime
            // collision needed) — "Ground"/"GroundSnow" reported present in
            // the Hierarchy under Terrain/ but absent from the MeshCollider
            // scan above are almost certainly exactly this case, and likely
            // the single largest/most complex mesh in the whole map.
            int navStaticRenderers = 0, navStaticNoCollider = 0;
            var reportedMeshes = new HashSet<Mesh>();
            foreach (var root in roots)
            {
                foreach (var mf in root.GetComponentsInChildren<MeshFilter>(true))
                {
                    var go = mf.gameObject;
                    var flags = GameObjectUtility.GetStaticEditorFlags(go);
                    bool navStatic = (flags & StaticEditorFlags.NavigationStatic) != 0;
                    if (!navStatic) continue;
                    navStaticRenderers++;

                    var mesh = mf.sharedMesh;
                    string path = HierarchyPath(mf.transform);
                    bool hasCollider = go.GetComponent<Collider>() != null;
                    if (!hasCollider) navStaticNoCollider++;

                    if (mesh == null)
                    {
                        sb.AppendLine(string.Format("[NAV-STATIC NULL MESH] {0}  hasCollider={1}", path, hasCollider));
                        continue;
                    }
                    if (!reportedMeshes.Add(mesh)) continue; // already covered via MeshCollider pass, or shared

                    int vc = mesh.vertexCount;
                    int tc = mesh.triangles != null ? mesh.triangles.Length / 3 : 0;
                    var b = mf.GetComponent<Renderer>() != null ? mf.GetComponent<Renderer>().bounds : new Bounds();

                    sb.AppendLine(string.Format(
                        "[NAV-STATIC MESH] {0}  hasCollider={1} verts={2} tris={3} isReadable={4} bounds={5:F0}x{6:F0}x{7:F0}m",
                        path, hasCollider, vc, tc, mesh.isReadable, b.size.x, b.size.y, b.size.z));

                    bool degenVert = false;
                    var verts = mesh.vertices;
                    for (int i = 0; i < verts.Length; i++)
                    {
                        var v = verts[i];
                        if (float.IsNaN(v.x) || float.IsNaN(v.y) || float.IsNaN(v.z) ||
                            float.IsInfinity(v.x) || float.IsInfinity(v.y) || float.IsInfinity(v.z))
                        { degenVert = true; break; }
                    }
                    if (degenVert)
                        sb.AppendLine(string.Format("                  [NaN/INF VERTS] verts={0}", vc));

                    int degenTriCount = 0;
                    var tris = mesh.triangles;
                    if (tris != null && verts.Length > 0)
                    {
                        for (int i = 0; i + 2 < tris.Length; i += 3)
                        {
                            var a = verts[tris[i]];
                            var bV = verts[tris[i + 1]];
                            var c = verts[tris[i + 2]];
                            var cross = Vector3.Cross(bV - a, c - a);
                            if (cross.sqrMagnitude < 1e-10f) degenTriCount++;
                        }
                    }
                    if (degenTriCount > 0)
                        sb.AppendLine(string.Format("                  [DEGEN TRIS] {0} of {1} triangles are zero-area", degenTriCount, tc));
                }
            }

            foreach (var root in roots)
            {
                foreach (var col in root.GetComponentsInChildren<Collider>(true))
                {
                    totalColliders++;
                    var mc = col as MeshCollider;
                    if (mc == null) continue;
                    meshColliders++;

                    var mesh = mc.sharedMesh;
                    string path = HierarchyPath(mc.transform);

                    if (mesh == null)
                    {
                        sb.AppendLine(string.Format("[NULL MESH]      {0}", path));
                        continue;
                    }

                    int vc = mesh.vertexCount;
                    int tc = mesh.triangles != null ? mesh.triangles.Length / 3 : 0;

                    // Huge collider — same rough threshold class as the
                    // existing exporter's MaxColliderAxisLength (300m) /
                    // MaxAllowedAxisLength (500m) skybox-dome defense.
                    var b = col.bounds;
                    bool huge = b.size.x > 300f || b.size.z > 300f || b.size.y > 300f;
                    if (huge)
                    {
                        flaggedHuge++;
                        sb.AppendLine(string.Format(
                            "[HUGE]           {0}  bounds={1:F0}x{2:F0}x{3:F0}m  verts={4} tris={5}",
                            path, b.size.x, b.size.y, b.size.z, vc, tc));
                    }

                    // Extreme vertex/triangle count — a MeshCollider pointed
                    // at a high-detail RENDER mesh instead of a simplified
                    // collision proxy is a classic perf/stability problem for
                    // any navmesh voxelizer, doubly so on 20-year-old 32-bit
                    // native code.
                    if (vc > 20000 || tc > 20000)
                    {
                        sb.AppendLine(string.Format(
                            "[HIGH-DETAIL]    {0}  verts={1} tris={2} (render-mesh-as-collider suspect)",
                            path, vc, tc));
                    }

                    // Degenerate vertices (NaN / Infinity) — would corrupt
                    // any native geometry processing that touches them.
                    bool degenVert = false;
                    var verts = mesh.vertices;
                    for (int i = 0; i < verts.Length; i++)
                    {
                        var v = verts[i];
                        if (float.IsNaN(v.x) || float.IsNaN(v.y) || float.IsNaN(v.z) ||
                            float.IsInfinity(v.x) || float.IsInfinity(v.y) || float.IsInfinity(v.z))
                        {
                            degenVert = true;
                            break;
                        }
                    }
                    if (degenVert)
                    {
                        flaggedDegenVerts++;
                        sb.AppendLine(string.Format("[NaN/INF VERTS]  {0}  verts={1}", path, vc));
                    }

                    // Degenerate (zero-area) triangles — collapsed/duplicate
                    // vertices forming a triangle with no real surface area.
                    // Recast-style voxelizers can choke on these.
                    int degenTriCount = 0;
                    var tris = mesh.triangles;
                    if (tris != null && verts.Length > 0)
                    {
                        for (int i = 0; i + 2 < tris.Length; i += 3)
                        {
                            var a = verts[tris[i]];
                            var bV = verts[tris[i + 1]];
                            var c = verts[tris[i + 2]];
                            var cross = Vector3.Cross(bV - a, c - a);
                            if (cross.sqrMagnitude < 1e-10f) degenTriCount++;
                        }
                    }
                    if (degenTriCount > 0)
                    {
                        flaggedDegenTris++;
                        sb.AppendLine(string.Format(
                            "[DEGEN TRIS]     {0}  {1} of {2} triangles are zero-area",
                            path, degenTriCount, tc));
                    }

                    if (!mesh.isReadable)
                    {
                        flaggedUnreadable++;
                        sb.AppendLine(string.Format("[NOT READABLE]   {0}  (Read/Write disabled on mesh import)", path));
                    }
                }
            }

            sb.AppendLine("========================================================");
            sb.AppendLine(string.Format(
                "Totals: colliders={0} meshColliders={1} huge={2} degenVerts={3} degenTris={4} unreadable={5} terrains={6} navStaticRenderers={7} navStaticNoCollider={8}",
                totalColliders, meshColliders, flaggedHuge, flaggedDegenVerts, flaggedDegenTris, flaggedUnreadable, terrainCount,
                navStaticRenderers, navStaticNoCollider));

            string body = sb.ToString();
            Debug.Log("[BotsNavMeshDiagnostic]\n" + body);

            try
            {
                string path = System.IO.Path.Combine(Application.dataPath, "../_navmesh_diagnostic_report.txt");
                System.IO.File.WriteAllText(path, body);
                Debug.Log("[BotsNavMeshDiagnostic] Report written -> " + path);
            }
            catch (Exception ex)
            {
                Debug.LogWarning("[BotsNavMeshDiagnostic] Report write failed: " + ex.Message);
            }
        }

        // Enables Read/Write on every MeshCollider's mesh asset in the active
        // scene by CLONING each into a fresh, naturally-readable Mesh asset
        // and repointing the MeshCollider at the clone. This is the fix for
        // the NavMesh bake crash: NavMeshBuilder.BuildNavMesh() reads
        // vertex/triangle data straight from each MeshCollider's mesh to
        // voxelize the scene — if that data was discarded (Read/Write
        // Enabled OFF), that read hits freed/invalid memory -> access
        // violation, at whatever memory happens to occupy the freed region
        // -> different crash offset each run.
        //
        // All 16 of FortWinter's MeshColliders point at RAW serialized Mesh
        // .asset files (AssetRipper couldn't reconstruct the original FBX
        // sources), not FBX-imported meshes — so there's no ModelImporter /
        // Read-Write checkbox to toggle at all; the readable flag is baked
        // into the serialized asset itself and Mesh.isReadable has no
        // setter. A freshly-created Mesh defaults to readable, so cloning
        // the vertex/triangle/normal/uv data into a new Mesh and swapping
        // the MeshCollider's sharedMesh reference sidesteps the problem
        // entirely. Confirmed 2026-07-06: reading mesh.vertices/.triangles
        // via script DOES return valid data even on these "non-readable"
        // assets (Editor-mode script access isn't blocked by the flag —
        // only Unity's native NavMesh baker seems to choke on it), so the
        // source data is available to copy.
        [MenuItem("UberStrike/Server Bots/Fix - Clone Mesh Colliders as Readable (active scene)")]
        public static void FixMeshCollidersCloneReadable()
        {
            const string outDir = "Assets/Mesh/ReadableClones";
            System.IO.Directory.CreateDirectory(
                System.IO.Path.Combine(Application.dataPath, "Mesh/ReadableClones"));
            AssetDatabase.Refresh();

            var roots = GetSceneRoots();
            var cache = new Dictionary<Mesh, Mesh>(); // original -> readable clone
            int fixedCount = 0, alreadyOk = 0, failed = 0;

            foreach (var root in roots)
            {
                foreach (var col in root.GetComponentsInChildren<Collider>(true))
                {
                    var mc = col as MeshCollider;
                    if (mc == null || mc.sharedMesh == null) continue;
                    var mesh = mc.sharedMesh;
                    if (mesh.isReadable) { alreadyOk++; continue; }

                    Mesh clone;
                    if (!cache.TryGetValue(mesh, out clone))
                    {
                        try
                        {
                            clone = new Mesh();
                            clone.name = mesh.name + "_Readable";
                            clone.vertices = mesh.vertices;
                            clone.normals = mesh.normals;
                            clone.uv = mesh.uv;
                            clone.tangents = mesh.tangents;
                            clone.colors = mesh.colors;
                            if (mesh.subMeshCount > 1)
                            {
                                clone.subMeshCount = mesh.subMeshCount;
                                for (int i = 0; i < mesh.subMeshCount; i++)
                                    clone.SetTriangles(mesh.GetTriangles(i), i);
                            }
                            else
                            {
                                clone.triangles = mesh.triangles;
                            }
                            clone.RecalculateBounds();

                            string path = AssetDatabase.GenerateUniqueAssetPath(
                                outDir + "/" + mesh.name + "_Readable.asset");
                            AssetDatabase.CreateAsset(clone, path);
                            cache[mesh] = clone;
                            Debug.Log("[BotsNavMeshDiagnostic] Cloned " + mesh.name + " -> " + path +
                                " (verts=" + clone.vertexCount + " isReadable=" + clone.isReadable + ")");
                        }
                        catch (Exception ex)
                        {
                            Debug.LogError("[BotsNavMeshDiagnostic] Clone failed for " + mesh.name + ": " + ex.Message + "\n" + ex.StackTrace);
                            failed++;
                            continue;
                        }
                    }

                    mc.sharedMesh = clone;
                    EditorUtility.SetDirty(mc);
                    fixedCount++;
                }
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            Debug.Log(string.Format(
                "[BotsNavMeshDiagnostic] Clone-as-readable fix complete: fixed={0} alreadyReadable={1} failed={2}. " +
                "SAVE THE SCENE (Ctrl+S) — the MeshCollider references changed — then re-run Diagnose, then try baking.",
                fixedCount, alreadyOk, failed));
        }

        // Fix for the REAL root cause: Unity's static batching destructively
        // merged many small meshes into shared "Combined Mesh (root_ scene)
        // N" buffers in the original build; AssetRipper could only recover
        // the post-batch combined mesh and assigned it back to EVERY
        // GameObject that used to render through it. Confirmed via full
        // hierarchy dump 2026-07-07: dozens of unrelated NavStatic objects
        // (Ground, GroundSnow, WallDoors, WireFence, every Tree_*, every
        // Prop, every TelephonePole, Mountain*) all reference the exact
        // same ~62,935-vertex mesh at different transforms across the map —
        // NavMesh baking voxelizes that huge mesh redundantly dozens of
        // times, very plausibly overwhelming the 32-bit native baker.
        //
        // The true individual meshes no longer exist (static batching is
        // destructive) so they can't be recovered. This clears Navigation
        // Static ONLY on objects whose render mesh is one of these bogus
        // shared "Combined Mesh" placeholders AND which have no other
        // distinct collider to contribute instead — decorative/duplicate
        // layers (snow overlays, trees, poles, props) that aren't the
        // actual collision source anyway. Objects with a BoxCollider or a
        // real (already-fixed, distinct) MeshCollider keep NavStatic, so
        // they still contribute their valid collider shape to the bake.
        [MenuItem("UberStrike/Server Bots/Fix - Strip NavStatic from Combined-Mesh-only objects (active scene)")]
        public static void FixStripNavStaticFromCombinedMeshOnly()
        {
            int stripped = 0, kept = 0;
            foreach (var root in GetSceneRoots())
            {
                foreach (var mf in root.GetComponentsInChildren<MeshFilter>(true))
                {
                    var go = mf.gameObject;
                    var flags = GameObjectUtility.GetStaticEditorFlags(go);
                    if ((flags & StaticEditorFlags.NavigationStatic) == 0) continue;

                    var mesh = mf.sharedMesh;
                    bool isBogusCombined = mesh != null && mesh.name.StartsWith("Combined Mesh");
                    if (!isBogusCombined) continue;

                    bool hasBox = go.GetComponent<BoxCollider>() != null;
                    var mc = go.GetComponent<MeshCollider>();
                    bool hasDistinctMeshCollider = mc != null && mc.sharedMesh != null &&
                        !mc.sharedMesh.name.StartsWith("Combined Mesh");

                    if (hasBox || hasDistinctMeshCollider)
                    {
                        kept++;
                        continue; // has its own valid collider geometry — keep contributing to the bake
                    }

                    var newFlags = flags & ~StaticEditorFlags.NavigationStatic;
                    GameObjectUtility.SetStaticEditorFlags(go, newFlags);
                    EditorUtility.SetDirty(go);
                    stripped++;
                    Debug.Log("[BotsNavMeshDiagnostic] Stripped NavStatic (bogus combined-mesh only): " + HierarchyPath(t: go.transform));
                }
            }

            AssetDatabase.SaveAssets();
            Debug.Log(string.Format(
                "[BotsNavMeshDiagnostic] NavStatic strip complete: stripped={0} kept(has real collider)={1}. " +
                "SAVE THE SCENE (Ctrl+S), then try baking.",
                stripped, kept));
        }

        // Real fix, after confirming root cause: restore useful NavMesh
        // coverage for objects whose Renderer mesh was the bogus shared
        // "Combined Mesh" batching leftover, WITHOUT reintroducing the
        // crash. Two cases:
        //
        //   A) Object has a distinct (already-fixed, non-combined)
        //      MeshCollider — that's real, correct geometry for this
        //      object's actual shape. Copy it into the MeshFilter's render
        //      mesh too (so render + collision agree), then re-enable
        //      Navigation Static — the bake now reads correct geometry
        //      instead of the bogus combined mesh.
        //
        //   B) Object has only a BoxCollider (Ground, WallDoors, WireFence,
        //      etc.) — no correct mesh data survives for these at all (the
        //      original per-object mesh was destroyed by static batching,
        //      unrecoverable). Remove the bogus MeshFilter/MeshRenderer
        //      entirely so the baker has no broken render mesh to read,
        //      then re-enable Navigation Static — the bake falls back to
        //      the BoxCollider's own (correct, if simplified) box shape.
        //
        // Generic — walks the whole scene rather than hardcoding FortWinter
        // paths, so it's reusable on other maps.
        //
        // Split into TWO separate menu items (A and B below) instead of one
        // combined fix, specifically so each can be tested independently —
        // re-enabling both at once crashed the bake again, and with the
        // scene unsaved we can bisect cleanly: run ONLY Part A, save/test;
        // if clean, then also run Part B, save/test.

        // Part A: objects with a distinct (already-fixed) MeshCollider —
        // copy that real geometry into the render mesh, re-enable NavStatic.
        [MenuItem("UberStrike/Server Bots/Fix A - Restore via real MeshCollider (active scene)")]
        public static void FixRestoreNavMeshCoverage_MeshOnly()
        {
            int fixedWithMesh = 0, skipped = 0;
            foreach (var root in GetSceneRoots())
            {
                foreach (var mf in root.GetComponentsInChildren<MeshFilter>(true))
                {
                    var go = mf.gameObject;
                    var mesh = mf.sharedMesh;
                    bool isBogusCombined = mesh != null && mesh.name.StartsWith("Combined Mesh");
                    if (!isBogusCombined) continue;

                    // Same note as Part B: don't skip objects that already
                    // have NavStatic on (Houses/WallRock/etc. were in the
                    // original "kept=23" group and never had it turned off).
                    var flags = GameObjectUtility.GetStaticEditorFlags(go);

                    var mc = go.GetComponent<MeshCollider>();
                    bool hasDistinctMeshCollider = mc != null && mc.sharedMesh != null &&
                        !mc.sharedMesh.name.StartsWith("Combined Mesh");
                    if (!hasDistinctMeshCollider) { skipped++; continue; }

                    mf.sharedMesh = mc.sharedMesh;
                    EditorUtility.SetDirty(mf);
                    GameObjectUtility.SetStaticEditorFlags(go, flags | StaticEditorFlags.NavigationStatic);
                    EditorUtility.SetDirty(go);
                    fixedWithMesh++;
                    Debug.Log("[BotsNavMeshDiagnostic] [Part A] Restored via real MeshCollider: " + HierarchyPath(go.transform));
                }
            }
            Debug.Log(string.Format(
                "[BotsNavMeshDiagnostic] Part A complete: fixed={0} skipped(not this case)={1}. " +
                "SAVE THE SCENE (Ctrl+S), then try baking to test THIS PART ALONE.",
                fixedWithMesh, skipped));
        }

        // Part B: objects with only a BoxCollider — strip the bogus
        // MeshFilter/MeshRenderer, re-enable NavStatic, bake from the box.
        [MenuItem("UberStrike/Server Bots/Fix B - Restore via BoxCollider only (active scene)")]
        public static void FixRestoreNavMeshCoverage_BoxOnly()
        {
            int fixedBoxOnly = 0, skipped = 0;
            foreach (var root in GetSceneRoots())
            {
                var meshFilters = new List<MeshFilter>(root.GetComponentsInChildren<MeshFilter>(true));
                foreach (var mf in meshFilters)
                {
                    if (mf == null) continue;
                    var go = mf.gameObject;
                    var mesh = mf.sharedMesh;
                    bool isBogusCombined = mesh != null && mesh.name.StartsWith("Combined Mesh");
                    if (!isBogusCombined) continue;

                    // NOTE: do NOT skip objects that already have NavStatic
                    // on — Ground/WallDoors/WireFence/etc. were in the
                    // original "kept=23" group from the very first fix
                    // (they have a real Collider) and never had NavStatic
                    // turned off, but they STILL reference the bogus mesh.
                    // "NavStatic already on" does not mean "already fixed".
                    var flags = GameObjectUtility.GetStaticEditorFlags(go);

                    bool hasBox = go.GetComponent<BoxCollider>() != null;
                    if (!hasBox) { skipped++; continue; }

                    var renderer = go.GetComponent<MeshRenderer>();
                    if (renderer != null) UnityEngine.Object.DestroyImmediate(renderer);
                    UnityEngine.Object.DestroyImmediate(mf);
                    GameObjectUtility.SetStaticEditorFlags(go, flags | StaticEditorFlags.NavigationStatic);
                    EditorUtility.SetDirty(go);
                    fixedBoxOnly++;
                    Debug.Log("[BotsNavMeshDiagnostic] [Part B] Restored via BoxCollider (removed bogus MeshFilter/Renderer): " + HierarchyPath(go.transform));
                }
            }
            Debug.Log(string.Format(
                "[BotsNavMeshDiagnostic] Part B complete: fixed={0} skipped(not this case)={1}. " +
                "SAVE THE SCENE (Ctrl+S), then try baking to test THIS PART ALONE.",
                fixedBoxOnly, skipped));
        }

        // Diagnostic-only "nuclear option": strip NavigationStatic from
        // EVERY object referencing a bogus "Combined Mesh", regardless of
        // whether it also has a valid Collider. Does NOT touch any
        // Collider component, so real player physics/collision is
        // completely unaffected — this only removes objects from the
        // NavMesh BAKE's geometry source. Purpose: confirm/deny whether
        // Unity's baker reads Renderer geometry even on objects that also
        // have a Collider (if the previous, more conservative strip still
        // crashed, this tells us definitively whether ANY remaining bogus-
        // mesh reference is enough by itself). Expect near-zero navmesh
        // coverage if this succeeds — that's fine, this is a test, not the
        // final fix.
        [MenuItem("UberStrike/Server Bots/Fix - Strip NavStatic from ALL Combined-Mesh objects (active scene)")]
        public static void FixStripNavStaticFromAllCombinedMesh()
        {
            int stripped = 0;
            foreach (var root in GetSceneRoots())
            {
                foreach (var mf in root.GetComponentsInChildren<MeshFilter>(true))
                {
                    var go = mf.gameObject;
                    var flags = GameObjectUtility.GetStaticEditorFlags(go);
                    if ((flags & StaticEditorFlags.NavigationStatic) == 0) continue;

                    var mesh = mf.sharedMesh;
                    bool isBogusCombined = mesh != null && mesh.name.StartsWith("Combined Mesh");
                    if (!isBogusCombined) continue;

                    var newFlags = flags & ~StaticEditorFlags.NavigationStatic;
                    GameObjectUtility.SetStaticEditorFlags(go, newFlags);
                    EditorUtility.SetDirty(go);
                    stripped++;
                    Debug.Log("[BotsNavMeshDiagnostic] Stripped NavStatic (ALL pass): " + HierarchyPath(go.transform));
                }
            }

            AssetDatabase.SaveAssets();
            Debug.Log(string.Format(
                "[BotsNavMeshDiagnostic] ALL-pass NavStatic strip complete: stripped={0}. " +
                "SAVE THE SCENE (Ctrl+S), then try baking. Expect little/no navmesh coverage — this is a diagnostic test.",
                stripped));
        }

        // Full recursive hierarchy dump — every GameObject, active state,
        // static flags, and key component summary (MeshFilter/Renderer/
        // Collider/Terrain vertex+triangle counts). Read-only, no bake, no
        // crash risk. Lets you see the WHOLE tree (e.g. what's actually
        // under a "Terrain" folder) from a text file instead of manually
        // expanding the Hierarchy panel in Unity 4.6.5's editor.
        [MenuItem("UberStrike/Server Bots/Dump Full Hierarchy (active scene)")]
        public static void DumpHierarchyActiveScene()
        {
            string sceneName = System.IO.Path.GetFileNameWithoutExtension(EditorApplication.currentScene);
            if (string.IsNullOrEmpty(sceneName)) sceneName = "ActiveScene";
            string body = BuildHierarchyDump(sceneName);
            string path = System.IO.Path.Combine(Application.dataPath, "../_hierarchy_" + sceneName + ".txt");
            System.IO.File.WriteAllText(path, body);
            Debug.Log("[BotsNavMeshDiagnostic] Hierarchy dump written -> " + path);
        }

        [MenuItem("UberStrike/Server Bots/Dump Full Hierarchy (all maps)")]
        public static void DumpHierarchyAllMaps()
        {
            string originalScene = EditorApplication.currentScene;
            if (!EditorApplication.SaveCurrentSceneIfUserWantsTo())
            {
                Debug.Log("[BotsNavMeshDiagnostic] Cancelled — current scene has unsaved changes.");
                return;
            }

            string mapsRoot = System.IO.Path.Combine(Application.dataPath, "ArtTools/Maps");
            if (!System.IO.Directory.Exists(mapsRoot))
            {
                Debug.LogError("[BotsNavMeshDiagnostic] No Assets/ArtTools/Maps folder found.");
                return;
            }

            var combined = new StringBuilder();
            int done = 0, failed = 0;
            foreach (var full in System.IO.Directory.GetFiles(mapsRoot, "*.unity", System.IO.SearchOption.AllDirectories))
            {
                string normalized = full.Replace('\\', '/');
                int idx = normalized.IndexOf("/Assets/");
                string rel = idx >= 0 ? normalized.Substring(idx + 1) : null;
                if (rel == null) continue;

                string sceneName = System.IO.Path.GetFileNameWithoutExtension(rel);
                try
                {
                    if (!EditorApplication.OpenScene(rel))
                    {
                        Debug.LogError("[BotsNavMeshDiagnostic] Could not open " + rel);
                        failed++;
                        continue;
                    }
                    combined.AppendLine(BuildHierarchyDump(sceneName));
                    combined.AppendLine();
                    done++;
                }
                catch (Exception ex)
                {
                    Debug.LogError("[BotsNavMeshDiagnostic] Dump failed for " + rel + ": " + ex.Message);
                    failed++;
                }
            }

            if (!string.IsNullOrEmpty(originalScene) && System.IO.File.Exists(originalScene))
            {
                try { EditorApplication.OpenScene(originalScene); }
                catch (Exception ex) { Debug.LogWarning("[BotsNavMeshDiagnostic] Could not restore '" + originalScene + "': " + ex.Message); }
            }

            string path = System.IO.Path.Combine(Application.dataPath, "../_hierarchy_all_maps.txt");
            System.IO.File.WriteAllText(path, combined.ToString());
            Debug.Log(string.Format("[BotsNavMeshDiagnostic] All-maps hierarchy dump done={0} failed={1} -> {2}", done, failed, path));
        }

        private static string BuildHierarchyDump(string sceneName)
        {
            var sb = new StringBuilder();
            sb.AppendLine("======================================================================");
            sb.AppendLine("SCENE: " + sceneName + "   (" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + ")");
            sb.AppendLine("======================================================================");

            foreach (var root in GetSceneRoots())
            {
                DumpTransformRecursive(root.transform, 0, sb);
            }
            return sb.ToString();
        }

        private static void DumpTransformRecursive(Transform t, int depth, StringBuilder sb)
        {
            var go = t.gameObject;
            var indent = new string(' ', depth * 2);

            var mf = go.GetComponent<MeshFilter>();
            var mesh = mf != null ? mf.sharedMesh : null;
            var col = go.GetComponent<Collider>();
            var terrain = go.GetComponent<Terrain>();
            var flags = GameObjectUtility.GetStaticEditorFlags(go);
            bool navStatic = (flags & StaticEditorFlags.NavigationStatic) != 0;

            var parts = new List<string>();
            if (!go.activeSelf) parts.Add("INACTIVE");
            if (navStatic) parts.Add("NavStatic");
            if (mesh != null) parts.Add(string.Format("Mesh[{0}]:v{1}/t{2}/readable={3}", mesh.name, mesh.vertexCount, mesh.triangles.Length / 3, mesh.isReadable));
            if (col != null) parts.Add("Collider:" + col.GetType().Name);
            if (terrain != null) parts.Add("Terrain");
            var otherComponents = go.GetComponents<Component>();
            foreach (var c in otherComponents)
            {
                if (c == null) continue; // missing script
                if (c is Transform || c is MeshFilter || c is Collider || c is Terrain || c is Renderer) continue;
                parts.Add(c.GetType().Name);
            }

            sb.AppendLine(string.Format("{0}{1}  [{2}]", indent, t.name, string.Join(", ", parts.ToArray())));

            for (int i = 0; i < t.childCount; i++)
                DumpTransformRecursive(t.GetChild(i), depth + 1, sb);
        }

        private static List<GameObject> GetSceneRoots()
        {
            var roots = new List<GameObject>();
            foreach (var o in Resources.FindObjectsOfTypeAll(typeof(GameObject)))
            {
                var go = o as GameObject;
                if (go == null) continue;
                if (go.transform.parent != null) continue;
                if (go.hideFlags != HideFlags.None) continue;
                if (EditorUtility.IsPersistent(go)) continue;
                roots.Add(go);
            }
            return roots;
        }

        private static string HierarchyPath(Transform t)
        {
            var sb = new StringBuilder(t.name);
            var p = t.parent;
            while (p != null) { sb.Insert(0, p.name + "/"); p = p.parent; }
            return sb.ToString();
        }
    }
}
