using System.Collections.Generic;
using System.Reflection;
using UnityEngine;
using UnityEngine.SceneManagement;
using Object = UnityEngine.Object;

// Rewires + sanitizes weapon impact ParticleSystems after the
// ParticleEmitter → ParticleSystem migration. Ported from the 4.3.8 Unity 2022
// fix at UberStrike.Unity/Assets/Scripts/Scene/ParticleEmitterAutoFixer.cs;
// stripped to the two changes we need:
//
// 1. GLOBAL SEARCH for impact ParticleSystems. They live as sibling GameObjects
//    in the scene — not under ParticleEffectController. Resources.FindObjectsOfTypeAll
//    finds scene instances regardless of hierarchy. Previous pass used
//    GetComponentsInChildren(ctrl.transform) and missed everything.
//
// 2. SHAPE MODULE DISABLE. Legacy ParticleEmitter migrations leave a Sphere
//    shape module with radius ~1, and Unity's EmitParams pathway still respects
//    applyShapeToPosition on some code paths. Result: particles emit at random
//    ±1m offsets from the hit point — often inside the wall, invisible. Turning
//    off shape.enabled is the single biggest visibility fix.
//
// Also clears startRotation/startSpeed/gravity/loop on the main module so nothing
// inherited from the migrated Ellipsoid settings interferes with our EmitParams.
//
// We deliberately DO NOT touch materials/shaders/colors here — the Unity 6 port
// already has weapon particles tuned via earlier shader-overhaul commits. The
// 4.3.8 AutoFixer's material-override block is specific to that project's
// GUIDs and would regress our work.

public static class ParticleEmitterAutoFixer
{
    private static readonly HashSet<string> KnownParticleNames = new HashSet<string>
    {
        "Wood", "Stone", "Metal", "Grass", "Sand", "Splat", "PlayerStar",
        "Fire", "Trail", "WaterCircle", "WaterExtra", "WaterDrops",
        "PaintOrange", "PaintGreen", "PaintBlue", "PaintRed",
        "ExplosionBlast", "ExplosionDust", "ExplosionRing",
        "ExplosionSmoke", "ExplosionSpark", "ExplosionTrail",
        "HeatWave",
    };

    private static bool _hasRun;
    private static GameObject _watcher;

    [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
    private static void ResetStatics() { _hasRun = false; _watcher = null; }

    [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
    private static void Bootstrap()
    {
        if (_watcher != null) return;
        _watcher = new GameObject("[ParticleAutoFixerWatcher]");
        Object.DontDestroyOnLoad(_watcher);
        _watcher.AddComponent<Watcher>();
        SceneManager.sceneLoaded -= OnSceneLoaded;
        SceneManager.sceneLoaded += OnSceneLoaded;
        Debug.Log("[ParticleAutoFixer] Bootstrap installed");
    }

    private static void OnSceneLoaded(Scene s, LoadSceneMode m) { if (!_hasRun) TryFix(); }

    private class Watcher : MonoBehaviour
    {
        private float _nextCheck;
        private void Update()
        {
            if (_hasRun) { enabled = false; return; }
            if (Time.unscaledTime < _nextCheck) return;
            _nextCheck = Time.unscaledTime + 0.5f;
            TryFix();
        }
    }

    private static int _tryFixAttempts;
    private static void TryFix()
    {
        _tryFixAttempts++;
        var ctrl = ParticleEffectController.Instance;
        if (ctrl == null)
        {
            if (_tryFixAttempts == 1 || _tryFixAttempts % 20 == 0)
                Debug.Log($"[ParticleAutoFixer] attempt #{_tryFixAttempts} — Instance still null, polling");
            return;
        }
        Debug.Log($"[ParticleAutoFixer] attempt #{_tryFixAttempts} — Instance found, running fix");

        // 1. Build a map of known impact ParticleSystem names → scene instances.
        var psMap = new Dictionary<string, ParticleSystem>();
        foreach (var ps in Resources.FindObjectsOfTypeAll<ParticleSystem>())
        {
            if (ps == null || ps.gameObject == null) continue;
            var name = ps.gameObject.name;
            if (!KnownParticleNames.Contains(name)) continue;
            // Prefer scene instances over prefab assets — only scene instances render.
            var isScene = !string.IsNullOrEmpty(ps.gameObject.scene.name);
            if (!psMap.ContainsKey(name))
                psMap[name] = ps;
            else if (isScene && string.IsNullOrEmpty(psMap[name].gameObject.scene.name))
                psMap[name] = ps;
        }
        if (psMap.Count == 0)
        {
            Debug.LogWarning("[ParticleAutoFixer] No known impact ParticleSystems in scene yet");
            return;
        }

        // 2. Sanitize every known impact PS: shape off, rotation/speed/gravity zero,
        //    world-space sim, non-looping. These are the modules EmitParams needs clean
        //    to spawn at the exact hit point we pass in.
        int sanitized = 0;
        foreach (var ps in psMap.Values)
        {
            var main = ps.main;
            main.simulationSpace = ParticleSystemSimulationSpace.World;
            main.playOnAwake = false;
            main.loop = false;
            main.startSpeed = 0f;
            main.startRotation = 0f;
            main.startRotation3D = false;
            main.gravityModifier = 0f;
            main.maxParticles = 1000;
            main.scalingMode = ParticleSystemScalingMode.Local;

            var shape = ps.shape;         shape.enabled = false;
            var emission = ps.emission;   emission.enabled = false;
            var noise = ps.noise;         noise.enabled = false;
            var velOL = ps.velocityOverLifetime; velOL.enabled = false;
            var rotOL = ps.rotationOverLifetime; rotOL.enabled = false;
            var inhV  = ps.inheritVelocity;      inhV.enabled  = false;
            var subE  = ps.subEmitters;          subE.enabled  = false;

            if (!ps.gameObject.activeInHierarchy) ps.gameObject.SetActive(true);
            sanitized++;
        }

        // 3. Wire any null ParticleEmitter fields on the controller's configs.
        int wired = 0, stillMissing = 0;
        var dataField = typeof(ParticleEffectController).GetField("_allWeaponData",
            BindingFlags.NonPublic | BindingFlags.Instance);
        var allData = dataField?.GetValue(ctrl) as System.Array;
        if (allData != null)
        {
            foreach (var entry in allData)
            {
                if (entry == null) continue;
                var cfg = entry.GetType().GetField("Configuration")?.GetValue(entry);
                if (cfg == null) continue;
                var impact = cfg.GetType().GetField("WeaponImpactEffectConfiguration")?.GetValue(cfg);
                if (impact == null) continue;

                wired += Wire(impact, "FireParticleConfigurationForInstantHit",  "Fire",        psMap, ref stillMissing);
                wired += Wire(impact, "TrailParticleConfigurationForInstantHit", "Trail",       psMap, ref stillMissing);

                var surf = impact.GetType().GetField("SurfaceParameterSet")?.GetValue(impact);
                if (surf == null) continue;

                wired += Wire(surf, "WoodEffect",             "Wood",        psMap, ref stillMissing);
                wired += Wire(surf, "WaterCircleEffect",      "WaterCircle", psMap, ref stillMissing);
                wired += Wire(surf, "WaterExtraSplashEffect", "WaterExtra",  psMap, ref stillMissing);
                wired += Wire(surf, "StoneEffect",            "Stone",       psMap, ref stillMissing);
                wired += Wire(surf, "MetalEffect",            "Metal",       psMap, ref stillMissing);
                wired += Wire(surf, "GrassEffect",            "Grass",       psMap, ref stillMissing);
                wired += Wire(surf, "SandEffect",             "Sand",        psMap, ref stillMissing);
                wired += Wire(surf, "Splat",                  "Splat",       psMap, ref stillMissing);
            }
        }

        Debug.Log($"[ParticleAutoFixer] sanitized {sanitized} PS, wired {wired} refs (missing {stillMissing}). Known systems found: {string.Join(",", psMap.Keys)}");
        _hasRun = true;
    }

    private static int Wire(object container, string fieldName, string lookupName, Dictionary<string, ParticleSystem> map, ref int stillMissing)
    {
        var f = container.GetType().GetField(fieldName);
        if (f == null) return 0;
        var subCfg = f.GetValue(container);
        if (subCfg == null) return 0;
        var emitterField = subCfg.GetType().GetField("ParticleEmitter");
        if (emitterField == null || emitterField.FieldType != typeof(ParticleSystem)) return 0;
        var current = emitterField.GetValue(subCfg) as ParticleSystem;
        // Always reassign — even if current is non-null, it may point at an
        // asset-mode duplicate rather than the scene instance we just sanitized.
        if (!map.TryGetValue(lookupName, out var ps) || ps == null) { stillMissing++; return 0; }
        if (current == ps) return 0;
        emitterField.SetValue(subCfg, ps);
        return 1;
    }
}
