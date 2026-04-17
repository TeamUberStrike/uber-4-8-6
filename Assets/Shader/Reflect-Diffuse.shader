Shader "Reflective/Diffuse" {
Properties {
    _Color ("Main Color", Color) = (1,1,1,1)
    _ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
    _MainTex ("Base (RGB) RefStrength (A)", 2D) = "white" {}
    _Cube ("Reflection Cubemap", CUBE) = "_Skybox" { TexGen CubeReflect }
    _FrameColor ("Frame/Bracing Color", Color) = (0.65, 0.65, 0.65, 1)
}

SubShader {
    Tags { "RenderType" = "Opaque" }
    LOD 200

    CGPROGRAM
    #pragma surface surf Lambert
    #pragma target 3.0

    sampler2D _MainTex;
    samplerCUBE _Cube;
    fixed4 _Color;
    fixed4 _ReflectColor;
    fixed4 _FrameColor;

    struct Input {
        float2 uv_MainTex;
        float3 worldRefl;
    };

    void surf (Input IN, inout SurfaceOutput o) {
        fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);

        fixed3 glassAlb = tex.rgb * _Color.rgb;
        fixed frameMask = (1.0 - smoothstep(0.02, 0.18, tex.a)) * 0.8;
        o.Albedo = lerp(glassAlb, _FrameColor.rgb, frameMask);

        fixed4 reflcol = texCUBE(_Cube, IN.worldRefl);
        reflcol *= tex.a;
        o.Emission = reflcol.rgb * _ReflectColor.rgb;
        o.Alpha = reflcol.a * _ReflectColor.a;
    }
    ENDCG
}

FallBack "Diffuse"
}
