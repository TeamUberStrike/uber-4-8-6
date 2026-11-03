using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Security.Cryptography;
using System.Threading;
using UnityEngine;

internal class WindowsUpdater
{
	private static string Auth;

	private static string Read;

	private static string Entry;

	private static List<string[]> FileData = new List<string[]>();

	private static List<string[]> DownloadList = new List<string[]>();

	private static bool downloadError;

	private static string gamepath = Directory.GetCurrentDirectory();

	private static string url_latest = "https://raw.githubusercontent.com/HaZardousss/UberUpdates/master/Entry.txt";

	private static string url_auth = "https://raw.githubusercontent.com/HaZardousss/UberUpdates/master/Auth";

	private static string url_windows = "https://raw.githubusercontent.com/HaZardousss/UberUpdates/master/Windows";

	public static bool IsUpdateRoutineComplete { get; private set; }

	public static IEnumerator Updater()
	{
		IsUpdateRoutineComplete = false;
		if (Directory.Exists(gamepath + "\\Updates"))
		{
			Directory.Delete(gamepath + "\\Updates", true);
		}
		AuthenticationManager._progress.Text = "Checking Updates";
		AuthenticationManager._progress.Progress = 0f;
		if (File.Exists(gamepath + "\\devx"))
		{
			NoUpdate();
			yield break;
		}
		yield return null;
		yield return UnityRuntime.StartRoutine(WWWRead(url_auth));
		Auth = Read;
		if (Auth.ToLower().Contains("qa"))
		{
			ApplicationDataManager.LockApplication("Servers are down for update. Please wait.");
			yield break;
		}
		yield return UnityRuntime.StartRoutine(WWWRead(url_latest));
		Entry = Read;
		if (Entry == null || Auth == null)
		{
			ApplicationDataManager.LockApplication("Could not connect to update servers.\nCheck your Internet connection or turn off Firewall if the issue persists");
			yield break;
		}
		string[] array = Entry.Split(new string[1] { "\n" }, StringSplitOptions.RemoveEmptyEntries);
		string[] array2 = array;
		foreach (string lines in array2)
		{
			yield return null;
			string[] item = lines.Split(' ');
			FileData.Add(item);
			yield return null;
		}
		yield return new WaitForEndOfFrame();
		int j;
		for (j = 0; j < FileData.Count; j++)
		{
			yield return null;
			string lines = gamepath + "\\" + FileData[j][0];
			string downlink = url_windows + "/" + FileData[j][0].Replace("\\", "/");
			string downpath = gamepath + "\\Updates\\UberStrike\\" + FileData[j][0];
			yield return null;
			if (!File.Exists(lines))
			{
				AddToDownload(downlink, downpath, FileData[j][1], FileData[j][2]);
			}
			else if (!FileData[j][1].Equals(CalculateMD5(lines)))
			{
				AddToDownload(downlink, downpath, FileData[j][1], FileData[j][2]);
			}
		}
		if (DownloadList.Count == 0)
		{
			NoUpdate();
			yield break;
		}
		j = 0;
		for (downloadError = false; j < DownloadList.Count; j++)
		{
			yield return null;
			yield return UnityRuntime.StartRoutine(WWWDownload(DownloadList[j][1], DownloadList[j][0], DownloadList[j][2], DownloadList[j][3], j + 1 + " / " + DownloadList.Count));
			if (downloadError)
			{
				break;
			}
		}
		if (downloadError)
		{
			NoUpdate();
			ApplicationDataManager.LockApplication("Could not download update files from the server. Please try again later.");
		}
		else
		{
			Finished();
		}
	}

	private static IEnumerator WWWDownload(string path, string link, string expectedMd5, string expectedSize, string index)
	{
		using (WWW www = new WWW(link))
		{
			while (!www.isDone)
			{
				AuthenticationManager._progress.Progress = www.progress * 1.2f;
				AuthenticationManager._progress.Text = "Downloading File " + index;
				yield return null;
			}
			yield return new WaitForSeconds(0.1f);
			byte[] bytes = www.bytes;
			bool flag = string.IsNullOrEmpty(www.error) && bytes != null && bytes.Length != 0;
			long result;
			if (flag && long.TryParse(expectedSize, out result) && result > 0 && bytes.Length != result)
			{
				UnityEngine.Debug.LogError("size mismatch for " + link + " (expected=" + result + ", actual=" + bytes.Length + ")");
				flag = false;
			}
			if (flag && !string.IsNullOrEmpty(expectedMd5))
			{
				string text;
				using (MD5 mD = MD5.Create())
				{
					text = BitConverter.ToString(mD.ComputeHash(bytes)).Replace("-", "").ToLowerInvariant();
				}
				if (!expectedMd5.Equals(text, StringComparison.OrdinalIgnoreCase))
				{
					UnityEngine.Debug.LogError("Server side Entry.txt md5 hash does not match for " + link + " (expected=" + expectedMd5 + ", actual=" + text + ")");
					flag = false;
				}
			}
			if (!flag)
			{
				UnityEngine.Debug.LogError("Download failed or corrupted for " + link + " (error=" + www.error + ", bytes=" + ((bytes != null) ? bytes.Length : (-1)) + ", expected=" + expectedSize + ")");
				downloadError = true;
				yield break;
			}
			File.WriteAllBytes(path, bytes);
		}
		yield return new WaitForEndOfFrame();
	}

	private static IEnumerator WWWRead(string link)
	{
		using (WWW www = new WWW(link))
		{
			while (!www.isDone)
			{
				yield return null;
			}
			Read = www.text;
		}
	}

	private static string CalculateMD5(string filename)
	{
		using (MD5 mD = MD5.Create())
		{
			using (FileStream inputStream = File.OpenRead(filename))
			{
				byte[] array = mD.ComputeHash(inputStream);
				return BitConverter.ToString(array).Replace("-", "").ToLowerInvariant();
			}
		}
	}

	private static void AddToDownload(string link, string downloadpath, string expectedMd5, string downloadsize)
	{
		Directory.CreateDirectory(Path.GetDirectoryName(downloadpath));
		string[] item = new string[4] { link, downloadpath, expectedMd5, downloadsize };
		DownloadList.Add(item);
	}

	private static void Finished()
	{
		DeleteUnnecessary();
		AuthenticationManager._progress.Text = "Installing update...";
		CopyFiles(Path.Combine(gamepath, "Updates\\UberStrike"), gamepath);
		IsUpdateRoutineComplete = true;
		try
		{
			Process.Start(Path.Combine(gamepath, "UberStrike.exe"));
		}
		catch (Exception message)
		{
			UnityEngine.Debug.LogError(message);
		}
		if (!Application.isEditor)
		{
			Thread thread = new Thread((ThreadStart)delegate
			{
				int num = 0;
				bool flag = false;
				while (!flag && num < 60)
				{
					try
					{
						Process[] processesByName = Process.GetProcessesByName("UberStrike");
						Process[] array = processesByName;
						foreach (Process process in array)
						{
							process.Refresh();
							if (process.MainWindowTitle.Length > 0)
							{
								flag = true;
								break;
							}
						}
					}
					catch (Exception message2)
					{
						UnityEngine.Debug.LogError(message2);
					}
					if (!flag)
					{
						Thread.Sleep(500);
					}
					num++;
				}
				try
				{
					Process.GetCurrentProcess().Kill();
				}
				catch (Exception message3)
				{
					UnityEngine.Debug.LogError(message3);
				}
			});
			thread.IsBackground = true;
			thread.Start();
		}
		Application.Quit();
	}

	private static void CopyFiles(string sourcePath, string destinationPath)
	{
		try
		{
			string[] directories = Directory.GetDirectories(sourcePath, "*", SearchOption.AllDirectories);
			foreach (string text in directories)
			{
				Directory.CreateDirectory(text.Replace(sourcePath, destinationPath));
			}
			string[] files = Directory.GetFiles(sourcePath, "*.*", SearchOption.AllDirectories);
			foreach (string text2 in files)
			{
				try
				{
					File.Copy(text2, text2.Replace(sourcePath, destinationPath), true);
				}
				catch (Exception message)
				{
					UnityEngine.Debug.LogError(message);
				}
			}
		}
		catch (Exception message2)
		{
			UnityEngine.Debug.LogError(message2);
		}
	}

	private static int DeleteUnnecessary()
	{
		DeleteFile("UberStrike_Data\\level12");
		DeleteFile("version.txt");
		DeleteFile("UberEyeEngine.exe");
		DeleteFile("UberStrike_Data\\version.txt");
		DeleteFile("UberStrike_Data\\Plugins\\CommEye.exe");
		DeleteFile("UberEye.exe");
		DeleteFile("Scs.dll");
		DeleteFile("Uber.eye");
		DeleteFile("Scs.xml");
		return 0;
	}

	private static void NoUpdate()
	{
		try
		{
			if (Directory.Exists(gamepath + "\\Updates"))
			{
				Directory.Delete(gamepath + "\\Updates", true);
			}
		}
		catch (Exception message)
		{
			UnityEngine.Debug.LogError(message);
		}
		IsUpdateRoutineComplete = true;
	}

	private static int DeleteFolder(string path)
	{
		path = Directory.GetCurrentDirectory() + "\\" + path;
		if (Directory.Exists(path))
		{
			Directory.Delete(path, true);
		}
		return 0;
	}

	private static int DeleteFile(string path)
	{
		try
		{
			path = Directory.GetCurrentDirectory() + "\\" + path;
			if (File.Exists(path))
			{
				File.Delete(path);
			}
		}
		catch (Exception message)
		{
			UnityEngine.Debug.LogError(message);
		}
		return 0;
	}
}
