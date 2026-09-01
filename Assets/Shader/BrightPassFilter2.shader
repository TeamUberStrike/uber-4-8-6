Shader "Hidden/BrightPassFilter2" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "" {}
	}

	// Shader code pasted into all further CGPROGRAM blocks
	CGINCLUDE

	#include "UnityCG.cginc"

	struct v2f {
		float4 pos : POSITION;
		float2 uv : TEXCOORD0;
	};

	sampler2D _MainTex;
	float4 _Threshhold;

	v2f vert (appdata_img v) {
		v2f o;
		o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
		o.uv = v.texcoord.xy;
		return o;
	}

	// pass 0: scalar threshold ( color.rgb = max(0, color.rgb - _Threshhold.x) )
	half4 fragScalar (v2f i) : COLOR {
		half4 color = tex2D (_MainTex, i.uv);
		color.rgb = max (half3(0,0,0), color.rgb - _Threshhold.x);
		return color;
	}

	// pass 1: colored / per-channel threshold ( color.rgb = max(0, color.rgb - _Threshhold.rgb) )
	half4 fragColored (v2f i) : COLOR {
		half4 color = tex2D (_MainTex, i.uv);
		color.rgb = max (half3(0,0,0), color.rgb - _Threshhold.rgb);
		return color;
	}

	ENDCG

	SubShader {
		ZTest Always Cull Off ZWrite Off
		Fog { Mode Off }

		// 0: scalar threshold
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			Fog { Mode Off }
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment fragScalar
			#pragma fragmentoption ARB_precision_hint_fastest
			ENDCG
		}

		// 1: colored (per-channel) threshold
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			Fog { Mode Off }
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment fragColored
			#pragma fragmentoption ARB_precision_hint_fastest
			ENDCG
		}
	}

	Fallback Off
}
