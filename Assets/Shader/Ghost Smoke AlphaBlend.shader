// Particles/Ghost Smoke Alpha -- dedicated shader for GhostIsland "FogInTheShip" legacy ship smoke.
// The legacy ParticleAnimator animates GREY rgb with alpha ~= 0 (every colour keyframe's A byte is 0),
// so opacity and shape MUST come from the TEXTURE alpha (cloud2.png, alphaIsTransparency:1), never from
// the vertex alpha. Straight alpha blend (SrcAlpha OneMinusSrcAlpha) composites the grey cloud OVER the
// dark ship interior, so dense overlapping sprites converge to the smoke colour and can never blow out to
// white -- the previous additive "Particle AddMultiply" screen-added grey-on-grey up to white.
// Scoped to GhostSteam.mat only; the shared additive shader (still used by BlueLongSpark) is left untouched.
// Mirrors the shipped "Particles/Alpha Blended" sibling exactly except: (a) alpha from t.a (not vertex.a),
// (b) Fog Mode Off so the smoke does not wash toward the scene's purple linear fog.
Shader "Particles/Ghost Smoke Alpha" {
Properties {
	_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
	_MainTex ("Particle Texture", 2D) = "white" {}
	_InvFade ("Soft Particles Factor", Range(0.01,3.0)) = 1.0
}

Category {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" }
	Blend SrcAlpha OneMinusSrcAlpha
	ColorMask RGB
	Cull Off Lighting Off ZWrite Off
	Fog { Mode Off }

	SubShader {
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_particles
			#pragma target 2.0
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			fixed4 _TintColor;
			float4 _MainTex_ST;

			struct appdata_t {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
				#ifdef SOFTPARTICLES_ON
				float4 projPos : TEXCOORD1;
				#endif
			};

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				#ifdef SOFTPARTICLES_ON
				o.projPos = ComputeScreenPos (o.vertex);
				COMPUTE_EYEDEPTH(o.projPos.z);
				#endif
				o.color = v.color;
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}

			sampler2D_float _CameraDepthTexture;
			float _InvFade;

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 t = tex2D(_MainTex, i.texcoord);
				fixed4 col;
				// WHITE steam: colour from the (white) tint only. The ParticleAnimator ramps the vertex
				// rgb black->grey->black, and cloud2 is mid-grey/blue -- multiplying by either darkened
				// the steam (it read black under alpha blend). Ignore both for COLOUR.
				col.rgb = _TintColor.rgb;
				// The animator encodes the birth->peak->death fade as that grey brightness ramp in the
				// vertex COLOUR (vertex alpha is ~0). Map its luminance back into ALPHA so the steam fades
				// in/out over life instead of popping; shape + soft edges still come from the texture alpha.
				half life = saturate(dot(i.color.rgb, half3(1.0, 1.0, 1.0)));
				col.a = t.a * _TintColor.a * life;
				#ifdef SOFTPARTICLES_ON
				float sceneZ = LinearEyeDepth (SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)));
				float partZ = i.projPos.z;
				float fade = saturate (_InvFade * (sceneZ - partZ));
				col.a *= fade;
				#endif
				return col;
			}
			ENDCG
		}
	}
}
}
