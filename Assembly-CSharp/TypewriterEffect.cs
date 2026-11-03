using UnityEngine;

[RequireComponent(typeof(UILabel))]
[AddComponentMenu("NGUI/Examples/Typewriter Effect")]
public class TypewriterEffect : MonoBehaviour
{
	public int charsPerSecond = 40;

	public bool loop;

	private UILabel mLabel;

	private string mText;

	private int mOffset;

	private float mNextChar;

	private void Update()
	{
		if (mLabel == null)
		{
			mLabel = GetComponent<UILabel>();
			mLabel.supportEncoding = false;
			mLabel.symbolStyle = UIFont.SymbolStyle.None;
			UIFont font = mLabel.font;
			string text = mLabel.text;
			float num = mLabel.lineWidth;
			mText = font.WrapText(text, num / mLabel.cachedTransform.localScale.x, mLabel.maxLineCount, false, UIFont.SymbolStyle.None);
		}
		if (mOffset < mText.Length)
		{
			if (mNextChar <= Time.time)
			{
				charsPerSecond = Mathf.Max(1, charsPerSecond);
				float num2 = 1f / (float)charsPerSecond;
				char c = mText[mOffset];
				if (c == '.' || c == '\n' || c == '!' || c == '?')
				{
					num2 *= 4f;
				}
				mNextChar = Time.time + num2;
				mLabel.text = mText.Substring(0, ++mOffset);
			}
		}
		else if (loop)
		{
			mOffset = 0;
			UIFont font2 = mLabel.font;
			string text2 = mLabel.text;
			float num3 = mLabel.lineWidth;
			mText = font2.WrapText(text2, num3 / mLabel.cachedTransform.localScale.x, mLabel.maxLineCount, false, UIFont.SymbolStyle.None);
		}
		else
		{
			Object.Destroy(this);
		}
	}
}
