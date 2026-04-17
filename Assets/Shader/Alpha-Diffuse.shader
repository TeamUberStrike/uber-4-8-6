// Transparent/Diffuse — restored from DummyShaderTextExporter stub.
// Alpha-blended diffuse. Used by avatar face materials (DefaultFace).
Shader "Transparent/Diffuse" {
Properties {
    _Color ("Main Color", Color) = (1,1,1,1)
    _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
}
SubShader {
    Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
    LOD 200

    CGPROGRAM
    #pragma surface surf Lambert alpha:fade
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
Fallback "Legacy Shaders/Transparent/Diffuse"
}
