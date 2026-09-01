Shader "Hidden/BlendForBloom" {
	Properties {
		_MainTex ("Screen Blended", 2D) = "" {}
		_ColorBuffer ("Color", 2D) = "" {}
	}

	// Reconstructed byte-faithfully from the 4.7.1 Steam baseline (sharedassets1.assets @ 17515488).
	// AssetRipper had stubbed this to a //DummyShaderTextExporter surface shader (1 pass), which
	// tripped Bloom.cs's guard (screenBlend.passCount <= 10) and silently disabled the effect.
	// This restores all 11 anonymous passes (0-10) in the exact original order. Consumer Blit pass
	// indices used by Bloom.cs: 0/1 (screen/add final blend), 2 (5-tap MAX downsample),
	// 3 (vignette mask multiply, from!=to), 6 (4-tap box downsample), 7 (vignette mask in-place,
	// from==to), 9 (additive AddTo), 10 (max-accumulate blur composite). Indices 4, 5, 8 are not
	// Blit'd directly but MUST remain present so passCount stays 11 and index 10 resolves.
	// _Intensity and _ColorBuffer are bound at runtime (SetFloat / SetTexture) by Bloom.cs.

	CGINCLUDE

	#include "UnityCG.cginc"

	struct v2f {
		float4 pos : POSITION;
		float2 uv[2] : TEXCOORD0;
	};

	struct v2f_mt {
		float4 pos : POSITION;
		float2 uv[4] : TEXCOORD0;
		float2 uvOrig : TEXCOORD4;
	};

	sampler2D _MainTex;
	sampler2D _ColorBuffer;

	half _Intensity;
	half4 _MainTex_TexelSize;
	half4 _ColorBuffer_TexelSize;

	// Full-screen vert; uv[1] is the color-buffer coord, flipped on platforms with a top-left
	// texel origin (matches the runtime "_ColorBuffer_TexelSize.y < 0" branch in the baseline vs asm).
	v2f vert( appdata_img v ) {
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
		o.uv[0] = v.texcoord.xy;
		o.uv[1] = v.texcoord.xy;
		#if UNITY_UV_STARTS_AT_TOP
		if (_ColorBuffer_TexelSize.y < 0.0)
			o.uv[1].y = 1.0 - o.uv[1].y;
		#endif
		return o;
	}

	// 4 diagonal taps at +/-0.5 texel (of _MainTex) plus the center; used by the MAX downsample (pass 2)
	// and the box downsample (pass 6). Baseline vp emits texcoord[0..4] identically for both.
	v2f_mt vertMultiTap( appdata_img v ) {
		v2f_mt o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
		o.uv[0] = v.texcoord.xy + _MainTex_TexelSize.xy * 0.5;
		o.uv[1] = v.texcoord.xy - _MainTex_TexelSize.xy * 0.5;
		o.uv[2] = v.texcoord.xy - _MainTex_TexelSize.xy * half2(1.0, -1.0) * 0.5;
		o.uv[3] = v.texcoord.xy + _MainTex_TexelSize.xy * half2(1.0, -1.0) * 0.5;
		o.uvOrig = v.texcoord.xy;
		return o;
	}

	// Pass 0 / 4 : screen blend  ->  1 - (1 - colorBuffer) * (1 - mainTex*intensity)
	half4 fragScreen( v2f i ) : COLOR {
		half4 toBlend    = tex2D(_MainTex, i.uv[0]) * _Intensity;
		half4 screenBase = tex2D(_ColorBuffer, i.uv[1]);
		return 1.0 - (1.0 - screenBase) * (1.0 - toBlend);
	}

	// Pass 1 / 5 : additive blend  ->  mainTex*intensity + colorBuffer
	half4 fragAdd( v2f i ) : COLOR {
		half4 addedbloom = tex2D(_MainTex, i.uv[0]);
		half4 screenBase = tex2D(_ColorBuffer, i.uv[1]);
		return _Intensity * addedbloom + screenBase;
	}

	// Pass 2 : 5-tap MAX downsample of _MainTex
	half4 fragMax( v2f_mt i ) : COLOR {
		half4 c = tex2D(_MainTex, i.uvOrig);
		c = max(c, tex2D(_MainTex, i.uv[0]));
		c = max(c, tex2D(_MainTex, i.uv[1]));
		c = max(c, tex2D(_MainTex, i.uv[2]));
		c = max(c, tex2D(_MainTex, i.uv[3]));
		return c;
	}

	// Pass 3 : vignette / mask multiply (from != to)  ->  mainTex * colorBuffer, both at uv[0]
	half4 fragVignetteMul( v2f i ) : COLOR {
		return tex2D(_MainTex, i.uv[0]) * tex2D(_ColorBuffer, i.uv[0]);
	}

	// Pass 6 : 4-tap box downsample (average of the 4 diagonal taps)
	half4 fragBox( v2f_mt i ) : COLOR {
		half4 c = tex2D(_MainTex, i.uv[0]);
		c += tex2D(_MainTex, i.uv[1]);
		c += tex2D(_MainTex, i.uv[2]);
		c += tex2D(_MainTex, i.uv[3]);
		return c * 0.25;
	}

	// Pass 7 : vignette mask multiply in place (from == to). Emits white with the mask's red channel
	// as alpha; combined with "Blend Zero SrcAlpha" this multiplies the framebuffer by the mask.
	half4 fragVignetteBlend( v2f i ) : COLOR {
		return half4(1.0, 1.0, 1.0, tex2D(_ColorBuffer, i.uv[0]).r);
	}

	// Pass 8 : clear / passthrough helper -> writes 0 (baseline fp is a single "MOV result.color, 0").
	half4 fragClear( v2f i ) : COLOR {
		return half4(0.0, 0.0, 0.0, 0.0);
	}

	// Pass 9 : additive AddTo (with "Blend One One")  ->  mainTex * intensity
	half4 fragAddOneOne( v2f i ) : COLOR {
		return _Intensity * tex2D(_MainTex, i.uv[0]);
	}

	// Pass 10 : blur composite (with "Blend One One" + "BlendOp Max")  ->  straight copy of mainTex
	half4 fragCopy( v2f i ) : COLOR {
		return tex2D(_MainTex, i.uv[0]);
	}

	ENDCG

	SubShader {
		ZTest Always Cull Off ZWrite Off
		Fog { Mode Off }

		// Pass 0 : screen blend (default when screenBlendMode == Screen)
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment fragScreen
			#pragma fragmentoption ARB_precision_hint_fastest
			ENDCG
		}

		// Pass 1 : additive blend (default when screenBlendMode == Add / doHdr)
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment fragAdd
			#pragma fragmentoption ARB_precision_hint_fastest
			ENDCG
		}

		// Pass 2 : 5-tap MAX downsample
		Pass {
			CGPROGRAM
			#pragma vertex vertMultiTap
			#pragma fragment fragMax
			#pragma fragmentoption ARB_precision_hint_fastest
			ENDCG
		}

		// Pass 3 : vignette / mask multiply (from != to)
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment fragVignetteMul
			#pragma fragmentoption ARB_precision_hint_fastest
			ENDCG
		}

		// Pass 4 : screen blend (duplicate of pass 0; retained for pass-index parity)
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment fragScreen
			#pragma fragmentoption ARB_precision_hint_fastest
			ENDCG
		}

		// Pass 5 : additive blend (duplicate of pass 1; retained for pass-index parity)
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment fragAdd
			#pragma fragmentoption ARB_precision_hint_fastest
			ENDCG
		}

		// Pass 6 : 4-tap box downsample
		Pass {
			CGPROGRAM
			#pragma vertex vertMultiTap
			#pragma fragment fragBox
			#pragma fragmentoption ARB_precision_hint_fastest
			ENDCG
		}

		// Pass 7 : vignette mask multiply in place (from == to)
		Pass {
			Blend Zero SrcAlpha
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment fragVignetteBlend
			#pragma fragmentoption ARB_precision_hint_fastest
			ENDCG
		}

		// Pass 8 : clear helper (retained for pass-index parity)
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment fragClear
			#pragma fragmentoption ARB_precision_hint_fastest
			ENDCG
		}

		// Pass 9 : additive AddTo
		Pass {
			Blend One One
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment fragAddOneOne
			#pragma fragmentoption ARB_precision_hint_fastest
			ENDCG
		}

		// Pass 10 : max-accumulate blur composite
		Pass {
			Blend One One
			BlendOp Max
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment fragCopy
			#pragma fragmentoption ARB_precision_hint_fastest
			ENDCG
		}
	}

	Fallback off
}
