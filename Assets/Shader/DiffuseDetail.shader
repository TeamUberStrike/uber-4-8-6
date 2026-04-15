// Cross Platform Shaders/Static/Diffuse Detail — restored from DummyShaderTextExporter stub.
// Diffuse base + detail texture overlay (multiplied at 2x for tonal contrast). Used by
// MonkeyIsland bridge/pillar/stone props and most SkyGarden detail surfaces.
Shader "Cross Platform Shaders/Static/Diffuse Detail" {
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
        fixed4 d = tex2D(_Detail, IN.uv_Detail);
        // Classic Unity 4 detail blend: detail * 2 means gray (.5) is neutral,
        // brighter detail brightens, darker detail darkens.
        o.Albedo = c.rgb * d.rgb * 2.0;
        o.Alpha = c.a;
    }
    ENDCG
}
Fallback "Diffuse"
}
