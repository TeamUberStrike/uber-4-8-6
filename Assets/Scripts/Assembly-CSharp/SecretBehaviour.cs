using System;
using UnityEngine;

public class SecretBehaviour : MonoBehaviour
{
	[Serializable]
	public class Door
	{
		public string _description;

		[SerializeField]
		private SecretDoor _door;

		[SerializeField]
		private SecretTrigger[] _trigger;

		public SecretTrigger[] Trigger
		{
			get
			{
				return _trigger;
			}
		}

		public void CheckAllTriggers()
		{
			bool flag = true;
			SecretTrigger[] trigger = _trigger;
			SecretTrigger[] array = trigger;
			SecretTrigger[] array2 = array;
			foreach (SecretTrigger secretTrigger in array2)
			{
				flag &= secretTrigger.ActivationTimeOut > Time.time;
			}
			if (flag)
			{
				_door.Open();
			}
		}
	}

	[SerializeField]
	private Door[] _doors;

	private void Awake()
	{
		Door[] doors = _doors;
		Door[] array = doors;
		Door[] array2 = array;
		foreach (Door door in array2)
		{
			SecretTrigger[] trigger = door.Trigger;
			SecretTrigger[] array3 = trigger;
			SecretTrigger[] array4 = array3;
			foreach (SecretTrigger secretTrigger in array4)
			{
				secretTrigger.SetSecretReciever(this);
			}
		}
	}

	public void SetTriggerActivated(SecretTrigger trigger)
	{
		Door[] doors = _doors;
		Door[] array = doors;
		Door[] array2 = array;
		foreach (Door door in array2)
		{
			door.CheckAllTriggers();
		}
	}
}
