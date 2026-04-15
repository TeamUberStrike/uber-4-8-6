using System;
using System.Collections;
using UnityEngine;
using UnityEngine.Networking;

public static class AssetBundleLoader
{
	public static IEnumerator LoadAssetBundleNoCache(string path, Action<float> progress = null, Action<AssetBundle> onLoaded = null, Action<string> onError = null)
	{
		Debug.Log("LOADING ASSETBUNDLE: " + path);
		using (UnityWebRequest loader = UnityWebRequestAssetBundle.GetAssetBundle(path))
		{
			UnityWebRequestAsyncOperation op = loader.SendWebRequest();
			while (!op.isDone)
			{
				yield return new WaitForEndOfFrame();
				if (progress != null)
				{
					progress(loader.downloadProgress);
				}
			}
			if (loader.result != UnityWebRequest.Result.Success)
			{
				Debug.LogError("Failed to locate Asset " + path + ". Error" + loader.error);
				if (onError != null)
				{
					onError("Failed to locate Asset " + path + ". Error" + loader.error);
				}
			}
			else if (onLoaded != null)
			{
				onLoaded(DownloadHandlerAssetBundle.GetContent(loader));
			}
			if (progress != null)
			{
				progress(1f);
			}
		}
	}
}
