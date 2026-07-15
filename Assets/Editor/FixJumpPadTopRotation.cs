// FixJumpPadTopRotation — one-off. SpacePortAlpha's "jumpPad_Top" sits at the correct position
// (fixed earlier via the 4.3.8 cross-reference) but its rotation was never correct — ground
// truth has it at local identity, same "stuck" pattern as every other position bug on this map.
// Unlike position, this needed the rotation specifically, which is also recoverable from the
// working UberStrike 4.3.8 client's own scene data (Downloads/uber-client-4-3-8-
// unity_2022_working/UberStrike.Unity/Assets/Scenes/LevelSpaceportAlpha.unity, PrefabInstance
// fid=992's m_LocalRotation modification) — same source, same validation already established
// for this map's position fixes tonight.
//
// Run via: UberStrike → Fix → Fix JumpPad_Top Rotation (active scene)

using UnityEngine;
using UnityEditor;

public static class FixJumpPadTopRotation
{
    private static readonly Quaternion TargetRotation = new Quaternion(0.38200134f, -1.88613287e-16f, 4.55381013e-08f, 0.924161851f);

    [MenuItem("UberStrike/Fix/Fix JumpPad_Top Rotation (active scene)")]
    public static void Fix()
    {
        string sceneName = System.IO.Path.GetFileNameWithoutExtension(EditorApplication.currentScene);
        if (sceneName.IndexOf("spaceportalpha", System.StringComparison.OrdinalIgnoreCase) < 0)
        {
            Debug.LogWarning("[FixJumpPadTopRotation] Active scene doesn't look like SpacePortAlpha (" + EditorApplication.currentScene + ") — aborting.");
            return;
        }

        GameObject target = null;
        foreach (var o in Resources.FindObjectsOfTypeAll(typeof(GameObject)))
        {
            var go = o as GameObject;
            if (go == null) continue;
            if (EditorUtility.IsPersistent(go)) continue;
            if (go.name == "jumpPad_Top") { target = go; break; }
        }

        if (target == null)
        {
            Debug.LogError("[FixJumpPadTopRotation] No 'jumpPad_Top' object found in the active scene — aborting.");
            return;
        }

        Debug.Log(string.Format("[FixJumpPadTopRotation] Found jumpPad_Top, current WORLD rotation={0} -> setting to {1}", target.transform.rotation, TargetRotation));
        target.transform.rotation = TargetRotation;
        EditorUtility.SetDirty(target);
        Debug.Log("[FixJumpPadTopRotation] Done. SAVE THE SCENE (File -> Save Scene), then test.");
    }
}
