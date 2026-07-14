// FixCollisionChildLayers — one-time repair for AutoColliderFix's missing layer copy.
//
// AutoColliderFix.cs created each "<Name>_Collision" child via `new GameObject(...)`,
// which defaults to layer 0 ("Default") and never had the source object's layer copied
// over. This silently broke every layer-based collision exclusion for all 198 objects it
// created (confirmed live: Airco_Vent_C_Collision sat on layer 0 instead of layer 8
// "GloballyLit", so Project Settings -> Physics layer-matrix exclusions had zero effect,
// and DisableOversizedUtilityColliders' layer filter (8-17) never matched them either).
// AutoColliderFix.cs itself is now patched (`collisionGO.layer = go.layer;`) so future
// runs on other maps won't repeat this — this script repairs the already-created objects
// in the current scene without needing to redo the whole fix.
//
// Matches each "<Name>_Collision" GameObject to its sibling "<Name>" (same parent, name
// minus the "_Collision" suffix) and copies that sibling's layer over.
//
// Run via:
//   UberStrike -> Fix -> Fix Collision-Child Layers -> Dry Run (report only, active scene)
//   UberStrike -> Fix -> Fix Collision-Child Layers -> Apply (active scene)

using UnityEngine;
using UnityEditor;

public static class FixCollisionChildLayers
{
    private const string Suffix = "_Collision";

    private static bool TryFindSourceSibling(Transform collisionChild, out Transform source)
    {
        source = null;
        if (!collisionChild.name.EndsWith(Suffix)) return false;
        string sourceName = collisionChild.name.Substring(0, collisionChild.name.Length - Suffix.Length);
        Transform parent = collisionChild.parent;
        if (parent == null) return false;
        for (int i = 0; i < parent.childCount; i++)
        {
            Transform sibling = parent.GetChild(i);
            if (sibling != collisionChild && sibling.name == sourceName)
            {
                source = sibling;
                return true;
            }
        }
        return false;
    }

    [MenuItem("UberStrike/Fix/Fix Collision-Child Layers/Dry Run (report only, active scene)")]
    public static void DryRun()
    {
        var allTransforms = Object.FindObjectsByType<Transform>(FindObjectsInactive.Include, FindObjectsSortMode.None);
        int mismatched = 0, noSource = 0;
        foreach (var t in allTransforms)
        {
            if (!t.name.EndsWith(Suffix)) continue;
            if (!TryFindSourceSibling(t, out Transform source))
            {
                noSource++;
                continue;
            }
            if (t.gameObject.layer != source.gameObject.layer)
            {
                mismatched++;
                Debug.Log(string.Format("  {0} layer={1} -> should be {2} (from sibling '{3}')",
                    t.name, t.gameObject.layer, source.gameObject.layer, source.name));
            }
        }
        Debug.Log(string.Format("[FixCollisionChildLayers] DRY RUN — {0} '_Collision' objects have a wrong layer (would be fixed), {1} had no matching source sibling. Nothing changed.", mismatched, noSource));
    }

    [MenuItem("UberStrike/Fix/Fix Collision-Child Layers/Apply (active scene)")]
    public static void Apply()
    {
        var allTransforms = Object.FindObjectsByType<Transform>(FindObjectsInactive.Include, FindObjectsSortMode.None);
        int fixedCount = 0, noSource = 0;
        foreach (var t in allTransforms)
        {
            if (!t.name.EndsWith(Suffix)) continue;
            if (!TryFindSourceSibling(t, out Transform source))
            {
                noSource++;
                continue;
            }
            if (t.gameObject.layer != source.gameObject.layer)
            {
                t.gameObject.layer = source.gameObject.layer;
                EditorUtility.SetDirty(t.gameObject);
                fixedCount++;
            }
        }
        Debug.Log(string.Format("[FixCollisionChildLayers] Apply complete — fixed layer on {0} '_Collision' objects, {1} had no matching source sibling. Save the scene (Ctrl+S) before testing in Play mode.", fixedCount, noSource));
    }
}
