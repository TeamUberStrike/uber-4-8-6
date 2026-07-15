// DumpAcceleratorPads — diagnostic only, no changes to the scene. Ground truth is producing
// confusing/contradictory position reports tonight (offline YAML parsing vs what's actually in
// the live Hierarchy/Inspector don't agree), so this asks Unity itself — via transform.position/
// localPosition directly, not a hand-rolled ancestor-chain approximation — for the real answer on
// every "AcceleratorPad" object in the active scene: identity, parent chain, local vs world
// position, and whether it actually has a visible mesh (to check Shadow's report that some pads
// show only the linear-line gizmo, no rendered mesh).
//
// Run via: UberStrike → Fix → Dump AcceleratorPads (active scene)

using UnityEngine;
using UnityEditor;

public static class DumpAcceleratorPads
{
    [MenuItem("UberStrike/Fix/Dump AcceleratorPads (active scene)")]
    public static void Dump()
    {
        Debug.Log("[DumpAcceleratorPads] Scanning active scene: " + EditorApplication.currentScene);

        int i = 0;
        foreach (var o in Resources.FindObjectsOfTypeAll(typeof(GameObject)))
        {
            var go = o as GameObject;
            if (go == null) continue;
            if (EditorUtility.IsPersistent(go)) continue;
            if (go.name != "AcceleratorPad") continue;

            i++;
            var t = go.transform;

            string parentChain = "";
            var p = t.parent;
            while (p != null) { parentChain = p.name + (parentChain.Length > 0 ? " > " + parentChain : ""); p = p.parent; }

            var renderers = go.GetComponentsInChildren<MeshRenderer>(true);
            string rendererInfo = renderers.Length == 0 ? "NO MeshRenderer found in children" :
                string.Join(", ", System.Array.ConvertAll(renderers, r =>
                    string.Format("{0}(enabled={1}, activeInHierarchy={2})", r.gameObject.name, r.enabled, r.gameObject.activeInHierarchy)));

            var mb = go.GetComponent<MonoBehaviour>();
            string scriptInfo = "no MonoBehaviour";
            if (mb != null)
            {
                var so = new SerializedObject(mb);
                var dir = so.FindProperty("_direction");
                var force = so.FindProperty("_force");
                scriptInfo = string.Format("{0}: direction={1} force={2}",
                    mb.GetType().Name,
                    dir != null ? dir.vector3Value.ToString() : "n/a",
                    force != null ? force.floatValue.ToString() : "n/a");
            }

            Debug.Log(string.Format(
                "[DumpAcceleratorPads] #{0} instanceID={1} activeInHierarchy={2}\n  parentChain={3}\n  LOCAL pos={4}\n  WORLD pos={5}\n  renderers: {6}\n  script: {7}",
                i, go.GetInstanceID(), go.activeInHierarchy, parentChain,
                t.localPosition, t.position, rendererInfo, scriptInfo));
        }

        Debug.Log(string.Format("[DumpAcceleratorPads] Done. Found {0} AcceleratorPad object(s) total.", i));
    }
}
