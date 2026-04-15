// Compat stubs for Unity 4 legacy particle types removed in Unity 6.
using UnityEngine;

public class ParticleEmitter : MonoBehaviour
{
    public bool emit;
    public float minSize = 0.1f;
    public float maxSize = 0.5f;
    public float minEnergy = 1f;
    public float maxEnergy = 3f;
    public float minEmission = 10f;
    public float maxEmission = 30f;
    public Vector3 worldVelocity;
    public Vector3 localVelocity;
    public Vector3 rndVelocity;
    public bool useWorldSpace = true;
    public bool rndRotation;
    public float angularVelocity;
    public float rndAngularVelocity;
    public int particleCount;

    public void Emit() { }
    public void Emit(int count) { }
    public void Emit(Vector3 pos, Vector3 velocity, float size, float energy, Color color) { }
    public void Emit(Vector3 pos, Vector3 velocity, float size, float energy, Color color, float rotation, float angularVelocity) { }
    public void ClearParticles() { }
}

public class EllipsoidParticleEmitter : ParticleEmitter
{
    public Vector3 ellipsoid = Vector3.one;
    public float minEmitterRange;
}

public class MeshParticleEmitter : ParticleEmitter
{
    public Mesh mesh;
    public bool interpolateTriangles;
    public bool systematic;
    public float minNormalVelocity;
    public float maxNormalVelocity;
}

public class ParticleAnimator : MonoBehaviour
{
    public bool doesAnimateColor;
    public Color[] colorAnimation = new Color[5];
    public Vector3 worldRotationAxis;
    public Vector3 localRotationAxis;
    public float sizeGrow;
    public Vector3 rndForce;
    public Vector3 force;
    public float damping = 1f;
    public bool autodestruct;
}

public class ParticleRenderer : Renderer
{
    public enum ParticleRenderMode { Billboard, Stretch, SortedBillboard, VerticalBillboard, HorizontalBillboard }
    public ParticleRenderMode particleRenderMode;
    public float lengthScale = 1f;
    public float velocityScale;
    public float cameraVelocityScale;
    public float maxParticleSize = 0.25f;
    public Vector3 stretchParticles;
    public int uvAnimationXTile = 1;
    public int uvAnimationYTile = 1;
    public float uvAnimationCycles = 1f;
}
