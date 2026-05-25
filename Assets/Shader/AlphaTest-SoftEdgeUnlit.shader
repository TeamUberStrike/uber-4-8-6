// Transparent/Cutout/Soft Edge Unlit — restored from DummyShaderTextExporter stub.
// Cmune-style unlit alpha-test for foliage / snow / decal cards. The original
// rendered as flat-black Lambert (stub) which broke the snow effects on
// FortWinter and the grass/foliage decals on GhostIsland. Unity 4.6.5-native
// CG: UNITY_MATRIX_MVP, clip(alpha - cutoff), tex tint. No lighting.
Shader "Transparent/Cutout/Soft Edge Unlit" {
Properties {
    _Color ("Main Color", Color) = (1,1,1,1)
    _MainTex ("Base (RGB) Alpha (A)", 2D) = "white" {}
    _Cutoff ("Base Alpha cutoff", Range(0,0.9)) = 0.5
}

SubShader {
    Tags { "Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout" }
    LOD 100
    Cull Off
    Lighting Off
    ZWrite On

    Pass {
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        #include "UnityCG.cginc"

        sampler2D _MainTex;
        float4 _MainTex_ST;
        fixed4 _Color;
        fixed _Cutoff;

        struct appdata {
            float4 vertex : POSITION;
            float2 uv : TEXCOORD0;
        };

        struct v2f {
            float4 pos : SV_POSITION;
            float2 uv : TEXCOORD0;
        };

        v2f vert (appdata v) {
            v2f o;
            o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
            o.uv = TRANSFORM_TEX(v.uv, _MainTex);
            return o;
        }

        fixed4 frag (v2f i) : SV_Target {
            fixed4 c = tex2D(_MainTex, i.uv) * _Color;
            clip(c.a - _Cutoff);
            return c;
        }
        ENDCG
    }
}

Fallback "Transparent/Cutout/VertexLit"
}
