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

	// =========================================================================
	// Tier 1 (LOD 500) -- REFRACTIVE, restored now that the RenderTexture unlock
	// makes GrabPass + Depth available on this Unity 4.6.5 editor. Transcribed
	// from the shipped FX/Water4 top SubShader (sharedassets3.assets @25064612):
	//   * 4-wave Gerstner vertex displacement (real wave motion)
	//   * GrabPass "_RefractionTex" + projective refraction (fills RGB from the
	//     scene below -> the surface reads OPAQUE; that fixes "too transparent")
	//   * depth-based edge blend: output alpha = edge (soft shorelines)
	// If this tier fails to compile on any GPU, Unity drops to the LOD 200 tier
	// below (the previous simple look) -- water can never go magenta.
	// =========================================================================
	SubShader {
		Tags { "WaterMode"="Refractive" "Queue"="Transparent" "RenderType"="Transparent" }
		LOD 500

		GrabPass { "_RefractionTex" }

		Pass {
			ZWrite Off
			Cull Off
			Blend SrcAlpha OneMinusSrcAlpha
			ColorMask RGB

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma target 3.0
			#include "UnityCG.cginc"

			sampler2D _RefractionTex;
			sampler2D _ReflectionTex;
			sampler2D _BumpMap;
			sampler2D _CameraDepthTexture;
			sampler2D _ShoreTex;   // shore/foam mask -- required by the shipped shore+crest foam term

			uniform float4 _BumpTiling;
			uniform float4 _BumpDirection;
			uniform float4 _DistortParams;   // x=bump strength, y=refraction distort, z=fresnel power, w=fresnel bias
			uniform float  _FresnelScale;
			uniform float4 _BaseColor;
			uniform float4 _ReflectionColor;
			uniform float4 _SpecularColor;
			uniform float4 _WorldLightDir;
			uniform float  _Shininess;
			uniform float4 _Foam;
			uniform float4 _InvFadeParemeter;   // x=edge blend, w=distance colour scale
			uniform float  _GerstnerIntensity;
			uniform float4 _GAmplitude;
			uniform float4 _GFrequency;
			uniform float4 _GSteepness;
			uniform float4 _GSpeed;
			uniform float4 _GDirectionAB;
			uniform float4 _GDirectionCD;

			// Standard Water4 4-wave Gerstner sum (matches the extracted oracle GLSL).
			inline float3 GerstnerOffset4 (float2 xzVtx, float4 steepness, float4 amp,
			                               float4 freq, float4 speed, float4 dirAB, float4 dirCD)
			{
				float3 offsets;
				float4 AB = steepness.xxyy * amp.xxyy * dirAB.xyzw;
				float4 CD = steepness.zzww * amp.zzww * dirCD.xyzw;
				float4 dotABCD = freq.xyzw * float4(dot(dirAB.xy, xzVtx), dot(dirAB.zw, xzVtx),
				                                    dot(dirCD.xy, xzVtx), dot(dirCD.zw, xzVtx));
				float4 TIME = _Time.yyyy * speed;
				float4 COS = cos(dotABCD + TIME);
				float4 SIN = sin(dotABCD + TIME);
				offsets.x = dot(COS, float4(AB.xz, CD.xz));
				offsets.z = dot(COS, float4(AB.yw, CD.yw));
				offsets.y = dot(SIN, amp);
				return offsets;
			}
			inline float3 GerstnerNormal4 (float2 xzVtx, float4 amp, float4 freq,
			                               float4 speed, float4 dirAB, float4 dirCD)
			{
				float3 nrml = float3(0.0, 2.0, 0.0);
				float4 AB = freq.xxyy * amp.xxyy * dirAB.xyzw;
				float4 CD = freq.zzww * amp.zzww * dirCD.xyzw;
				float4 dotABCD = freq.xyzw * float4(dot(dirAB.xy, xzVtx), dot(dirAB.zw, xzVtx),
				                                    dot(dirCD.xy, xzVtx), dot(dirCD.zw, xzVtx));
				float4 TIME = _Time.yyyy * speed;
				float4 COS = cos(dotABCD + TIME);
				nrml.x -= dot(COS, float4(AB.xz, CD.xz));
				nrml.z -= dot(COS, float4(AB.yw, CD.yw));
				nrml.xz *= _GerstnerIntensity;
				nrml = normalize(nrml);
				return nrml;
			}

			struct appdata { float4 vertex : POSITION; };

			struct v2f {
				float4 pos          : SV_POSITION;
				float4 normalInterp : TEXCOORD0;   // xyz = perturbed world normal
				float4 viewInterp   : TEXCOORD1;   // xyz = world view vec, w = foam/edge term
				float4 bumpCoords   : TEXCOORD2;   // two scrolling bump uv sets
				float4 grabPos      : TEXCOORD3;   // screen coord for depth/edge taps (NOT y-flipped)
				float4 reflUV       : TEXCOORD4;   // y-flipped grab coord for the refraction tap
			};

			v2f vert (appdata v)
			{
				v2f o;
				float4 worldVtx = mul(_Object2World, v.vertex);
				float2 xzVtx = worldVtx.xz;

				float3 offsets = GerstnerOffset4(xzVtx, _GSteepness, _GAmplitude, _GFrequency, _GSpeed, _GDirectionAB, _GDirectionCD);
				float3 nrml    = GerstnerNormal4(xzVtx, _GAmplitude, _GFrequency, _GSpeed, _GDirectionAB, _GDirectionCD);
				worldVtx.xyz += offsets;

				o.pos = mul(UNITY_MATRIX_VP, worldVtx);
				o.normalInterp = float4(nrml, 1.0);
				o.viewInterp.xyz = worldVtx.xyz - _WorldSpaceCameraPos;
				o.viewInterp.w   = clamp(offsets.y, 0.0, 1.0);

				o.bumpCoords = (worldVtx.xzxz + _Time.x * _BumpDirection) * _BumpTiling;

				float4 clip = o.pos;
				// DEPTH / edge-blend tap coord (screen space, NOT y-flipped). This is the
				// orientation _CameraDepthTexture is stored in, which is why the shore/opacity
				// read correctly -- leave it exactly as-is.
				o.grabPos.xy = (clip.xy + clip.w) * 0.5;
				o.grabPos.zw = clip.zw;
				// REFRACTION grab coord. ComputeGrabScreenPos applies the platform y-flip
				// (scale=-1 under UNITY_UV_STARTS_AT_TOP on D3D). The previous hand-rolled coord
				// omitted that flip, so the GrabPass frame was sampled UPSIDE-DOWN -> the water
				// showed a vertically-mirrored image of the map ("reflective surface"). The
				// GrabPass texture and _CameraDepthTexture have OPPOSITE y-orientation on D3D,
				// so refraction needs its own flipped coord while depth keeps grabPos. reflUV
				// (formerly the unused projected-reflection coord) now carries it.
				o.reflUV = ComputeGrabScreenPos(o.pos);
				return o;
			}

			half4 frag (v2f i) : COLOR
			{
				half3 viewDir = normalize(i.viewInterp.xyz);

				half4 s = tex2D(_BumpMap, i.bumpCoords.xy) + tex2D(_BumpMap, i.bumpCoords.zw);
				half2 bump = half2(s.w, s.y) - 1.0;
				half3 normal = normalize(i.normalInterp.xyz + (bump.xxy * _DistortParams.x) * half3(1.0, 0.0, 1.0));

				// Refraction (GrabPass, grabs the already-rendered frame -- no re-render/lag) + the shipped
				// depth-guard: revert to the UNDISTORTED tap when the distorted tap pulls in geometry IN
				// FRONT of the surface (stops foreground/edge bleed). Verbatim shipped @byte 25071673.
				float4 distort = float4(normal.xz * _DistortParams.y * 10.0, 0.0, 0.0);
				// Sample the GrabPass via reflUV (ComputeGrabScreenPos, y-flipped for D3D) -- NOT
				// grabPos -- otherwise the refraction is the map mirrored upside-down.
				half4 refr       = tex2Dproj(_RefractionTex, UNITY_PROJ_COORD(i.reflUV + distort));
				half4 refrUndist = tex2Dproj(_RefractionTex, UNITY_PROJ_COORD(i.reflUV));
				float distZ = LinearEyeDepth(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.grabPos + distort)).r);
				if (distZ < i.grabPos.z) refr = refrUndist;   // i.grabPos.z == clip.z (verbatim shipped)

				// Planar reflection (1:1 shipped Water4): sample the PlanarReflection camera RT
				// (_ReflectionTex) blended toward _ReflectionColor by its alpha. Uses grabPos
				// (ComputeScreenPos, main camera) -- NOT reflUV: a camera RenderTexture and a GrabPass
				// have OPPOSITE y-orientation on D3D, so the reflection keeps grabPos while the GrabPass
				// refraction above keeps reflUV. If the reflection reads upside-down, flip grabPos here.
				half3 reflCol = lerp(tex2Dproj(_ReflectionTex, UNITY_PROJ_COORD(i.grabPos + distort)).rgb,
				                     _ReflectionColor.rgb, _ReflectionColor.a);

				// Depth edge-blend from _CameraDepthTexture (grabPos = safe non-y-flipped screen tap;
				// .w == clip.w). edgeBlend.x -> ALPHA (opaque in deep water, transparent at shore);
				// edgeBlend.y -> the shore source for foam. THE opacity switch: needs the camera depth
				// texture populated (WaterBase sets DepthTextureMode.Depth) or edge collapses to 0.
				float sceneZ = LinearEyeDepth(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.grabPos)).r);
				half4 edgeBlend = saturate(_InvFadeParemeter * (sceneZ - i.grabPos.w));
				half  shoreFac  = 1.0 - edgeBlend.y;

				// fresnel (horizontally-scaled normal)
				half3 fresnelNormal; fresnelNormal.xz = normal.xz * _FresnelScale; fresnelNormal.y = normal.y;
				half facing  = max(dot(-viewDir, fresnelNormal), 0.0);
				half fresnel = saturate(_DistortParams.w + (1.0 - _DistortParams.w) * pow(saturate(1.0 - facing), _DistortParams.z));

				half3 halfDir = normalize(_WorldLightDir.xyz + viewDir);
				half  spec    = pow(max(0.0, dot(normal, -halfDir)), _Shininess);

				half4 baseCol = _BaseColor - i.viewInterp.w * _InvFadeParemeter.w * half4(0.15, 0.03, 0.01, 0.0);

				// Shore + crest foam (shipped @byte 25072793): _ShoreTex mask * _Foam.x, gated by
				// (shore factor + crest above _Foam.y). Shore-based -> restores the island-edge blend
				// WITHOUT whitening open-water crests (shoreFac ~0 in deep water, so no deep foam).
				float4 shoreUV = i.bumpCoords * 2.0;
				half3 foam = ((tex2D(_ShoreTex, shoreUV.xy) * tex2D(_ShoreTex, shoreUV.zw)).rgb - 0.125)
				             * _Foam.x * (shoreFac + saturate(i.viewInterp.w - _Foam.y));

				half3 rgb = lerp( lerp(refr.rgb, baseCol.rgb, baseCol.a), reflCol, fresnel )
				            + spec * _SpecularColor.rgb
				            + foam;

				return half4(rgb, edgeBlend.x);   // alpha = edge.x -> opaque deep water, transparent at shore
			}
			ENDCG
		}
	}

	// -------------------------------------------------------------------------
	// Tier 2 (LOD 200) -- no-RenderTexture fallback (the previous simple tier).
	// Kept as the fallback so any GPU/driver that can't run the refractive tier
	// above still gets water. Samples ONLY _BumpMap; no GrabPass, no reflection.
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
			uniform float4 _DistortParams;
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
				float4 viewInterp     : TEXCOORD0;
				float4 bumpCoords     : TEXCOORD1;
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

				half4 s = tex2D(_BumpMap, i.bumpCoords.xy) + tex2D(_BumpMap, i.bumpCoords.zw);
				half2 bump = half2(s.w, s.y) - 1.0;

				half3 normal = normalize(float3(0.0, 1.0, 0.0)
				               + (bump.xxy * _DistortParams.x) * float3(1.0, 0.0, 1.0));

				half3 fresnelNormal;
				fresnelNormal.xz = normal.xz * _FresnelScale;
				fresnelNormal.y  = normal.y;

				half facing  = max(dot(-viewDir, fresnelNormal), 0.0);
				half fresnel = saturate(_DistortParams.w
				               + (1.0 - _DistortParams.w)
				               * pow(saturate(1.0 - facing), _DistortParams.z));

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
