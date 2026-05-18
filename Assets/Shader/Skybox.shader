// RenderFX/Skybox — restored from DummyShaderTextExporter stub.
// Classic 6-sided skybox shader (Unity 4.6 compatible).
// One Pass per face, sampling _FrontTex/_BackTex/_LeftTex/_RightTex/_UpTex/_DownTex.
// Used by Space.mat (SuperPRISMReactor) and HalloweenSky.mat (GhostIsland).
Shader "RenderFX/Skybox" {
Properties {
    _Tint ("Tint Color", Color) = (.5, .5, .5, .5)
    _FrontTex ("Front (+Z)", 2D) = "white" {}
    _BackTex ("Back (-Z)", 2D) = "white" {}
    _LeftTex ("Left (+X)", 2D) = "white" {}
    _RightTex ("Right (-X)", 2D) = "white" {}
    _UpTex ("Up (+Y)", 2D) = "white" {}
    _DownTex ("Down (-Y)", 2D) = "white" {}
}

SubShader {
    Tags { "Queue" = "Background" "RenderType" = "Background" "PreviewType" = "Skybox" }
    Cull Off
    ZWrite Off
    Fog { Mode Off }

    CGINCLUDE
    #include "UnityCG.cginc"
    half4 _Tint;
    struct appdata_t { float4 vertex : POSITION; float2 texcoord : TEXCOORD0; };
    struct v2f { float4 vertex : SV_POSITION; float2 texcoord : TEXCOORD0; };
    v2f vert (appdata_t v) {
        v2f o;
        o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
        o.texcoord = v.texcoord;
        return o;
    }
    half4 skybox_frag (v2f i, sampler2D smp) {
        half4 tex = tex2D (smp, i.texcoord);
        half3 c = tex.rgb * _Tint.rgb * 2.0;
        return half4(c, 1.0);
    }
    ENDCG

    Pass {
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        sampler2D _FrontTex;
        half4 frag (v2f i) : SV_Target { return skybox_frag(i, _FrontTex); }
        ENDCG
    }
    Pass {
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        sampler2D _BackTex;
        half4 frag (v2f i) : SV_Target { return skybox_frag(i, _BackTex); }
        ENDCG
    }
    Pass {
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        sampler2D _LeftTex;
        half4 frag (v2f i) : SV_Target { return skybox_frag(i, _LeftTex); }
        ENDCG
    }
    Pass {
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        sampler2D _RightTex;
        half4 frag (v2f i) : SV_Target { return skybox_frag(i, _RightTex); }
        ENDCG
    }
    Pass {
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        sampler2D _UpTex;
        half4 frag (v2f i) : SV_Target { return skybox_frag(i, _UpTex); }
        ENDCG
    }
    Pass {
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        sampler2D _DownTex;
        half4 frag (v2f i) : SV_Target { return skybox_frag(i, _DownTex); }
        ENDCG
    }
}
Fallback Off
}
