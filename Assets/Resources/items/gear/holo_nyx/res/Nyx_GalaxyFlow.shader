// Nyx-only derivative of CMune/Water/Opaque_Flowing. Hydra is not modified.
// Unlike the opaque donor, _GalaxyTex is diffuse, and alpha is composited.
Shader "CMune/Holos/Nyx_GalaxyFlow" {
 Properties {
  _MainTex ("Flow normal A", 2D) = "bump" {}
  _BumpMap ("Flow normal B", 2D) = "bump" {}
  _GalaxyTex ("Baked galaxy atlas", 2D) = "black" {}
  _Caustics ("Interior nebula and stars", 2D) = "black" {}
  _Cube ("Reflection cubemap", CUBE) = "black" {}
  _Color ("Violet surface", Color) = (0.10,0.008,0.24,1)
  _WaterColor_Dark ("Deep interior", Color) = (0.006,0.001,0.018,1)
  _ReflectColor ("Indigo magenta rim", Color) = (0.22,0.035,0.50,1)
  _Tiling ("Flow tiling", Float) = 1
  _Gloss ("Gloss", Range(0.01,1)) = 0.3
  _Specular ("Specular", Range(0,2)) = 0.18
  _Opacity ("Body opacity", Range(0,1)) = 0.22
  _RimOpacity ("Rim opacity", Range(0,1)) = 0.42
  _GalaxyStrength ("Galaxy emission", Range(0,4)) = 1.7
  _InteriorStrength ("Interior star layer", Range(0,3)) = 0.65
  _Parallax ("Interior depth", Range(0,0.3)) = 0.10
  _FlowSpeed ("Nebula drift", Range(0,1)) = 0.12
 }
 SubShader {
  Tags { "Queue"="Transparent" "RenderType"="Transparent" "IgnoreProjector"="True" }
  ZWrite Off
  ZTest LEqual
  Blend One OneMinusSrcAlpha
  CGINCLUDE
  #include "UnityCG.cginc"
  #include "Lighting.cginc"
  sampler2D _MainTex, _BumpMap, _GalaxyTex, _Caustics;
  samplerCUBE _Cube;
  fixed4 _Color, _WaterColor_Dark, _ReflectColor;
  float _Tiling, _Gloss, _Specular, _Opacity, _RimOpacity;
  float _GalaxyStrength, _InteriorStrength, _Parallax, _FlowSpeed;
  struct appdata_nyx {
   float4 vertex : POSITION;
   float3 normal : NORMAL;
   float4 tangent : TANGENT;
   float2 uv : TEXCOORD0;
  };
  struct v2f_nyx {
   float4 position : SV_POSITION;
   float2 uv : TEXCOORD0;
   float3 localPos : TEXCOORD1;
   float3 worldPos : TEXCOORD2;
   float3 normal : TEXCOORD3;
   float3 tangent : TEXCOORD4;
   float3 binormal : TEXCOORD5;
  };
  v2f_nyx vertNyx(appdata_nyx v) {
   v2f_nyx o;
   o.position = mul(UNITY_MATRIX_MVP, v.vertex);
   o.uv = v.uv;
   o.localPos = v.vertex.xyz;
   o.worldPos = mul(_Object2World, v.vertex).xyz;
   o.normal = normalize(mul(v.normal, (float3x3)_World2Object));
   o.tangent = normalize(mul((float3x3)_Object2World, v.tangent.xyz));
   o.binormal = normalize(cross(o.normal, o.tangent) * v.tangent.w);
   return o;
  }
  fixed4 shadeNyx(v2f_nyx i, float side, float layerOpacity) {
   float2 flow = _Time.xy * (0.05 * _FlowSpeed);
   half3 n1 = UnpackNormal(tex2D(_MainTex, i.uv * _Tiling + flow));
   half3 n2 = UnpackNormal(tex2D(_BumpMap, i.uv * _Tiling + flow * 1.4));
   half3 nt = normalize(n1 + n2);
   half3 normal = normalize(i.tangent * nt.x + i.binormal * nt.y + i.normal * nt.z) * side;
   half3 view = normalize(_WorldSpaceCameraPos.xyz - i.worldPos);
   half rim = pow(1.0 - saturate(dot(normal, view)), 2.4);
   half3 galaxy = tex2D(_GalaxyTex, i.uv).rgb;
   // Two differently shifted nebula layers supply changing internal depth.
   // Position is already skinned renderer-local position; no new rig is needed.
   float3 localView = normalize(mul((float3x3)_World2Object, view));
   float2 interiorUV = i.localPos.xy * float2(0.82,0.62) + float2(0.5,0.04);
   float2 depth = localView.xy * _Parallax;
   half3 nearNebula = tex2D(_Caustics, interiorUV + depth + flow).rgb;
   half3 farNebula = tex2D(_Caustics, interiorUV * 1.31 - depth * 1.7 - flow * 0.7 + 0.37).rgb;
   half3 interior = nearNebula * 0.65 + farNebula * 0.35;
   half core = exp2(-12.0 * dot((i.localPos.xy - float2(0,1.26)) * float2(2.0,1.0), (i.localPos.xy - float2(0,1.26)) * float2(2.0,1.0)));
   half star = saturate(max(galaxy.r,max(galaxy.g,galaxy.b)) * 1.8);
   half hair = step(0.75,i.uv.x);
   half alpha = saturate((_Opacity + rim * _RimOpacity + star * 0.12 + hair * 0.12) * layerOpacity);
   half3 reflection = texCUBE(_Cube,reflect(-view,normal)).rgb;
   half3 waterCol = lerp(_Color.rgb,_WaterColor_Dark.rgb,saturate(reflection));
   half3 lightDir = normalize(_WorldSpaceLightPos0.xyz - i.worldPos * _WorldSpaceLightPos0.w);
   half diffuse = saturate(dot(normal,lightDir));
   half spec = pow(saturate(dot(normal,normalize(lightDir+view))),max(1.0,_Gloss*128.0)) * _Specular;
   half3 colour = _WaterColor_Dark.rgb + waterCol * (0.15 + diffuse * 0.18);
   colour += galaxy * _GalaxyStrength + interior * _InteriorStrength * (0.55 + core * 0.6);
   colour += _ReflectColor.rgb * rim * 0.38 + _LightColor0.rgb * spec;
   return fixed4(colour * alpha,alpha);
  }
  fixed4 fragBack(v2f_nyx i) : COLOR { return shadeNyx(i,-1.0,0.55); }
  fixed4 fragFront(v2f_nyx i) : COLOR { return shadeNyx(i,1.0,1.0); }
  ENDCG
  // Far-side surface first, then near-side surface. No opaque depth prepass:
  // the far side and scene behind the body remain visible.
  Pass {
   Name "GALAXY_BACK"
   Cull Front
   CGPROGRAM
   #pragma target 3.0
   #pragma vertex vertNyx
   #pragma fragment fragBack
   ENDCG
  }
  Pass {
   Name "GALAXY_FRONT"
   Tags { "LightMode"="ForwardBase" }
   Cull Back
   CGPROGRAM
   #pragma target 3.0
   #pragma vertex vertNyx
   #pragma fragment fragFront
   ENDCG
  }
 }
 Fallback Off
}
