using System;
using System.Collections;
using System.Collections.Generic;
using Cmune.DataCenter.Common.Entities;
using Steamworks;
using UberStrike.Core.Models.Views;
using UberStrike.Core.Types;
using UberStrike.Core.ViewModel;
using UberStrike.DataCenter.Common.Entities;
using UberStrike.WebService.Unity;
using UnityEngine;

public class AuthenticationManager : Singleton<AuthenticationManager>
{
	private ProgressPopupDialog _progress;

	private Callback<GetAuthSessionTicketResponse_t> m_GetAuthSessionTicketResponse;

	public bool IsAuthComplete { get; private set; }

	private AuthenticationManager()
	{
		_progress = new ProgressPopupDialog(LocalizedStrings.SettingUp, LocalizedStrings.ProcessingLogin);
	}

	public void SetAuthComplete(bool enabled)
	{
		IsAuthComplete = enabled;
	}

	// DEV: flip to true to bypass the OFFLINE_STEAMID guard in-editor and exercise
	// the real UBZ email auth path. Requires UBZ server running and a user account
	// at DEV_REAL_AUTH_EMAIL / DEV_REAL_AUTH_PASS (create one via the in-game
	// signup flow once if needed). Flip back to false for offline iteration.
	private const bool DEV_REAL_AUTH_TEST = false;
	private const string DEV_REAL_AUTH_EMAIL = "aaa@bbb.com";
	private const string DEV_REAL_AUTH_PASS = "dev123";

	public void LoginByChannel()
	{
		string text = PlayerPrefs.GetString("CurrentSteamUser", string.Empty);
		Debug.Log(string.Format("SteamWorks SteamID:{0}, PlayerPrefs SteamID:{1}", PlayerDataManager.SteamId, text));

		if (DEV_REAL_AUTH_TEST)
		{
			Debug.LogWarning("[AuthenticationManager] DEV_REAL_AUTH_TEST=true — routing to UBZ email auth ("
				+ DEV_REAL_AUTH_EMAIL + ").");
			UnityRuntime.StartRoutine(StartLoginMemberEmailDirect(DEV_REAL_AUTH_EMAIL, DEV_REAL_AUTH_PASS));
			return;
		}

		// Offline editor bypass — when SteamId returns the hardcoded sentinel
		// from PlayerDataManager.SteamId (uninit SteamManager / DllNotFoundException
		// path), UBZ would reject the empty Steam ticket and the auth chain
		// infinite-loops on the error popup. Skip the LoginSteam → CompleteAuthentication
		// flow entirely; jump straight to the home page with minimal stub state so
		// the menu UI can paint and we can iterate from there.
		Debug.LogWarning("[AuthenticationManager] LoginByChannel: SteamId='" + PlayerDataManager.SteamId
			+ "' SteamManager.Initialized=" + SteamManager.Initialized
			+ " — choosing " + (PlayerDataManager.SteamId == PlayerDataManager.OFFLINE_STEAMID ? "OFFLINE BYPASS" : "REAL STEAM PATH"));
		if (PlayerDataManager.SteamId == PlayerDataManager.OFFLINE_STEAMID)
		{
			// Real auth scope (re-investigated 2026-05-25): UBZ AspNetCore server uses
			// Rijndael-encrypted request bodies (CryptoHelper.DecryptRequest) for auth
			// methods, plus a custom AuthProxy43 response format that differs from the
			// shared MemberAuthenticationResultViewProxy in field order, mask bits, and
			// nested proxies (MemberWalletView/PublicProfileView/PlayerStatisticsView).
			// 4.7.1 client lacks the crypto layer AND has stock proxies — so real auth
			// requires porting RijndaelCipher.cs + 4 proxy rewrites. Multi-hour port,
			// deferred. Offline bypass remains the editor path.
			UnityRuntime.StartRoutine(StartOfflineLogin());
			return;
		}

		if (string.IsNullOrEmpty(text) || text != PlayerDataManager.SteamId)
		{
			Debug.Log(string.Format("No SteamID saved. Using SteamWorks SteamID:{0}", PlayerDataManager.SteamId));
			PopupSystem.ShowMessage(string.Empty, "Have you played UberStrike before?", PopupSystem.AlertType.OKCancel, delegate
			{
				UnityRuntime.StartRoutine(StartLoginMemberSteam(true));
			}, "No", delegate
			{
				PopupSystem.ShowMessage(string.Empty, "Do you want to upgrade an UberStrike.com or Facebook account?\n\nNOTE: This will permenantly link your UberStrike account to this Steam ID", PopupSystem.AlertType.OKCancel, delegate
				{
					UnityRuntime.StartRoutine(StartLoginMemberSteam(true));
				}, "No", delegate
				{
					UnityRuntime.StartRoutine(StartLoginMemberSteam(false));
				}, "Yes");
			}, "Yes");
		}
		else
		{
			Debug.Log(string.Format("Login using saved SteamID:{0}", text));
			UnityRuntime.StartRoutine(StartLoginMemberSteam(true));
		}
	}

	public IEnumerator StartLoginMemberEmail(string emailAddress, string password)
	{
		if (string.IsNullOrEmpty(emailAddress) || string.IsNullOrEmpty(password))
		{
			ShowLoginErrorPopup(LocalizedStrings.Error, "Your login credentials are not correct. Please try to login again.");
			yield break;
		}
		_progress.Text = "Authenticating Account";
		_progress.Progress = 0.1f;
		PopupSystem.Show(_progress);
		MemberAuthenticationResultView authenticationView = null;
		if (ApplicationDataManager.Channel == ChannelType.Steam)
		{
			yield return AuthenticationWebServiceClient.LinkSteamMember(emailAddress, password, PlayerDataManager.SteamId, SystemInfo.deviceUniqueIdentifier, delegate(MemberAuthenticationResultView ev)
			{
				authenticationView = ev;
				PlayerPrefs.SetString("CurrentSteamUser", PlayerDataManager.SteamId);
				PlayerPrefs.Save();
			}, delegate
			{
			});
		}
		else
		{
			yield return AuthenticationWebServiceClient.LoginMemberEmail(emailAddress, password, ApplicationDataManager.Channel, SystemInfo.deviceUniqueIdentifier, delegate(MemberAuthenticationResultView ev)
			{
				authenticationView = ev;
			}, delegate
			{
			});
		}
		if (authenticationView == null)
		{
			ShowLoginErrorPopup(LocalizedStrings.Error, "The login could not be processed. Please check your internet connection and try again.");
		}
		else
		{
			yield return UnityRuntime.StartRoutine(CompleteAuthentication(authenticationView));
		}
	}

	// Dev-only: routes around the Steam-link branch in StartLoginMemberEmail by passing
	// ChannelType.WindowsStandalone directly. ApplicationDataManager.Channel stays Steam
	// globally (other code paths still gate correctly); only the LoginMemberEmail call
	// itself uses WindowsStandalone so UBZ treats this as a plain email auth, not a Steam link.
	public IEnumerator StartLoginMemberEmailDirect(string emailAddress, string password)
	{
		if (string.IsNullOrEmpty(emailAddress) || string.IsNullOrEmpty(password))
		{
			ShowLoginErrorPopup(LocalizedStrings.Error, "Dev login: empty email/password.");
			yield break;
		}
		_progress.Text = "Authenticating (UBZ email)";
		_progress.Progress = 0.1f;
		PopupSystem.Show(_progress);
		MemberAuthenticationResultView authenticationView = null;
		yield return AuthenticationWebServiceClient.LoginMemberEmail(emailAddress, password, ChannelType.WindowsStandalone, SystemInfo.deviceUniqueIdentifier, delegate(MemberAuthenticationResultView ev)
		{
			authenticationView = ev;
		}, delegate(Exception ex)
		{
			Debug.LogError("[AuthenticationManager] LoginMemberEmail SOAP error: " + (ex != null ? ex.Message : "(null)"));
		});
		if (authenticationView == null)
		{
			ShowLoginErrorPopup(LocalizedStrings.Error, "UBZ email login failed (no response). Check server + proxy.");
			yield break;
		}
		Debug.Log("[AuthenticationManager] UBZ email login result: " + authenticationView.MemberAuthenticationResult);
		yield return UnityRuntime.StartRoutine(CompleteAuthentication(authenticationView));
	}

	public IEnumerator StartOfflineLogin()
	{
		Debug.Log("[AuthenticationManager] Offline editor login bypass — skipping server auth.");
		// ApplicationDataManager.Channel is hard-coded to ChannelType.Steam already,
		// so CreditBundlesShopGui.BuyButton's `if (Channel == Steam)` guard passes
		// without us touching anything. Shop purchases route to BundleManager.BuyBundle.
		yield return new WaitForEndOfFrame();

		MemberView memberView = new MemberView
		{
			PublicProfile = new PublicProfileView
			{
				Cmid = 1,
				Name = "OfflineEditor",
				AccessLevel = MemberAccessLevel.Admin,
				IsChatDisabled = true,
				GroupTag = "DEV",
				LastLoginDate = DateTime.UtcNow,
				EmailAddressStatus = EmailAddressStatus.Verified,
				FacebookId = string.Empty,
			},
			MemberWallet = new MemberWalletView(),
			MemberItems = new List<int>(),
		};

		Singleton<PlayerDataManager>.Instance.SetLocalPlayerMemberView(memberView);
		PlayerDataManager.AuthToken = "OFFLINE_TOKEN";
		PlayerDataManager.MagicHash = "OFFLINE_HASH";
		ApplicationDataManager.ServerDateTime = DateTime.UtcNow;

		// Stub XpPointsUtil.Config — without it every call to XpPointsUtil.MaxPlayerLevel
		// / GetLevelForXp throws NRE. 99 levels with quadratic XP curve (level² × 100).
		ApplicationConfigurationView config = new ApplicationConfigurationView
		{
			MaxLevel = 99,
			MaxXp = 99 * 99 * 100,
			XpKill = 10,
			XpSmackdown = 5,
			XpHeadshot = 5,
			XpNutshot = 5,
			XpPerMinuteLoser = 1,
			XpPerMinuteWinner = 2,
			XpBaseLoser = 10,
			XpBaseWinner = 20,
			PointsKill = 1,
			PointsSmackdown = 1,
			PointsHeadshot = 1,
			PointsNutshot = 1,
			PointsPerMinuteLoser = 1,
			PointsPerMinuteWinner = 2,
			PointsBaseLoser = 5,
			PointsBaseWinner = 10,
			XpRequiredPerLevel = new Dictionary<int, int>(),
		};
		// Level 1 starts at 0 XP so a fresh player (XP=0) lands on level 1.
		// Each subsequent level needs (level-1)² × 100 XP cumulatively.
		for (int lvl = 1; lvl <= 99; lvl++)
		{
			config.XpRequiredPerLevel[lvl] = (lvl - 1) * (lvl - 1) * 100;
		}
		XpPointsUtil.Config = config;

		EventHandler.Global.Fire(new GlobalEvents.Login(MemberAccessLevel.Admin));
		Singleton<PlayerDataManager>.Instance.SetPlayerStatisticsView(new PlayerStatisticsView());

		// Avatar build with Animator-neutralization. The AssetRipper-emitted
		// DefaultAvatar prefab has a corrupt Animator state machine that crashes
		// Unity 4.6 mecanim native (StateMachine.cpp:1584 → EvaluateAvatarSM AV).
		// Strategy: instantiate the prefab, then immediately strip the runtime
		// Animator controller off every Animator we find on the new avatar so
		// mecanim never tries to evaluate the broken state machine. Result: avatar
		// renders in T-pose (static) but the lobby has a visible character.
		try
		{
			AvatarDecorator dec = AvatarBuilder.CreateLocalAvatar();
			if (dec != null)
			{
				Animator[] anims = dec.GetComponentsInChildren<Animator>(true);
				int killed = 0;
				foreach (Animator a in anims)
				{
					if (a == null) continue;
					// Null both — the crash is in EvaluateAvatarSM which walks the
					// Avatar's state machine; corruption could be in either the
					// runtime controller asset or the Avatar humanoid mapping.
					a.runtimeAnimatorController = null;
					a.avatar = null;
					a.enabled = false;
					killed++;
				}
				Debug.Log("[Offline] Avatar built; neutralized " + killed + " Animator(s) to dodge mecanim state-machine crash.");
				GameState.Current.Avatar.SetDecorator(dec);
				GameState.Current.Avatar.UpdateAllWeapons();
			}
			else
			{
				Debug.LogWarning("[Offline] AvatarBuilder.CreateLocalAvatar returned null.");
			}
		}
		catch (Exception ex)
		{
			Debug.LogWarning("[Offline] Avatar build failed (synchronous): " + ex.Message);
		}

		yield return new WaitForEndOfFrame();

		try { Singleton<InboxManager>.Instance.Initialize(); Debug.Log("[Offline] InboxManager.Initialize() fired."); }
		catch (Exception ex) { Debug.LogWarning("[Offline] InboxManager.Initialize() failed: " + ex.Message); }

		yield return new WaitForEndOfFrame();

		try { Singleton<BundleManager>.Instance.Initialize(); Debug.Log("[Offline] BundleManager.Initialize() fired."); }
		catch (Exception ex) { Debug.LogWarning("[Offline] BundleManager.Initialize() failed: " + ex.Message); }

		yield return new WaitForEndOfFrame();

		// Try real GetMaps from UBZ (via tls_proxy); if SOAP blows up, fall
		// back to the hardcoded 19-map list so MapManager has something to chew on.
		Coroutine mapsCoroutine = null;
		bool mapsLoadedFromServer = false;
		try
		{
			mapsCoroutine = ApplicationWebServiceClient.GetMaps("4.8.6", DefinitionType.StandardDefinition, delegate(List<MapView> callback)
			{
				bool loaded = Singleton<MapManager>.Instance.InitializeMapsToLoad(callback);
				mapsLoadedFromServer = loaded;
				Debug.Log("[Offline] MapManager.InitializeMapsToLoad result: " + loaded + ", count=" + Singleton<MapManager>.Instance.Count);
			}, delegate(Exception soapEx)
			{
				Debug.LogWarning("[Offline] ApplicationWebServiceClient.GetMaps SOAP error: " + (soapEx != null ? soapEx.GetType().Name + ": " + soapEx.Message : "(null)"));
			});
		}
		catch (Exception ex)
		{
			Debug.LogWarning("[Offline] GetMaps pre-yield exception: " + ex.Message);
		}
		if (mapsCoroutine != null)
		{
			yield return mapsCoroutine;
		}

		if (!mapsLoadedFromServer)
		{
			Debug.Log("[Offline] GetMaps server load failed — falling back to hardcoded map list.");
			try
			{
				List<MapView> fallbackMaps = BuildOfflineFallbackMapList();
				bool fallbackLoaded = Singleton<MapManager>.Instance.InitializeMapsToLoad(fallbackMaps);
				Debug.Log("[Offline] Hardcoded fallback InitializeMapsToLoad result: " + fallbackLoaded + ", count=" + Singleton<MapManager>.Instance.Count);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("[Offline] Fallback map list build failed: " + ex.Message);
			}
		}

		yield return new WaitForEndOfFrame();

		IEnumerator shopRoutine = null;
		try { shopRoutine = Singleton<ItemManager>.Instance.StartGetShop(); }
		catch (Exception ex) { Debug.LogWarning("[Offline] ItemManager.StartGetShop pre-yield exception: " + ex.Message); }
		if (shopRoutine != null)
		{
			yield return UnityRuntime.StartRoutine(shopRoutine);
			Debug.Log("[Offline] ItemManager.StartGetShop() completed. ItemMall valid: " + Singleton<ItemManager>.Instance.ValidateItemMall());
		}

		yield return new WaitForEndOfFrame();

		IEnumerator invRoutine = null;
		try { invRoutine = Singleton<ItemManager>.Instance.StartGetInventory(false); }
		catch (Exception ex) { Debug.LogWarning("[Offline] ItemManager.StartGetInventory pre-yield exception: " + ex.Message); }
		if (invRoutine != null)
		{
			yield return UnityRuntime.StartRoutine(invRoutine);
			Debug.Log("[Offline] ItemManager.StartGetInventory(false) completed.");
		}

		yield return new WaitForEndOfFrame();
		PopupSystem.HideMessage(_progress);

		try { MenuPageManager.Instance.LoadPage(PageType.Home); }
		catch (Exception ex) { Debug.LogError("[Offline] LoadPage(Home) failed: " + ex.Message + "\n" + ex.StackTrace); }

		// Editor camera diagnostic — force-enable all cameras + spawn fallback
		// if none. Unity 4.6 equivalent of Unity 6's FindObjectsByType is
		// Resources.FindObjectsOfTypeAll (returns active+inactive).
		yield return new WaitForEndOfFrame();

		Camera[] allCameras = Resources.FindObjectsOfTypeAll<Camera>();
		Debug.LogWarning("[Offline] Camera diagnostic: found " + allCameras.Length + " Camera component(s) in loaded scene(s).");
		for (int i = 0; i < allCameras.Length; i++)
		{
			Camera cam = allCameras[i];
			GameObject go = cam.gameObject;
			Debug.LogWarning(string.Format(
				"[Offline]   [{0}] '{1}' parent='{2}' active={3} enabled={4} tag='{5}' depth={6} pos={7}",
				i, go.name,
				(go.transform.parent != null ? go.transform.parent.name : "<root>"),
				go.activeInHierarchy, cam.enabled, go.tag, cam.depth, go.transform.position));
			if (!go.activeSelf) go.SetActive(true);
			if (!cam.enabled) cam.enabled = true;
			// Camera.targetDisplay added in Unity 5.4 — not available here.
			if (cam.rect.width <= 0f || cam.rect.height <= 0f)
			{
				cam.rect = new Rect(0f, 0f, 1f, 1f);
			}
		}

		if (allCameras.Length == 0 || Camera.main == null)
		{
			Debug.LogWarning("[Offline] Spawning brand-new fallback editor camera (Camera.main is " + (Camera.main == null ? "null" : "non-null") + ").");
			GameObject fallback = new GameObject("OfflineFallbackCamera");
			fallback.tag = "MainCamera";
			Camera fcam = fallback.AddComponent<Camera>();
			fcam.clearFlags = CameraClearFlags.Skybox;
			fcam.fieldOfView = 60f;
			fcam.nearClipPlane = 0.3f;
			fcam.farClipPlane = 500f;
			fcam.depth = -10;
			// Camera.targetDisplay added in Unity 5.4 — not available here.
			fallback.transform.position = new Vector3(2.5f, 1.7f, -3.5f);
			fallback.transform.LookAt(new Vector3(0f, 1.2f, 0f));
			fallback.AddComponent<AudioListener>();
		}

		IsAuthComplete = true;
		Debug.Log("[AuthenticationManager] Offline login complete — home page requested.");
	}

	// Hardcoded fallback map list for when GetMaps SOAP fails. Scene names
	// match the .unity files under Assets/ArtTools/Maps/*/*.unity so
	// MapManager.LoadMap can resolve them.
	private static List<MapView> BuildOfflineFallbackMapList()
	{
		string[,] mapData = new string[,]
		{
			{ "ApexTwin",           "Apex Twin" },
			{ "AqualabResearchHub", "Aqualab Research Hub" },
			{ "Catalyst",           "Catalyst" },
			{ "CuberSpace",         "CuberSpace" },
			{ "CuberStrike",        "CuberStrike" },
			{ "FortWinter",         "Fort Winter" },
			{ "GhostIsland",        "Ghost Island" },
			{ "GideonsTower",       "Gideons Tower" },
			{ "LostParadise2",      "Lost Paradise 2" },
			{ "MonkeyIsland",       "Monkey Island" },
			{ "SkyGarden",          "Sky Garden" },
			{ "SpacePortAlpha",     "Space Port Alpha" },
			{ "SuperPRISMReactor",  "Super PRISM Reactor" },
			{ "TempleOfTheRaven",   "Temple of the Raven" },
			{ "TheHangar",          "The Hangar" },
			{ "TheWarehouse",       "The Warehouse" },
			{ "UberZone",           "UberZone" },
			{ "Volley",             "Volley" },
		};
		List<MapView> list = new List<MapView>(mapData.GetLength(0));
		for (int i = 0; i < mapData.GetLength(0); i++)
		{
			MapView mv = new MapView();
			mv.SceneName = mapData[i, 0];
			mv.DisplayName = mapData[i, 1];
			mv.Description = mapData[i, 1];
			mv.MapId = i + 1;
			mv.MaxPlayers = 16;
			mv.RecommendedItemId = 0;
			mv.IsBlueBox = false;
			mv.SupportedGameModes = -1;
			mv.SupportedItemClass = -1;
			list.Add(mv);
		}
		return list;
	}

	public IEnumerator StartLoginMemberSteam(bool directSteamLogin)
	{
		if (directSteamLogin)
		{
			_progress.Text = "Authenticating with Steam";
			_progress.Progress = 0.05f;
			PopupSystem.Show(_progress);
			string authToken;
			try
			{
				m_GetAuthSessionTicketResponse = Callback<GetAuthSessionTicketResponse_t>.Create(OnGetAuthSessionTicketResponse);
				byte[] ticket = new byte[1024];
				uint pcbTicket;
				HAuthTicket authTicket = SteamUser.GetAuthSessionTicket(ticket, 1024, out pcbTicket);
				int num = (int)pcbTicket;
				authToken = num.ToString();
			}
			catch (DllNotFoundException)
			{
				Debug.LogWarning("[AuthenticationManager] Steamworks native DLL missing — using empty auth token (offline editor mode).");
				authToken = string.Empty;
			}
			catch (InvalidOperationException ex)
			{
				Debug.LogWarning("[AuthenticationManager] Steamworks not initialized — using empty auth token. " + ex.Message);
				authToken = string.Empty;
			}
			string machineId = SystemInfo.deviceUniqueIdentifier;
			MemberAuthenticationResultView authenticationView = null;
			_progress.Text = "Authenticating with UberStrike";
			_progress.Progress = 0.1f;
			yield return AuthenticationWebServiceClient.LoginSteam("4.8.6", PlayerDataManager.SteamId, authToken, machineId, delegate(MemberAuthenticationResultView result)
			{
				authenticationView = result;
				PlayerPrefs.SetString("CurrentSteamUser", PlayerDataManager.SteamId);
				PlayerPrefs.Save();
			}, delegate(Exception error)
			{
				Debug.LogError("Account authentication error: " + error);
				ShowLoginErrorPopup(LocalizedStrings.Error, "There was an error logging you in. Please try again or contact us at http://support.cmune.com");
			});
			yield return UnityRuntime.StartRoutine(CompleteAuthentication(authenticationView));
		}
		else
		{
			PopupSystem.ClearAll();
			yield return PanelManager.Instance.OpenPanel(PanelType.Login);
		}
	}

	private void OnGetAuthSessionTicketResponse(GetAuthSessionTicketResponse_t pCallback)
	{
		Debug.Log(string.Concat("[", 163, " - GetAuthSessionTicketResponse] - ", pCallback.m_hAuthTicket, " -- ", pCallback.m_eResult));
	}

	private IEnumerator CompleteAuthentication(MemberAuthenticationResultView authView, bool isRegistrationLogin = false)
	{
		if (authView == null)
		{
			Debug.LogError("Account authentication error: MemberAuthenticationResultView was null, isRegistrationLogin: " + isRegistrationLogin);
			ShowLoginErrorPopup(LocalizedStrings.Error, "There was an error logging you in. Please try again or contact us at http://support.cmune.com");
			yield break;
		}
		if (authView.MemberAuthenticationResult == MemberAuthenticationResult.IsBanned || authView.MemberAuthenticationResult == MemberAuthenticationResult.IsIpBanned)
		{
			ApplicationDataManager.LockApplication(LocalizedStrings.YourAccountHasBeenBanned);
			yield break;
		}
		if (authView.MemberAuthenticationResult == MemberAuthenticationResult.InvalidEsns)
		{
			Debug.Log("Result: " + authView.MemberAuthenticationResult);
			ShowLoginErrorPopup(LocalizedStrings.Error, "Sorry this account is linked already.");
			yield break;
		}
		if (authView.MemberAuthenticationResult != MemberAuthenticationResult.Ok)
		{
			Debug.Log("Result: " + authView.MemberAuthenticationResult);
			ShowLoginErrorPopup(LocalizedStrings.Error, "Your login credentials are not correct. Please try to login again.");
			yield break;
		}
		Singleton<PlayerDataManager>.Instance.SetLocalPlayerMemberView(authView.MemberView);
		PlayerDataManager.AuthToken = authView.AuthToken;
		if (!PlayerDataManager.IsTestBuild)
		{
			PlayerDataManager.MagicHash = UberDaemon.Instance.GetMagicHash(authView.AuthToken);
			Debug.Log("Magic Hash:" + PlayerDataManager.MagicHash);
		}
		ApplicationDataManager.ServerDateTime = authView.ServerTime;
		EventHandler.Global.Fire(new GlobalEvents.Login(authView.MemberView.PublicProfile.AccessLevel));
		_progress.Text = LocalizedStrings.LoadingFriendsList;
		_progress.Progress = 0.2f;
		yield return UnityRuntime.StartRoutine(Singleton<CommsManager>.Instance.GetContactsByGroups());
		_progress.Text = LocalizedStrings.LoadingCharacterData;
		_progress.Progress = 0.3f;
		yield return ApplicationWebServiceClient.GetConfigurationData("4.7.1", delegate(ApplicationConfigurationView appConfigView)
		{
			XpPointsUtil.Config = appConfigView;
		}, delegate
		{
			ApplicationDataManager.LockApplication(LocalizedStrings.ErrorLoadingData);
		});
		Singleton<PlayerDataManager>.Instance.SetPlayerStatisticsView(authView.PlayerStatisticsView);
		_progress.Text = LocalizedStrings.LoadingMapData;
		_progress.Progress = 0.5f;
		bool mapsLoadedSuccessfully = false;
		yield return ApplicationWebServiceClient.GetMaps("4.7.1", DefinitionType.StandardDefinition, delegate(List<MapView> callback)
		{
			mapsLoadedSuccessfully = Singleton<MapManager>.Instance.InitializeMapsToLoad(callback);
		}, delegate
		{
			ApplicationDataManager.LockApplication(LocalizedStrings.ErrorLoadingMaps);
		});
		if (!mapsLoadedSuccessfully)
		{
			ShowLoginErrorPopup(LocalizedStrings.Error, LocalizedStrings.ErrorLoadingMapsSupport);
			PopupSystem.HideMessage(_progress);
			yield break;
		}
		_progress.Progress = 0.6f;
		_progress.Text = LocalizedStrings.LoadingWeaponAndGear;
		yield return UnityRuntime.StartRoutine(Singleton<ItemManager>.Instance.StartGetShop());
		if (!Singleton<ItemManager>.Instance.ValidateItemMall())
		{
			PopupSystem.HideMessage(_progress);
			yield break;
		}
		_progress.Progress = 0.7f;
		_progress.Text = LocalizedStrings.LoadingPlayerInventory;
		yield return UnityRuntime.StartRoutine(Singleton<ItemManager>.Instance.StartGetInventory(false));
		_progress.Progress = 0.8f;
		_progress.Text = LocalizedStrings.GettingPlayerLoadout;
		yield return UnityRuntime.StartRoutine(Singleton<PlayerDataManager>.Instance.StartGetLoadout());
		if (!Singleton<LoadoutManager>.Instance.ValidateLoadout())
		{
			ShowLoginErrorPopup(LocalizedStrings.ErrorGettingPlayerLoadout, LocalizedStrings.ErrorGettingPlayerLoadoutSupport);
			yield break;
		}
		_progress.Progress = 0.85f;
		_progress.Text = LocalizedStrings.LoadingPlayerStatistics;
		yield return UnityRuntime.StartRoutine(Singleton<PlayerDataManager>.Instance.StartGetMember());
		if (!Singleton<PlayerDataManager>.Instance.ValidateMemberData())
		{
			ShowLoginErrorPopup(LocalizedStrings.ErrorGettingPlayerStatistics, LocalizedStrings.ErrorPlayerStatisticsSupport);
			yield break;
		}
		_progress.Progress = 0.9f;
		_progress.Text = LocalizedStrings.LoadingClanData;
		yield return ClanWebServiceClient.GetMyClanId(PlayerDataManager.AuthToken, delegate(int id)
		{
			PlayerDataManager.ClanID = id;
		}, delegate
		{
		});
		if (PlayerDataManager.ClanID > 0)
		{
			yield return ClanWebServiceClient.GetOwnClan(PlayerDataManager.AuthToken, PlayerDataManager.ClanID, delegate(ClanView ev)
			{
				Singleton<ClanDataManager>.Instance.SetClanData(ev);
			}, delegate
			{
			});
		}
		GameState.Current.Avatar.SetDecorator(AvatarBuilder.CreateLocalAvatar());
		GameState.Current.Avatar.UpdateAllWeapons();
		yield return new WaitForEndOfFrame();
		Singleton<InboxManager>.Instance.Initialize();
		yield return new WaitForEndOfFrame();
		Singleton<BundleManager>.Instance.Initialize();
		yield return new WaitForEndOfFrame();
		PopupSystem.HideMessage(_progress);
		if (!authView.IsAccountComplete)
		{
			PanelManager.Instance.OpenPanel(PanelType.CompleteAccount);
		}
		else
		{
			MenuPageManager.Instance.LoadPage(PageType.Home);
			IsAuthComplete = true;
		}
		Debug.LogWarning(string.Format("AuthToken:{0}, MagicHash:{1}", PlayerDataManager.AuthToken, PlayerDataManager.MagicHash));
	}

	public void StartLogout()
	{
		UnityRuntime.StartRoutine(Logout());
	}

	private IEnumerator Logout()
	{
		if (GameState.Current.HasJoinedGame)
		{
			Singleton<GameStateController>.Instance.LeaveGame();
			yield return new WaitForSeconds(3f);
		}
		MenuPageManager.Instance.LoadPage(PageType.Home);
		MenuPageManager.Instance.UnloadCurrentPage();
		GlobalUIRibbon.Instance.Hide();
		if (GameState.Current.Avatar.Decorator != null)
		{
			AvatarBuilder.Destroy(GameState.Current.Avatar.Decorator.gameObject);
		}
		GameState.Current.Avatar.SetDecorator(null);
		Singleton<PlayerDataManager>.Instance.Dispose();
		Singleton<InventoryManager>.Instance.Dispose();
		Singleton<LoadoutManager>.Instance.Dispose();
		Singleton<ClanDataManager>.Instance.Dispose();
		Singleton<ChatManager>.Instance.Dispose();
		Singleton<InboxManager>.Instance.Dispose();
		Singleton<TransactionHistory>.Instance.Dispose();
		Singleton<BundleManager>.Instance.Dispose();
		Singleton<GameStateController>.Instance.ResetClient();
		AutoMonoBehaviour<CommConnectionManager>.Instance.Reconnect();
		InboxThread.Current = null;
		EventHandler.Global.Fire(new GlobalEvents.Logout());
		GameData.Instance.MainMenu.Value = MainMenuState.Logout;
		Application.Quit();
	}

	private void ShowLoginErrorPopup(string title, string message)
	{
		Debug.Log("Login Error!");
		PopupSystem.HideMessage(_progress);
		PopupSystem.ShowMessage(title, message, PopupSystem.AlertType.OK, delegate
		{
			LoginPanelGUI.ErrorMessage = string.Empty;
			LoginByChannel();
		});
	}
}
