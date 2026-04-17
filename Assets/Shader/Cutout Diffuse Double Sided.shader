// Cross Platform Shaders/Cutout Diffuse Double Sided — restored from DummyShaderTextExporter stub.
// Alpha-tested diffuse with no backface culling (renders both sides). Used by
// MonkeyIsland CaseFirePot-chain_m material (hanging fire pot chains that need
// to be visible from all angles).
Shader "Cross Platform Shaders/Cutout Diffuse Double Sided" {
Properties {
    _Color ("Main Color", Color) = (1,1,1,1)
    _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
    _Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
}
SubShader {
    Tags { "Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout" }
    LOD 200
    Cull Off

    CGPROGRAM
    #pragma surface surf Lambert alphatest:_Cutoff
    #pragma target 2.5

    sampler2D _MainTex;
    fixed4 _Color;

    struct Input {
        float2 uv_MainTex;
    };

    void surf(Input IN, inout SurfaceOutput o) {
        fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
        o.Albedo = tex.rgb * _Color.rgb;
        o.Alpha = tex.a * _Color.a;
    }
    ENDCG
}
Fallback "Legacy Shaders/Transparent/Cutout/Diffuse"
}
