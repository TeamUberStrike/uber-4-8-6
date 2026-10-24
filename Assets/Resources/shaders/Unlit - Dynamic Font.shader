Shader "Unlit/Dynamic Font" {
Properties {
 _MainTex ("Alpha (A)", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
  AlphaTest Greater 0.01
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
			o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
			return o;
		}

		half4 frag (v2f IN) : COLOR
		{
			half4 col = IN.color;
			col.a *= tex2D(_MainTex, IN.texcoord).a;
			return col;
		}
		ENDCG

 }
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "color", Color
   Bind "texcoord", TexCoord
  }
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
  SetTexture [_MainTex] { ConstantColor [_Color] combine constant * primary, constant alpha * texture alpha }
 }
}
}