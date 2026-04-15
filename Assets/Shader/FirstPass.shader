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
        fixed4 s0 = tex2D(_Splat0, IN.uv_Control * _Splat0_ST.xy + _Splat0_ST.zw);
        fixed4 s1 = tex2D(_Splat1, IN.uv_Control * _Splat1_ST.xy + _Splat1_ST.zw);
        fixed4 s2 = tex2D(_Splat2, IN.uv_Control * _Splat2_ST.xy + _Splat2_ST.zw);
        fixed4 s3 = tex2D(_Splat3, IN.uv_Control * _Splat3_ST.xy + _Splat3_ST.zw);

        o.Albedo = s0.rgb * ctrl.r + s1.rgb * ctrl.g + s2.rgb * ctrl.b + s3.rgb * ctrl.a;
        o.Alpha = 1.0;
    }
    ENDCG
}
Fallback "Diffuse"
}
