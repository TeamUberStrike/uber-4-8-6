using System.Collections.Generic;
using UnityEngine;

public class HUDWeaponScroller : MonoBehaviour
{
	[SerializeField]
	private NGUIScrollList scrollList;

	[SerializeField]
	private HUDWeaponScrollItem melee;

	[SerializeField]
	private HUDWeaponScrollItem primary;

	[SerializeField]
	private HUDWeaponScrollItem secondary;

	[SerializeField]
	private HUDWeaponScrollItem tertiary;

	private Dictionary<LoadoutSlotType, GameObject> loadoutWeapons = new Dictionary<LoadoutSlotType, GameObject>();

	// Ordered weapon list for the 3-weapon vertical display
	private List<string> _weaponNames = new List<string>();
	private List<LoadoutSlotType> _weaponSlots = new List<LoadoutSlotType>();
	private int _activeIndex;
	private float _displayAlpha;
	private float _displayTimer;
	private GUIStyle _bigStyle;
	private GUIStyle _smallStyle;
	private const float DISPLAY_TIME = 2.5f;
	private const float FADE_IN = 0.2f;
	private const float FADE_OUT = 1f;

	private void OnEnable()
	{
		GameState.Current.PlayerData.LoadoutWeapons.Fire();
	}

	private void Start()
	{
		// Disable the NGUI scroll list — its UILabels render as garbled
		// squares in Unity 6 due to broken font atlas binding in additive scenes.
		if (scrollList != null)
		{
			scrollList.gameObject.SetActive(false);
		}

		GameState.Current.PlayerData.LoadoutWeapons.AddEventAndFire(delegate(Dictionary<LoadoutSlotType, IUnityItem> el)
		{
			if (el != null)
			{
				loadoutWeapons.Clear();
				_weaponNames.Clear();
				_weaponSlots.Clear();

				// Build ordered weapon list: melee, primary, secondary, tertiary
				LoadoutSlotType[] order = {
					LoadoutSlotType.WeaponMelee,
					LoadoutSlotType.WeaponPrimary,
					LoadoutSlotType.WeaponSecondary,
					LoadoutSlotType.WeaponTertiary
				};

				foreach (LoadoutSlotType slot in order)
				{
					if (el.ContainsKey(slot) && el[slot] != null)
					{
						_weaponSlots.Add(slot);
						_weaponNames.Add(el[slot].View.Name);
						loadoutWeapons[slot] = GetSlotGO(slot).gameObject;
					}
				}
			}
		}, this);

		GameState.Current.PlayerData.NextActiveWeapon.AddEvent(delegate(WeaponSlot el)
		{
			if (el != null)
			{
				SetActiveSlot(el.Slot);
				_displayTimer = FADE_IN + DISPLAY_TIME + FADE_OUT;
			}
		}, this);

		GameState.Current.PlayerData.ActiveWeapon.AddEventAndFire(delegate(WeaponSlot el)
		{
			if (el != null)
			{
				SetActiveSlot(el.Slot);
				_displayTimer = FADE_IN + DISPLAY_TIME + FADE_OUT;
			}
		}, this);
	}

	private void SetActiveSlot(LoadoutSlotType slot)
	{
		for (int i = 0; i < _weaponSlots.Count; i++)
		{
			if (_weaponSlots[i] == slot)
			{
				_activeIndex = i;
				return;
			}
		}
	}

	private HUDWeaponScrollItem GetSlotGO(LoadoutSlotType slot)
	{
		switch (slot)
		{
		case LoadoutSlotType.WeaponMelee: return melee;
		case LoadoutSlotType.WeaponPrimary: return primary;
		case LoadoutSlotType.WeaponSecondary: return secondary;
		case LoadoutSlotType.WeaponTertiary: return tertiary;
		default: return primary;
		}
	}

	private void Update()
	{
		if (_displayTimer > 0f)
		{
			_displayTimer -= Time.deltaTime;
			float total = FADE_IN + DISPLAY_TIME + FADE_OUT;
			float elapsed = total - _displayTimer;

			if (elapsed < FADE_IN)
				_displayAlpha = elapsed / FADE_IN;
			else if (elapsed < FADE_IN + DISPLAY_TIME)
				_displayAlpha = 1f;
			else
				_displayAlpha = 1f - (elapsed - FADE_IN - DISPLAY_TIME) / FADE_OUT;

			_displayAlpha = Mathf.Clamp01(_displayAlpha);
		}
		else
		{
			_displayAlpha = 0f;
		}
	}

	private void OnGUI()
	{
		if (_displayAlpha <= 0f || _weaponNames.Count == 0)
			return;

		// Don't cache GUIStyles — BlueStonez fields start as GUIStyle.none and
		// are only populated after the skin loads. Caching captures the empty state.
		GUIStyle bigStyle = BlueStonez.label_interparkbold_48pt;
		GUIStyle smallStyle = BlueStonez.label_interparkbold_18pt;

		if (bigStyle == null || bigStyle == GUIStyle.none || bigStyle.fontSize == 0)
		{
			// Fallback: create a large style manually from the default font
			if (_bigStyle == null)
			{
				_bigStyle = new GUIStyle(GUI.skin.label);
				_bigStyle.fontSize = 36;
				_bigStyle.fontStyle = FontStyle.Bold;
				_bigStyle.alignment = TextAnchor.MiddleCenter;
				_smallStyle = new GUIStyle(GUI.skin.label);
				_smallStyle.fontSize = 16;
				_smallStyle.alignment = TextAnchor.MiddleCenter;
			}
			bigStyle = _bigStyle;
			smallStyle = _smallStyle;
		}

		float cx = Screen.width * 0.5f;
		// Position the current weapon name so that it AND the next weapon below
		// both fit comfortably above the bottom HUD bar (~80px from bottom edge).
		float centerY = Screen.height - 100f;

		// Current weapon (large, bold, full white)
		string current = (_activeIndex >= 0 && _activeIndex < _weaponNames.Count) ? _weaponNames[_activeIndex] : "";
		Vector2 bigSize = bigStyle.CalcSize(new GUIContent(current));
		bigSize.x = Mathf.Max(bigSize.x + 40f, 200f);
		bigSize.y = Mathf.Max(bigSize.y, 40f);
		float bigY = centerY - bigSize.y * 0.5f;
		DrawLabel(cx - bigSize.x * 0.5f, bigY, bigSize.x, bigSize.y, current, bigStyle, _displayAlpha);

		// Previous weapon (above current, smaller, faded)
		int prevIdx = _activeIndex - 1;
		if (prevIdx >= 0 && prevIdx < _weaponNames.Count)
		{
			string prev = _weaponNames[prevIdx];
			Vector2 smSize = smallStyle.CalcSize(new GUIContent(prev));
			smSize.x = Mathf.Max(smSize.x + 20f, 150f);
			float prevY = bigY - smSize.y - 4f;
			DrawLabel(cx - smSize.x * 0.5f, prevY, smSize.x, smSize.y, prev, smallStyle, _displayAlpha * 0.5f);
		}

		// Next weapon (below current, smaller, faded)
		int nextIdx = _activeIndex + 1;
		if (nextIdx >= 0 && nextIdx < _weaponNames.Count)
		{
			string next = _weaponNames[nextIdx];
			Vector2 smSize = smallStyle.CalcSize(new GUIContent(next));
			smSize.x = Mathf.Max(smSize.x + 20f, 150f);
			float nextY = bigY + bigSize.y + 4f;
			DrawLabel(cx - smSize.x * 0.5f, nextY, smSize.x, smSize.y, next, smallStyle, _displayAlpha * 0.5f);
		}
	}

	private void DrawLabel(float x, float y, float w, float h, string text, GUIStyle style, float alpha)
	{
		// Shadow
		GUI.color = new Color(0f, 0f, 0f, alpha * 0.7f);
		GUI.Label(new Rect(x + 1f, y + 1f, w, h), text, style);
		// Text
		GUI.color = new Color(1f, 1f, 1f, alpha);
		GUI.Label(new Rect(x, y, w, h), text, style);
	}

	private void SetElement(KeyValuePair<LoadoutSlotType, IUnityItem> item, HUDWeaponScrollItem slot)
	{
		if (item.Value != null)
		{
			slot.WeaponName = item.Value.View.Name;
			loadoutWeapons[item.Key] = slot.gameObject;
		}
	}
}
