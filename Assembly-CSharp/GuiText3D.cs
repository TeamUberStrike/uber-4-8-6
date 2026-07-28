using UnityEngine;
public class GuiText3D : MonoBehaviour
{
    public Font mFont;
    public string mText;
    public Camera mCamera;
    public Transform mTarget;
    public float mMaxDistance = 20f;
    public float mLifeTime = 5f;
    public Color mColor = Color.black;
    public bool mFadeOut = true;
    public Vector3 mFadeDirection = Vector2.up;
}
