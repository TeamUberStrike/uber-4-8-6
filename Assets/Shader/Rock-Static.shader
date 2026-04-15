// Cross Platform Shaders/Unique/Rock Blend — restored from DummyShaderTextExporter stub.
// Rock with moss overlay blended by world-up direction. The classic technique is to put
// moss on top-facing (up-vector aligned) faces and bare rock on side faces, with _Fading
// controlling the blend falloff and _Threshold being the dot-product cutoff. Used heavily
// on MonkeyIsland (rocks, cave walls, Monkey Tower, water rocks).
Shader "Cross Platform Shaders/Unique/Rock Blend" {
Properties {
    _MainTex ("Rock (RGB)", 2D) = "white" {}
    _MossTex ("Moss (RGB)", 2D) = "white" {}
    _Fading ("Fading", Range(1,10)) = 5
    _Threshold ("Threshold", Range(0,1)) = 0.5
    _FadeColor ("Fade Direction", Vector) = (0,1,0,1)
}
SubShader {
    Tags { "RenderType"="Opaque" }
    LOD 200

    CGPROGRAM
    #pragma surface surf Lambert vertex:vert
    #pragma target 2.5

    sampler2D _MainTex;
    sampler2D _MossTex;
    float _Fading;
    float _Threshold;
    float4 _FadeColor;

    struct Input {
        float2 uv_MainTex;
        float2 uv_MossTex;
        float blendValue;
    };

    void vert(inout appdata_full v, out Input o) {
        UNITY_INITIALIZE_OUTPUT(Input, o);
        // World-space normal alignment with the fade direction (default +Y).
        float3 worldNormal = mul((float3x3)unity_ObjectToWorld, v.normal);
        float dotN = dot(normalize(worldNormal), normalize(_FadeColor.xyz));
        // Smoothstep around the threshold, with falloff controlled by _Fading.
        o.blendValue = saturate((dotN - _Threshold) * _Fading);
    }

    void surf(Input IN, inout SurfaceOutput o) {
        fixed4 rock = tex2D(_MainTex, IN.uv_MainTex);
        fixed4 moss = tex2D(_MossTex, IN.uv_MossTex);
        o.Albedo = lerp(rock.rgb, moss.rgb, IN.blendValue);
        o.Alpha = 1.0;
    }
    ENDCG
}
Fallback "Diffuse"
}
