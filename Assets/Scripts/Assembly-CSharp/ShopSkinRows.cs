using System;
using System.Collections.Generic;
using Cmune.DataCenter.Common.Entities;
using UberStrike.Core.Types;

// Shop tab: skins are not listed as rows; they expand under their base weapon (same PrefabName).
public static class ShopSkinRows
{
	// Team pick 2026-10-25: hidden from shop and inventory. Textures and SkinDefs stay, so owned copies still render.
	public static readonly HashSet<int> Retired = new HashSet<int>
	{
		2012, 2016, 2017, 2019, 2020, 2030, 2038, 2039, 2041, 2042,
		2047, 2048, 2049, 2050, 2055, 2056, 2058, 2068, 2070
	};

	public static bool IsSkin(IUnityItem item)
	{
		return item != null && WeaponSkinHelper.Skins.ContainsKey(item.View.ID);
	}

	public static bool IsRetired(IUnityItem item)
	{
		return item != null && Retired.Contains(item.View.ID);
	}

	// Original game variants ("AK-47 [Snake]") have their own prefab; group them by name instead.
	public static string VariantBaseName(IUnityItem item)
	{
		if (item == null || item.View.ItemType != UberstrikeItemType.Weapon || IsSkin(item) || string.IsNullOrEmpty(item.Name) || !item.Name.EndsWith("]"))
		{
			return null;
		}
		int i = item.Name.LastIndexOf(" [");
		return i > 0 ? item.Name.Substring(0, i) : null;
	}

	public static Dictionary<string, string> VariantBasePrefabs(List<IUnityItem> items)
	{
		Dictionary<string, string> bases = new Dictionary<string, string>();
		HashSet<string> skinned = new HashSet<string>();
		foreach (IUnityItem item in items)
		{
			if (IsSkin(item))
			{
				skinned.Add(item.View.PrefabName);
			}
			else if (item.View.ItemType == UberstrikeItemType.Weapon && VariantBaseName(item) == null && !bases.ContainsKey(item.Name))
			{
				bases.Add(item.Name, item.View.PrefabName);
			}
		}
		foreach (IUnityItem item in items)
		{
			string baseName = VariantBaseName(item);
			if (baseName != null && !bases.ContainsKey(baseName) && skinned.Contains(item.View.PrefabName))
			{
				bases.Add(baseName, item.View.PrefabName);
			}
		}
		return bases;
	}

	public static string RowKey(IUnityItem item, Dictionary<string, string> variantBases)
	{
		if (IsSkin(item))
		{
			return item.View.PrefabName;
		}
		string baseName = VariantBaseName(item);
		string prefab;
		if (baseName != null && variantBases.TryGetValue(baseName, out prefab) && prefab != item.View.PrefabName)
		{
			return prefab;
		}
		return null;
	}

	public static int CompareByName(IShopItemGUI a, IShopItemGUI b)
	{
		int result = string.Compare(a.Item.Name, b.Item.Name, StringComparison.OrdinalIgnoreCase);
		return result != 0 ? result : a.Item.View.ID.CompareTo(b.Item.View.ID);
	}
}
