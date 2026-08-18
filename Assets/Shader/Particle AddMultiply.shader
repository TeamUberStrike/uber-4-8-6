// Ported to Unity 6 (Built-in RP) from the uber471-unity465 branch, where this
// shader already had a real body while main still carried the ForgeRipper stub.
// Particles/~Additive-Multiply -- restored from DummyShaderTextExporter stub.
// Soft-additive blend (Blend OneMinusDstColor One): brightens dark scene areas
// without overexposing bright ones.
//
// Critical for legacy ParticleAnimator (component 12) compatibility: the legacy
// particle system writes per-particle color into vertex color, where alpha is
// typically 0 across all color-animation keyframes (only RGB varies for fade).
// So this shader MUST NOT gate visibility by vertex.a -- the blend `OneMinusDstColor One`
// already ignores src.a, and the shape mask must come from texture luminance only.
//
// Used by GhostSteam.mat on FogInTheShip (Ghost Island ship-interior fog) and other
// legacy-PS smoke/fog/haze effects.
Shader "Particles/~Additive-Multiply" {
Properties {
    _TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
    _MainTex ("Particle Texture", 2D) = "white" {}
    _InvFade ("Soft Particles Factor", Range(0.01,3.0)) = 1.0
}

Category {
    Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" }
    Blend OneMinusDstColor One
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
            fixed4 _TintColor;
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
                fixed4 t = tex2D(_MainTex, i.texcoord);
                // Mask combines three sources to defeat the "white square" problem
                // we hit on legacy ParticleAnimator + textures with weak alpha/RGB fade:
                //  1. tex.a       -- cloud2.png style (shape in alpha)
                //  2. luminance   -- CFX2 style (shape in RGB on black)
                //  3. radial fade -- procedural, kills quad corners even if both
                //                    texture channels are uniform across the quad
                // Critical: NOT vertex.a (legacy ParticleAnimator is zero there).
                fixed lum = max(max(t.r, t.g), t.b);
                float2 uvc = i.texcoord - 0.5;
                float r2 = saturate(dot(uvc, uvc) * 4.0);   // 0 at center, 1 at corner
                fixed radial = 1.0 - r2 * r2;               // smooth quadratic falloff
                fixed mask = t.a * lum * radial;

                fixed4 col;
                col.rgb = i.color.rgb * _TintColor.rgb * t.rgb * 2.0 * mask;
                #ifdef SOFTPARTICLES_ON
                float sceneZ = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)));
                float partZ = i.projPos.z;
                float fade = saturate(_InvFade * (sceneZ - partZ));
                col.rgb *= fade;
                #endif
                col.a = 1.0;  // ignored by Blend OneMinusDstColor One
                return col;
            }
            ENDCG
        }
    }
}
}
