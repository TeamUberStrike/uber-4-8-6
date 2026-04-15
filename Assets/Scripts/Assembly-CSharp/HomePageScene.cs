public class HomePageScene : PageScene
{
	public override PageType PageType
	{
		get
		{
			return PageType.Home;
		}
	}

	protected override void OnLoad()
	{
		if ((bool)_avatarAnchor)
		{
			// If the Decorator was destroyed during a match→lobby transition
			// (AuthenticationManager calls AvatarBuilder.Destroy on the old one),
			// re-create it now using the same CreateLocalAvatar path that the
			// initial login uses. Without this fallback the lobby has no visible
			// avatar on every return after the first match.
			if (GameState.Current.Avatar.Decorator == null)
			{
				GameState.Current.Avatar.SetDecorator(AvatarBuilder.CreateLocalAvatar());
			}
			if ((bool)GameState.Current.Avatar.Decorator)
			{
				GameState.Current.Avatar.Decorator.SetPosition(_avatarAnchor.position, _avatarAnchor.rotation);
				GameState.Current.Avatar.HideWeapons();
				GameState.Current.Avatar.Decorator.HudInformation.SetAvatarLabel(PlayerDataManager.NameAndTag);
			}
		}
		Singleton<EventPopupManager>.Instance.ShowNextPopup(1);
	}
}
