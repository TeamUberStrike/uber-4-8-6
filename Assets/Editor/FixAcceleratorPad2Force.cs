// FixAcceleratorPad2Force — one-off. ForceField._force (Assets/Scripts/Assembly-CSharp/ForceField.cs)
// is declared as `private int _force`, not float. RestoreDeletedAcceleratorPad.cs (earlier tonight)
// tried to set it via SerializedProperty.floatValue, which silently fails on an int field — this is
// the exact native "type is not a supported float value" / SerializedProperty.cpp line 1250 warning
// seen at the time. The clone kept its template's original force (1200) instead of the intended
// 1620 (the real value for this exact pad, cross-referenced from the 4.3.8 client earlier tonight —
// its mirror pad at (9.0, 5.6, 65.9) already correctly has 1620). Confirmed as the root cause of
// tonight's report: weaker launch, shorter gizmo line (gizmo length is Mathf.Log(_force) * _force),
// dropping the player short into the void.
//
// Run via: UberStrike → Fix → Fix AcceleratorPad #2 Force (active scene)

using UnityEngine;
using UnityEditor;

public static class FixAcceleratorPad2Force
{
    private static readonly Vector3 TargetPosition = new Vector3(-8.87912178f, 5.57954931f, 65.8640289f);
    private const int TargetForce = 1620;
    private const float Epsilon = 0.05f;

    [MenuItem("UberStrike/Fix/Fix AcceleratorPad #2 Force (active scene)")]
    public static void Fix()
    {
        string sceneName = System.IO.Path.GetFileNameWithoutExtension(EditorApplication.currentScene);
        if (sceneName.IndexOf("spaceportalpha", System.StringComparison.OrdinalIgnoreCase) < 0)
        {
            Debug.LogWarning("[FixAcceleratorPad2Force] Active scene doesn't look like SpacePortAlpha (" + EditorApplication.currentScene + ") — aborting.");
            return;
        }

        foreach (var o in Resources.FindObjectsOfTypeAll(typeof(GameObject)))
        {
            var go = o as GameObject;
            if (go == null) continue;
            if (EditorUtility.IsPersistent(go)) continue;
            if (go.name != "AcceleratorPad") continue;
            if (Vector3.Distance(go.transform.position, TargetPosition) > Epsilon) continue;

            var script = go.GetComponent<MonoBehaviour>();
            if (script == null)
            {
                Debug.LogError("[FixAcceleratorPad2Force] Found the pad but no MonoBehaviour on it — aborting.");
                return;
            }

            var so = new SerializedObject(script);
            var forceProp = so.FindProperty("_force");
            Debug.Log("[FixAcceleratorPad2Force] Current _force=" + forceProp.intValue + " -> setting to " + TargetForce);
            forceProp.intValue = TargetForce;
            so.ApplyModifiedProperties();
            EditorUtility.SetDirty(go);

            Debug.Log("[FixAcceleratorPad2Force] Done. SAVE THE SCENE (File -> Save Scene), then test.");
            return;
        }

        Debug.LogError("[FixAcceleratorPad2Force] No AcceleratorPad found at " + TargetPosition + " — aborting.");
    }
}
