// FixAcceleratorMaterialAndRotation — one-off. Two remaining bugs traced to hard sources after
// the position/mesh-offset fix, 2026-07-11:
//
// 1. COLOR: ground truth's shared "AcceleratorPad.mat"/"AcceleratorLight.mat" point at
//    Assets/Texture2D/Accelerator_green.png / AcceleratorLight_green.png. Confirmed Catalyst's own
//    AcceleratorPad objects reference these SAME shared material assets (grep'd Catalyst.unity) —
//    so this green wiring is correct FOR CATALYST and must not be edited in place. SpacePortAlpha's
//    5 pads were only green because the RestoreDeletedAcceleratorPad clone (earlier tonight) grabbed
//    Catalyst's own material assignment along with everything else it cloned.
//    Fix: repoint SpacePortAlpha's 5 pads to the already-existing "AcceleratorPad_0.mat" /
//    "AcceleratorLight_0.mat" — both already reference the plain (non-green) textures, and their
//    _Color/_TintColor values match the working 4.3.8 client's real AcceleratorPad.prefab exactly
//    (base _Color {0.642,0.599,0.599,1}, light _TintColor {0.612,0.853,1,0.502} — a genuine blue).
//
// 2. ROTATION: the AcceleratorPad root Transform's rotation was never touched by tonight's earlier
//    position fixes (ApplySpacePortAlphaAcceleratorRefData only ever set .position). 4 of 5 pads'
//    real per-instance rotations recovered from the same 4.3.8 LevelSpaceportAlpha.unity
//    PrefabInstance blocks used for position data (m_LocalRotation modifications). The 5th pad
//    (this map's Steam-only addition, no 4.3.8 counterpart) has no source — its rotation is
//    INFERRED by mirroring pad #1's rotation across the X axis (q' = (x, -y, -z, w)), consistent
//    with its already-confirmed X-mirrored position/direction relative to pad #1. Flagged as
//    inferred in the log — verify visually, low risk since it's cosmetic only (gameplay force/
//    direction data for this pad was already independently confirmed correct via earlier playtest).
//
// Run via: UberStrike → Fix → Fix Accelerator Material And Rotation (active scene)

using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public static class FixAcceleratorMaterialAndRotation
{
    private const string BaseMatGuid = "06b95b76f75fd004f8d69c7e60f75371";  // AcceleratorPad_0.mat (blue)
    private const string LightMatGuid = "b83b85236fa28184780793cff7ddd872"; // AcceleratorLight_0.mat (blue)
    private const float Epsilon = 0.05f;

    private struct PadFix
    {
        public Vector3 position;
        public Quaternion rotation;
        public bool inferred;
    }

    private static List<PadFix> Fixes()
    {
        var list = new List<PadFix>();
        list.Add(new PadFix { position = new Vector3(13.5029745f, 23.7087955f, -22.3332443f), rotation = new Quaternion(0.183012709f, 0.683012724f, 0.183012709f, -0.683012724f), inferred = false });
        list.Add(new PadFix { position = new Vector3(-8.87912178f, 5.57954931f, 65.8640289f), rotation = new Quaternion(0f, 1f, 0f, -4.37113883e-08f), inferred = false });
        list.Add(new PadFix { position = new Vector3(9.03121758f, 5.57954931f, 65.8640289f), rotation = new Quaternion(0f, 1f, 0f, -4.37113883e-08f), inferred = false });
        list.Add(new PadFix { position = new Vector3(-0.182397485f, -1.505853653f, 26.0211887f), rotation = Quaternion.identity, inferred = false });
        // Inferred: mirror pad #1's rotation across X (q' = (x, -y, -z, w)).
        list.Add(new PadFix { position = new Vector3(-14.547428f, 22.977001f, -22.259157f), rotation = new Quaternion(0.183012709f, -0.683012724f, -0.183012709f, -0.683012724f), inferred = true });
        return list;
    }

    private static Material LoadMat(string guid)
    {
        string path = AssetDatabase.GUIDToAssetPath(guid);
        return (Material)AssetDatabase.LoadAssetAtPath(path, typeof(Material));
    }

    [MenuItem("UberStrike/Fix/Fix Accelerator Material And Rotation (active scene)")]
    public static void Fix()
    {
        string sceneName = System.IO.Path.GetFileNameWithoutExtension(EditorApplication.currentScene);
        if (sceneName.IndexOf("spaceportalpha", System.StringComparison.OrdinalIgnoreCase) < 0)
        {
            Debug.LogWarning("[FixAcceleratorMaterialAndRotation] Active scene doesn't look like SpacePortAlpha (" + EditorApplication.currentScene + ") — aborting.");
            return;
        }

        var baseMat = LoadMat(BaseMatGuid);
        var lightMat = LoadMat(LightMatGuid);
        if (baseMat == null || lightMat == null)
        {
            Debug.LogError("[FixAcceleratorMaterialAndRotation] Could not load AcceleratorPad_0/AcceleratorLight_0 materials by GUID — aborting.");
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

        var fixes = Fixes();
        int matched = 0;
        foreach (var pad in pads)
        {
            PadFix? found = null;
            foreach (var f in fixes)
            {
                if (Vector3.Distance(pad.transform.position, f.position) < Epsilon) { found = f; break; }
            }
            if (found == null)
            {
                Debug.LogWarning("[FixAcceleratorMaterialAndRotation] No reference data for pad at " + pad.transform.position + " — skipping.");
                continue;
            }

            var f2 = found.Value;
            pad.transform.rotation = f2.rotation;
            EditorUtility.SetDirty(pad);

            foreach (var mr in pad.GetComponentsInChildren<MeshRenderer>())
            {
                if (mr.gameObject.name == "Accelerator") mr.sharedMaterial = baseMat;
                else if (mr.gameObject.name == "Accelerator_Light") mr.sharedMaterial = lightMat;
                EditorUtility.SetDirty(mr);
            }

            matched++;
            Debug.Log(string.Format("[FixAcceleratorMaterialAndRotation] Pad at {0}: rotation set to {1}{2}, materials repointed to blue variants.",
                pad.transform.position, f2.rotation, f2.inferred ? " (INFERRED — verify visually)" : ""));
        }

        Debug.Log(string.Format("[FixAcceleratorMaterialAndRotation] Done. Fixed {0} of {1} pads. SAVE THE SCENE (File -> Save Scene), then test.", matched, pads.Count));
    }
}
