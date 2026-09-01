// Reconstructed from the 4.7.1 steam baseline (sharedassets1.assets @ byte 17605576).
// AssetRipper stubbed this to a //DummyShaderTextExporter surf/Lambert placeholder (0 real passes),
// which killed the camera Bloom (BloomAndFlares) image effect. This file restores the compiled
// baseline byte-for-byte in semantics: 5 Pass{} blocks in index order 0..4, matching the Unity 4.x
// Standard Assets "Hidden/BlurAndFlares" image-effect shader.
//
// Consumer: Bloom.cs (Assembly-UnityScript-firstpass) blits blurAndFlaresMaterial at pass indices
// 1 (anamorphic stretch), 2 (downsample+threshold+tint), 3 (additive blur), 4 (gaussian blur).
// CheckResources disables the effect unless passCount > 4, so all 5 passes MUST be present in order.
// Pass 0 is never blitted by this material; it exists only to keep indices 1..4 aligned.
Shader "Hidden/BlurAndFlares" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "" {}
		_NonBlurredTex ("Base (RGB)", 2D) = "" {}
	}

	CGINCLUDE

	#include "UnityCG.cginc"

	sampler2D _MainTex;
	sampler2D _NonBlurredTex;
	float4    _MainTex_TexelSize;

	uniform float4 _Offsets;
	uniform float4 _Threshhold;
	uniform float4 _TintColor;
	uniform float  _Saturation;
	uniform float  _StretchWidth;

	// Exact luminance coefficients from the baseline ARB constants.
	#define BAF_LUM half3(0.2199707, 0.70703125, 0.070983887)

	ENDCG

	SubShader {

		// ---------------------------------------------------------------
		// Pass 0 : luminance normalize / saturate  (alignment only, not blitted by this material)
		//   col / (dot(col.rgb, LUM) + 1.5)
		// ---------------------------------------------------------------
		Pass {
			ZTest Always ZWrite Off Cull Off Fog { Mode Off }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			struct v2f {
				float4 pos : SV_POSITION;
				float2 uv  : TEXCOORD0;
			};

			v2f vert (appdata_img v) {
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv  = v.texcoord.xy;
				return o;
			}

			half4 frag (v2f i) : COLOR {
				half4 col = tex2D(_MainTex, i.uv);
				half  lum = dot(col.rgb, BAF_LUM);
				return col * (1.0 / (lum + 1.5));
			}
			ENDCG
		}

		// ---------------------------------------------------------------
		// Pass 1 : anamorphic stretch, 7-tap MAX  (Bloom.cs pass index 1)
		//   offset = _Offsets.xy * _StretchWidth ; taps at uv +/- offset*{2,4,6}
		// ---------------------------------------------------------------
		Pass {
			ZTest Always ZWrite Off Cull Off Fog { Mode Off }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			struct v2f {
				float4 pos : SV_POSITION;
				float2 uv[7] : TEXCOORD0;
			};

			v2f vert (appdata_img v) {
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				float2 uv  = v.texcoord.xy;
				float2 off = _Offsets.xy * _StretchWidth;
				o.uv[0] = uv;
				o.uv[1] = uv + off * 2.0;
				o.uv[2] = uv - off * 2.0;
				o.uv[3] = uv + off * 4.0;
				o.uv[4] = uv - off * 4.0;
				o.uv[5] = uv + off * 6.0;
				o.uv[6] = uv - off * 6.0;
				return o;
			}

			half4 frag (v2f i) : COLOR {
				half4 col = tex2D(_MainTex, i.uv[0]);
				col = max(col, tex2D(_MainTex, i.uv[1]));
				col = max(col, tex2D(_MainTex, i.uv[2]));
				col = max(col, tex2D(_MainTex, i.uv[3]));
				col = max(col, tex2D(_MainTex, i.uv[4]));
				col = max(col, tex2D(_MainTex, i.uv[5]));
				col = max(col, tex2D(_MainTex, i.uv[6]));
				return col;
			}
			ENDCG
		}

		// ---------------------------------------------------------------
		// Pass 2 : downsample + threshold + tint + saturation  (Bloom.cs pass index 2)
		//   offset = _Offsets.xy * _MainTex_TexelSize.xy ; taps at uv +/- offset*{0.5,1.5,2.5}
		//   avg = sum/7 ; c = max(avg - _Threshhold.x, 0) ; saturate around luminance ; rgb *= _TintColor
		// ---------------------------------------------------------------
		Pass {
			ZTest Always ZWrite Off Cull Off Fog { Mode Off }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			struct v2f {
				float4 pos : SV_POSITION;
				float2 uv[7] : TEXCOORD0;
			};

			v2f vert (appdata_img v) {
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				float2 uv  = v.texcoord.xy;
				float2 off = _Offsets.xy * _MainTex_TexelSize.xy;
				o.uv[0] = uv;
				o.uv[1] = uv + off * 0.5;
				o.uv[2] = uv - off * 0.5;
				o.uv[3] = uv + off * 1.5;
				o.uv[4] = uv - off * 1.5;
				o.uv[5] = uv + off * 2.5;
				o.uv[6] = uv - off * 2.5;
				return o;
			}

			half4 frag (v2f i) : COLOR {
				half4 sum = tex2D(_MainTex, i.uv[0]);
				sum += tex2D(_MainTex, i.uv[1]);
				sum += tex2D(_MainTex, i.uv[2]);
				sum += tex2D(_MainTex, i.uv[3]);
				sum += tex2D(_MainTex, i.uv[4]);
				sum += tex2D(_MainTex, i.uv[5]);
				sum += tex2D(_MainTex, i.uv[6]);

				half4 col = max(sum * (1.0 / 7.0) - _Threshhold.x, 0.0);

				half  lum = dot(col.rgb, BAF_LUM);
				col.rgb = (col.rgb - lum) * _Saturation + lum;

				half4 outCol;
				outCol.rgb = col.rgb * _TintColor.rgb;
				outCol.a   = col.a;
				return outCol;
			}
			ENDCG
		}

		// ---------------------------------------------------------------
		// Pass 3 : additive 7-tap blur + luminance normalize  (Bloom.cs pass index 3)
		//   same 7-tap layout as pass 2 ; sum / (dot(sum.rgb, LUM) + 7.5)
		// ---------------------------------------------------------------
		Pass {
			ZTest Always ZWrite Off Cull Off Fog { Mode Off }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			struct v2f {
				float4 pos : SV_POSITION;
				float2 uv[7] : TEXCOORD0;
			};

			v2f vert (appdata_img v) {
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				float2 uv  = v.texcoord.xy;
				float2 off = _Offsets.xy * _MainTex_TexelSize.xy;
				o.uv[0] = uv;
				o.uv[1] = uv + off * 0.5;
				o.uv[2] = uv - off * 0.5;
				o.uv[3] = uv + off * 1.5;
				o.uv[4] = uv - off * 1.5;
				o.uv[5] = uv + off * 2.5;
				o.uv[6] = uv - off * 2.5;
				return o;
			}

			half4 frag (v2f i) : COLOR {
				half4 sum = tex2D(_MainTex, i.uv[0]);
				sum += tex2D(_MainTex, i.uv[1]);
				sum += tex2D(_MainTex, i.uv[2]);
				sum += tex2D(_MainTex, i.uv[3]);
				sum += tex2D(_MainTex, i.uv[4]);
				sum += tex2D(_MainTex, i.uv[5]);
				sum += tex2D(_MainTex, i.uv[6]);

				half lum = dot(sum.rgb, BAF_LUM);
				return sum * (1.0 / (lum + 7.5));
			}
			ENDCG
		}

		// ---------------------------------------------------------------
		// Pass 4 : separable 9-tap gaussian blur  (Bloom.cs pass index 4 - the main blur)
		//   taps at uv +/- _Offsets.xy*{1,2,3,5} ; weights 0.225 / 0.15 / 0.11 / 0.075 / 0.0525
		//   _Offsets is set to (texelSize.x, 0) horizontally and (0, texelSize.y) vertically by the script.
		// ---------------------------------------------------------------
		Pass {
			ZTest Always ZWrite Off Cull Off Fog { Mode Off }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			struct v2f {
				float4 pos : SV_POSITION;
				float2 uv  : TEXCOORD0;   // center
				float4 uv1 : TEXCOORD1;   // uv +/- off*1  (xy = +, zw = -)
				float4 uv2 : TEXCOORD2;   // uv +/- off*2
				float4 uv3 : TEXCOORD3;   // uv +/- off*3
				float4 uv4 : TEXCOORD4;   // uv +/- off*5
			};

			v2f vert (appdata_img v) {
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				float2 uv  = v.texcoord.xy;
				float2 off = _Offsets.xy;
				o.uv  = uv;
				o.uv1 = float4(uv + off * 1.0, uv - off * 1.0);
				o.uv2 = float4(uv + off * 2.0, uv - off * 2.0);
				o.uv3 = float4(uv + off * 3.0, uv - off * 3.0);
				o.uv4 = float4(uv + off * 5.0, uv - off * 5.0);
				return o;
			}

			half4 frag (v2f i) : COLOR {
				half4 col = tex2D(_MainTex, i.uv)        * 0.225;

				col += tex2D(_MainTex, i.uv1.xy)          * 0.15;
				col += tex2D(_MainTex, i.uv1.zw)          * 0.15;

				col += tex2D(_MainTex, i.uv2.xy)          * 0.11;
				col += tex2D(_MainTex, i.uv2.zw)          * 0.11;

				col += tex2D(_MainTex, i.uv3.xy)          * 0.075;
				col += tex2D(_MainTex, i.uv3.zw)          * 0.075;

				col += tex2D(_MainTex, i.uv4.xy)          * 0.0525;
				col += tex2D(_MainTex, i.uv4.zw)          * 0.0525;

				return col;
			}
			ENDCG
		}
	}

	Fallback Off
}
