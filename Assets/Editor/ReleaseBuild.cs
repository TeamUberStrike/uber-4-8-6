using System;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

// Command-line player build, used by tools\build-player.bat:
// Unity.exe -projectPath <repo> -executeMethod ReleaseBuild.Build -releaseOut <dir>
public static class ReleaseBuild
{
	static string Arg(string name, string def)
	{
		string[] a = Environment.GetCommandLineArgs();
		for (int i = 0; i < a.Length - 1; i++)
		{
			if (a[i] == name)
			{
				return a[i + 1];
			}
		}
		return def;
	}

	public static void Build()
	{
		string root = Path.GetDirectoryName(Application.dataPath);
		string outDir = Arg("-releaseOut", Path.Combine(root, "Build/UberStrike-4.7.1"));
		List<string> scenes = new List<string>();
		foreach (EditorBuildSettingsScene s in EditorBuildSettings.scenes)
		{
			if (s.enabled)
			{
				scenes.Add(s.path);
			}
		}
		Directory.CreateDirectory(outDir);
		string exe = Path.Combine(outDir, "UberStrike.exe");
		string err;
		try
		{
			err = BuildPipeline.BuildPlayer(scenes.ToArray(), exe, BuildTarget.StandaloneWindows, BuildOptions.None);
		}
		catch (Exception e)
		{
			err = e.GetType().Name + ": " + e.Message;
		}
		bool ok = string.IsNullOrEmpty(err) && File.Exists(exe);
		File.WriteAllText(Path.Combine(outDir, "build_result.txt"), (ok ? "OK" : "FAILED") + " scenes=" + scenes.Count + " " + (err ?? string.Empty));
		Debug.Log("[ReleaseBuild] " + (ok ? "OK " : "FAILED ") + exe + " " + err);
		EditorApplication.Exit(ok ? 0 : 1);
	}
}
