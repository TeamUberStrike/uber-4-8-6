// FortWinterColliderFix — decouples collision from the ForgeRipper-converted render
// objects for the 3 confirmed-broken wall pieces (WallSnow, WallRock, WallSmallDoor).
//
// Root cause (verified against the working UberSteam-Unity4.6.5 project): ForgeRipper's
// conversion split the map's original combined/batched mesh into per-piece render
// meshes with BAKED WORLD-SPACE vertices (Assets/Mesh/SplitMeshes/split_*.asset) sitting
// on an identity transform — correct, that's why the map renders fine. But each such
// GameObject's MeshCollider was wired to a SEPARATE, ORIGINAL local-space mesh asset
// (e.g. Assets/Mesh/WallSnow.asset) that was never given a real transform, so its
// collision geometry sits stacked at/near world origin instead of the wall's real
// position — invisible obstacles + phantom ceilings with no visual correlation.
//
// Fix: remove the mismatched MeshCollider from the render object (its identity
// transform must stay untouched, or the correctly-baked render mesh would move), and
// add a dedicated collision-only child object — same convention as the map's existing
// hand-placed BaseCollider/Cube_Fix system — carrying the SAME (correct) local-space
// collision mesh, positioned at the real value recovered from the working 4.6.5 project.
//
// Run via  UberStrike → Fix - Decouple + Reposition Wall Colliders (active scene)

using UnityEngine;
using UnityEditor;

public static class FortWinterColliderFix
{
    private struct FixEntry
    {
        public string objectName;
        public Vector3 correctLocalPosition; // relative to the SAME parent as the original object

        public FixEntry(string name, float x, float y, float z)
        {
            objectName = name;
            correctLocalPosition = new Vector3(x, y, z);
        }
    }

    // Values recovered directly from UberSteam-Unity4.6.5's FortWinter.unity (same
    // fileID scheme, same parent chain — only this project's m_LocalPosition was zeroed).
    private static readonly FixEntry[] Fixes = new FixEntry[]
    {
        new FixEntry("WallSnow",      -18.4574242f, -1.27502406f, -11.1657791f),
        new FixEntry("WallRock",      -18.4574242f, -1.27502406f, -11.1657791f),
        new FixEntry("WallSmallDoor", -21.4492569f,  5.27359104f,   2.55042863f),
    };

    [MenuItem("UberStrike/Fix - Decouple + Reposition Wall Colliders (active scene)")]
    public static void FixWallColliders()
    {
        int fixedCount = 0, skipped = 0;

        foreach (var entry in Fixes)
        {
            var go = GameObject.Find(entry.objectName);
            if (go == null)
            {
                Debug.LogWarning("[FortWinterColliderFix] GameObject not found: " + entry.objectName);
                skipped++;
                continue;
            }

            var existingCollider = go.GetComponent<MeshCollider>();
            if (existingCollider == null)
            {
                Debug.LogWarning("[FortWinterColliderFix] No MeshCollider on " + entry.objectName +
                    " — already fixed or unexpected structure, skipping.");
                skipped++;
                continue;
            }

            var colliderMesh = existingCollider.sharedMesh;
            var wasConvex = existingCollider.convex;
            var mat = existingCollider.sharedMaterial;

            // Remove the mismatched collider from the render object — its identity
            // transform must not change, or the baked-absolute render mesh would shift.
            Object.DestroyImmediate(existingCollider);

            var collisionGO = new GameObject(entry.objectName + "_Collision");
            collisionGO.transform.SetParent(go.transform.parent, false);
            collisionGO.transform.localPosition = entry.correctLocalPosition;
            collisionGO.transform.localRotation = Quaternion.identity;
            collisionGO.transform.localScale = Vector3.one;

            var newCollider = collisionGO.AddComponent<MeshCollider>();
            newCollider.sharedMesh = colliderMesh;
            newCollider.convex = wasConvex;
            newCollider.sharedMaterial = mat;

            GameObjectUtility.SetStaticEditorFlags(collisionGO, StaticEditorFlags.NavigationStatic);

            EditorUtility.SetDirty(go);
            EditorUtility.SetDirty(collisionGO);
            fixedCount++;
            Debug.Log("[FortWinterColliderFix] Fixed " + entry.objectName + " -> " +
                collisionGO.name + " at local " + entry.correctLocalPosition);
        }

        Debug.Log(string.Format(
            "[FortWinterColliderFix] Complete: fixed={0} skipped={1}. " +
            "SAVE THE SCENE (Ctrl+S), then test in Play mode near the FortWinter towers.",
            fixedCount, skipped));
    }

    // Same bug, BoxCollider variant — found via live Physics Debugger inspection:
    // WireFencePoles (parent 699, same group as the wall fixes above) is a long thin
    // BoxCollider directly on the render object, zeroed to local (0,0,0) instead of its
    // real position. Its render mesh is ALSO a baked-absolute SplitMeshes piece
    // (split_21cc2007_sub33.asset, same source combined mesh as the walls), so the same
    // decouple-don't-just-reposition rule applies.
    private struct BoxFixEntry
    {
        public string objectName;
        public Vector3 correctLocalPosition;

        public BoxFixEntry(string name, float x, float y, float z)
        {
            objectName = name;
            correctLocalPosition = new Vector3(x, y, z);
        }
    }

    private static readonly BoxFixEntry[] BoxFixes = new BoxFixEntry[]
    {
        new BoxFixEntry("WireFencePoles", 19.2645149f, 6.86983871f, -8.97284794f),
    };

    [MenuItem("UberStrike/Fix - Decouple + Reposition Box Colliders (active scene)")]
    public static void FixBoxColliders()
    {
        int fixedCount = 0, skipped = 0;

        foreach (var entry in BoxFixes)
        {
            var go = GameObject.Find(entry.objectName);
            if (go == null)
            {
                Debug.LogWarning("[FortWinterColliderFix] GameObject not found: " + entry.objectName);
                skipped++;
                continue;
            }

            var existingCollider = go.GetComponent<BoxCollider>();
            if (existingCollider == null)
            {
                Debug.LogWarning("[FortWinterColliderFix] No BoxCollider on " + entry.objectName +
                    " — already fixed or unexpected structure, skipping.");
                skipped++;
                continue;
            }

            var size = existingCollider.size;
            var center = existingCollider.center;
            var wasTrigger = existingCollider.isTrigger;
            var mat = existingCollider.sharedMaterial;

            Object.DestroyImmediate(existingCollider);

            var collisionGO = new GameObject(entry.objectName + "_Collision");
            collisionGO.transform.SetParent(go.transform.parent, false);
            collisionGO.transform.localPosition = entry.correctLocalPosition;
            collisionGO.transform.localRotation = Quaternion.identity;
            collisionGO.transform.localScale = Vector3.one;

            var newCollider = collisionGO.AddComponent<BoxCollider>();
            newCollider.size = size;
            newCollider.center = center;
            newCollider.isTrigger = wasTrigger;
            newCollider.sharedMaterial = mat;

            GameObjectUtility.SetStaticEditorFlags(collisionGO, StaticEditorFlags.NavigationStatic);

            EditorUtility.SetDirty(go);
            EditorUtility.SetDirty(collisionGO);
            fixedCount++;
            Debug.Log("[FortWinterColliderFix] Fixed " + entry.objectName + " -> " +
                collisionGO.name + " at local " + entry.correctLocalPosition);
        }

        Debug.Log(string.Format(
            "[FortWinterColliderFix] Box-collider fix complete: fixed={0} skipped={1}. " +
            "SAVE THE SCENE (Ctrl+S), then test in Play mode near the wire fence.",
            fixedCount, skipped));
    }
}
