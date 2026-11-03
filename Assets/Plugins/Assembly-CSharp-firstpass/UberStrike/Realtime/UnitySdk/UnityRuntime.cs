using System;
using UnityEngine;

namespace UberStrike.Realtime.UnitySdk
{
	internal class UnityRuntime : MonoBehaviour
	{
		[SerializeField]
		private bool showInvocationList;

		private static UnityRuntime instance;

		private Action onFixedUpdate;

		private Action onUpdate;

		private Action onShutdown;

		public static UnityRuntime Instance
		{
			get
			{
				if (instance == null)
				{
					GameObject gameObject = GameObject.Find("AutoMonoBehaviours");
					if (gameObject == null)
					{
						gameObject = new GameObject("AutoMonoBehaviours");
					}
					instance = gameObject.AddComponent<UnityRuntime>();
				}
				return instance;
			}
		}

		public event Action OnFixedUpdate
		{
			add
			{
				onFixedUpdate = (Action)Delegate.Combine(onFixedUpdate, value);
			}
			remove
			{
				onFixedUpdate = (Action)Delegate.Remove(onFixedUpdate, value);
			}
		}

		public event Action OnUpdate
		{
			add
			{
				onUpdate = (Action)Delegate.Combine(onUpdate, value);
			}
			remove
			{
				onUpdate = (Action)Delegate.Remove(onUpdate, value);
			}
		}

		public event Action OnShutdown
		{
			add
			{
				onShutdown = (Action)Delegate.Combine(onShutdown, value);
			}
			remove
			{
				onShutdown = (Action)Delegate.Remove(onShutdown, value);
			}
		}

		private void OnGUI()
		{
			if (!showInvocationList)
			{
				return;
			}
			GUILayout.BeginArea(new Rect(10f, 100f, 400f, Screen.height - 200));
			if (onUpdate != null)
			{
				Delegate[] invocationList = onUpdate.GetInvocationList();
				Delegate[] array = invocationList;
				Delegate[] array2 = array;
				foreach (Delegate obj in array2)
				{
					GUILayout.Label("Update: " + obj.Method.DeclaringType.Name + "." + obj.Method.Name);
				}
			}
			if (onFixedUpdate != null)
			{
				Delegate[] invocationList2 = onFixedUpdate.GetInvocationList();
				Delegate[] array3 = invocationList2;
				Delegate[] array4 = array3;
				foreach (Delegate obj2 in array4)
				{
					GUILayout.Label("FixedUpdate: " + obj2.Method.DeclaringType.Name + "." + obj2.Method.Name);
				}
			}
			if (onShutdown != null)
			{
				Delegate[] invocationList3 = onShutdown.GetInvocationList();
				Delegate[] array5 = invocationList3;
				Delegate[] array6 = array5;
				foreach (Delegate obj3 in array6)
				{
					GUILayout.Label("OnApplicationQuit: " + obj3.Method.DeclaringType.Name + "." + obj3.Method.Name);
				}
			}
			GUILayout.EndArea();
		}

		private void Update()
		{
			if (onUpdate != null)
			{
				onUpdate();
			}
		}

		private void FixedUpdate()
		{
			if (onFixedUpdate != null)
			{
				onFixedUpdate();
			}
		}

		private void OnApplicationQuit()
		{
			if (onShutdown != null)
			{
				onShutdown();
			}
		}
	}
}
