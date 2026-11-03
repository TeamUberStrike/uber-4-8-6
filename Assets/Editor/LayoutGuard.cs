using System.IO;
using UnityEditor;

[InitializeOnLoad]
public static class LayoutGuard
{
	static LayoutGuard()
	{
		if (!Directory.Exists("Assets/Scripts/Assembly-CSharp") || !Directory.Exists("Assets/Plugins/Assembly-CSharp-firstpass"))
		{
			EditorUtility.DisplayDialog("UberStrike: code folders not linked", "Close Unity WITHOUT saving and run tools\\setup-links.bat (or open the project with tools\\open-project.bat). Scenes show missing scripts until the links exist.", "OK");
		}
	}
}
