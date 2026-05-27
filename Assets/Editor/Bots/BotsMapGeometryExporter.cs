// BotsMapGeometryExporter — Phase 6 port of the server-side bots geometry
// exporter to Unity 4.6.5 (UberStrike 4.7.1 Steam reconstruction).
//
// ── Why this exists ─────────────────────────────────────────────────────
// The server-side bots run inside the UBZ UberStrok v4.8.6 server and serve
// the LIVE Steam 4.7.1 client. The server has no 3D mesh data, so it needs a
// compact 2D representation of each map to answer:
//
//   * GroundY(x, z)         — where is the floor?
//   * IsWalkable(x, z)      — can a bot stand here?
//   * HasLineOfSight(a, b)  — can a bot see another bot/player?
//
// This exporter samples the colliders of a Steam map scene and writes a flat
// JSON grid the server deserializes with Newtonsoft.Json into MapGeometryV1.
//
// ── Port notes (Unity 2022 → Unity 4.6.5) ───────────────────────────────
// The original (unity_2022_tg/server-bots-integration) was written against
// Unity 2022 APIs that DO NOT EXIST in 4.6.5. This port replaces them:
//
//   UnityEngine/UnityEditor.SceneManagement  → EditorApplication.OpenScene +
//                                              Resources.FindObjectsOfTypeAll
//   JsonUtility.ToJson                       → hand-rolled, invariant-culture
//   Physics.SyncTransforms                   → dropped (4.6.5 syncs eagerly)
//   Physics.CheckBox                         → Physics.OverlapSphere band test
//   QueryTriggerInteraction.Ignore           → manual hit.collider.isTrigger
//   Physics.DefaultRaycastLayers             → ~(1 << IgnoreRaycast layer 2)
//
// Output: <repo>/Assets/StreamingAssets/BotsGeometry/<MapName>.json
//         + a copy to the UBZ server's maps_geometry folder.
//
// Run via  UberStrike → Server Bots → Export Map Geometry (active scene)
//      or  UberStrike → Server Bots → Export Map Geometry (all maps)

using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;

namespace UberStrike.Editor.Bots
{
    public static class BotsMapGeometryExporter
    {
        // 1m × 1m XZ cells. Smaller = sharper walls/edges but bigger files.
        private const float CellSize = 1.0f;

        // Vertical band the bot's torso occupies when standing on the floor.
        private const float BotHeightMin = 0.3f;
        private const float BotHeightMax = 1.8f;

        // Floor scan starts here and rays downward. Set well above the
        // tallest map ceiling so the first hit is reliable.
        private const float ScanRayTopY = 500f;
        private const float ScanRayLength = 1000f;

        // No-data marker for GroundY; matches the server-side constant.
        private const float NoGround = -9999f;

        // Default raycast layer mask: every layer except IgnoreRaycast (2).
        // (Physics.DefaultRaycastLayers doesn't exist in Unity 4.6.5.)
        private const int RaycastMask = ~(1 << 2);

        // Maximum permissible map axis length (metres). Beyond this the bounds
        // were almost certainly corrupted by a stray far-away collider, so we
        // refuse to grid the scene rather than build a multi-GB array. With
        // the skip + clip passes below this should now never trigger.
        private const float MaxAllowedAxisLength = 500f;

        // A single collider wider than this on X or Z is not playable map
        // geometry — it's a skybox dome, ocean plane, or world-bounds helper.
        // Such colliders are skipped (and logged with their hierarchy path)
        // so they don't inflate the grid. No real UberStrike arena collider
        // comes close to this size.
        private const float MaxColliderAxisLength = 300f;

        // After oversized colliders are skipped, the surviving bounds are
        // additionally clipped to the spawn-point AABB expanded by this
        // margin (metres). Players never roam this far past the outermost
        // spawn, so it tightens outdoor maps without losing playable area.
        private const float SpawnPlayMargin = 75f;

        // Accumulates a human-readable per-map summary for _export_report.txt
        // — Unity 4.6.5's Console has no select-all / copy.
        private static readonly StringBuilder _report = new StringBuilder();

        // Where to also drop a copy for the UBZ server to load at runtime.
        // Points at the UBZ `server-bots-integration` worktree so exports
        // land on the bots branch — the main UBZ checkout is on the
        // unrelated `4.3.8-client-support` branch. Override via the
        // BOTS_GEOMETRY_DIR environment variable.
        private const string ServerCopyPath =
            @"C:\Users\Shadow\Downloads\UBZ-server-bots\server\UberServer-v4.8.6\maps_geometry";

        // Steam scene name → server geometry basename. The UBZ server's map
        // tables are partly fork-named; keep these two in sync with the
        // server's _steamToForkBase alias map so exported filenames land
        // where the server already looks. Everything not listed is identity.
        private static readonly Dictionary<string, string> SteamToServerName =
            new Dictionary<string, string>
            {
                { "UberZone",      "QuakeDm6" },
                { "SpacePortAlpha", "SpaceportAlpha" },
            };

        [MenuItem("UberStrike/Server Bots/Export Map Geometry (active scene)")]
        public static void ExportActive()
        {
            string scenePath = EditorApplication.currentScene;
            if (string.IsNullOrEmpty(scenePath))
            {
                Debug.LogError("[BotsGeo] No active scene to export. Open a map scene first.");
                return;
            }
            _report.Length = 0;
            ExportScene(CurrentSceneName());
            WriteReport();
            AssetDatabase.Refresh();
            Debug.Log("[BotsGeo] Done exporting active scene.");
        }

        [MenuItem("UberStrike/Server Bots/Export Map Geometry (all maps)")]
        public static void ExportAllMaps()
        {
            // Remember the open scene so we can restore it afterward.
            string originalScene = EditorApplication.currentScene;
            if (!EditorApplication.SaveCurrentSceneIfUserWantsTo())
            {
                Debug.Log("[BotsGeo] Cancelled — current scene has unsaved changes.");
                return;
            }

            var scenePaths = DiscoverMapScenes();
            if (scenePaths.Count == 0)
            {
                Debug.LogError("[BotsGeo] No map scenes found under Assets/ArtTools/Maps/.");
                return;
            }

            _report.Length = 0;
            int written = 0, empty = 0, errored = 0;
            foreach (var path in scenePaths)
            {
                try
                {
                    if (!EditorApplication.OpenScene(path))
                    {
                        errored++;
                        Debug.LogError("[BotsGeo] Could not open scene: " + path);
                        continue;
                    }
                    if (ExportScene(Path.GetFileNameWithoutExtension(path))) written++;
                    else empty++;
                }
                catch (Exception ex)
                {
                    errored++;
                    Debug.LogError("[BotsGeo] Export failed for " + path + ": " + ex.Message + "\n" + ex.StackTrace);
                }
            }

            // Restore the originally-open scene.
            if (!string.IsNullOrEmpty(originalScene) && File.Exists(originalScene))
            {
                try { EditorApplication.OpenScene(originalScene); }
                catch (Exception ex) { Debug.LogWarning("[BotsGeo] Could not restore '" + originalScene + "': " + ex.Message); }
            }

            _report.AppendLine();
            _report.AppendLine(string.Format("Totals: wrote={0}  rejected/empty={1}  errored={2}",
                written, empty, errored));
            WriteReport();

            AssetDatabase.Refresh();
            Debug.Log(string.Format("[BotsGeo] Done. wrote={0}  empty(no colliders)={1}  errored={2}",
                written, empty, errored));
        }

        // Writes the accumulated per-map summary to a copyable text file in
        // both StreamingAssets/BotsGeometry and the server geometry folder.
        private static void WriteReport()
        {
            string body =
                "BotsMapGeometry export report — " +
                DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "\n" +
                "================================================================\n" +
                _report.ToString();
            try
            {
                string dir = Path.Combine(Application.streamingAssetsPath, "BotsGeometry");
                Directory.CreateDirectory(dir);
                string path = Path.Combine(dir, "_export_report.txt");
                File.WriteAllText(path, body);
                Debug.Log("[BotsGeo] Report written -> " + path);

                string serverDir = Environment.GetEnvironmentVariable("BOTS_GEOMETRY_DIR");
                if (string.IsNullOrEmpty(serverDir)) serverDir = ServerCopyPath;
                Directory.CreateDirectory(serverDir);
                File.WriteAllText(Path.Combine(serverDir, "_export_report.txt"), body);
            }
            catch (Exception ex)
            {
                Debug.LogWarning("[BotsGeo] Report write failed: " + ex.Message);
            }
        }

        // ── Scene discovery ─────────────────────────────────────────────

        // All Steam map scenes live under Assets/ArtTools/Maps/<map>/<Map>.unity.
        // Plain .NET IO so it's independent of the AssetDatabase.FindAssets
        // availability quirks across Unity versions.
        private static List<string> DiscoverMapScenes()
        {
            var result = new List<string>();
            string mapsRoot = Path.Combine(Application.dataPath, "ArtTools/Maps");
            if (!Directory.Exists(mapsRoot)) return result;

            foreach (var full in Directory.GetFiles(mapsRoot, "*.unity", SearchOption.AllDirectories))
            {
                // Convert absolute path → project-relative "Assets/..." path.
                string normalized = full.Replace('\\', '/');
                int idx = normalized.IndexOf("/Assets/");
                string rel = idx >= 0
                    ? normalized.Substring(idx + 1)
                    : "Assets" + normalized.Substring(Application.dataPath.Length);
                result.Add(rel);
            }
            result.Sort(StringComparer.OrdinalIgnoreCase);
            return result;
        }

        private static string CurrentSceneName()
        {
            return Path.GetFileNameWithoutExtension(EditorApplication.currentScene);
        }

        // Server-side maps use the Steam scene name without any "Level"
        // prefix, with the two known Steam→server renames applied.
        private static string FileBaseFor(string sceneName)
        {
            string n = string.IsNullOrEmpty(sceneName) ? "Unnamed" : sceneName;
            if (n.StartsWith("Level")) n = n.Substring("Level".Length);
            string mapped;
            if (SteamToServerName.TryGetValue(n, out mapped)) return mapped;
            return n;
        }

        // ── Scene object access (no Scene struct in 4.6.5) ──────────────

        // Mirrors Unity 2022's scene.GetRootGameObjects(): every root-level
        // GameObject that belongs to the open scene (not a prefab asset, not
        // an editor-internal object).
        private static List<GameObject> GetSceneRoots()
        {
            var roots = new List<GameObject>();
            foreach (var o in Resources.FindObjectsOfTypeAll(typeof(GameObject)))
            {
                var go = o as GameObject;
                if (go == null) continue;
                if (go.transform.parent != null) continue;     // not a root
                if (go.hideFlags != HideFlags.None) continue;   // editor-internal
                if (EditorUtility.IsPersistent(go)) continue;   // prefab/asset
                roots.Add(go);
            }
            return roots;
        }

        // ── Per-scene export ────────────────────────────────────────────

        private static bool ExportScene(string sceneName)
        {
            // 1) Collect authored spawn points first — ComputeColliderBounds
            // uses them to clip the grid to the playable area.
            var spawns = CollectSpawns();

            // 2) Compute scene XZ bounds from colliders (oversized skybox /
            // ocean colliders skipped, result clipped to the spawn play-box).
            Bounds? rootBounds = ComputeColliderBounds(sceneName, spawns);
            if (rootBounds == null)
            {
                Debug.LogWarning("[BotsGeo] " + sceneName + ": no usable colliders / bounds — skipping.");
                _report.AppendLine(string.Format("{0,-22} REJECTED  no usable collider bounds", sceneName));
                return false;
            }
            Bounds bounds = rootBounds.Value;

            // Add a 2m margin so edge cells are sampled cleanly.
            const float margin = 2f;
            float minX = bounds.min.x - margin;
            float maxX = bounds.max.x + margin;
            float minZ = bounds.min.z - margin;
            float maxZ = bounds.max.z + margin;

            int gridW = Mathf.CeilToInt((maxX - minX) / CellSize);
            int gridH = Mathf.CeilToInt((maxZ - minZ) / CellSize);
            int total = gridW * gridH;

            var groundY  = new float[total];
            var walkable = new byte[total];
            var wall     = new byte[total];

            // Median spawn Y filters out surfaces below/above the play band.
            float? referenceY = ComputeReferenceY(spawns);
            var pickups = CollectPickups();

            float refYLowerBand = referenceY.HasValue ? referenceY.Value - 1.5f : float.NegativeInfinity;
            float refYUpperBand = referenceY.HasValue ? referenceY.Value + 30f  : float.PositiveInfinity;

            int hitGround = 0, walkN = 0, wallN = 0, rejectedBelow = 0, rejectedAbove = 0;
            for (int gz = 0; gz < gridH; gz++)
            {
                float cz = minZ + (gz + 0.5f) * CellSize;
                for (int gx = 0; gx < gridW; gx++)
                {
                    float cx = minX + (gx + 0.5f) * CellSize;
                    int idx = gz * gridW + gx;

                    var rayStart = new Vector3(cx, ScanRayTopY, cz);
                    var hits = Physics.RaycastAll(rayStart, Vector3.down, ScanRayLength, RaycastMask);

                    float chosenY = NoGround;
                    bool chosenWalkable = false;
                    if (hits.Length > 0)
                    {
                        // Sort ascending by world Y so we evaluate the lowest
                        // surface first (interior floor before building roof).
                        Array.Sort(hits, delegate (RaycastHit a, RaycastHit b)
                        {
                            return a.point.y.CompareTo(b.point.y);
                        });
                        foreach (var hit in hits)
                        {
                            if (hit.collider != null && hit.collider.isTrigger) continue; // ignore triggers
                            if (hit.normal.y < 0.5f) continue;                            // not floor-like
                            float floorY = hit.point.y;

                            if (floorY < refYLowerBand) { rejectedBelow++; continue; }
                            if (floorY > refYUpperBand) { rejectedAbove++; continue; }

                            bool blocked = TorsoBlocked(cx, floorY, cz);

                            if (chosenY <= NoGround)
                            {
                                chosenY = floorY;
                                chosenWalkable = !blocked;
                                if (!blocked) break;
                            }
                            else if (!blocked)
                            {
                                chosenY = floorY;
                                chosenWalkable = true;
                                break;
                            }
                        }
                    }

                    groundY[idx] = chosenY;
                    if (chosenY > NoGround) hitGround++;
                    if (chosenWalkable) { walkable[idx] = 1; walkN++; }
                    else                { wall[idx]     = 1; wallN++; }
                }
            }
            if (referenceY.HasValue)
                Debug.Log(string.Format("[BotsGeo]   refY={0:F2} band=[{1:F2}..{2:F2}] rejected below={3} above={4}",
                    referenceY.Value, refYLowerBand, refYUpperBand, rejectedBelow, rejectedAbove));
            else
                Debug.LogWarning("[BotsGeo]   no spawn points found in " + sceneName +
                    " — Y-band filter disabled; bots may sink into outdoor terrain.");

            // 2) Build the export model.
            string fileBase = FileBaseFor(sceneName);
            var model = new MapGeometryV1
            {
                version    = 1,
                sceneName  = fileBase,
                unityScene = sceneName,
                cellSize   = CellSize,
                originX    = minX,
                originZ    = minZ,
                gridWidth  = gridW,
                gridHeight = gridH,
                groundY    = groundY,
                walkable   = walkable,
                wall       = wall,
                spawnsBlue = spawns.blue,
                spawnsRed  = spawns.red,
                spawnsNone = spawns.none,
                pickups    = pickups,
            };

            string json = ToJson(model);

            // 3) Write to StreamingAssets and the optional server folder.
            string streamingDir = Path.Combine(Application.streamingAssetsPath, "BotsGeometry");
            Directory.CreateDirectory(streamingDir);
            string streamingPath = Path.Combine(streamingDir, fileBase + ".json");
            File.WriteAllText(streamingPath, json);

            string serverDir = Environment.GetEnvironmentVariable("BOTS_GEOMETRY_DIR");
            if (string.IsNullOrEmpty(serverDir)) serverDir = ServerCopyPath;
            try
            {
                Directory.CreateDirectory(serverDir);
                File.WriteAllText(Path.Combine(serverDir, fileBase + ".json"), json);
            }
            catch (Exception ex)
            {
                Debug.LogWarning("[BotsGeo] Server copy failed (" + serverDir + "): " + ex.Message);
            }

            Debug.Log(string.Format(
                "[BotsGeo] {0}: grid {1}x{2} ({3} cells) | ground={4} walkable={5} wall={6} | " +
                "bounds X[{7:F1}..{8:F1}] Z[{9:F1}..{10:F1}] | {11} KB -> {12}",
                sceneName, gridW, gridH, total, hitGround, walkN, wallN,
                minX, maxX, minZ, maxZ, json.Length / 1024, streamingPath));

            _report.AppendLine(string.Format(
                "{0,-22} OK        grid {1,4}x{2,-5} ground={3,-7} walk={4,-7} wall={5,-7} spawns={6,-4} {7}KB",
                sceneName, gridW, gridH, hitGround, walkN, wallN,
                spawns.blue.Count + spawns.red.Count + spawns.none.Count, json.Length / 1024));
            return true;
        }

        // Clearance test: does a collider overlap the bot's torso band above
        // this floor cell? Replaces Unity 2022's Physics.CheckBox — 4.6.5 has
        // no CheckBox, and OverlapSphere lets us drop trigger hits per-call
        // (CheckCapsule cannot). Two samples (knee + chest) catch low rails
        // and chest-height walls without flagging the floor itself.
        private static bool TorsoBlocked(float cx, float floorY, float cz)
        {
            float radius = CellSize * 0.4f;
            float[] sampleHeights = { BotHeightMin + 0.3f, BotHeightMax - 0.3f };
            foreach (float h in sampleHeights)
            {
                var center = new Vector3(cx, floorY + h, cz);
                var overlaps = Physics.OverlapSphere(center, radius, RaycastMask);
                foreach (var col in overlaps)
                {
                    if (col == null || col.isTrigger) continue; // triggers aren't walls
                    return true;
                }
            }
            return false;
        }

        // ── Bounds ──────────────────────────────────────────────────────

        private static Bounds? ComputeColliderBounds(string sceneName, SpawnLists spawns)
        {
            // Step 1: force-activate every GameObject so Physics queries can
            // hit them. Older UberStrike maps stash geometry under nested-
            // inactive GameObjects that runtime code activates on Start; in
            // Editor mode they're invisible to Raycast unless woken first.
            int activated = 0;
            foreach (var root in GetSceneRoots())
            {
                foreach (var t in root.GetComponentsInChildren<Transform>(true))
                {
                    if (!t.gameObject.activeSelf) { t.gameObject.SetActive(true); activated++; }
                }
            }
            // Unity 4.6.5 updates collider world bounds synchronously on
            // activation — no Physics.SyncTransforms() needed (and it doesn't
            // exist until 2017.2).

            // Step 2: gather bounds from active non-trigger colliders, but
            // skip skybox-dome / ocean-plane colliders that would otherwise
            // inflate the grid to thousands of metres. Each skip is logged
            // with its hierarchy path so the culprit object is identifiable.
            Bounds? acc = null;
            int sampled = 0, skippedTrigger = 0, skippedInactive = 0, skippedOversized = 0;
            foreach (var root in GetSceneRoots())
            {
                foreach (var col in root.GetComponentsInChildren<Collider>(true))
                {
                    if (col.isTrigger) { skippedTrigger++; continue; }
                    if (!col.gameObject.activeInHierarchy || !col.enabled) { skippedInactive++; continue; }
                    var b = col.bounds;
                    if (b.size.sqrMagnitude < 0.0001f) continue;
                    if (b.size.x > MaxColliderAxisLength || b.size.z > MaxColliderAxisLength)
                    {
                        skippedOversized++;
                        Debug.Log(string.Format(
                            "[BotsGeo]   skipped oversized collider {0:F0}x{1:F0}m at ({2:F0},{3:F0},{4:F0}) — {5}",
                            b.size.x, b.size.z, b.center.x, b.center.y, b.center.z,
                            HierarchyPath(col.transform)));
                        continue;
                    }
                    if (acc == null) acc = b;
                    else { var x = acc.Value; x.Encapsulate(b); acc = x; }
                    sampled++;
                }
            }
            Debug.Log(string.Format(
                "[BotsGeo]   activated={0} colliders sampled={1} inactive={2} triggers={3} oversized={4}",
                activated, sampled, skippedInactive, skippedTrigger, skippedOversized));

            if (acc == null) return null;

            // Step 3: clip the XZ extents to the spawn-point play-box. Some
            // maps tile their skybox / ocean from many medium colliders, no
            // single one of which trips the oversized check above — clipping
            // to spawns + margin removes them. Y is left untouched.
            Bounds? spawnBox = ComputeSpawnBox(spawns);
            if (spawnBox != null)
            {
                var cur = acc.Value;
                var sb = spawnBox.Value;
                float minX = Mathf.Max(cur.min.x, sb.min.x);
                float maxX = Mathf.Min(cur.max.x, sb.max.x);
                float minZ = Mathf.Max(cur.min.z, sb.min.z);
                float maxZ = Mathf.Min(cur.max.z, sb.max.z);
                if (maxX > minX && maxZ > minZ)
                {
                    var clipped = new Bounds();
                    clipped.SetMinMax(new Vector3(minX, cur.min.y, minZ),
                                      new Vector3(maxX, cur.max.y, maxZ));
                    if (clipped.size != cur.size)
                        Debug.Log(string.Format(
                            "[BotsGeo]   clipped to spawn play-box: {0:F0}x{1:F0}m -> {2:F0}x{3:F0}m",
                            cur.size.x, cur.size.z, clipped.size.x, clipped.size.z));
                    acc = clipped;
                }
            }
            else
            {
                Debug.LogWarning("[BotsGeo]   " + sceneName +
                    ": no spawn points — spawn-box clip skipped; relying on oversized-collider skip only.");
            }

            // Step 4: last-resort sanity cap. After skip + clip this should
            // never fire; if it does, the map needs manual inspection.
            var finalSize = acc.Value.size;
            if (finalSize.x > MaxAllowedAxisLength || finalSize.z > MaxAllowedAxisLength)
            {
                Debug.LogWarning(string.Format(
                    "[BotsGeo]   {0}: bounds still {1:F0}x{2:F0}m after skip+clip — exceeds {3}m cap, " +
                    "skipping. Inspect the oversized-collider log lines above.",
                    sceneName, finalSize.x, finalSize.z, MaxAllowedAxisLength));
                return null;
            }
            return acc;
        }

        // XZ AABB of every spawn point, expanded by SpawnPlayMargin on X/Z.
        // Y is left effectively unbounded. Null if the scene has no spawns.
        private static Bounds? ComputeSpawnBox(SpawnLists s)
        {
            var all = new List<Vector3>();
            all.AddRange(s.blue);
            all.AddRange(s.red);
            all.AddRange(s.none);
            if (all.Count == 0) return null;

            float minX = float.MaxValue, maxX = float.MinValue;
            float minZ = float.MaxValue, maxZ = float.MinValue;
            foreach (var p in all)
            {
                if (p.x < minX) minX = p.x;
                if (p.x > maxX) maxX = p.x;
                if (p.z < minZ) minZ = p.z;
                if (p.z > maxZ) maxZ = p.z;
            }
            var box = new Bounds();
            box.SetMinMax(
                new Vector3(minX - SpawnPlayMargin, -100000f, minZ - SpawnPlayMargin),
                new Vector3(maxX + SpawnPlayMargin,  100000f, maxZ + SpawnPlayMargin));
            return box;
        }

        // Full "Root/Child/.../Leaf" path of a transform, for diagnostics.
        private static string HierarchyPath(Transform t)
        {
            var sb = new StringBuilder(t.name);
            var p = t.parent;
            while (p != null) { sb.Insert(0, p.name + "/"); p = p.parent; }
            return sb.ToString();
        }

        // ── Spawns / pickups ────────────────────────────────────────────

        private struct SpawnLists
        {
            public List<Vector3> blue;
            public List<Vector3> red;
            public List<Vector3> none;
        }

        private static SpawnLists CollectSpawns()
        {
            var s = new SpawnLists
            {
                blue = new List<Vector3>(),
                red  = new List<Vector3>(),
                none = new List<Vector3>(),
            };
            foreach (var root in GetSceneRoots())
            {
                foreach (var mb in root.GetComponentsInChildren<MonoBehaviour>(true))
                {
                    if (mb == null) continue;
                    string typeName = mb.GetType().Name;
                    if (typeName != "SpawnPoint" && typeName != "TeamPoint") continue;
                    string team = TryGetTeamName(mb);
                    var p = mb.transform.position;
                    if (team == "BLUE") s.blue.Add(p);
                    else if (team == "RED") s.red.Add(p);
                    else s.none.Add(p);
                }
            }
            return s;
        }

        // Median Y of authored spawn points — used to filter ground samples.
        // Median (not mean) so a single outlier spawn (death-pit teleporter)
        // doesn't drag the reference Y off. Null if the scene has no spawns.
        private static float? ComputeReferenceY(SpawnLists s)
        {
            var ys = new List<float>(s.blue.Count + s.red.Count + s.none.Count);
            foreach (var p in s.blue) ys.Add(p.y);
            foreach (var p in s.red)  ys.Add(p.y);
            foreach (var p in s.none) ys.Add(p.y);
            if (ys.Count == 0) return null;
            ys.Sort();
            return ys[ys.Count / 2];
        }

        private static List<PickupEntry> CollectPickups()
        {
            var list = new List<PickupEntry>();
            foreach (var root in GetSceneRoots())
            {
                foreach (var mb in root.GetComponentsInChildren<MonoBehaviour>(true))
                {
                    if (mb == null) continue;
                    string typeName = mb.GetType().Name;
                    if (typeName != "HealthPickupItem" && typeName != "ArmorPickupItem") continue;
                    var p = mb.transform.position;
                    list.Add(new PickupEntry
                    {
                        type  = typeName == "HealthPickupItem" ? "Health" : "Armor",
                        value = ResolvePickupValue(mb, typeName),
                        x = p.x, y = p.y, z = p.z,
                    });
                }
            }
            return list;
        }

        private static int ResolvePickupValue(MonoBehaviour mb, string typeName)
        {
            try
            {
                var t = mb.GetType();
                var f = t.GetField("_healthPoints",
                            System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance)
                       ?? t.GetField("_armorPoints",
                            System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance);
                if (f != null)
                {
                    var v = f.GetValue(mb);
                    string name = v != null ? v.ToString() : "";
                    if (typeName == "HealthPickupItem")
                    {
                        if (name == "HP_100") return 100;
                        if (name == "HP_50")  return 50;
                        if (name == "HP_25")  return 25;
                        if (name == "HP_5")   return 5;
                    }
                    else
                    {
                        if (name == "Gold")   return 100;
                        if (name == "Silver") return 50;
                        if (name == "Bronze") return 5;
                    }
                }
            }
            catch { }
            return 25; // sane default
        }

        // UberStrike 4.7.1's SpawnPoint stores the team in a public field
        // named "TeamPoint" (TeamID enum) with a "TeamId" getter. Earlier
        // forks used "Team"/"team", so probe all known spellings.
        private static string TryGetTeamName(MonoBehaviour mb)
        {
            string[] fieldNames    = { "TeamPoint", "Team", "TeamID", "team" };
            string[] propertyNames = { "TeamId", "TeamPoint", "Team", "TeamID", "team" };
            try
            {
                var t = mb.GetType();
                foreach (var name in fieldNames)
                {
                    var f = t.GetField(name);
                    if (f != null)
                    {
                        var v = f.GetValue(mb);
                        if (v != null) return v.ToString().ToUpperInvariant();
                    }
                }
                foreach (var name in propertyNames)
                {
                    var p = t.GetProperty(name);
                    if (p != null)
                    {
                        var v = p.GetValue(mb, null);
                        if (v != null) return v.ToString().ToUpperInvariant();
                    }
                }
            }
            catch { }
            return "NONE";
        }

        // ── JSON serialization (hand-rolled — no JsonUtility in 4.6.5) ───
        //
        // The server reads this with Newtonsoft.Json into MapGeometryV1, so
        // only field names and valid JSON matter — not formatting. Output
        // mirrors the compact JsonUtility shape of the 11 existing JSONs.
        // CRITICAL: all floats are written with InvariantCulture so the
        // German-locale Windows host doesn't emit "-9999,0" (invalid JSON).

        private static string ToJson(MapGeometryV1 m)
        {
            var sb = new StringBuilder(m.gridWidth * m.gridHeight * 8 + 1024);
            sb.Append('{');
            sb.Append("\"version\":").Append(m.version);
            sb.Append(",\"sceneName\":").Append(Quote(m.sceneName));
            sb.Append(",\"unityScene\":").Append(Quote(m.unityScene));
            sb.Append(",\"cellSize\":").Append(F(m.cellSize));
            sb.Append(",\"originX\":").Append(F(m.originX));
            sb.Append(",\"originZ\":").Append(F(m.originZ));
            sb.Append(",\"gridWidth\":").Append(m.gridWidth);
            sb.Append(",\"gridHeight\":").Append(m.gridHeight);

            sb.Append(",\"groundY\":[");
            for (int i = 0; i < m.groundY.Length; i++)
            {
                if (i > 0) sb.Append(',');
                sb.Append(F(m.groundY[i]));
            }
            sb.Append(']');

            AppendByteArray(sb, ",\"walkable\":", m.walkable);
            AppendByteArray(sb, ",\"wall\":", m.wall);

            AppendVec3List(sb, ",\"spawnsBlue\":", m.spawnsBlue);
            AppendVec3List(sb, ",\"spawnsRed\":",  m.spawnsRed);
            AppendVec3List(sb, ",\"spawnsNone\":", m.spawnsNone);

            sb.Append(",\"pickups\":[");
            for (int i = 0; i < m.pickups.Count; i++)
            {
                if (i > 0) sb.Append(',');
                var p = m.pickups[i];
                sb.Append("{\"type\":").Append(Quote(p.type));
                sb.Append(",\"value\":").Append(p.value);
                sb.Append(",\"x\":").Append(F(p.x));
                sb.Append(",\"y\":").Append(F(p.y));
                sb.Append(",\"z\":").Append(F(p.z));
                sb.Append('}');
            }
            sb.Append(']');

            sb.Append('}');
            return sb.ToString();
        }

        private static void AppendByteArray(StringBuilder sb, string key, byte[] arr)
        {
            sb.Append(key).Append('[');
            for (int i = 0; i < arr.Length; i++)
            {
                if (i > 0) sb.Append(',');
                sb.Append(arr[i]);
            }
            sb.Append(']');
        }

        private static void AppendVec3List(StringBuilder sb, string key, List<Vector3> list)
        {
            sb.Append(key).Append('[');
            for (int i = 0; i < list.Count; i++)
            {
                if (i > 0) sb.Append(',');
                var v = list[i];
                sb.Append("{\"x\":").Append(F(v.x));
                sb.Append(",\"y\":").Append(F(v.y));
                sb.Append(",\"z\":").Append(F(v.z));
                sb.Append('}');
            }
            sb.Append(']');
        }

        private static string F(float v)
        {
            // "R" round-trip format, invariant culture (decimal point, not comma).
            return v.ToString("R", CultureInfo.InvariantCulture);
        }

        private static string Quote(string s)
        {
            if (s == null) return "null";
            var sb = new StringBuilder(s.Length + 2);
            sb.Append('"');
            foreach (char c in s)
            {
                if (c == '"' || c == '\\') sb.Append('\\').Append(c);
                else if (c == '\n') sb.Append("\\n");
                else if (c == '\r') sb.Append("\\r");
                else if (c == '\t') sb.Append("\\t");
                else sb.Append(c);
            }
            sb.Append('"');
            return sb.ToString();
        }

        // Wire-format. Matches MapGeometryV1 on the server.
        [Serializable]
        private class MapGeometryV1
        {
            public int version;
            public string sceneName;   // server-side geometry basename
            public string unityScene;  // original Steam scene name for cross-ref
            public float cellSize;
            public float originX;
            public float originZ;
            public int gridWidth;
            public int gridHeight;
            public float[] groundY;
            public byte[] walkable;
            public byte[] wall;
            public List<Vector3> spawnsBlue;
            public List<Vector3> spawnsRed;
            public List<Vector3> spawnsNone;
            public List<PickupEntry> pickups;
        }

        [Serializable]
        public class PickupEntry
        {
            public string type; // "Health" | "Armor"
            public int value;   // HP or AP amount
            public float x, y, z;
        }
    }
}
