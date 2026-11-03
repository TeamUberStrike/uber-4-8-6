using System;
using UnityEngine;

public class AutoMonoBehaviour<T> : MonoBehaviour where T : class
{
	private const string rootGameObjectName = "AutoMonoBehaviours";

	private static T _instance;

	private static GameObject _gameObject;

	private static bool _isRunning = true;

	private static bool _isInstantiating;

	protected static bool IsRunning
	{
		get
		{
			return _isRunning;
		}
	}

	public static T Instance
	{
		get
		{
			if (_instance == null && _isRunning)
			{
				if (_isInstantiating)
				{
					string[] obj = new string[5] { "Recursive calls to Constuctor of AutoMonoBehaviour! Check your ", null, null, null, null };
					Type typeFromHandle = typeof(T);
					obj[1] = ((typeFromHandle != null) ? typeFromHandle.ToString() : null);
					obj[2] = ":Awake() function for calls to ";
					Type typeFromHandle2 = typeof(T);
					obj[3] = ((typeFromHandle2 != null) ? typeFromHandle2.ToString() : null);
					obj[4] = ".Instance";
					throw new Exception(string.Concat(obj));
				}
				_isInstantiating = true;
				_instance = GetInstance();
			}
			return _instance;
		}
	}

	private static T GetInstance()
	{
		GameObject gameObject = GameObject.Find("AutoMonoBehaviours");
		if (gameObject == null)
		{
			gameObject = new GameObject("AutoMonoBehaviours");
			UnityEngine.Object.DontDestroyOnLoad(gameObject);
		}
		string text = typeof(T).Name;
		_gameObject = GameObject.Find("AutoMonoBehaviours/" + text);
		if (_gameObject == null)
		{
			_gameObject = new GameObject(text);
			_gameObject.transform.parent = gameObject.transform;
		}
		return _gameObject.AddComponent(typeof(T)) as T;
	}

	private void OnApplicationQuit()
	{
		_isRunning = false;
	}

	protected virtual void Start()
	{
		if (_instance == null)
		{
			throw new Exception("The script " + typeof(T).Name + " is self instantiating and shouldn't be attached manually to a GameObject.");
		}
	}
}
