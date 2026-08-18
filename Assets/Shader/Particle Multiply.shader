// Ported to Unity 6 (Built-in RP) from the uber471-unity465 branch, where this
// shader already had a real body while main still carried the ForgeRipper stub.
// Particles/Multiply — restored from DummyShaderTextExporter stub.
// Multiplicative-blend particle shader (Blend DstColor Zero). Used by HalloweenBat
// for the PFXHalloweenFly01/02 swarms on Ghost Island. The texture's RGB modulates
// the scene below; alpha controls fade (lerps toward white = neutral = invisible).
Shader "Particles/Multiply" {
Properties {
    _MainTex ("Particle Texture", 2D) = "white" {}
    _InvFade ("Soft Particles Factor", Range(0.01,3.0)) = 1.0
}

Category {
    Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" }
    Blend DstColor Zero
    ColorMask RGB
    Cull Off
    Lighting Off
    ZWrite Off

    SubShader {
        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_particles
            #pragma target 2.0
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;

            struct appdata_t {
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

            v2f vert (appdata_t v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                #ifdef SOFTPARTICLES_ON
                o.projPos = ComputeScreenPos(o.vertex);
                COMPUTE_EYEDEPTH(o.projPos.z);
                #endif
                o.color = v.color;
                o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
                return o;
            }

            sampler2D_float _CameraDepthTexture;
            float _InvFade;

            fixed4 frag (v2f i) : SV_Target {
                #ifdef SOFTPARTICLES_ON
                float sceneZ = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)));
                float partZ = i.projPos.z;
                float fade = saturate(_InvFade * (sceneZ - partZ));
                i.color.a *= fade;
                #endif

                fixed4 col = tex2D(_MainTex, i.texcoord) * i.color * 2.0;
                // Lerp toward white (multiply identity) based on alpha so transparent
                // pixels do nothing to the framebuffer.
                col.rgb = lerp(half3(1,1,1), col.rgb, col.a);
                return col;
            }
            ENDCG
        }
    }
}
}
