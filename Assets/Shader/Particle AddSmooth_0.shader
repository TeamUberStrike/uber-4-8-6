// Particles/Additive (Soft) — restored from DummyShaderTextExporter stub.
// Soft additive particle: blends with (One, OneMinusSrcColor) for a softer glow
// that doesn't blow out to white as aggressively as pure additive. No _TintColor;
// uses vertex color directly. Used by blast rings, dust, sparks, trail explosions.
Shader "Particles/Additive (Soft)" {
Properties {
    _MainTex ("Particle Texture", 2D) = "white" {}
    _InvFade ("Soft Particles Factor", Range(0.01,3)) = 1
}
SubShader {
    Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" }
    Blend One OneMinusSrcColor
    ColorMask RGB
    Cull Off
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

        UNITY_DECLARE_DEPTH_TEXTURE(_CameraDepthTexture);
        float _InvFade;

        struct appdata {
            float4 vertex : POSITION;
            fixed4 color : COLOR;
            float2 texcoord : TEXCOORD0;
            UNITY_VERTEX_INPUT_INSTANCE_ID
        };

        struct v2f {
            float4 vertex : SV_POSITION;
            fixed4 color : COLOR;
            float2 texcoord : TEXCOORD0;
            #ifdef SOFTPARTICLES_ON
            float4 projPos : TEXCOORD1;
            #endif
            UNITY_VERTEX_OUTPUT_STEREO
        };

        float4 _MainTex_ST;

        v2f vert(appdata v) {
            v2f o;
            UNITY_SETUP_INSTANCE_ID(v);
            UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
            o.vertex = UnityObjectToClipPos(v.vertex);
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

            fixed4 col = i.color * tex2D(_MainTex, i.texcoord);
            col.rgb *= col.a;
            return col;
        }
        ENDCG
    }
}
Fallback "Particles/Additive (Soft)"
}
