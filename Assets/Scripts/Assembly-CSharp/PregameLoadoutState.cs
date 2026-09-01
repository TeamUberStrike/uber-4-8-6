using System.Collections;
using UnityEngine;

internal class PregameLoadoutState : IState
{
	private StateMachine<GameStateId> stateMachine;

	private bool _enteringMatch;

	public PregameLoadoutState(StateMachine<GameStateId> stateMachine)
	{
		this.stateMachine = stateMachine;
	}

	public void OnEnter()
	{
		_enteringMatch = false;
		GamePageManager.Instance.LoadPage(IngamePageType.PreGame);
		Singleton<QuickItemController>.Instance.Restriction.RenewRoundUses();
		EventHandler.Global.AddListener<GameEvents.PlayerRespawn>(OnPlayerRespawn);
		SpawnLocalAvatar();
		if (GameState.Current.IsMultiplayer)
		{
			Singleton<ChatManager>.Instance.SetGameSection(GameState.Current.RoomData.Server.ConnectionString, GameState.Current.RoomData.Number, GameState.Current.RoomData.MapID, GameState.Current.Players.Values);
		}
	}

	public void OnExit()
	{
		EventHandler.Global.RemoveListener<GameEvents.PlayerRespawn>(OnPlayerRespawn);
		GamePageManager.Instance.UnloadCurrentPage();
	}

	public void OnResume()
	{
	}

	private void SpawnLocalAvatar()
	{
		if ((bool)GameState.Current.Avatar.Decorator)
		{
			GameState.Current.Player.SpawnPlayerAt(GameState.Current.Map.DefaultSpawnPoint.position, GameState.Current.Map.DefaultSpawnPoint.rotation);
			GameState.Current.Avatar.Decorator.SetPosition(GameState.Current.Map.DefaultSpawnPoint.position, GameState.Current.Map.DefaultSpawnPoint.rotation);
			GameState.Current.Avatar.HideWeapons();
		}
		GameState.Current.PlayerState.SetState(PlayerStateId.Overview);
	}

	public void OnUpdate()
	{
	}

	// ESC-first-pause invisible-avatar fix (client-side, chosen after the Steam-exact server
	// route was proven inert by uber-audit: SendPrepareNextRound puts the client in FirstPerson
	// for the whole countdown, so no server spawn-retiming can warm the third-person avatar).
	// On a local server the respawn arrives immediately, collapsing the pregame OrbitAround
	// Overview (which DOES render the third-person avatar) to ~0 frames, so the decorator is
	// first drawn cold at the first ESC -> 1-2s invisible on heavy maps. Hold here in Overview
	// until the avatar's combined SkinnedMeshRenderer has actually been drawn (isVisible for 2
	// frames = bounds settled + shader variants compiled), realtime-timeout-capped so it can
	// never wedge match start, THEN run the ORIGINAL transition byte-for-byte. Same class as the
	// existing WarmPausedCameraVariants / updateWhenOffscreen reconstruction compensations.
	// uber-audit: correctness/regression/output-sanity/provenance CONFIRM; parity-drift accepted.
	private void OnPlayerRespawn(GameEvents.PlayerRespawn ev)
	{
		if (_enteringMatch)
		{
			return;
		}
		_enteringMatch = true;
		UnityRuntime.StartRoutine(EnterMatchWhenAvatarWarm(ev));
	}

	private IEnumerator EnterMatchWhenAvatarWarm(GameEvents.PlayerRespawn ev)
	{
		SkinnedMeshRenderer smr = null;
		if (GameState.Current.IsLocalAvatarLoaded && (bool)GameState.Current.Avatar.Decorator)
		{
			smr = GameState.Current.Avatar.Decorator.GetComponentInChildren<SkinnedMeshRenderer>();
		}
		// Heavy maps run ~2-5 FPS, so WaitForEndOfFrame is ~200-500ms; 2s leaves headroom for two
		// presented frames and can never wedge match start (uses realtime, not scaled time).
		float deadline = Time.realtimeSinceStartup + 2f;
		int visibleFrames = 0;
		while (smr != null && visibleFrames < 2 && Time.realtimeSinceStartup < deadline)
		{
			yield return new WaitForEndOfFrame();
			if (smr == null || !smr.gameObject.activeInHierarchy)
			{
				break;
			}
			visibleFrames = (smr.isVisible ? (visibleFrames + 1) : 0);
		}
		if (stateMachine.CurrentStateId != GameStateId.PregameLoadout)
		{
			yield break;
		}
		stateMachine.SetState(GameStateId.MatchRunning);
		stateMachine.Events.Fire(ev);
	}
}
