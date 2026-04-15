// Cross Platform Shaders/Static/Diffuse — restored from DummyShaderTextExporter stub.
// Equivalent to Unity built-in Diffuse but with explicit _Color tint, used by static
// (non-skinned) map props. Matches the Cmune Cross Platform Shaders pack from UberStrike's
// original Unity 4.6 build.
Shader "Cross Platform Shaders/Static/Diffuse" {
Properties {
    _Color ("Main Color", Color) = (1,1,1,1)
    _MainTex ("Base (RGB)", 2D) = "white" {}
}
SubShader {
    Tags { "RenderType"="Opaque" }
    LOD 200

    CGPROGRAM
    #pragma surface surf Lambert
    #pragma target 2.5

    sampler2D _MainTex;
    fixed4 _Color;

    struct Input {
        float2 uv_MainTex;
    };

    void surf(Input IN, inout SurfaceOutput o) {
        fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
        o.Albedo = c.rgb;
        o.Alpha = c.a;
    }
    ENDCG
}
Fallback "Diffuse"
}
