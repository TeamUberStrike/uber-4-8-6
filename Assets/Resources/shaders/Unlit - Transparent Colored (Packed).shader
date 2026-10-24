Shader "Unlit/Transparent Colored (Packed)" {
Properties {
 _MainTex ("Base (RGB), Alpha (A)", 2D) = "white" {}
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask RGB
  Offset -1, -1
CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#pragma fragmentoption ARB_precision_hint_fastest
		#include "UnityCG.cginc"

		sampler2D _MainTex;
		float4 _MainTex_ST;

		struct appdata_t
		{
			float4 vertex : POSITION;
			half4 color : COLOR;
			float2 texcoord : TEXCOORD0;
		};

		struct v2f
		{
			float4 vertex : POSITION;
			half4 color : COLOR;
			float2 texcoord : TEXCOORD0;
		};

		v2f vert (appdata_t v)
		{
			v2f o;
			o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
			o.color = v.color;
			o.texcoord = v.texcoord;
			return o;
		}

		half4 frag (v2f IN) : COLOR
		{
			half4 mask = tex2D(_MainTex, IN.texcoord);
			half4 mixed = saturate(ceil(IN.color - 0.5));
			half4 col = saturate((mixed * 0.51 - IN.color) * -2.04);
			mask *= mixed;
			col.a *= mask.r + mask.g + mask.b + mask.a;
			return col;
		}
		ENDCG

 }
}
Fallback Off
}