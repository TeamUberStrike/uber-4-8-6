using System.Reflection;
using UnityEngine;

public static class PopupSkin
{
	public static GUIStyle box = GUIStyle.none;

	public static GUIStyle label = GUIStyle.none;

	public static GUIStyle textField = GUIStyle.none;

	public static GUIStyle textArea = GUIStyle.none;

	public static GUIStyle button = GUIStyle.none;

	public static GUIStyle toggle = GUIStyle.none;

	public static GUIStyle window = GUIStyle.none;

	public static GUIStyle horizontalSlider = GUIStyle.none;

	public static GUIStyle horizontalSliderThumb = GUIStyle.none;

	public static GUIStyle verticalSlider = GUIStyle.none;

	public static GUIStyle verticalSliderThumb = GUIStyle.none;

	public static GUIStyle horizontalScrollbar = GUIStyle.none;

	public static GUIStyle horizontalScrollbarThumb = GUIStyle.none;

	public static GUIStyle horizontalScrollbarLeftButton = GUIStyle.none;

	public static GUIStyle horizontalScrollbarRightButton = GUIStyle.none;

	public static GUIStyle verticalScrollbar = GUIStyle.none;

	public static GUIStyle verticalScrollbarThumb = GUIStyle.none;

	public static GUIStyle verticalScrollbarUpButton = GUIStyle.none;

	public static GUIStyle verticalScrollbarDownButton = GUIStyle.none;

	public static GUIStyle scrollView = GUIStyle.none;

	public static GUIStyle title = GUIStyle.none;

	public static GUIStyle button_green = GUIStyle.none;

	public static GUIStyle button_red = GUIStyle.none;

	public static GUIStyle label_loading = GUIStyle.none;

	public static GUISkin Skin { get; private set; }

	public static void Initialize(GUISkin skin)
	{
		Skin = skin;
		box = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("box"));
		label = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("label"));
		textField = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("textField"));
		textArea = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("textArea"));
		button = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("button"));
		toggle = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("toggle"));
		window = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("window"));
		horizontalSlider = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("horizontalSlider"));
		horizontalSliderThumb = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("horizontalSliderThumb"));
		verticalSlider = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("verticalSlider"));
		verticalSliderThumb = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("verticalSliderThumb"));
		horizontalScrollbar = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("horizontalScrollbar"));
		horizontalScrollbarThumb = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("horizontalScrollbarThumb"));
		horizontalScrollbarLeftButton = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("horizontalScrollbarLeftButton"));
		horizontalScrollbarRightButton = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("horizontalScrollbarRightButton"));
		verticalScrollbar = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("verticalScrollbar"));
		verticalScrollbarThumb = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("verticalScrollbarThumb"));
		verticalScrollbarUpButton = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("verticalScrollbarUpButton"));
		verticalScrollbarDownButton = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("verticalScrollbarDownButton"));
		scrollView = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("scrollView"));
		title = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("title"));
		button_green = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("button_green"));
		button_red = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("button_red"));
		label_loading = LocalizationHelper.GetLocalizedStyle(Skin.GetStyle("label_loading"));

		// Same Unity-6 font fallback as BlueStonez.Initialize: the legacy
		// bitmap fonts on these styles can't be rendered by IMGUI, so
		// assign the built-in LegacyRuntime.ttf in their place. Walk the
		// Skin's customStyles + the static fields via reflection.
		Font fallbackFont = Resources.GetBuiltinResource<Font>("LegacyRuntime.ttf");
		if (fallbackFont == null) fallbackFont = Resources.GetBuiltinResource<Font>("Arial.ttf");
		if (fallbackFont != null && Skin != null)
		{
			foreach (GUIStyle gs in Skin.customStyles)
			{
				if (gs != null && (gs.font == null || gs.font.dynamic == false)) gs.font = fallbackFont;
			}
			if (Skin.box != null) Skin.box.font = fallbackFont;
			if (Skin.label != null) Skin.label.font = fallbackFont;
			if (Skin.button != null) Skin.button.font = fallbackFont;
			if (Skin.textField != null) Skin.textField.font = fallbackFont;
			if (Skin.textArea != null) Skin.textArea.font = fallbackFont;
			if (Skin.toggle != null) Skin.toggle.font = fallbackFont;
			if (Skin.window != null) Skin.window.font = fallbackFont;
			Skin.font = fallbackFont;

			FieldInfo[] fields = typeof(PopupSkin).GetFields(BindingFlags.Public | BindingFlags.Static);
			foreach (FieldInfo f in fields)
			{
				if (f.FieldType != typeof(GUIStyle)) continue;
				GUIStyle gs = f.GetValue(null) as GUIStyle;
				if (gs == null) continue;
				if (gs.font == null || gs.font.dynamic == false) gs.font = fallbackFont;
			}
		}
	}
}
