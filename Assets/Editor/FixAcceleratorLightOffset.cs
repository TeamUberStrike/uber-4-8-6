// FixAcceleratorLightOffset — one-off. FixAcceleratorMeshOffset (earlier tonight) only corrected
// the top-level "Accelerator" mesh child's broken local transform; "Accelerator_Light" (nested one
// level deeper, under "Accelerator") was assumed to already carry a correct, untouched relative
// offset — that assumption was wrong. It also came from the same unverified RestoreDeletedAcceleratorPad
// clone and carries its own corruption: local position (0,0,0) instead of a real embedded offset,
// and local scale (2,2,2) — inherited from the AcceleratorPad root's own scale — instead of (1,1,1).
//
// Correct values confirmed from TWO independent sources tonight: the real 4.3.8 client's
// AcceleratorPad.prefab, and LostParadise2's own already-working, already-playtested AcceleratorPad
// (Assets/ArtTools/Maps/lostparadise2/LostParadise2.unity, go=474/tf=1240) — both agree exactly:
// localPosition=(0, 0.32985753, -0.47679123), localRotation=identity, localScale=(1,1,1).
//
// Run via: UberStrike → Fix → Fix Accelerator Light Offset (active scene)

using UnityEngine;
using UnityEditor;

public static class FixAcceleratorLightOffset
{
    private static readonly Vector3 TargetLocalPosition = new Vector3(0f, 0.32985753f, -0.47679123f);
    private static readonly Vector3 TargetLocalScale = Vector3.one;

    [MenuItem("UberStrike/Fix/Fix Accelerator Light Offset (active scene)")]
    public static void Fix()
    {
        string sceneName = System.IO.Path.GetFileNameWithoutExtension(EditorApplication.currentScene);
        if (sceneName.IndexOf("spaceportalpha", System.StringComparison.OrdinalIgnoreCase) < 0)
        {
            Debug.LogWarning("[FixAcceleratorLightOffset] Active scene doesn't look like SpacePortAlpha (" + EditorApplication.currentScene + ") — aborting.");
            return;
        }

        int fixedCount = 0;
        foreach (var o in Resources.FindObjectsOfTypeAll(typeof(GameObject)))
        {
            var go = o as GameObject;
            if (go == null) continue;
            if (EditorUtility.IsPersistent(go)) continue;
            if (go.name != "Accelerator_Light") continue;
            if (go.transform.parent == null || go.transform.parent.gameObject.name != "Accelerator") continue;

            Debug.Log(string.Format("[FixAcceleratorLightOffset] '{0}' under '{1}': localPosition {2} -> {3}, localScale {4} -> {5}",
                go.name, go.transform.parent.name, go.transform.localPosition, TargetLocalPosition, go.transform.localScale, TargetLocalScale));

            go.transform.localPosition = TargetLocalPosition;
            go.transform.localRotation = Quaternion.identity;
            go.transform.localScale = TargetLocalScale;
            EditorUtility.SetDirty(go);
            fixedCount++;
        }

        Debug.Log(string.Format("[FixAcceleratorLightOffset] Done. Fixed {0} 'Accelerator_Light' object(s). SAVE THE SCENE (File -> Save Scene), then test.", fixedCount));
    }
}
