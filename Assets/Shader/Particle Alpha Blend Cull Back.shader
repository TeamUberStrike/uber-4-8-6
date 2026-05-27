// Cross Platform Shaders/Particles/Alpha Blended Cull Back — restored from DummyShaderTextExporter stub.
// Same as Particles/Alpha Blended but with backface culling (Cull Back instead of Cull Off).
// Used by SkyGarden TransparencyGround materials (ground transparency planes that should
// only be visible from above).
Shader "Cross Platform Shaders/Particles/Alpha Blended Cull Back" {
Properties {
    _TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
    _MainTex ("Particle Texture", 2D) = "white" {}
    _InvFade ("Soft Particles Factor", Range(0.01,3)) = 1
}
SubShader {
    Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" }
    Blend SrcAlpha OneMinusSrcAlpha
    ColorMask RGB
    Cull Back
    Lighting Off
    ZWrite Off

    Pass {
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        #pragma target 2.5
        #pragma multi_compile_particles

        #include "UnityCG.cginc"

        sampler2D _MainTex;
        fixed4 _TintColor;

        sampler2D_float _CameraDepthTexture;
        float _InvFade;

        struct appdata {
            float4 vertex : POSITION;
            fixed4 color : COLOR;
            float2 texcoord : TEXCOORD0;
        };

        struct v2f {
            float4 vertex : SV_POSITION;
            fixed4 color : COLOR;
            float2 texcoord : TEXCOORD0;
            #ifdef SOFTPARTICLES_ON
            float4 projPos : TEXCOORD1;
            #endif
        };

        float4 _MainTex_ST;

        v2f vert(appdata v) {
            v2f o;
            o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
            #ifdef SOFTPARTICLES_ON
            o.projPos = ComputeScreenPos(o.vertex);
            COMPUTE_EYEDEPTH(o.projPos.z);
            #endif
            o.color = v.color;
            o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
            return o;
        }

        fixed4 frag(v2f i) : SV_Target {
            #ifdef SOFTPARTICLES_ON
            float sceneZ = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)));
            float partZ = i.projPos.z;
            float fade = saturate(_InvFade * (sceneZ - partZ));
            i.color.a *= fade;
            #endif

            fixed4 col = 2.0 * i.color * _TintColor * tex2D(_MainTex, i.texcoord);
            col.a = saturate(col.a);
            return col;
        }
        ENDCG
    }
}
}
