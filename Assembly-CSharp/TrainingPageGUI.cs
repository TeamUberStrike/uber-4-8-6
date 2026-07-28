using UberStrike.Core.Models;
using UnityEngine;

public class TrainingPageGUI : MonoBehaviour
{
	private const int PageWidth = 700;

	private const int PageHeight = 480;

	private const int MapsPerRow = 4;

	private Vector2 _mapScroll;

	private static bool _lowGravity;
	private static bool _quickSwitch;

	public static bool LowGravityEnabled => _lowGravity;
	public static bool QuickSwitchEnabled => _quickSwitch;

	private void OnGUI()
	{
		GUI.depth = 11;
		GUI.skin = BlueStonez.Skin;
		GUI.BeginGroup(new Rect((float)(Screen.width - 700) * 0.5f, (float)(Screen.height - GlobalUIRibbon.Instance.Height() - 480) * 0.5f, 700f, 480f), string.Empty, BlueStonez.window);
		GUI.Label(new Rect(10f, 20f, 670f, 48f), LocalizedStrings.ExploreMaps, BlueStonez.label_interparkbold_48pt);
		GUI.Label(new Rect(30f, 50f, 640f, 120f), LocalizedStrings.TrainingModeDesc, BlueStonez.label_interparkbold_13pt);

		// Low Gravity + Quick Switch toggles — restored to match original 4.3.8/4.7 layout.
		// GameFlags applied when the player picks a map (see LoadMap delegate below).
		_lowGravity  = GUI.Toggle(new Rect(20f, 124f, 180f, 24f), _lowGravity,  LocalizedStrings.LowGravity, BlueStonez.toggle);
		_quickSwitch = GUI.Toggle(new Rect(20f, 146f, 180f, 24f), _quickSwitch, "Quick Switch",             BlueStonez.toggle);

		GUI.Box(new Rect(12f, 172f, 670f, 20f), string.Empty, BlueStonez.box_grey50);
		GUI.Label(new Rect(16f, 172f, 120f, 20f), LocalizedStrings.ChooseAMap, BlueStonez.label_interparkbold_18pt_left);
		int num = 280;
		GUI.Box(new Rect(12f, 191f, 670f, num), string.Empty, BlueStonez.window);
		int num2 = 0;
		if (Singleton<MapManager>.Instance.Count > 0)
		{
			num2 = (Singleton<MapManager>.Instance.Count - 1) / 4 + 1;
		}
		_mapScroll = GUITools.BeginScrollView(new Rect(0f, 191f, 682f, num), _mapScroll, new Rect(0f, 0f, 655f, 10 + 80 * num2));
		Vector2 v = new Vector2(163f, 80f);
		int num3 = 0;
		foreach (UberstrikeMap allMap in Singleton<MapManager>.Instance.AllMaps)
		{
			if (!allMap.IsVisible)
			{
				continue;
			}
			Color white = Color.white;
			int num4 = num3 / 4;
			int num5 = num3 % 4;
			Rect rect = new Rect(13f + (float)num5 * v.Width(), (float)num4 * v.y + 4f, v.x, v.y);
			if (GUI.Button(rect, string.Empty, BlueStonez.gray_background) && !GUITools.IsScrolling && !Singleton<SceneLoader>.Instance.IsLoading && allMap != null)
			{
				Singleton<MapManager>.Instance.LoadMap(allMap, delegate
				{
					Singleton<GameStateController>.Instance.SetGameMode(new TrainingRoom());
					GameState.Current.Actions.JoinTeam(TeamID.NONE);
					ApplyTrainingFlags();
				});
			}
			GUI.BeginGroup(rect);
			allMap.Icon.Draw(rect.CenterHorizontally(2f, 100f, 64f));
			// Use full cell width for the label with MiddleCenter alignment so long map
			// names like "Temple of the Raven" and "SuperPRISM Reactor" don't clip into
			// neighbouring cells. Previous layout used the natural text width which
			// overflowed when Unity 6 metrics differ from the legacy interparkbold font.
			var labelStyle = new GUIStyle(BlueStonez.label_interparkbold_11pt)
			{
				alignment = TextAnchor.MiddleCenter,
				wordWrap = false,
				clipping = TextClipping.Clip,
			};
			GUI.contentColor = white;
			GUI.Label(new Rect(2f, rect.height - 18f, rect.width - 4f, 16f), allMap.Name, labelStyle);
			GUI.contentColor = Color.white;
			GUI.EndGroup();
			num3++;
		}
		GUITools.EndScrollView();
		GUI.EndGroup();
		GUI.enabled = true;
	}

	private static void ApplyTrainingFlags()
	{
		if (GameState.Current == null || GameState.Current.Player == null || GameState.Current.Player.MoveController == null)
			return;
		GameState.Current.Player.MoveController.IsLowGravity = _lowGravity;
		// Quick Switch doesn't have a MoveController flag — it's a weapon-switch setting
		// applied by WeaponController via RoomData.GameFlags. For training (offline) there's
		// no RoomData; the flag is parked here for WeaponController to consume if it checks
		// TrainingPageGUI.QuickSwitchEnabled.
	}
}
