using UnityEngine;

public static class ParticleEmissionSystem
{
	// Modern emit using ParticleSystem.EmitParams. Replaces legacy
	// ParticleEmitter.Emit(pos, vel, size, energy, color) which no longer exists
	// in Unity 6. Ensures the system is playing before emit — serialized refs
	// created via auto-migration can land in stopped state.
	private static int _emitLogs;
	private static void EmitSafe(ParticleSystem ps, Vector3 position, Vector3 velocity, float size, float lifetime, Color color)
	{
		if (ps == null)
		{
			if (_emitLogs < 10) { _emitLogs++; UnityEngine.Debug.Log("[EmitSafe] ps=NULL"); }
			return;
		}
		if (_emitLogs < 10)
		{
			_emitLogs++;
			var go = ps.gameObject;
			var r = ps.GetComponent<ParticleSystemRenderer>();
			UnityEngine.Debug.Log($"[EmitSafe #{_emitLogs}] ps={go.name} active={go.activeInHierarchy} playing={ps.isPlaying} pos={position} size={size:F2} life={lifetime:F2} mat={(r && r.sharedMaterial ? r.sharedMaterial.name : "<null>")} shader={(r && r.sharedMaterial && r.sharedMaterial.shader ? r.sharedMaterial.shader.name : "<null>")}");
		}
		if (!ps.isPlaying) ps.Play();
		var ep = new ParticleSystem.EmitParams();
		ep.position = position;
		ep.velocity = velocity;
		ep.startSize = size;
		ep.startLifetime = lifetime;
		ep.startColor = color;
		ps.Emit(ep, 1);
	}

	private static void EmitSafeRotated(ParticleSystem ps, Vector3 position, Vector3 velocity, float size, float lifetime, Color color, float rotation)
	{
		if (ps == null) return;
		if (!ps.isPlaying) ps.Play();
		var ep = new ParticleSystem.EmitParams();
		ep.position = position;
		ep.velocity = velocity;
		ep.startSize = size;
		ep.startLifetime = lifetime;
		ep.startColor = color;
		ep.rotation = rotation;
		ps.Emit(ep, 1);
	}

	public static void TrailParticles(Vector3 emitPoint, Vector3 direction, TrailParticleConfiguration particleConfiguration, Vector3 muzzlePosition, float distance)
	{
		if (particleConfiguration.ParticleEmitter == null) return;
		if (distance <= 3f) return;
		const float speed = 200f;
		Vector3 velocity = direction * speed;
		float energy = distance / speed * 0.9f;
		EmitSafe(particleConfiguration.ParticleEmitter,
			muzzlePosition + direction * 3f, velocity,
			Random.Range(particleConfiguration.ParticleMinSize, particleConfiguration.ParticleMaxSize),
			energy, particleConfiguration.ParticleColor);
	}

	public static void FireParticles(Vector3 hitPoint, Vector3 hitNormal, FireParticleConfiguration particleConfiguration)
	{
		if (particleConfiguration.ParticleEmitter == null) return;
		Vector3 velocity = Vector3.zero;
		Quaternion rotation = Quaternion.FromToRotation(Vector3.up, hitNormal);
		Vector3 pos = Vector3.zero;
		for (int i = 0; i < particleConfiguration.ParticleCount; i++)
		{
			velocity.x = 0f + Random.Range(0f, 0.001f);
			velocity.y = 2f + Random.Range(0f, 0.4f);
			velocity.z = 0f + Random.Range(0f, 0.001f);
			velocity = rotation * velocity;
			pos = hitPoint;
			pos.x += Random.Range(0f, 0.2f);
			pos.z += Random.Range(0f, 0.4f) * -1f;
			EmitSafe(particleConfiguration.ParticleEmitter,
				pos, velocity,
				Random.Range(particleConfiguration.ParticleMinSize, particleConfiguration.ParticleMaxSize),
				Random.Range(particleConfiguration.ParticleMinLiveTime, particleConfiguration.ParticleMaxLiveTime),
				particleConfiguration.ParticleColor);
		}
	}

	public static void WaterCircleParticles(Vector3 hitPoint, Vector3 hitNormal, FireParticleConfiguration particleConfiguration)
	{
		if (particleConfiguration.ParticleEmitter == null) return;
		Vector3 velocity = Vector3.zero;
		for (int i = 0; i < particleConfiguration.ParticleCount; i++)
		{
			velocity.x = Random.Range(0f, 0.3f);
			velocity.z = Random.Range(0f, 0.3f);
			EmitSafe(particleConfiguration.ParticleEmitter,
				hitPoint, velocity,
				Random.Range(particleConfiguration.ParticleMinSize, particleConfiguration.ParticleMaxSize),
				Random.Range(particleConfiguration.ParticleMinLiveTime, particleConfiguration.ParticleMaxLiveTime),
				particleConfiguration.ParticleColor);
		}
	}

	public static void WaterSplashParticles(Vector3 hitPoint, Vector3 hitNormal, FireParticleConfiguration particleConfiguration)
	{
		if (particleConfiguration.ParticleEmitter == null) return;
		Vector3 velocity = Vector3.zero;
		for (int i = 0; i < particleConfiguration.ParticleCount; i++)
		{
			velocity.x = Random.Range(0f, 0.3f);
			velocity.y = 2f + Random.Range(0f, 0.3f);
			velocity.z = Random.Range(0f, 0.3f);
			EmitSafe(particleConfiguration.ParticleEmitter,
				hitPoint, velocity,
				Random.Range(particleConfiguration.ParticleMinSize, particleConfiguration.ParticleMaxSize),
				Random.Range(particleConfiguration.ParticleMinLiveTime, particleConfiguration.ParticleMaxLiveTime),
				particleConfiguration.ParticleColor);
		}
	}

	public static void HitMaterialParticles(Vector3 hitPoint, Vector3 hitNormal, ParticleConfiguration particleConfiguration)
	{
		if (particleConfiguration.ParticleEmitter == null) return;
		Vector3 velocity = Vector3.zero;
		Quaternion rotation = Quaternion.FromToRotation(Vector3.back, hitNormal);
		for (int i = 0; i < particleConfiguration.ParticleCount; i++)
		{
			Vector2 unit = Random.insideUnitCircle * Random.Range(particleConfiguration.ParticleMinSpeed, particleConfiguration.ParticleMaxSpeed);
			velocity.x = unit.x;
			velocity.y = unit.y;
			velocity.z = Random.Range(particleConfiguration.ParticleMinZVelocity, particleConfiguration.ParticleMaxZVelocity) * -1f;
			velocity = rotation * velocity;
			EmitSafe(particleConfiguration.ParticleEmitter,
				hitPoint, velocity,
				Random.Range(particleConfiguration.ParticleMinSize, particleConfiguration.ParticleMaxSize),
				Random.Range(particleConfiguration.ParticleMinLiveTime, particleConfiguration.ParticleMaxLiveTime),
				particleConfiguration.ParticleColor);
		}
	}

	public static void HitMaterialRotatingParticles(Vector3 hitPoint, Vector3 hitNormal, ParticleConfiguration particleConfiguration)
	{
		if (particleConfiguration.ParticleEmitter == null) return;
		Vector3 velocity = Vector3.zero;
		Quaternion rotation = Quaternion.FromToRotation(Vector3.back, hitNormal);
		for (int i = 0; i < particleConfiguration.ParticleCount; i++)
		{
			Vector2 unit = Random.insideUnitCircle * Random.Range(particleConfiguration.ParticleMinSpeed, particleConfiguration.ParticleMaxSpeed);
			velocity.x = unit.x;
			velocity.y = unit.y;
			velocity.z = Random.Range(particleConfiguration.ParticleMinZVelocity, particleConfiguration.ParticleMaxZVelocity) * -1f;
			velocity = rotation * velocity;
			EmitSafeRotated(particleConfiguration.ParticleEmitter,
				hitPoint, velocity,
				Random.Range(particleConfiguration.ParticleMinSize, particleConfiguration.ParticleMaxSize),
				Random.Range(particleConfiguration.ParticleMinLiveTime, particleConfiguration.ParticleMaxLiveTime),
				particleConfiguration.ParticleColor, Random.Range(0f, 360f));
		}
	}

	public static void HitMateriaHalfSphericParticles(Vector3 hitPoint, Vector3 hitNormal, ParticleConfiguration particleConfiguration)
	{
		if (particleConfiguration.ParticleEmitter == null) return;
		Vector3 velocity = Vector3.zero;
		Quaternion rotation = Quaternion.FromToRotation(Vector3.back, hitNormal);
		for (int i = 0; i < particleConfiguration.ParticleCount; i++)
		{
			velocity = Random.insideUnitSphere * Random.Range(particleConfiguration.ParticleMinSpeed, particleConfiguration.ParticleMaxSpeed);
			if (velocity.z > 0f) velocity.z *= -1f;
			velocity = rotation * velocity;
			EmitSafe(particleConfiguration.ParticleEmitter,
				hitPoint, velocity,
				Random.Range(particleConfiguration.ParticleMinSize, particleConfiguration.ParticleMaxSize),
				Random.Range(particleConfiguration.ParticleMinLiveTime, particleConfiguration.ParticleMaxLiveTime),
				particleConfiguration.ParticleColor);
		}
	}

	public static void HitMateriaFullSphericParticles(Vector3 hitPoint, Vector3 hitNormal, ParticleConfiguration particleConfiguration)
	{
		if (particleConfiguration.ParticleEmitter == null) return;
		Vector3 velocity = Vector3.zero;
		for (int i = 0; i < particleConfiguration.ParticleCount; i++)
		{
			velocity = Random.insideUnitSphere * Random.Range(particleConfiguration.ParticleMinSpeed, particleConfiguration.ParticleMaxSpeed);
			EmitSafe(particleConfiguration.ParticleEmitter,
				hitPoint, velocity,
				Random.Range(particleConfiguration.ParticleMinSize, particleConfiguration.ParticleMaxSize),
				Random.Range(particleConfiguration.ParticleMinLiveTime, particleConfiguration.ParticleMaxLiveTime),
				particleConfiguration.ParticleColor);
		}
	}
}
