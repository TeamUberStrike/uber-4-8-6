// Cross Platform Shaders/Static/Double Diffuse — restored from DummyShaderTextExporter stub.
// Two diffuse textures blended by a fade factor. Used by SeaFloor (beach blending) and
// other multi-texture map surfaces.
Shader "Cross Platform Shaders/Static/Double Diffuse" {
Properties {
    _Fade ("Detail Fade", Range(0,1)) = 0.5
    _MainTex ("Base (RGB)", 2D) = "white" {}
    _Detail ("Detail (RGB)", 2D) = "gray" {}
}
SubShader {
    Tags { "RenderType"="Opaque" }
    LOD 200

    CGPROGRAM
    #pragma surface surf Lambert
    #pragma target 2.5

    sampler2D _MainTex;
    sampler2D _Detail;
    float _Fade;

    struct Input {
        float2 uv_MainTex;
        float2 uv_Detail;
    };

    void surf(Input IN, inout SurfaceOutput o) {
        fixed4 base = tex2D(_MainTex, IN.uv_MainTex);
        fixed4 detail = tex2D(_Detail, IN.uv_Detail);
        // Linear blend between base and detail by _Fade slider.
        o.Albedo = lerp(base.rgb, detail.rgb, _Fade);
        o.Alpha = base.a;
    }
    ENDCG
}
Fallback "Diffuse"
}
