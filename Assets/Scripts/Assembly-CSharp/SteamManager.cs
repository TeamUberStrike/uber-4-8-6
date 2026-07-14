// SteamManager: real Steamworks.NET init when steam_api64.dll + Steam are
// available. Falls through gracefully when Steam can't init (no DLL, Steam
// not running, no app id) — `Initialized` reports `false`, the auth chain
// detects this via PlayerDataManager.SteamId returning the offline fallback,
// and AuthenticationManager.LoginByChannel jumps to the offline bypass.
//
// Differs from the original in two ways:
//  1. Never calls Application.Quit() on failure — Editor must keep running
//  2. Wraps every Steamworks call in try/catch so a missing native DLL just
//     downgrades to offline mode instead of throwing across the engine
using System;
using System.Text;
using Steamworks;
using UnityEngine;

internal class SteamManager : MonoBehaviour
{
    private static SteamManager m_instance;
    private static bool s_bInitialized;
    private SteamAPIWarningMessageHook_t m_SteamAPIWarningMessageHook;

    public static bool Initialized => s_bInitialized;

    // SteamAPI.Init() is called directly here — in BeforeSceneLoad — so the
    // result is available before any MonoBehaviour.Start() checks SteamId.
    // In Unity 6, AddComponent Awake() is deferred to the first scene frame,
    // which is too late; the auth chain runs in GlobalSceneLoader.Start().
    [RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
    private static void CreateInstance()
    {
        Debug.Log("[SteamManager] CreateInstance() — calling SteamAPI.Init() before scene load.");
        try
        {
            if (!SteamAPI.Init())
            {
                Debug.LogWarning("[SteamManager] SteamAPI.Init() returned false — Steam not running or app 291210 not accessible. Offline fallback active.");
                return;
            }
            s_bInitialized = true;
#if UNITY_EDITOR
            Debug.Log("[SteamManager] SteamAPI.Init() OK — Steam auth available. SteamId=" + SteamUser.GetSteamID());
#endif
        }
        catch (DllNotFoundException ex)
        {
            Debug.LogWarning("[SteamManager] steam_api64.dll not found — offline fallback active. " + ex.Message);
        }
        catch (Exception ex)
        {
            Debug.LogWarning("[SteamManager] SteamAPI.Init() threw — offline fallback active. " + ex.Message);
        }

        if (!s_bInitialized) return;

        // Spawn the MonoBehaviour only when Steam init succeeded — needed for RunCallbacks + Shutdown.
        var go = new GameObject("SteamManager");
        DontDestroyOnLoad(go);
        go.AddComponent<SteamManager>();
    }

    private static void SteamAPIDebugTextHook(int nSeverity, StringBuilder pchDebugText)
    {
        Debug.LogWarning(pchDebugText);
    }

    private void Awake()
    {
        if (m_instance != null) { Destroy(gameObject); return; }
        m_instance = this;
    }

    private void OnDestroy()
    {
        if (m_instance == this) { m_instance = null; s_bInitialized = false; }
    }

    private void Start() { }

    private void OnEnable()
    {
        if (s_bInitialized && m_SteamAPIWarningMessageHook == null)
        {
            try
            {
                m_SteamAPIWarningMessageHook = SteamAPIDebugTextHook;
                SteamClient.SetWarningMessageHook(m_SteamAPIWarningMessageHook);
            }
            catch (Exception ex)
            {
                Debug.LogWarning("[SteamManager] SetWarningMessageHook failed: " + ex.Message);
            }
        }
    }

    private void OnApplicationQuit()
    {
        if (s_bInitialized)
        {
            try { SteamAPI.Shutdown(); } catch { }
        }
    }

    private void Update()
    {
        if (s_bInitialized)
        {
            try { SteamAPI.RunCallbacks(); } catch { }
        }
    }
}
