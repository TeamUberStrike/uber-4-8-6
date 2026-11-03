Shader "Cross Platform Shaders/HeatDistort_Particle" {
Properties {
 _BumpAmt ("Distortion", Range(0,128)) = 10
 _BumpMap ("Normalmap", 2D) = "bump" {}
}
SubShader {
 Tags { "Queue"="Overlay" "RenderType"="Overlay" "IgnoreProjector"="True" }
 GrabPass {
  Name "BASE"
  Tags { "LightMode"="Always" }
 }
 Pass {
  Name "BASE"
  Tags { "LightMode"="Always" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#pragma fragmentoption ARB_precision_hint_fastest
#include "UnityCG.cginc"

struct appdata_t {
 float4 vertex : POSITION;
 float2 texcoord : TEXCOORD0;
 fixed4 color : COLOR;
};

struct v2f {
 float4 vertex : POSITION;
 float4 uvgrab : TEXCOORD0;
 float2 uvbump : TEXCOORD1;
 fixed4 color : COLOR;
};

float _BumpAmt;
float4 _BumpMap_ST;
sampler2D _BumpMap;
sampler2D _GrabTexture;
float4 _GrabTexture_TexelSize;

v2f vert (appdata_t v)
{
 v2f o;
 o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
 #if UNITY_UV_STARTS_AT_TOP
 float scale = -1.0;
 #else
 float scale = 1.0;
 #endif
 o.uvgrab.xy = (float2(o.vertex.x, o.vertex.y * scale) + o.vertex.w) * 0.5;
 o.uvgrab.zw = o.vertex.zw;
 o.uvbump = TRANSFORM_TEX(v.texcoord, _BumpMap);
 o.color = v.color;
 return o;
}

half4 frag (v2f i) : COLOR
{
 half2 bump = UnpackNormal(tex2D(_BumpMap, i.uvbump)).rg;
 float2 d = i.uvbump - 0.5;
 half falloff = saturate(1.0 - dot(d, d) * 4.0);
 falloff *= falloff;
 float2 offset = bump * _BumpAmt * _GrabTexture_TexelSize.xy * (i.color.a * falloff);
 i.uvgrab.xy = offset * i.uvgrab.z + i.uvgrab.xy;
 return tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvgrab));
}
ENDCG
 }
}
Fallback Off
}
