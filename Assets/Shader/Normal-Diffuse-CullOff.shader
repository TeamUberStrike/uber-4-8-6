// Cross Platform Shaders/Diffuse (Cull Off) -- restored from DummyShaderTextExporter stub.
// Plain Lambert diffuse with main texture, color tint, and double-sided rendering
// (Cull Off lets backfaces show too). Used as the fallback shader for materials whose
// Unity 6 Standard binding doesn't exist in U4.6.5 (SpacePortAlpha + UberZone teleporters,
// BlueBox cubes, PickupBaseWeapon, etc.).
Shader "Cross Platform Shaders/Diffuse (Cull Off)" {
Properties {
    _Color ("Main Color", Color) = (1,1,1,1)
    _MainTex ("Base (RGB)", 2D) = "white" {}
}
SubShader {
    Tags { "RenderType"="Opaque" }
    LOD 200
    Cull Off
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
