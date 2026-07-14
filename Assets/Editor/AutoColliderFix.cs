// AutoColliderFix — generic version of FortWinterColliderFix, driven live by comparing
// the currently open scene against the matching map file in the working
// UberSteam-Unity4.6.5 project, instead of hardcoded per-object entries.
//
// Root cause recap: ForgeRipper's conversion split combined map meshes into per-piece
// RENDER meshes with baked world-space vertices sitting on an identity Transform
// (correct — renders fine), but each such GameObject's Collider (MeshCollider or
// BoxCollider) keeps its OWN Transform at identity too, when it should carry the
// object's real position/rotation/scale — collision ends up stacked at/near wherever
// identity puts it, decoupled from the render mesh. Confirmed pervasive across maps
// (TheHangar alone: 224 render+collider objects, 202-208 diverge from ground truth).
//
// v3 change (WORLD-SPACE, not local): earlier versions compared/copied LOCAL transform
// values only. That broke whenever a divergent object sat under its OWN divergent
// ancestor (a pure grouping Transform with no MeshFilter/Collider, invisible to this
// scanner) — e.g. Wall_B_PHYS's grandparent container was silently offset by (45,0,0),
// and BLUE_Base's own root container was missing a 180deg Y rotation entirely. In both
// cases local-only comparison either produced a WRONG fix (an accidentally-correct local
// offset that was compensating for the broken ancestor got "corrected" into the wrong
// world position) or silently left objects broken because the ancestor itself is
// unreachable by this scanner (only render+collider objects are scanned). Confirmed
// live: multiple _PHYS objects (Ceiling_A_PHYS, Ceiling_C_PHYS, Floor_C_PHYS,
// Container_B/C_PHYS, WalkWay_A_PHYS, Windows_B_Frame_PHYS, Wall_B/C_PHYS) all have
// ground-truth LOCAL position (0,0,0) — the same "position fully delegated to parent"
// signature as Wall_B_PHYS — meaning each is likely sitting under its own independently
// broken intermediate container, not just the one under BLUE_Base.
//
// Fix: compare and set WORLD-SPACE transforms instead. Unity6's live `transform.position`
// / `.rotation` are already correct world values no matter how broken any ancestor is
// (Unity composes the live hierarchy for us) — no change needed there. The ground-truth
// side is parsed from a static file, so its world transform is computed by manually
// composing the FULL ancestor chain (position + rotation; scale is not composed since
// every scale observed in this data is (1,1,1) — flagged if that assumption ever breaks).
// The new `_Collision` child is still parented under the same live Unity6 parent for
// hierarchy tidiness, but its transform is set via world-space `.position`/`.rotation`
// setters, which makes Unity compute whatever local values are needed to land at the
// correct absolute position — this is correct regardless of whether that live parent
// chain is itself broken, fixed, or anything in between.
//
// Matches objects by full HIERARCHY PATH (name chain from scene root), NOT by Unity's
// internal fileID — UnityEditor.Unsupported.GetLocalIdentifierInFile turned out to be
// unreliable in this Unity version (100% no-match in practice) for live objects. Path
// alone is still ambiguous though: many props repeat the same name many times as
// siblings (e.g. 8+ identical "Arch_A" under one parent) — so each path segment includes
// a SIBLING INDEX (Nth same-named child in actual child order, e.g. "Arch_A#3"), computed
// identically on both the live scene (Transform.GetSiblingIndex + name scan) and the
// ground-truth file (m_Children order) — verified offline in Python first (0 ambiguous
// paths, 224/224 matched) before being ported here, after an earlier odd-count
// duplicate-handling bug caused a bad live Apply that had to be reverted via git.
//
// v4 change (SCALE): v3 through here never compared or copied scale at all — matching
// was position+rotation only, and Apply always left the new `_Collision` child at Unity's
// default localScale (1,1,1). Root-caused on ApexTwin (2026-07-09): many collider-bearing
// ground-truth objects carry heavy non-uniform scale (rocks at 0.5-0.7x, large "twins"
// rock-formation proxies at 22-55x, flat "Cube" platform proxies at 5x0.3x5) that were
// either being silently reset to (1,1,1) by Apply, or — worse — skipped as "already
// matching" whenever position/rotation happened to be correct but scale wasn't, so they
// were never even flagged as candidates. Symptom: player-reported "badly twisted"
// colliders after an otherwise-successful Apply pass. Fix: GroundTruth now also carries
// scale (leaf object's own m_LocalScale, same not-composed-through-ancestors assumption
// already used for position — verified true for ApexTwin's SniperTower2 chain), matching
// now requires position+rotation+scale to all be Close(), and Apply sets
// `collisionGO.transform.localScale` from ground truth.
//
// Run via:
//   UberStrike → Auto-Fix → Dry Run (report only, active scene)
//   UberStrike → Auto-Fix → Apply (active scene)

using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using UnityEngine;
using UnityEditor;
using UnityEngine.SceneManagement;

public static class AutoColliderFix
{
    private const string Ground465Root = @"C:\Users\Shadow\Downloads\UberSteam-Unity4.6.5\Assets\";


    private struct GroundTruth
    {
        public Vector3 worldPos;
        public Quaternion worldRot;
        // Not composed through the ancestor chain (same simplifying assumption already
        // used for position/rotation): every ancestor scale observed in this dataset is
        // (1,1,1), so the leaf object's own m_LocalScale IS its effective world scale.
        // Flag for re-check if a future map's dry-run numbers look implausible.
        public Vector3 scale;
        // How many OTHER distinct ground-truth objects share this exact world position
        // (including this one). A high count is the real, reliable signature of a shared
        // grouping-container pivot — e.g. GhostIsland's BrokenPillar/FullPillar/Cave/Tunnel2/
        // StoneRamp family (20 unrelated objects all parented under one container at
        // (0,0.28,0), each with its own baked-absolute mesh, real position encoded in vertex
        // data rather than Transform). See sharedPositionThreshold usage in FindCandidates.
        public int siblingsAtSamePosition;
    }

    private class RawTransform
    {
        public Vector3 pos;
        public Quaternion rot;
        public Vector3 scale;
        public int fatherFid;   // 0 = none
        public int gameObjectFid;
        public List<int> children = new List<int>();
    }

    private static float F(Match m, int group) => float.Parse(m.Groups[group].Value, System.Globalization.CultureInfo.InvariantCulture);

    private static Dictionary<string, GroundTruth> ParseGroundTruth(string path)
    {
        var result = new Dictionary<string, GroundTruth>();
        if (!File.Exists(path))
        {
            Debug.LogError("[AutoColliderFix] Ground-truth file not found: " + path);
            return result;
        }

        string content = File.ReadAllText(path);
        var blocks = Regex.Split(content, @"(?=^--- !u!\d+ &\d+\r?\n)", RegexOptions.Multiline);

        var goHeader = new Regex(@"^--- !u!1 &(\d+)\r?\n");
        var tfHeader = new Regex(@"^--- !u!4 &(\d+)\r?\n");
        var nameRe = new Regex(@"m_Name: (.*)");
        var posRe = new Regex(@"m_LocalPosition: \{x: ([\-0-9.eE]+), y: ([\-0-9.eE]+), z: ([\-0-9.eE]+)\}");
        var rotRe = new Regex(@"m_LocalRotation: \{x: ([\-0-9.eE]+), y: ([\-0-9.eE]+), z: ([\-0-9.eE]+), w: ([\-0-9.eE]+)\}");
        var scaleRe = new Regex(@"m_LocalScale: \{x: ([\-0-9.eE]+), y: ([\-0-9.eE]+), z: ([\-0-9.eE]+)\}");
        var fatherRe = new Regex(@"m_Father: \{fileID: (\d+)\}");
        var goRef = new Regex(@"m_GameObject: \{fileID: (\d+)\}");
        var childrenBlockRe = new Regex(@"m_Children:\s*\r?\n((?:\s*-\s*\{fileID: \d+\}\s*\r?\n?)*)");
        var childFidRe = new Regex(@"\{fileID: (\d+)\}");

        var gameObjectNames = new Dictionary<int, string>();
        var rawTransforms = new Dictionary<int, RawTransform>();

        foreach (var b in blocks)
        {
            var gm = goHeader.Match(b);
            if (gm.Success)
            {
                int fid = int.Parse(gm.Groups[1].Value);
                var nm = nameRe.Match(b);
                gameObjectNames[fid] = nm.Success ? nm.Groups[1].Value.Trim() : "";
                continue;
            }
            var tm = tfHeader.Match(b);
            if (tm.Success)
            {
                int fid = int.Parse(tm.Groups[1].Value);
                var pm = posRe.Match(b);
                var rm = rotRe.Match(b);
                var sm = scaleRe.Match(b);
                var fm = fatherRe.Match(b);
                var gr = goRef.Match(b);
                var raw = new RawTransform
                {
                    pos = pm.Success ? new Vector3(F(pm, 1), F(pm, 2), F(pm, 3)) : Vector3.zero,
                    rot = rm.Success ? new Quaternion(F(rm, 1), F(rm, 2), F(rm, 3), F(rm, 4)) : Quaternion.identity,
                    scale = sm.Success ? new Vector3(F(sm, 1), F(sm, 2), F(sm, 3)) : Vector3.one,
                    fatherFid = fm.Success ? int.Parse(fm.Groups[1].Value) : 0,
                    gameObjectFid = gr.Success ? int.Parse(gr.Groups[1].Value) : 0,
                };
                var cb = childrenBlockRe.Match(b);
                if (cb.Success)
                {
                    foreach (Match cm in childFidRe.Matches(cb.Groups[1].Value))
                        raw.children.Add(int.Parse(cm.Groups[1].Value));
                }
                rawTransforms[fid] = raw;
            }
        }

        // Sibling index: Nth same-named child in actual m_Children order (0-based).
        var siblingIndex = new Dictionary<int, int>();
        foreach (var kvp in rawTransforms)
        {
            int tfFid = kvp.Key;
            var t = kvp.Value;
            if (t.fatherFid == 0 || !rawTransforms.TryGetValue(t.fatherFid, out var parent))
            {
                siblingIndex[tfFid] = 0;
                continue;
            }
            string myName = gameObjectNames.TryGetValue(t.gameObjectFid, out var n) ? n : "?";
            int count = 0;
            foreach (var childFid in parent.children)
            {
                if (childFid == tfFid) break;
                if (rawTransforms.TryGetValue(childFid, out var childT))
                {
                    string childName = gameObjectNames.TryGetValue(childT.gameObjectFid, out var cn) ? cn : "?";
                    if (childName == myName) count++;
                }
            }
            siblingIndex[tfFid] = count;
        }

        string BuildPath(int tfFid, int depth)
        {
            if (depth > 64 || !rawTransforms.TryGetValue(tfFid, out var t)) return "";
            string myName = gameObjectNames.TryGetValue(t.gameObjectFid, out var n) ? n : ("<unnamed:" + tfFid + ">");
            int idx = siblingIndex.TryGetValue(tfFid, out var si) ? si : 0;
            string label = idx == 0 ? myName : (myName + "#" + idx);
            if (t.fatherFid != 0)
            {
                string parentPath = BuildPath(t.fatherFid, depth + 1);
                return string.IsNullOrEmpty(parentPath) ? label : parentPath + "/" + label;
            }
            return label;
        }

        // World transform = full composition of local pos/rot up the entire ancestor
        // chain. Scale is intentionally NOT composed into position (every m_LocalScale
        // observed in this dataset is (1,1,1); if that ever changes for a map, this will
        // silently under/over-scale offsets — worth re-checking if a future map's dry
        // run numbers look implausible).
        var worldCache = new Dictionary<int, (Vector3 pos, Quaternion rot)>();
        (Vector3 pos, Quaternion rot) BuildWorld(int tfFid, int depth)
        {
            if (worldCache.TryGetValue(tfFid, out var cached)) return cached;
            if (depth > 64 || !rawTransforms.TryGetValue(tfFid, out var t))
                return (Vector3.zero, Quaternion.identity);

            (Vector3 pos, Quaternion rot) result;
            if (t.fatherFid == 0)
            {
                result = (t.pos, t.rot);
            }
            else
            {
                var parentWorld = BuildWorld(t.fatherFid, depth + 1);
                result = (parentWorld.pos + parentWorld.rot * t.pos, parentWorld.rot * t.rot);
            }
            worldCache[tfFid] = result;
            return result;
        }

        var seenOnce = new HashSet<string>();
        var ambiguous = new HashSet<string>();
        foreach (var kvp in rawTransforms)
        {
            string objPath = BuildPath(kvp.Key, 0);
            if (!seenOnce.Add(objPath)) ambiguous.Add(objPath); // permanently flags true dupes, any count
        }
        var fatherFidByPath = new Dictionary<string, int>();
        foreach (var kvp in rawTransforms)
        {
            string objPath = BuildPath(kvp.Key, 0);
            if (ambiguous.Contains(objPath)) continue; // never insert — stays excluded regardless of count
            var world = BuildWorld(kvp.Key, 0);
            result[objPath] = new GroundTruth { worldPos = world.pos, worldRot = world.rot, scale = kvp.Value.scale };
            fatherFidByPath[objPath] = kvp.Value.fatherFid;
        }
        if (ambiguous.Count > 0)
            Debug.LogWarning("[AutoColliderFix] " + ambiguous.Count + " still-ambiguous paths even with sibling indexing (skipped, not fixed): " + string.Join(", ", ambiguous));

        // Second pass: count how many TRUE SIBLINGS (same immediate parent) share the exact
        // same world position. Rounded to 3 decimals so float noise doesn't split what's
        // really one shared point.
        //
        // v15 fix: previously keyed by position ALONE, which meant a parent object counting
        // its own descendants (nested at local (0,0,0) all the way down — e.g. a "pad"
        // container whose child render mesh and grandchild particle effects all compose to
        // the exact same world position as the parent itself) inflated the count exactly
        // like a real shared-container pivot would, even though an ancestor/descendant
        // chain is a completely different shape from unrelated siblings collapsed onto one
        // point. Root-caused on SpacePortAlpha (2026-07-10): 3 of 7 jumpPads were silently
        // excluded because each "jumpPad" object's own descendants (render mesh child,
        // particle grandchildren under a "JumpPad" child) shared its exact position, and
        // that position also happened to be small in magnitude (v12's other signal), so
        // both conditions coincidentally matched a "skip" — even though this is nothing
        // like GhostIsland's tombstone cluster (~20 genuinely distinct, unrelated props
        // sharing one external container's pivot). Fix: only count objects that share the
        // SAME IMMEDIATE PARENT — an ancestor/descendant chain can never inflate this count,
        // since each link in the chain has a different father than the one above/below it.
        var positionCounts = new Dictionary<string, int>();
        string PosKey(int fatherFid, Vector3 p) => fatherFid + "|" + string.Format("{0:F3}|{1:F3}|{2:F3}", p.x, p.y, p.z);
        foreach (var kvp in result)
        {
            string key = PosKey(fatherFidByPath[kvp.Key], kvp.Value.worldPos);
            positionCounts.TryGetValue(key, out int count);
            positionCounts[key] = count + 1;
        }
        var keys = new List<string>(result.Keys);
        foreach (var k in keys)
        {
            var gt = result[k];
            gt.siblingsAtSamePosition = positionCounts[PosKey(fatherFidByPath[k], gt.worldPos)];
            result[k] = gt;
        }

        return result;
    }

    private static string GetLivePath(Transform t)
    {
        var labels = new List<string>();
        var cur = t;
        while (cur != null)
        {
            int idx = 0;
            var parent = cur.parent;
            if (parent != null)
            {
                int mySibling = cur.GetSiblingIndex();
                for (int i = 0; i < mySibling; i++)
                {
                    if (parent.GetChild(i).name == cur.name) idx++;
                }
            }
            labels.Add(idx == 0 ? cur.name : (cur.name + "#" + idx));
            cur = parent;
        }
        labels.Reverse();
        return string.Join("/", labels);
    }

    private static string ResolveGroundTruthPath()
    {
        string scenePath = SceneManager.GetActiveScene().path; // e.g. Assets/ArtTools/Maps/thehangar/TheHangar.unity
        if (string.IsNullOrEmpty(scenePath))
        {
            Debug.LogError("[AutoColliderFix] Active scene has no path (unsaved?) — open the map's .unity asset directly.");
            return null;
        }
        string relative = scenePath.StartsWith("Assets/") ? scenePath.Substring("Assets/".Length) : scenePath;
        return Ground465Root + relative.Replace('/', Path.DirectorySeparatorChar);
    }

    private static bool Close(Vector3 a, Vector3 b, float eps = 1e-3f) =>
        Mathf.Abs(a.x - b.x) < eps && Mathf.Abs(a.y - b.y) < eps && Mathf.Abs(a.z - b.z) < eps;

    private static bool Close(Quaternion a, Quaternion b, float eps = 1e-3f) =>
        Mathf.Abs(Quaternion.Dot(a, b)) > 1f - eps;

    private struct Candidate
    {
        public GameObject go;
        public Component collider; // MeshCollider or BoxCollider
        public GroundTruth gt;
        // true only for a genuine leaf collision-only proxy (no MeshFilter of its own AND no
        // children at all) — safe to move its Transform directly. Anything else (has a
        // MeshFilter, OR has children that could be dragged along) must be decoupled instead.
        public bool safeInPlace;
        // v14: true when this object has children (so !safeInPlace) AND carries an attached
        // MonoBehaviour — decoupling would create a correctly-positioned CLONE of the collider
        // while leaving the original script (and whatever it reads via GetComponent on this
        // same GameObject) stuck at the broken position, or fail outright if the script
        // RequireComponents the very collider Apply is trying to destroy. Root-caused on
        // Catalyst's "jumpPad" (2026-07-10): ForceField has [RequireComponent(typeof(BoxCollider))]
        // and reads base.transform.position directly for both the launch force and its SFX
        // origin, so DestroyImmediate on the original BoxCollider failed for all 10 jumpPad/
        // AcceleratorPad candidates ("Can't remove BoxCollider because ForceField (Script)
        // depends on it") — Apply still reported them as fixed since Unity logs that failure
        // internally rather than throwing a catchable exception. These objects instead need
        // "detach children (preserving world position) → move this object in place → reattach
        // children" — repositions the script/collider/audio source correctly without ever
        // touching the render mesh children at all.
        public bool detachAndMove;
    }

    private static List<Candidate> FindCandidates(Dictionary<string, GroundTruth> groundTruth, out int scanned, out int noGroundTruth)
    {
        var candidates = new List<Candidate>();
        scanned = 0;
        noGroundTruth = 0;

        var allTransforms = UnityEngine.Object.FindObjectsByType<Transform>(FindObjectsInactive.Include, FindObjectsSortMode.None);
        foreach (var t in allTransforms)
        {
            var go = t.gameObject;
            // v5 change: previously required a MeshFilter on the same object ("only
            // render+collider objects are in scope for this bug") — wrong assumption.
            // Pure collision-only proxy objects (pillars, walls — no visual mesh at all)
            // can be just as broken and were completely invisible to every prior scan.
            // Root-caused on ApexTwin: a whole wooden-tower collision skeleton
            // (hPillar/vPillar/upperwall1/front) sat consistently misrotated, never once
            // flagged. No MeshFilter requirement anymore — any Collider is in scope.
            var mf = go.GetComponent<MeshFilter>();

            // v7 change: "no MeshFilter" alone isn't enough to know it's safe to move a
            // Transform directly. Root-caused on Catalyst: "jumpPad" (a BoxCollider, no
            // MeshFilter of its own) is a PARENT CONTAINER — its child "JumpPad" carries the
            // actual visible ramp mesh. Fixing "jumpPad" in place correctly repositioned the
            // trigger box, but as an ordinary side effect of Unity's Transform hierarchy it
            // also dragged "JumpPad" (and its baked-absolute-vertex render mesh, which was
            // only rendering correctly because its ancestor chain was at identity) down to
            // the same low, recessed ground-truth position — reported as jump
            // pads/accelerator pads ending up "way underneath the map, floating in the
            // void." A leaf with zero children is safe to move directly; anything with
            // children is not, regardless of whether it has a MeshFilter itself.
            bool safeInPlace = mf == null && t.childCount == 0;

            // v14 change: see Candidate.detachAndMove comment — an attached script changes
            // which repositioning strategy is safe when this object also has children.
            bool detachAndMove = !safeInPlace && go.GetComponent<MonoBehaviour>() != null;

            // v13 change: previously picked only ONE collider per object
            // (`GetComponent<MeshCollider>() ?? GetComponent<BoxCollider>()`) — if an object
            // had both, the second was completely invisible to every prior scan. Root-caused
            // on TempleOfTheRaven's MainWall (2026-07-10): its MeshCollider got correctly
            // decoupled by the v12 fix, but its separate BoxCollider (m_Center (151.55, 2.5, 0)
            // — a real second collision volume, not a utility leftover) stayed on the original
            // GameObject, whose Transform is still broken, leaving a small stray box floating
            // outside the map. Fix: collect every collider on the object, not just the first
            // found — each gets its own Candidate against the same ground-truth Transform.
            var colliders = new List<Component>();
            var meshCollider = go.GetComponent<MeshCollider>();
            if (meshCollider != null) colliders.Add(meshCollider);
            var boxCollider = go.GetComponent<BoxCollider>();
            if (boxCollider != null) colliders.Add(boxCollider);
            if (colliders.Count == 0) continue;

            scanned++;
            string path = GetLivePath(t);
            if (!groundTruth.TryGetValue(path, out var gt))
            {
                noGroundTruth++;
                continue;
            }

            // v9 change (replaces v8's flawed magnitude-based check entirely — see git
            // history if the old approach is ever needed for reference): a MeshCollider
            // whose mesh has baked-absolute vertex data must NEVER be repositioned via
            // Transform, since it's already sitting at its correct world location regardless
            // of Transform. Root-caused on GhostIsland in two rounds:
            //   1. ~20 unrelated objects (BrokenPillar1-10, FullPillar1-7, Cave, Tunnel2,
            //      StoneRamp) all shared one ground-truth position (a shared container's
            //      pivot) — real signature of "Transform is just a grouping node, true
            //      position is baked into vertex data."
            //   2. v8 tried to detect this via "collider mesh bounds center far from local
            //      origin" — seemed to work (RockLarge1 exactly (0,0,0) vs BrokenPillar1
            //      ~19.6) until it silently misfired on a WHOLE OTHER map area: Tombstones5/
            //      6/7/10/11 have large, legitimate off-center mesh pivots (magnitude 7-20,
            //      nothing to do with being baked-absolute) and got wrongly excluded,
            //      leaving them unfixed — reported back as "player passed through the
            //      tombstones" after an Apply that looked clean in Dry Run. Meanwhile
            //      Tombstones8/9 (small pivot offset) survived the same flawed check by
            //      coincidence and got fixed correctly, muddying the signal further.
            // The actual reliable signal was in front of us the whole time: MANY DISTINCT
            // ground-truth objects sharing the EXACT SAME world position (computed in
            // ParseGroundTruth as siblingsAtSamePosition) is what a shared-container pivot
            // looks like — Tombstones5-11 each have their OWN distinct position, so this
            // correctly leaves every one of them as a real candidate regardless of their
            // mesh's local pivot offset.
            // v12 fix: root-caused on TempleOfTheRaven's SecretTemple room (2026-07-10).
            // v9's siblingsAtSamePosition >= 3 check skipped UNCONDITIONALLY, before ever
            // comparing against the live Transform — correct for GhostIsland (where the
            // shared ground-truth position really is just a near-zero pivot marker, e.g.
            // BrokenPillar1/FullPillar1's shared (0, 0.277, 0), with each mesh's own large
            // local AABB offset supplying the true position), but wrong for SecretTemple:
            // 7 siblings (Lights1/2, MainWall, Pillars, Rocks1-3) share ground-truth WORLD
            // position (-151.54, -55.74, 0.81) — NOT a negligible pivot, a real, load-bearing
            // offset. Composing that with MainWall's own mesh AABB offset (151.55, 21.92, 0)
            // lands it correctly inside the room (~0.01, -33.82, 0.81, matching Cube/
            // TeleporterParticles); at identity Transform alone (what v9's skip left it at)
            // it sits ~165 units away at nothing — exactly the reported fall-through.
            // Distinguishing signal: is the SHARED ground-truth world position itself close
            // to the origin (a true pivot marker, mesh data does all the work) or a real,
            // non-trivial offset (Transform composition is load-bearing and must be applied)?
            if (gt.siblingsAtSamePosition >= 3 && gt.worldPos.magnitude < 5f)
            {
                continue;
            }

            // WORLD-space comparison: t.position/t.rotation are Unity's own live
            // composition, correct regardless of whether any ancestor is broken.
            // Scale is compared as local scale (see GroundTruth.scale comment) — catches
            // objects whose position/rotation are already correct but whose collider
            // shape is still wrong (e.g. a rock collider left at the Unity default (1,1,1)
            // instead of its real, often heavily non-uniform, ground-truth scale).
            bool matches = Close(t.position, gt.worldPos) && Close(t.rotation, gt.worldRot) && Close(t.localScale, gt.scale);
            if (matches) continue; // already correct — per tonight's lesson, don't touch matching objects

            foreach (var collider in colliders)
                candidates.Add(new Candidate { go = go, collider = collider, gt = gt, safeInPlace = safeInPlace, detachAndMove = detachAndMove });
        }
        return candidates;
    }

    [MenuItem("UberStrike/Auto-Fix/Dry Run (report only, active scene)")]
    public static void DryRun()
    {
        string gtPath = ResolveGroundTruthPath();
        if (gtPath == null) return;
        var groundTruth = ParseGroundTruth(gtPath);
        if (groundTruth.Count == 0) return;

        var candidates = FindCandidates(groundTruth, out int scanned, out int noGroundTruth);

        Debug.Log(string.Format(
            "[AutoColliderFix] DRY RUN (world-space) vs {0}\nScanned {1} collider objects (render+collider and collision-only), {2} had no ground-truth match, {3} DIVERGE from ground truth (would be fixed):",
            gtPath, scanned, noGroundTruth, candidates.Count));
        foreach (var c in candidates)
        {
            string kind = c.safeInPlace ? "collision-only leaf, fix in place"
                : c.detachAndMove ? "has script, detach children + move in place"
                : "decouple to new child";
            Debug.Log(string.Format("  {0} ({1}, {2}) current WORLD pos={3} scale={4} -> ground truth WORLD pos={5} scale={6}",
                c.go.name, c.collider.GetType().Name, kind, c.go.transform.position, c.go.transform.localScale, c.gt.worldPos, c.gt.scale));
        }
        Debug.Log("[AutoColliderFix] Dry run complete — nothing changed. Run Apply when ready.");
    }

    [MenuItem("UberStrike/Auto-Fix/Apply (active scene)")]
    public static void Apply()
    {
        string gtPath = ResolveGroundTruthPath();
        if (gtPath == null) return;
        var groundTruth = ParseGroundTruth(gtPath);
        if (groundTruth.Count == 0) return;

        var candidates = FindCandidates(groundTruth, out int scanned, out int noGroundTruth);
        int fixedCount = 0, failed = 0;

        // v6 change: two explicit passes (all in-place fixes, then all decouples), not one
        // intermixed loop — guards against any remaining ordering sensitivity between
        // candidates that share a live parent/child relationship, now that v7 (below)
        // handles the actual root cause of the Catalyst jump-pad regression this was
        // originally written to fix. Cheap to keep, no downside.
        //
        // v7 is the real fix for "jump pads/accelerator pads ending up way underneath the
        // map, floating in the void": `safeInPlace` (see FindCandidates) now requires zero
        // children, not just "no MeshFilter of its own" — "jumpPad" has no MeshFilter but
        // DOES have a child ("JumpPad", the actual visible ramp mesh), so moving jumpPad's
        // Transform directly dragged its child mesh down to the same recessed position via
        // ordinary Unity hierarchy inheritance. Anything with children now always goes
        // through the decouple path instead, leaving its Transform (and everything nested
        // under it) completely untouched.
        var inPlaceCandidates = new List<Candidate>();
        var detachMoveCandidates = new List<Candidate>();
        var decoupleCandidates = new List<Candidate>();
        foreach (var c in candidates)
        {
            if (c.safeInPlace) inPlaceCandidates.Add(c);
            else if (c.detachAndMove) detachMoveCandidates.Add(c);
            else decoupleCandidates.Add(c);
        }

        // v14: see Candidate.detachAndMove comment. This object has children (so a plain
        // in-place move would drag them along) but ALSO carries a script that needs to stay
        // attached to a collider positioned exactly where the ground truth says — decoupling
        // to a new sibling either fails outright (RequireComponent blocks destroying the
        // original collider) or silently orphans the script from the fix. Detaching every
        // child first (worldPositionStays=true preserves their current, already-correct
        // world placement), moving this now-childless object directly, then reattaching the
        // children (again worldPositionStays=true) repositions the script/collider/whatever
        // else lives here without ever touching the render mesh children's actual position.
        foreach (var c in detachMoveCandidates)
        {
            try
            {
                var go = c.go;
                var t = go.transform;
                var originalParent = t.parent;
                var children = new List<Transform>();
                for (int i = 0; i < t.childCount; i++) children.Add(t.GetChild(i));

                foreach (var child in children)
                    child.SetParent(originalParent, true);

                t.position = c.gt.worldPos;
                t.rotation = c.gt.worldRot;
                t.localScale = c.gt.scale;

                foreach (var child in children)
                    child.SetParent(t, true);

                EditorUtility.SetDirty(go);
                fixedCount++;
            }
            catch (Exception ex)
            {
                Debug.LogError("[AutoColliderFix] Failed to fix " + c.go.name + ": " + ex.Message);
                failed++;
            }
        }

        foreach (var c in inPlaceCandidates)
        {
            try
            {
                var go = c.go;
                // Collision-only proxy (pillar/wall/etc, no render mesh riding on the
                // same Transform) — nothing to decouple from, nothing at risk of being
                // visually displaced. Fix the Transform directly in place.
                go.transform.position = c.gt.worldPos;
                go.transform.rotation = c.gt.worldRot;
                go.transform.localScale = c.gt.scale;
                EditorUtility.SetDirty(go);
                fixedCount++;
            }
            catch (Exception ex)
            {
                Debug.LogError("[AutoColliderFix] Failed to fix " + c.go.name + ": " + ex.Message);
                failed++;
            }
        }

        foreach (var c in decoupleCandidates)
        {
            try
            {
                var go = c.go;
                Transform parent = go.transform.parent;

                // v10 guard (fixed in v11 — see below): root-caused on GhostIsland — an
                // object can end up as a candidate again on a LATER Dry Run even though a
                // "<name>_Collision" sibling from an earlier Apply already exists for it.
                // Re-running the naive create-new-child logic in that state would produce a
                // SECOND, redundant "<name>_Collision" sibling — two overlapping trigger
                // volumes risk double-firing whatever OnTriggerEnter logic the object drives.
                //
                // v11 fix: v10's guard matched an existing "<name>_Collision" sibling by NAME
                // ONLY, with no position check. Root-caused on Volley (2026-07-10): dozens of
                // wall pieces legitimately share the same base name ("Wall_A_4" etc, a
                // repeated modular piece) at DIFFERENT positions. The first Wall_A_4 processed
                // created "Wall_A_4_Collision" correctly — every OTHER Wall_A_4 instance then
                // matched that SAME sibling by name, got treated as "already handled," and had
                // its own stale collider destroyed with NOTHING created to replace it. Only 3
                // of 46 diverging objects ended up with real collision (one per distinct base
                // name), the rest lost their collider entirely — worse than before the fix,
                // and exactly matches "player passes through the walls." Very likely the same
                // root cause behind MonkeyIsland's "RaidMiniCrateFix pass-through" report
                // (~60 same-named instances at different positions, fixed while v10 was
                // active). Fix: an existing same-named sibling only counts as "already
                // handled" if it's ALSO already sitting at (approximately) this candidate's
                // ground-truth target position — otherwise it belongs to a different instance
                // of the same repeated piece, and a genuinely new collision object is needed.
                // v13: disambiguate by collider type so an object with both a MeshCollider
                // and a BoxCollider gets two distinct decoupled children (not a name clash),
                // and the v11 "already handled" guard below matches the right one.
                string collisionName = go.name + (c.collider is BoxCollider ? "_Collision_Box" : "_Collision");
                Transform existingCollisionChild = null;
                if (parent != null)
                {
                    for (int i = 0; i < parent.childCount; i++)
                    {
                        var child = parent.GetChild(i);
                        if (child.name == collisionName && Close(child.position, c.gt.worldPos))
                        {
                            existingCollisionChild = child;
                            break;
                        }
                    }
                }

                if (existingCollisionChild != null)
                {
                    UnityEngine.Object.DestroyImmediate(c.collider);
                    EditorUtility.SetDirty(go);
                    fixedCount++;
                    continue;
                }

                var collisionGO = new GameObject(collisionName);
                collisionGO.layer = go.layer;
                collisionGO.transform.SetParent(parent, false);
                // World-space setters: Unity computes whatever local values are needed
                // under the current parent to land at this exact absolute transform,
                // regardless of whether that parent chain is itself broken or fixed.
                collisionGO.transform.position = c.gt.worldPos;
                collisionGO.transform.rotation = c.gt.worldRot;
                collisionGO.transform.localScale = c.gt.scale;

                if (c.collider is MeshCollider mc)
                {
                    var newMc = collisionGO.AddComponent<MeshCollider>();
                    newMc.sharedMesh = mc.sharedMesh;
                    newMc.convex = mc.convex;
                    newMc.sharedMaterial = mc.sharedMaterial;
                    newMc.isTrigger = mc.isTrigger;
                }
                else if (c.collider is BoxCollider bc)
                {
                    var newBc = collisionGO.AddComponent<BoxCollider>();
                    newBc.size = bc.size;
                    newBc.center = bc.center;
                    newBc.isTrigger = bc.isTrigger;
                    newBc.sharedMaterial = bc.sharedMaterial;
                }

                UnityEngine.Object.DestroyImmediate(c.collider);
                GameObjectUtility.SetStaticEditorFlags(collisionGO, StaticEditorFlags.NavigationStatic);
                EditorUtility.SetDirty(go);
                EditorUtility.SetDirty(collisionGO);
                fixedCount++;
            }
            catch (Exception ex)
            {
                Debug.LogError("[AutoColliderFix] Failed to fix " + c.go.name + ": " + ex.Message);
                failed++;
            }
        }

        Debug.Log(string.Format(
            "[AutoColliderFix] APPLY complete (world-space) vs {0}\nScanned={1} noGroundTruth={2} fixed={3} failed={4}. " +
            "SAVE THE SCENE (Ctrl+S), then test.",
            gtPath, scanned, noGroundTruth, fixedCount, failed));
    }
}
