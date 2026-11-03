// BotsNavMeshExporter — Phase 7 spike: export a REAL baked Unity NavMesh
// triangulation, to replace the synthetic 2D heightmap grid BotsMapGeometry-
// Exporter produces.
//
// ── Why this exists ─────────────────────────────────────────────────────
// The server-side bot pathfinder (MapGeometry.cs) samples one Y per 1m XZ
// cell via raycast and gates connectivity/pathing on a per-edge MaxStepHeight
// (2.5m). That's a lossy proxy: it can't tell a real staircase from a
// decorative rooftop edge that happens to present similarly-shaped small Y
// jumps at 1m sampling resolution. Confirmed via live FortWinter testing
// 2026-07-06 — bots kept reaching an unreachable rooftop; tuning the step-
// height threshold either let it back in or collapsed connectivity across
// the whole map.
//
// Compared against the 4.3.8 client's WORKING bot navigation
// (uber-client-4-3-8-unity_2022-bots-integration — read-only reference, not
// touched by this script) — it uses a real baked Unity NavMesh, with
// FortWinter's actual bake settings (confirmed identical across all 15
// scenes checked in that project):
//   agentRadius: 0.5   agentHeight: 2   agentSlope: 45   agentClimb: 0.4
// agentClimb=0.4m is the key value: real per-triangle mesh slope/step
// analysis, not a coarse grid heuristic. This exporter bakes and exports
// THAT ground-truth data so the server can eventually sample it directly
// instead of the synthetic heightmap.
//
// ── Scope of this spike ─────────────────────────────────────────────────
// Phase 1 only: bake + export the triangulation for validation. Does NOT
// touch BotsMapGeometryExporter.cs or any server-side code. Output is a
// SEPARATE file (<MapName>_navmesh.json) so it can be inspected without
// affecting the currently-running bot geometry at all.
//
// Run via  UberStrike → Server Bots → Export NavMesh (active scene)

using System;
using System.Globalization;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;

namespace UberStrike.Editor.Bots
{
    public static class BotsNavMeshExporter
    {
        // Matches the 4.3.8 client's proven FortWinter bake settings —
        // confirmed identical across all 15 scenes checked in that project
        // (AqualabResearchHub, CuberSpace, CuberStrike, FortWinter,
        // GideonsTower, LostParadise2, MonkeyIsland, SkyGarden,
        // SpaceportAlpha, Spaceship, SuperPRISMReactor, TempleOfTheRaven,
        // TheBunker, TheWarehouse, QuakeDm6) — a single project-wide
        // default, never customized per-map.
        private const float AgentRadius = 0.5f;
        private const float AgentHeight = 2f;
        private const float AgentSlope  = 45f;
        private const float AgentClimb  = 0.4f;

        private const string ServerCopyPath =
            @"C:\Users\Shadow\Downloads\UBZ-server-bots\server\UberServer-v4.8.6\maps_geometry";

        [MenuItem("UberStrike/Server Bots/Export NavMesh (active scene)")]
        public static void ExportActiveSceneNavMesh()
        {
            string scenePath = EditorApplication.currentScene;
            if (string.IsNullOrEmpty(scenePath))
            {
                Debug.LogError("[BotsNavMesh] No active scene to export. Open a map scene first.");
                return;
            }
            string sceneName = Path.GetFileNameWithoutExtension(scenePath);
            ExportCurrent(sceneName);
        }

        // Batch-mode entry point: -batchmode -executeMethod
        // UberStrike.Editor.Bots.BotsNavMeshExporter.ExportFortWinterBatch
        // Opens the scene explicitly (nothing is "active" in batch mode),
        // exports, then exits so the process doesn't hang.
        public static void ExportFortWinterBatch()
        {
            const string scenePath = "Assets/ArtTools/Maps/fortwinter/FortWinter.unity";
            try
            {
                if (!EditorApplication.OpenScene(scenePath))
                {
                    Debug.LogError("[BotsNavMesh] Batch: could not open " + scenePath);
                    EditorApplication.Exit(1);
                    return;
                }
                ExportCurrent("FortWinter");
                EditorApplication.Exit(0);
            }
            catch (Exception ex)
            {
                Debug.LogError("[BotsNavMesh] Batch export failed: " + ex.Message + "\n" + ex.StackTrace);
                EditorApplication.Exit(1);
            }
        }

        private static void ExportCurrent(string sceneName)
        {
            Debug.Log(string.Format(
                "[BotsNavMesh] Baking '{0}' — agentRadius={1} agentHeight={2} agentSlope={3} agentClimb={4}",
                sceneName, AgentRadius, AgentHeight, AgentSlope, AgentClimb));

            // Unity 4.6.5's NavMeshBuilder.BuildNavMesh() takes no arguments
            // — it bakes using whatever's already configured in the scene's
            // NavMesh window (m_BuildSettings), which we confirmed already
            // matches AgentRadius/Height/Slope/Climb above.
            try
            {
                NavMeshBuilder.BuildNavMesh();
            }
            catch (Exception ex)
            {
                Debug.LogError("[BotsNavMesh] Bake failed for " + sceneName + ": " + ex.Message + "\n" + ex.StackTrace);
                return;
            }

            var tri = NavMesh.CalculateTriangulation();
            if (tri.vertices == null || tri.vertices.Length == 0)
            {
                Debug.LogError("[BotsNavMesh] " + sceneName +
                    ": bake produced an EMPTY triangulation (0 vertices). " +
                    "Check the scene actually has walkable geometry / the bake settings above.");
                return;
            }

            string json = ToJson(sceneName, tri);

            string fileBase = sceneName.StartsWith("Level") ? sceneName.Substring("Level".Length) : sceneName;

            string streamingDir = Path.Combine(Application.streamingAssetsPath, "BotsGeometry");
            Directory.CreateDirectory(streamingDir);
            string streamingPath = Path.Combine(streamingDir, fileBase + "_navmesh.json");
            File.WriteAllText(streamingPath, json);

            string serverDir = Environment.GetEnvironmentVariable("BOTS_GEOMETRY_DIR");
            if (string.IsNullOrEmpty(serverDir)) serverDir = ServerCopyPath;
            string serverPath = null;
            try
            {
                Directory.CreateDirectory(serverDir);
                serverPath = Path.Combine(serverDir, fileBase + "_navmesh.json");
                File.WriteAllText(serverPath, json);
            }
            catch (Exception ex)
            {
                Debug.LogWarning("[BotsNavMesh] Server copy failed (" + serverDir + "): " + ex.Message);
            }

            Debug.Log(string.Format(
                "[BotsNavMesh] {0}: {1} vertices, {2} triangles | {3} KB -> {4}{5}",
                sceneName, tri.vertices.Length, tri.indices.Length / 3,
                json.Length / 1024, streamingPath,
                serverPath != null ? " (+ " + serverPath + ")" : ""));

            AssetDatabase.Refresh();
        }

        // ── JSON serialization (hand-rolled, matches BotsMapGeometryExporter
        // conventions — no JsonUtility support for this shape in 4.6.5,
        // InvariantCulture so the German-locale host doesn't emit commas) ──

        private static string ToJson(string sceneName, NavMeshTriangulation tri)
        {
            var sb = new StringBuilder(tri.vertices.Length * 24 + tri.indices.Length * 8 + 256);
            sb.Append('{');
            sb.Append("\"version\":1");
            sb.Append(",\"sceneName\":").Append(Quote(sceneName));
            sb.Append(",\"agentRadius\":").Append(F(AgentRadius));
            sb.Append(",\"agentHeight\":").Append(F(AgentHeight));
            sb.Append(",\"agentSlope\":").Append(F(AgentSlope));
            sb.Append(",\"agentClimb\":").Append(F(AgentClimb));

            sb.Append(",\"vertices\":[");
            for (int i = 0; i < tri.vertices.Length; i++)
            {
                if (i > 0) sb.Append(',');
                var v = tri.vertices[i];
                sb.Append("{\"x\":").Append(F(v.x));
                sb.Append(",\"y\":").Append(F(v.y));
                sb.Append(",\"z\":").Append(F(v.z));
                sb.Append('}');
            }
            sb.Append(']');

            sb.Append(",\"triangles\":[");
            for (int i = 0; i < tri.indices.Length; i++)
            {
                if (i > 0) sb.Append(',');
                sb.Append(tri.indices[i]);
            }
            sb.Append(']');

            sb.Append('}');
            return sb.ToString();
        }

        private static string F(float v)
        {
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
                else sb.Append(c);
            }
            sb.Append('"');
            return sb.ToString();
        }
    }
}
