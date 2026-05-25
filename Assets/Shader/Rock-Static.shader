// Cross Platform Shaders/Unique/Rock Static — restored from DummyShaderTextExporter stub.
//
// Identified from material slots: MonkeyIsland-Rock_Diffuse / MonkeyTower / Cave /
// WaterRocks / LostParadise2-RockLarge all bind _MainTex + _Detail (10x tiling) + _Color.
// That's the classic Unity 4 "Diffuse Detail" pattern (rock base texture * detail
// multiplier for close-up surface variation), NOT a world-up moss/snow blend. An
// earlier port assumed _MossTex with lerp-by-world-normal, which (a) used the wrong
// property name so materials defaulted Detail to white, and (b) lerp'd top-facing
// faces toward white — gave Ghost Island / Monkey Island rocks a snow-cap look.
Shader "Cross Platform Shaders/Unique/Rock Static" {
Properties {
    _Color ("Main Color", Color) = (1,1,1,1)
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
    fixed4 _Color;

    struct Input {
        float2 uv_MainTex;
        float2 uv_Detail;
    };

    void surf(Input IN, inout SurfaceOutput o) {
        fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
        fixed4 detail = tex2D(_Detail, IN.uv_Detail);
        // Standard Unity "Diffuse Detail" formula: detail * 2 lets the detail texture
        // either darken (values < 0.5) or brighten (> 0.5) the base, with neutral gray
        // (= the default texture) acting as a 1:1 passthrough.
        o.Albedo = c.rgb * detail.rgb * 2.0;
        o.Alpha = c.a;
    }
    ENDCG
}
Fallback "Diffuse"
}
