Shader "UberStrike/Water" {
Properties {
    _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
    _BumpMap ("Normalmap", 2D) = "bump" {}
    _Cube ("Reflection Cubemap", CUBE) = "black" {}
    _Specular ("Specular", Float) = 2
    _Gloss ("Gloss", Float) = 1
    _Tiling ("Tiling", Float) = 1
    _Opacity ("Opacity", Range(0,1)) = 0.8
}

SubShader {
    Tags { "RenderType" = "Transparent" "Queue" = "Transparent" }
    LOD 200

    CGPROGRAM
    #pragma surface surf BlinnPhong alpha:fade
    #pragma target 3.0

    sampler2D _MainTex;
    sampler2D _BumpMap;
    samplerCUBE _Cube;
    float _Specular;
    float _Gloss;
    float _Tiling;
    float _Opacity;

    struct Input {
        float2 uv_MainTex;
        float2 uv_BumpMap;
        float3 worldRefl;
        INTERNAL_DATA
    };

    void surf(Input IN, inout SurfaceOutput o) {
        float2 uv = IN.uv_MainTex * _Tiling;
        fixed4 c = tex2D(_MainTex, uv);
        o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap * _Tiling));
        fixed4 refl = texCUBE(_Cube, WorldReflectionVector(IN, o.Normal));
        o.Albedo = lerp(c.rgb, refl.rgb, 0.4);
        o.Specular = _Specular;
        o.Gloss = _Gloss;
        o.Alpha = _Opacity;
    }
    ENDCG
}
Fallback "Transparent/Diffuse"
}
