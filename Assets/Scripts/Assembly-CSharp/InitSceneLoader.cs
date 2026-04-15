using UnityEngine;
using UnityEngine.SceneManagement;

public class InitSceneLoader : MonoBehaviour
{
	private void Awake()
	{
		if (!GlobalSceneLoader.IsInitialised)
		{
			SceneManager.LoadScene("InitScene");
		}
	}
}
