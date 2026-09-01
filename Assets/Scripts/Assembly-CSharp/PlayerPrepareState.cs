using UnityEngine;

internal class PlayerPrepareState : IState
{
	public PlayerPrepareState(StateMachine<PlayerStateId> stateMachine)
	{
	}

	public void OnEnter()
	{
		GameState.Current.Player.InitializePlayer();
		AutoMonoBehaviour<InputManager>.Instance.IsInputEnabled = false;
		Singleton<QuickItemController>.Instance.IsEnabled = false;
		GameState.Current.Player.EnableWeaponControl = false;
		Screen.lockCursor = true;
		// Warm the exact shader variants the first ESC/pause will compile by rendering ONE real
		// MainCamera frame in the Paused (OrbitAround) config, off-screen (no flash), once per map.
		// Reproduces Steam's free pregame-Overview warm-up, which our collapsed spawn flow skips.
		LevelCamera.WarmPausedCameraVariants();
		LevelCamera.SetMode(LevelCamera.CameraMode.FirstPerson);
		EventHandler.Global.Fire(new GameEvents.PlayerIngame());
		AutoMonoBehaviour<UnityRuntime>.Instance.OnFixedUpdate += GameState.Current.Player.MoveController.UpdatePlayerMovement;
	}

	public void OnResume()
	{
	}

	public void OnExit()
	{
		AutoMonoBehaviour<UnityRuntime>.Instance.OnFixedUpdate -= GameState.Current.Player.MoveController.UpdatePlayerMovement;
	}

	public void OnUpdate()
	{
	}
}
