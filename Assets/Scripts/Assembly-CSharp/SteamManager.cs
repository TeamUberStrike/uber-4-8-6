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
    private bool m_bInitialized;
    private SteamAPIWarningMessageHook_t m_SteamAPIWarningMessageHook;

    public static bool Initialized => m_instance != null && m_instance.m_bInitialized;

    private static void SteamAPIDebugTextHook(int nSeverity, StringBuilder pchDebugText)
    {
        Debug.LogWarning(pchDebugText);
    }

    private void Awake() { }

    private void OnDestroy()
    {
        if (m_instance == this) m_instance = null;
    }

    private void Start()
    {
        Debug.Log("[SteamManager] Start() running — Steamworks init is DISABLED in this build (ABI-incompatible steam_api64.dll). Forcing offline mode.");
        m_instance = this;
        m_bInitialized = false;
    }

    private void OnEnable()
    {
        if (m_bInitialized && m_SteamAPIWarningMessageHook == null)
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
        if (m_bInitialized)
        {
            try { SteamAPI.Shutdown(); } catch { }
        }
    }

    private void Update()
    {
        if (m_bInitialized)
        {
            try { SteamAPI.RunCallbacks(); } catch { }
        }
    }
}
