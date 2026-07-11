// RestoreDeletedAcceleratorPad — one-off recovery tool. On 2026-07-10, SpacePortAlpha's
// AcceleratorPad at world (-8.879122, 5.5795493, 65.86403) (index [1] of the 5 fixed via
// ApplySpacePortAlphaAcceleratorRefData) was accidentally deleted after being mistaken for a
// stray duplicate from another map. It was not a duplicate — it was one of the 5 genuine,
// pre-existing AcceleratorPad objects on this map, confirmed via its own intact script data
// before deletion.
//
// Recovery approach: clone an intact sibling AcceleratorPad rather than hand-build the object
// from scratch — confirmed all 5 AcceleratorPad instances in this ground-truth project share the
// exact same "Accelerator" render mesh asset (guid 32481c3f500b1874aaca9d6cc737922c) and BoxCollider/
// AudioSource setup, so cloning preserves everything (custom AudioSource rolloff curve, tags,
// layers, static flags) exactly rather than risking a subtly-wrong manual reconstruction. Only
// the position and the MonoBehaviour's _direction/_force need to be overridden per-instance —
// values below extracted directly from the still-intact copy of this exact object in the
// Unity6 port (Downloads/ForgeRipper/data/UberStrike_Unity6), which was never touched by the
// deletion.
//
// Run via: UberStrike → Fix → Restore Deleted AcceleratorPad (active scene)

using UnityEngine;
using UnityEditor;

public static class RestoreDeletedAcceleratorPad
{
    private static readonly Vector3 TargetPosition = new Vector3(-8.879122f, 5.5795493f, 65.86403f);
    private static readonly Vector3 TargetDirection = new Vector3(-0.2f, 1.4f, -1.2f);
    private const float TargetForce = 1620f;

    [MenuItem("UberStrike/Fix/Restore Deleted AcceleratorPad (active scene)")]
    public static void Restore()
    {
        string sceneName = System.IO.Path.GetFileNameWithoutExtension(EditorApplication.currentScene);
        if (sceneName.IndexOf("spaceportalpha", System.StringComparison.OrdinalIgnoreCase) < 0)
        {
            Debug.LogWarning("[RestoreDeletedAcceleratorPad] Active scene doesn't look like SpacePortAlpha (" + EditorApplication.currentScene + ") — aborting.");
            return;
        }

        // Find any intact sibling AcceleratorPad to clone.
        GameObject template = null;
        foreach (var o in Resources.FindObjectsOfTypeAll(typeof(GameObject)))
        {
            var go = o as GameObject;
            if (go == null) continue;
            if (EditorUtility.IsPersistent(go)) continue;
            if (go.name == "AcceleratorPad") { template = go; break; }
        }

        if (template == null)
        {
            Debug.LogError("[RestoreDeletedAcceleratorPad] No intact AcceleratorPad found to clone from — aborting.");
            return;
        }

        var clone = (GameObject)Object.Instantiate(template, template.transform.position, template.transform.rotation);
        clone.name = "AcceleratorPad";
        clone.transform.parent = template.transform.parent;
        clone.transform.position = TargetPosition;

        var script = clone.GetComponent<MonoBehaviour>();
        if (script == null)
        {
            Debug.LogError("[RestoreDeletedAcceleratorPad] Clone has no MonoBehaviour (ForceField-equivalent) component — check manually.");
        }
        else
        {
            var so = new SerializedObject(script);
            so.FindProperty("_direction").vector3Value = TargetDirection;
            so.FindProperty("_force").floatValue = TargetForce;
            so.ApplyModifiedProperties();
        }

        EditorUtility.SetDirty(clone);
        Debug.Log(string.Format("[RestoreDeletedAcceleratorPad] Cloned from '{0}', repositioned to {1}, set _direction={2} _force={3}. SAVE THE SCENE (File -> Save Scene), then test.",
            template.name, TargetPosition, TargetDirection, TargetForce));
    }
}
