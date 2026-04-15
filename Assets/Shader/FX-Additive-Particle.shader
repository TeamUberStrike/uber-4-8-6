// Additive particle shader for Unity 6 BIRP — replaces the broken built-in
// Particles/Additive reference (fileID 210 zero-guid) used by stub materials.
//
// Scoped narrowly — ONLY materials explicitly redirected via GUID swap will use it.
// Does not affect any other material by default.
//
// Matches the classic Unity 4-5 "Particles/Additive" behavior:
//   Blend SrcAlpha One, ZWrite Off, no depth test occlusion on transparent sorts,
//   Cull Off (double-sided), vertex color * tint color * texture for per-particle tinting.
Shader "FX/Additive Particle" {
Properties {
    _TintColor ("Tint Color", Color) = (0.5, 0.5, 0.5, 0.5)
    _MainTex ("Particle Texture", 2D) = "white" {}
}

SubShader {
    Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" }
    Blend SrcAlpha One
    ColorMask RGB
    Cull Off
    Lighting Off
    ZWrite Off

    Pass {
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        #pragma target 2.5
        #include "UnityCG.cginc"

        sampler2D _MainTex;
        float4 _MainTex_ST;
        fixed4 _TintColor;

        struct appdata {
            float4 vertex : POSITION;
            fixed4 color : COLOR;
            float2 texcoord : TEXCOORD0;
        };

        struct v2f {
            float4 vertex : SV_POSITION;
            fixed4 color : COLOR;
            float2 texcoord : TEXCOORD0;
        };

        v2f vert(appdata v) {
            v2f o;
            o.vertex = UnityObjectToClipPos(v.vertex);
            o.color = v.color;
            o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
            return o;
        }

        fixed4 frag(v2f i) : SV_Target {
            fixed4 col = 2.0f * i.color * _TintColor * tex2D(_MainTex, i.texcoord);
            return col;
        }
        ENDCG
    }
}
Fallback Off
}
