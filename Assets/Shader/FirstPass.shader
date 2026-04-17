// UberStrike/Terrain Splatmap — 4-layer terrain blend using a control map.
// The control texture's R/G/B channels drive layers 0-2. Layer 3 fills the
// remainder (1 - R - G - B) so it doesn't require a valid alpha channel.
// This matches Unity 4.6's Terrain/Diffuse built-in behavior.
Shader "UberStrike/Terrain Splatmap" {
Properties {
    _Control ("Control (RGBA)", 2D) = "red" {}
    _Splat0 ("Layer 0 (R)", 2D) = "black" {}
    _Splat1 ("Layer 1 (G)", 2D) = "black" {}
    _Splat2 ("Layer 2 (B)", 2D) = "black" {}
    _Splat3 ("Layer 3 (A)", 2D) = "black" {}
}

SubShader {
    Tags { "RenderType" = "Opaque" "Queue" = "Geometry-100" }
    LOD 200

    CGPROGRAM
    #pragma surface surf Lambert
    #pragma target 3.0

    sampler2D _Control;
    sampler2D _Splat0, _Splat1, _Splat2, _Splat3;
    float4 _Splat0_ST;
    float4 _Splat1_ST;
    float4 _Splat2_ST;
    float4 _Splat3_ST;

    struct Input {
        float2 uv_Control;
    };

    void surf(Input IN, inout SurfaceOutput o) {
        fixed4 ctrl = tex2D(_Control, IN.uv_Control);

        // Compute layer 3 weight as the remainder so we don't depend on the
        // control texture's alpha channel (PNG may not have one → defaults to 1
        // which would plaster layer 3 over the entire terrain).
        float w3 = saturate(1.0 - ctrl.r - ctrl.g - ctrl.b);

        float2 uv = IN.uv_Control;
        fixed3 s0 = tex2D(_Splat0, uv * _Splat0_ST.xy + _Splat0_ST.zw).rgb;
        fixed3 s1 = tex2D(_Splat1, uv * _Splat1_ST.xy + _Splat1_ST.zw).rgb;
        fixed3 s2 = tex2D(_Splat2, uv * _Splat2_ST.xy + _Splat2_ST.zw).rgb;
        fixed3 s3 = tex2D(_Splat3, uv * _Splat3_ST.xy + _Splat3_ST.zw).rgb;

        o.Albedo = s0 * ctrl.r + s1 * ctrl.g + s2 * ctrl.b + s3 * w3;
        o.Alpha = 1.0;
    }
    ENDCG
}
Fallback "Diffuse"
}
