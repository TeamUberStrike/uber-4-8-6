Shader "Unlit/Masked Colored" {
Properties {
 _MainTex ("Base (RGB) Mask (A)", 2D) = "white" {}
 _Color ("Tint Color", Color) = (1,1,1,1)
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  ColorMask RGB
CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#pragma fragmentoption ARB_precision_hint_fastest
		#include "UnityCG.cginc"

		sampler2D _MainTex;
		float4 _MainTex_ST;
		fixed4 _Color;

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
			o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
			return o;
		}

		half4 frag (v2f IN) : COLOR
		{
			half4 col = tex2D(_MainTex, IN.texcoord) * IN.color;
			col.rgb = lerp(col.rgb, col.rgb * _Color.rgb, col.a);
			return col;
		}
		ENDCG

 }
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  AlphaTest Greater 0.01
  ColorMask RGB
  ColorMaterial AmbientAndDiffuse
  SetTexture [_MainTex] { combine texture * primary }
  SetTexture [_MainTex] { ConstantColor [_Color] combine previous * constant }
 }
}
}