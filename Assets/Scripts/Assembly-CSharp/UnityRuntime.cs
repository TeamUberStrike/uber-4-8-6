using System;
using System.Collections;
using UnityEngine;

public class UnityRuntime : AutoMonoBehaviour<UnityRuntime>
{
	[SerializeField]
	private bool showInvocationList;

	public event Action OnGui;

	public event Action OnUpdate;

	public event Action OnLateUpdate;

	public event Action OnFixedUpdate;

	public event Action OnDrawGizmo;

	public event Action<bool> OnAppFocus;

	private void FixedUpdate()
	{
		if (this.OnFixedUpdate != null)
		{
			this.OnFixedUpdate();
		}
	}

	private void Update()
	{
		if (this.OnUpdate != null)
		{
			this.OnUpdate();
		}
	}

	private void LateUpdate()
	{
		if (this.OnLateUpdate != null)
		{
			this.OnLateUpdate();
		}
	}

	private void OnGUI()
	{
		if (this.OnGui != null)
		{
			this.OnGui();
		}
		if (!showInvocationList)
		{
			return;
		}
		GUILayout.BeginArea(new Rect(10f, 100f, 400f, Screen.height - 200));
		if (this.OnUpdate != null)
		{
			Delegate[] invocationList = this.OnUpdate.GetInvocationList();
			Delegate[] array = invocationList;
			Delegate[] array2 = array;
			foreach (Delegate obj in array2)
			{
				GUILayout.Label("Update: " + obj.Method.DeclaringType.Name + "." + obj.Method.Name);
			}
		}
		if (this.OnFixedUpdate != null)
		{
			Delegate[] invocationList2 = this.OnFixedUpdate.GetInvocationList();
			Delegate[] array3 = invocationList2;
			Delegate[] array4 = array3;
			foreach (Delegate obj2 in array4)
			{
				GUILayout.Label("FixedUpdate: " + obj2.Method.DeclaringType.Name + "." + obj2.Method.Name);
			}
		}
		if (this.OnAppFocus != null)
		{
			Delegate[] invocationList3 = this.OnAppFocus.GetInvocationList();
			Delegate[] array5 = invocationList3;
			Delegate[] array6 = array5;
			foreach (Delegate obj3 in array6)
			{
				GUILayout.Label("OnApplicationFocus: " + obj3.Method.DeclaringType.Name + "." + obj3.Method.Name);
			}
		}
		GUILayout.EndArea();
	}

	private void OnApplicationFocus(bool focus)
	{
		if (this.OnAppFocus != null)
		{
			this.OnAppFocus(focus);
		}
	}

	public static Coroutine StartRoutine(IEnumerator routine)
	{
		if (AutoMonoBehaviour<UnityRuntime>.IsRunning)
		{
			return AutoMonoBehaviour<UnityRuntime>.Instance.StartCoroutine(routine);
		}
		return null;
	}
}
