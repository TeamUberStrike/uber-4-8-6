// FixAcceleratorMeshOffset — one-off. Root cause confirmed 2026-07-11 against the authoritative
// source: Downloads/uber-client-4-3-8-unity_2022_working/UberStrike.Unity/Assets/Scenes/Props/
// AcceleratorPad/Prefabs/AcceleratorPad.prefab. In the real prefab, the "Accelerator" mesh child's
// m_LocalPosition is (0, 0, 0) — it sits directly on its parent AcceleratorPad, identity rotation.
// "Accelerator_Light" nests one level deeper under "Accelerator" with its own small sane offset.
//
// Ground truth's "Accelerator" mesh child instead carried local position (-13.5029745,
// -23.7087955, 22.3332443) on all 5 pads — traced to RestoreDeletedAcceleratorPad.cs cloning an
// unverified template earlier tonight, then CloneAcceleratorMeshOntoPads.cs propagating that same
// broken offset onto the other 4 pads. Confirmed via DumpAcceleratorPads-style direct scene read
// that all 5 "Accelerator" children carry the identical broken value. This is why every pad's
// mesh rendered floating far outside the map instead of sitting on its pad.
//
// Fix: zero the "Accelerator" child's localPosition/localRotation (matching the real prefab).
// "Accelerator_Light" is untouched — its offset is relative to "Accelerator", not the broken
// value, so it was never wrong.
//
// Run via: UberStrike → Fix → Fix Accelerator Mesh Offset (active scene)

using UnityEngine;
using UnityEditor;

public static class FixAcceleratorMeshOffset
{
    [MenuItem("UberStrike/Fix/Fix Accelerator Mesh Offset (active scene)")]
    public static void Fix()
    {
        string sceneName = System.IO.Path.GetFileNameWithoutExtension(EditorApplication.currentScene);
        if (sceneName.IndexOf("spaceportalpha", System.StringComparison.OrdinalIgnoreCase) < 0)
        {
            Debug.LogWarning("[FixAcceleratorMeshOffset] Active scene doesn't look like SpacePortAlpha (" + EditorApplication.currentScene + ") — aborting.");
            return;
        }

        int fixedCount = 0;
        foreach (var o in Resources.FindObjectsOfTypeAll(typeof(GameObject)))
        {
            var go = o as GameObject;
            if (go == null) continue;
            if (EditorUtility.IsPersistent(go)) continue;
            if (go.name != "Accelerator") continue;
            if (go.transform.parent == null || go.transform.parent.gameObject.name != "AcceleratorPad") continue;

            Debug.Log(string.Format("[FixAcceleratorMeshOffset] '{0}' under parent at {1}: localPosition {2} -> (0,0,0), localRotation {3} -> identity",
                go.name, go.transform.parent.position, go.transform.localPosition, go.transform.localRotation));

            go.transform.localPosition = Vector3.zero;
            go.transform.localRotation = Quaternion.identity;
            EditorUtility.SetDirty(go);
            fixedCount++;
        }

        Debug.Log(string.Format("[FixAcceleratorMeshOffset] Done. Fixed {0} 'Accelerator' mesh child object(s). SAVE THE SCENE (File -> Save Scene), then test.", fixedCount));
    }
}
