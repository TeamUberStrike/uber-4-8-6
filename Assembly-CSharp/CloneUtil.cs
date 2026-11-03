using System;
using System.Reflection;
using UberStrike.Realtime.UnitySdk;

public static class CloneUtil
{
	public static T Clone<T>(T instance) where T : class
	{
		Type type = instance.GetType();
		ConstructorInfo constructor = type.GetConstructor(new Type[0]);
		if (constructor != null)
		{
			T val = constructor.Invoke(new object[0]) as T;
			CopyAllFields(val, instance);
			return val;
		}
		return null;
	}

	public static void CopyAllFields<T>(T destination, T source) where T : class
	{
		foreach (FieldInfo allField in ReflectionHelper.GetAllFields(source.GetType(), true))
		{
			allField.SetValue(destination, allField.GetValue(source));
		}
	}

	public static void CopyFields(object dst, object src)
	{
		PropertyInfo[] properties = src.GetType().GetProperties();
		PropertyInfo[] array = properties;
		PropertyInfo[] array2 = array;
		foreach (PropertyInfo propertyInfo in array2)
		{
			if (propertyInfo.CanWrite)
			{
				dst.GetType().GetProperty(propertyInfo.Name).SetValue(dst, propertyInfo.GetValue(src, null), null);
			}
		}
	}
}
