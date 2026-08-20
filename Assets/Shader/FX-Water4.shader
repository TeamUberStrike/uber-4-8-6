Shader "FX/Water4" {
Properties {
 _ReflectionTex ("Internal reflection", 2D) = "white" {}
 _MainTex ("Fallback texture", 2D) = "black" {}
 _ShoreTex ("Shore & Foam texture ", 2D) = "black" {}
 _BumpMap ("Normals ", 2D) = "bump" {}
 _DistortParams ("Distortions (Bump waves, Reflection, Fresnel power, Fresnel bias)", Vector) = (1,1,2,1.15)
 _InvFadeParemeter ("Auto blend parameter (Edge, Shore, Distance scale)", Vector) = (0.15,0.15,0.5,1)
 _AnimationTiling ("Animation Tiling (Displacement)", Vector) = (2.2,2.2,-1.1,-1.1)
 _AnimationDirection ("Animation Direction (displacement)", Vector) = (1,1,1,1)
 _BumpTiling ("Bump Tiling", Vector) = (1,1,-2,3)
 _BumpDirection ("Bump Direction & Speed", Vector) = (1,1,-1,1)
 _FresnelScale ("FresnelScale", Range(0.15,4)) = 0.75
 _BaseColor ("Base color", Color) = (0.54,0.95,0.99,0.5)
 _ReflectionColor ("Reflection color", Color) = (0.54,0.95,0.99,0.5)
 _SpecularColor ("Specular color", Color) = (0.72,0.72,0.72,1)
 _WorldLightDir ("Specular light direction", Vector) = (0,0.1,-0.5,0)
 _Shininess ("Shininess", Range(2,500)) = 200
 _Foam ("Foam (intensity, cutoff)", Vector) = (0.1,0.375,0,0)
 _GerstnerIntensity ("Per vertex displacement", Float) = 1
 _GAmplitude ("Wave Amplitude", Vector) = (0.3,0.35,0.25,0.25)
 _GFrequency ("Wave Frequency", Vector) = (1.3,1.35,1.25,1.25)
 _GSteepness ("Wave Steepness", Vector) = (1,1,1,1)
 _GSpeed ("Wave Speed", Vector) = (1.2,1.375,1.1,1.5)
 _GDirectionAB ("Wave Direction", Vector) = (0.3,0.85,0.85,0.25)
 _GDirectionCD ("Wave Direction", Vector) = (0.1,0.9,0.5,0.5)
}

	// -------------------------------------------------------------------------
	// No-RenderTexture fallback tier, transcribed from the shipped FX/Water4
	// (sharedassets3.assets pathID at byte 25064604). This is the third and
	// simplest SubShader of the shipped shader (LOD 200, keyword-less base
	// variant): its single pass samples ONLY _BumpMap -- no _ReflectionTex
	// (Pro-only reflection RenderTexture) and no _RefractionTex (GrabPass).
	// It is the authentic tier the shipped client falls to on hardware /
	// licences without render-to-texture, exactly analogous to FX/Water's
	// WATER_SIMPLE. On a Unity 4.6 FREE licence this is the tier that renders.
	// The higher tiers (LOD 500 refractive GrabPass + reflection RT, LOD 300
	// reflection RT) are intentionally omitted so the Free build cannot select
	// a tier that needs a reflection RenderTexture it can never create.
	// -------------------------------------------------------------------------

	SubShader {
		Tags { "Queue"="Transparent" "RenderType"="Transparent" }
		LOD 200

		Pass {
			Tags { "Queue"="Transparent" "RenderType"="Transparent" }
			ZWrite Off
			Cull Off
			Blend SrcAlpha OneMinusSrcAlpha
			ColorMask RGB

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#include "UnityCG.cginc"

			sampler2D _BumpMap;

			uniform float4 _BumpTiling;
			uniform float4 _BumpDirection;
			uniform float4 _DistortParams;   // x = bump wave strength, z = fresnel power, w = fresnel bias
			uniform float  _FresnelScale;
			uniform float4 _BaseColor;
			uniform float4 _ReflectionColor;
			uniform float4 _SpecularColor;
			uniform float4 _WorldLightDir;
			uniform float  _Shininess;

			struct appdata {
				float4 vertex : POSITION;
			};

			struct v2f {
				float4 pos            : SV_POSITION;
				float4 viewInterp     : TEXCOORD0;   // xyz = world view vector (surface - camera), w = 1
				float4 bumpCoords     : TEXCOORD1;   // xy / zw = two scrolling bump uv sets
			};

			v2f vert (appdata v)
			{
				v2f o;
				float3 worldPos = mul(_Object2World, v.vertex).xyz;

				o.viewInterp.xyz = worldPos - _WorldSpaceCameraPos;
				o.viewInterp.w   = 1.0;

				o.bumpCoords = (worldPos.xzxz + _Time.x * _BumpDirection) * _BumpTiling;

				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				return o;
			}

			half4 frag (v2f i) : COLOR
			{
				half3 viewDir = normalize(i.viewInterp.xyz);

				// Two scrolling normal-map layers summed. Normal is stored with
				// x in alpha (.w) and y in green (.y); the (sum - 1) remap turns
				// the [0,2] channel sum back into a signed [-1,1] perturbation.
				half4 s = tex2D(_BumpMap, i.bumpCoords.xy) + tex2D(_BumpMap, i.bumpCoords.zw);
				half2 bump = half2(s.w, s.y) - 1.0;

				// Perturbed surface normal about the up axis (0,1,0).
				half3 normal = normalize(float3(0.0, 1.0, 0.0)
				               + (bump.xxy * _DistortParams.x) * float3(1.0, 0.0, 1.0));

				// Fresnel is evaluated against a horizontally-scaled normal.
				half3 fresnelNormal;
				fresnelNormal.xz = normal.xz * _FresnelScale;
				fresnelNormal.y  = normal.y;

				half facing  = max(dot(-viewDir, fresnelNormal), 0.0);
				half fresnel = saturate(_DistortParams.w
				               + (1.0 - _DistortParams.w)
				               * pow(saturate(1.0 - facing), _DistortParams.z));

				// Specular glint against the unscaled normal.
				half3 halfDir = normalize(_WorldLightDir.xyz + viewDir);
				half  spec    = pow(max(0.0, dot(normal, -halfDir)), _Shininess);

				half3 col = lerp(_BaseColor.rgb, _ReflectionColor.rgb, saturate(fresnel * 2.0))
				            + spec * _SpecularColor.rgb;

				half alpha = saturate(fresnel * 2.0 + 0.5);

				return half4(col, alpha);
			}
			ENDCG
		}
	}

	Fallback "Transparent/Diffuse"
}
