// SteamManager: real Steamworks.NET init when CSteamworks.dll + steam_api.dll +
// Steam client are available. Falls through gracefully when Steam can't init
// (no DLL, Steam not running, Unity Editor Free license blocks native plugins)
// — `Initialized` reports `false`, the auth chain detects this via
// PlayerDataManager.SteamId returning the offline sentinel "76561197960287930",
// and AuthenticationManager.LoginByChannel jumps to StartOfflineLogin.
//
// Differs from Cmune's original in two ways:
//   1. Never calls Application.Quit() on failure — Editor Play must keep running.
//   2. Every Steamworks call is wrapped in try/catch so a missing native DLL
//      downgrades to offline mode instead of unwinding across the engine.
//
// Unity 4.6 has no [RuntimeInitializeOnLoadMethod] — init still runs from
// Start() on the SteamManager GameObject placed in the bootstrap scene.
using System;
using System.Text;
using Steamworks;
using UnityEngine;

internal class SteamManager : MonoBehaviour
{
	private static SteamManager m_instance;
	private static bool s_bInitialized;

	private SteamAPIWarningMessageHook_t m_SteamAPIWarningMessageHook;

	public static bool Initialized
	{
		get { return s_bInitialized; }
	}

	private static void SteamAPIDebugTextHook(int nSeverity, StringBuilder pchDebugText)
	{
		Debug.LogWarning(pchDebugText);
	}

	private void Awake()
	{
	}

	private void Start()
	{
		Debug.Log("INITIALIZING STEAMWORKS SDK");
		if (m_instance != null)
		{
			UnityEngine.Object.Destroy(base.gameObject);
			return;
		}
		m_instance = this;
		try
		{
			if (SteamAPI.RestartAppIfNecessary((AppId_t)291210u))
			{
				// Standalone-only: relaunch via Steam. In Editor this never fires
				// because SteamAPI throws DllNotFoundException first.
				Application.Quit();
				return;
			}
		}
		catch (DllNotFoundException ex)
		{
			Debug.LogWarning("[SteamManager] CSteamworks/steam_api native DLL missing — offline fallback active. " + ex.Message);
			return;
		}
		catch (Exception ex)
		{
			Debug.LogWarning("[SteamManager] SteamAPI.RestartAppIfNecessary threw — offline fallback active. " + ex.Message);
			return;
		}
		try
		{
			if (SteamAPI.Init())
			{
				s_bInitialized = true;
				Debug.Log("SteamAPI was successfully initialized!");
				if (!SteamUser.BLoggedOn())
				{
					Debug.LogWarning("[Steamworks.NET] Steam user not logged in — offline fallback active.");
					s_bInitialized = false;
				}
			}
			else
			{
				Debug.LogWarning("[Steamworks.NET] SteamAPI_Init() returned false — offline fallback active.");
			}
		}
		catch (DllNotFoundException ex)
		{
			Debug.LogWarning("[SteamManager] SteamAPI.Init missing native dep — offline fallback active. " + ex.Message);
		}
		catch (Exception ex)
		{
			Debug.LogWarning("[SteamManager] SteamAPI.Init threw — offline fallback active. " + ex.Message);
		}
	}

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

	private void OnDestroy()
	{
		if (m_instance == this)
		{
			m_instance = null;
			s_bInitialized = false;
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
