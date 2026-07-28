using UnityEngine;
public class GuiText : MonoBehaviour
{
    [SerializeField] private Font _font;
    [SerializeField] private string _text;
    [SerializeField] private Color _color;
    [SerializeField] private Vector3 _offset;
    [SerializeField] private Transform _target;
    [SerializeField] private bool _hasTimeLimit;
    [SerializeField] private float _distanceCap = -1f;
    public bool IsTextVisible { get; set; } = true;
    public void ShowText(int seconds) { }
    public void ShowText() { }
}
