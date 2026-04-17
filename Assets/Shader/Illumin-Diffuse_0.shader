// Cross Platform Shaders/Self-Illumin/Diffuse — restored from DummyShaderTextExporter stub.
// Cmune variant of Self-Illumin/Diffuse. Used by SkyGarden InsideBlue_M and InsideRed_M
// panel materials (the colored interior walls).
Shader "Cross Platform Shaders/Self-Illumin/Diffuse" {
Properties {
    _Color ("Main Color", Color) = (1,1,1,1)
    _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
    _Illum ("Illumin (A)", 2D) = "white" {}
    _EmissionLM ("Emission (Lightmapper)", Float) = 0
}
SubShader {
    Tags { "RenderType"="Opaque" }
    LOD 200

    CGPROGRAM
    #pragma surface surf Lambert
    #pragma target 2.5

    sampler2D _MainTex;
    sampler2D _Illum;
    fixed4 _Color;
    float _EmissionLM;

    struct Input {
        float2 uv_MainTex;
        float2 uv_Illum;
    };

    void surf(Input IN, inout SurfaceOutput o) {
        fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
        fixed4 illum = tex2D(_Illum, IN.uv_Illum);
        o.Albedo = tex.rgb * _Color.rgb;
        o.Emission = tex.rgb * illum.a * _Color.rgb;
        o.Alpha = tex.a * _Color.a;
    }
    ENDCG
}
Fallback "Legacy Shaders/Self-Illumin/Diffuse"
}
