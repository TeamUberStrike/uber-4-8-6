using System.Collections;
using System.IO;
using UnityEngine;

public class UberKill : MonoBehaviour
{
	public static UberKill Instance;

	public static bool KnockBack { get; set; }

	public void Start()
	{
		Instance = this;
		StartCoroutine(StartGetHomeSound());
	}

	public IEnumerator StartGetHomeSound()
	{
		string url = (ApplicationDataManager.IsMac ? ("file://" + Directory.GetCurrentDirectory() + "/Uberstrike.app/Contents/Data/SeloTron.ogg") : ("file:///" + Directory.GetCurrentDirectory().Replace("\\", "/") + "/UberStrike_Data/SeloTron.ogg"));
		using (WWW request = new WWW(url))
		{
			while (!request.isDone)
			{
				yield return null;
			}
			if (request.isDone)
			{
				GameAudio.HomeSceneBackground = request.GetAudioClip(false);
				AutoMonoBehaviour<BackgroundMusicPlayer>.Instance.Play(GameAudio.HomeSceneBackground);
			}
		}
	}
}
