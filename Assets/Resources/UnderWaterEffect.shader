// CMune/Under Water Effect — restored from a //DummyShaderTextExporter stub.
// Screen-space underwater distortion (the subtle swirl/stretch) + a depth color-ramp.
// Reconstructed from the shipped oracle program (resources.assets ARBfp1.0).
// Driven by UnderWaterEffect.cs -> ImageEffects.RenderDistortion, which sets
// _MainTex (Blit source), _RotationMatrix, _CenterRadius, _RampTex, _FadeDistance, _EffectWeight.
Shader "CMune/Under Water Effect" {
Properties {
    _MainTex ("Base (RGB)", 2D) = "white" {}
    _RampTex ("Ramp (RGB)", 2D) = "grayscaleRamp" {}
}
SubShader {
    Tags { "RenderType"="Opaque" }
    Pass {
        ZTest Always
        ZWrite Off
        Cull Off
        Fog { Mode Off }
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        #pragma fragmentoption ARB_precision_hint_fastest
        #include "UnityCG.cginc"

        sampler2D _MainTex;
        sampler2D _RampTex;
        sampler2D _CameraDepthTexture;
        float4x4 _RotationMatrix;
        float4 _CenterRadius;   // xy = center, zw = radius
        float _FadeDistance;
        float _EffectWeight;

        struct v2f {
            float4 pos : SV_POSITION;
            float2 uv  : TEXCOORD0;
            float2 uvc : TEXCOORD1;   // uv relative to the swirl center
        };

        v2f vert(appdata_img v) {
            v2f o;
            o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
            o.uv  = v.texcoord.xy;
            o.uvc = v.texcoord.xy - _CenterRadius.xy;
            return o;
        }

        half4 frag(v2f i) : COLOR {
            // radial swirl: rotate the offset near the center, fade to identity by the radius
            float2 offset = i.uvc;
            float  dist   = length(offset / max(_CenterRadius.zw, 1e-4));
            float2 rot;
            rot.x = dot(_RotationMatrix[0], float4(offset, 0, 0));
            rot.y = dot(_RotationMatrix[1], float4(offset, 0, 0));
            float  t   = min(dist, 1.0);
            float2 duv = lerp(rot, offset, t) + _CenterRadius.xy;
            float2 uv  = i.uv + (duv - i.uv) * _EffectWeight;

            half4 col = tex2D(_MainTex, uv);
            // per-channel color ramp (near-identity until Underwater_ColorRamp is supplied)
            half4 ramp;
            ramp.r = tex2D(_RampTex, half2(col.r, 0.5)).r;
            ramp.g = tex2D(_RampTex, half2(col.g, 0.5)).r;
            ramp.b = tex2D(_RampTex, half2(col.b, 0.5)).r;
            ramp.a = col.a;
            float d    = Linear01Depth(tex2D(_CameraDepthTexture, uv).r);
            float fade = saturate(d / max(_FadeDistance, 1e-4)) * _EffectWeight;
            return lerp(col, ramp, fade);
        }
        ENDCG
    }
}
Fallback Off
}
