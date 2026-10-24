Shader "Unlit/Premultiplied Colored (SoftClip)" {
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
  Blend One OneMinusSrcAlpha
  ColorMask RGB
  Offset -1, -1
CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#pragma fragmentoption ARB_precision_hint_fastest
		#include "UnityCG.cginc"

		sampler2D _MainTex;
		float4 _MainTex_ST;
		float2 _ClipSharpness = float2(20.0, 20.0);

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
			float2 worldPos : TEXCOORD1;
		};

		v2f vert (appdata_t v)
		{
			v2f o;
			o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
			o.color = v.color;
			o.texcoord = v.texcoord;
			o.worldPos = TRANSFORM_TEX(v.vertex.xy, _MainTex);
			return o;
		}

		half4 frag (v2f IN) : COLOR
		{
			half4 col = tex2D(_MainTex, IN.texcoord) * IN.color;
			float2 factor = (float2(1.0, 1.0) - abs(IN.worldPos)) * _ClipSharpness;
			col *= clamp(min(factor.x, factor.y), 0.0, 1.0);
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
  Blend One OneMinusSrcAlpha
  ColorMask RGB
  ColorMaterial AmbientAndDiffuse
  Offset -1, -1
  SetTexture [_MainTex] { combine texture * primary }
 }
}
}