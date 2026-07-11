// CloneAcceleratorMeshOntoPads — one-off. DumpAcceleratorPads (2026-07-10/11) established ground
// truth: of the 6 "AcceleratorPad" objects in the active scene, exactly one (the clone left over
// from RestoreDeletedAcceleratorPad, sitting at the same position as a meshless duplicate) has a
// real visible mesh (child renderers "Accelerator" + "Accelerator_Light", both enabled). The other
// 5 — the real, position-correct pads fixed earlier via ApplySpacePortAlphaAcceleratorRefData —
// have no mesh child at all, which is why only linear direction-line gizmos were visible for them.
//
// Fix: delete the redundant meshless duplicate sitting at the mesh-bearing clone's position (so
// that slot keeps exactly one object, the meshed one), then clone the mesh-bearing object's
// "Accelerator"/"Accelerator_Light" children onto every other AcceleratorPad still missing a mesh,
// preserving their local offset/rotation/scale relative to the parent pad exactly as authored on
// the source.
//
// Run via: UberStrike → Fix → Clone Accelerator Mesh Onto Pads (active scene)

using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public static class CloneAcceleratorMeshOntoPads
{
    private const float Epsilon = 0.05f;

    [MenuItem("UberStrike/Fix/Clone Accelerator Mesh Onto Pads (active scene)")]
    public static void Run()
    {
        string sceneName = System.IO.Path.GetFileNameWithoutExtension(EditorApplication.currentScene);
        if (sceneName.IndexOf("spaceportalpha", System.StringComparison.OrdinalIgnoreCase) < 0)
        {
            Debug.LogWarning("[CloneAcceleratorMeshOntoPads] Active scene doesn't look like SpacePortAlpha (" + EditorApplication.currentScene + ") — aborting.");
            return;
        }

        var pads = new List<GameObject>();
        foreach (var o in Resources.FindObjectsOfTypeAll(typeof(GameObject)))
        {
            var go = o as GameObject;
            if (go == null) continue;
            if (EditorUtility.IsPersistent(go)) continue;
            if (go.name == "AcceleratorPad") pads.Add(go);
        }

        GameObject source = null;
        foreach (var p in pads)
        {
            if (p.GetComponentInChildren<MeshRenderer>() != null) { source = p; break; }
        }

        if (source == null)
        {
            Debug.LogError("[CloneAcceleratorMeshOntoPads] No AcceleratorPad with an existing mesh found to clone from — aborting.");
            return;
        }

        Debug.Log("[CloneAcceleratorMeshOntoPads] Source (has mesh): instanceID=" + source.GetInstanceID() + " pos=" + source.transform.position);

        // Delete any OTHER pad sitting at the same position as source with no mesh — redundant duplicate.
        var toDelete = new List<GameObject>();
        foreach (var p in pads)
        {
            if (p == source) continue;
            if (p.GetComponentInChildren<MeshRenderer>() != null) continue; // has its own mesh, not a dup of source
            if (Vector3.Distance(p.transform.position, source.transform.position) < Epsilon)
                toDelete.Add(p);
        }
        foreach (var d in toDelete)
        {
            Debug.Log("[CloneAcceleratorMeshOntoPads] Deleting redundant meshless duplicate at " + d.transform.position + " (instanceID=" + d.GetInstanceID() + ")");
            Object.DestroyImmediate(d);
        }

        // Collect the mesh child objects to clone from source (top-level children only, e.g. "Accelerator", "Accelerator_Light").
        var meshChildren = new List<Transform>();
        for (int c = 0; c < source.transform.childCount; c++)
        {
            var child = source.transform.GetChild(c);
            if (child.GetComponentInChildren<MeshRenderer>() != null)
                meshChildren.Add(child);
        }
        Debug.Log("[CloneAcceleratorMeshOntoPads] Found " + meshChildren.Count + " mesh child object(s) on source to clone: " +
            string.Join(", ", meshChildren.ConvertAll(t => t.name).ToArray()));

        int fixedCount = 0;
        foreach (var p in pads)
        {
            if (p == source) continue;
            if (toDelete.Contains(p)) continue;
            if (p.GetComponentInChildren<MeshRenderer>() != null) continue; // already has a mesh

            foreach (var meshChild in meshChildren)
            {
                var clone = (GameObject)Object.Instantiate(meshChild.gameObject);
                clone.name = meshChild.name;
                clone.transform.parent = p.transform;
                clone.transform.localPosition = meshChild.localPosition;
                clone.transform.localRotation = meshChild.localRotation;
                clone.transform.localScale = meshChild.localScale;
            }
            EditorUtility.SetDirty(p);
            fixedCount++;
            Debug.Log("[CloneAcceleratorMeshOntoPads] Cloned mesh onto pad at " + p.transform.position + " (instanceID=" + p.GetInstanceID() + ")");
        }

        Debug.Log(string.Format("[CloneAcceleratorMeshOntoPads] Done. Deleted {0} redundant duplicate(s), added mesh to {1} pad(s). SAVE THE SCENE (File -> Save Scene), then test.",
            toDelete.Count, fixedCount));
    }
}
