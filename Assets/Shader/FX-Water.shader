// FX/Water — Unity 4.6 Free-compatible custom vert+frag water shader.
//
// Surface shader path hit "Too many texture interpolators" on Unity 4.6 SM3
// once I needed multiple scrolling UVs + INTERNAL_DATA + worldRefl. Switching
// to a minimal custom vert+frag pipeline that:
//   - Computes 2 scrolling UVs in vert (guaranteed _Time-driven per frame).
//   - Samples _MainTex caustic at both UVs and blends → flowing shimmer.
//   - Samples _BumpMap at both UVs and blends → animated normals.
//   - Manual BlinnPhong specular against a fake sun direction.
//   - Tinted by _Color.
//   - Alpha-blended via _Opacity.
//
// Keeps "FX/Water" name + GUID 915a5308... so Menu Water.mat picks it up
// without rebinding. NO RenderTexture — works on Unity 4.6 Free license.
Shader "FX/Water"
{
    Properties
    {
        _Color       ("Tint",                Color)         = (0.18, 0.30, 0.24, 1)
        _MainTex     ("Base (RGB)",          2D)            = "white" {}
        _BumpMap     ("Normalmap",           2D)            = "bump"  {}
        _SunDir      ("Sun direction (xyz)", Vector)        = (0.4, 0.9, 0.3, 0)
        _SpecColor2  ("Specular color",      Color)         = (1.0, 1.0, 0.95, 1)
        _SpecPower   ("Specular sharpness",  Range(8, 256)) = 40
        _SpecAmount  ("Specular intensity",  Range(0, 1))   = 0.30
        _FresnelPow  ("Fresnel power",       Range(1, 8))   = 4.0
        _FresnelAmt  ("Fresnel intensity",   Range(0, 1))   = 0.18
        _CrestAmount ("Wave crest brightness", Range(0, 1)) = 0.16
        _Distortion  ("Refraction wobble",    Range(0, 0.3)) = 0.07
        _Tiling      ("Tiling",              Range(0.1, 8)) = 2.8
        _Opacity     ("Opacity",             Range(0, 1))   = 0.82
        _CausticDepth ("Deep caustic strength", Range(0, 1)) = 0.18
        _CausticTile ("Deep caustic tiling",  Range(0.5, 16)) = 4.5
        _ScrollSpeed ("Wave scroll (xy, xy)", Vector)        = (0.040, 0.020, -0.030, 0.035)

        // Real reflection cubemap (material already binds this to the
        // lobby's environment cubemap GUID d90d88b5e57c34d4db77bbeba8afa6bd).
        _ReflectiveColorCube ("Reflection cubemap", Cube)        = "" {}
        _ReflStrength        ("Reflection strength", Range(0,4)) = 1.6

        // Legacy properties (declared so material warnings don't fire).
        _WaveScale       ("Wave scale (legacy)",   Float)  = 0.063
        _ReflDistort     ("Refl distort (legacy)", Float)  = 0.44
        _RefrDistort     ("Refr distort (legacy)", Float)  = 0.40
        _RefrColor       ("Refr color (legacy)",   Color)  = (0.34, 0.85, 0.92, 1)
        _Fresnel         ("Fresnel (legacy)",      2D)     = "gray" {}
        WaveSpeed        ("WaveSpeed (legacy)",    Vector) = (19, 9, -16, -7)
        _ReflectiveColor ("RefColor (legacy)",     2D)     = "white" {}
        _HorizonColor    ("Horizon (legacy)",      Color)  = (0.15, 0.50, 0.42, 1)
    }

    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" "IgnoreProjector"="True" }
        LOD 200
        Blend SrcAlpha OneMinusSrcAlpha
        Cull Back
        ZWrite Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            sampler2D _BumpMap;
            float4    _MainTex_ST;
            fixed4    _Color;
            float4    _SunDir;
            fixed4    _SpecColor2;
            half      _SpecPower;
            half      _SpecAmount;
            half      _Tiling;
            half      _Opacity;
            float4    _ScrollSpeed;
            half      _FresnelPow;
            half      _FresnelAmt;
            half      _CrestAmount;
            half      _Distortion;
            half      _CausticDepth;
            half      _CausticTile;
            samplerCUBE _ReflectiveColorCube;
            half      _ReflStrength;

            struct appdata
            {
                float4 vertex   : POSITION;
                float3 normal   : NORMAL;
                float2 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos     : SV_POSITION;
                float2 uv0     : TEXCOORD0;   // caustic / bump layer A
                float2 uv1     : TEXCOORD1;   // caustic / bump layer B
                float3 viewDir : TEXCOORD2;   // for specular
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

                float2 baseUV = v.texcoord * _Tiling;
                o.uv0 = baseUV + _ScrollSpeed.xy * _Time.y;
                o.uv1 = baseUV + _ScrollSpeed.zw * _Time.y;

                float3 worldPos = mul(_Object2World, v.vertex).xyz;
                o.viewDir = normalize(_WorldSpaceCameraPos.xyz - worldPos);

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // Sample bump first so we can use the normal to distort the
                // caustic UV reads. This fakes the refraction wobble of
                // real water — light wavers through the surface instead of
                // hitting it straight. No RenderTexture needed.
                fixed3 bn0 = UnpackNormal(tex2D(_BumpMap, i.uv0));
                fixed3 bn1 = UnpackNormal(tex2D(_BumpMap, i.uv1));
                float2 wobble = (bn0.xy + bn1.xy) * 0.5 * _Distortion;

                fixed4 c1 = tex2D(_MainTex, i.uv0 + wobble);
                fixed4 c2 = tex2D(_MainTex, i.uv1 - wobble);
                fixed lum = dot(c1.rgb * c2.rgb * 2.0, fixed3(0.3, 0.59, 0.11));

                // Deep caustic layer — higher tiling, stronger distortion.
                // Reads as bright sun patterns on the floor BELOW the water
                // surface, viewed through the wavy surface above. This is
                // what gives real water its "see-into-it" optical-zoom look.
                float2 deepUV = i.uv0 * (_CausticTile / _Tiling) + wobble * 2.5;
                fixed deepCaustic = tex2D(_MainTex, deepUV).g;
                deepCaustic = pow(deepCaustic, 2.0) * _CausticDepth;

                // Procedural sin-wave shimmer — guarantees visible motion
                // even when the caustic texture itself is bland/uniform.
                float r1 = sin(i.uv0.x * 12.0 + _Time.y * 1.8);
                float r2 = sin(i.uv1.y *  9.0 - _Time.y * 1.3);
                float r3 = sin((i.uv0.x + i.uv0.y) * 7.0 + _Time.y * 2.4);
                fixed ripple = (r1 + r2 + r3) * 0.16667 + 0.5; // -> 0..1 ish
                // Shimmer + luminance combined product stays <= 1.0 so the
                // green tint is never bleached to white. Was peaking at ~1.59.
                // Lower floor lets dark patches stay dark (depth variation
                // visible in target), keeps peak at 1.0 so no white bleach.
                // Tightened range so murky base reads dark, accents bright.
                fixed shimmer = lerp(0.62, 0.98, ripple);
                fixed lumMod  = saturate(0.35 + lum * 0.70);

                fixed3 baseRGB = _Color.rgb * lumMod * shimmer;

                // Reuse the bump samples we already took for distortion.
                fixed3 worldN = normalize(bn0 + bn1);
                fixed3 n1 = bn0;
                fixed3 n2 = bn1;
                // Twist into world-up space (water is mostly flat horizontal).
                worldN = normalize(float3(worldN.x, 1.0, worldN.y));

                // Manual BlinnPhong specular against the sun direction.
                fixed3 sunDir = normalize(_SunDir.xyz);
                fixed3 halfV = normalize(sunDir + i.viewDir);
                float ndoth = saturate(dot(worldN, halfV));
                float spec = pow(ndoth, _SpecPower) * _SpecAmount;

                // Wave-crest highlight — view-independent, shows the bump
                // structure as visible ripple lines across the whole surface.
                // bumpDeviation = how much the normal deviates from flat-up.
                fixed bumpDeviation = saturate(length(n1 + n2) * 0.5);
                fixed crest = bumpDeviation * _CrestAmount;

                // Fresnel — surface brightens at grazing view angles.
                fixed nDotV = saturate(dot(worldN, normalize(i.viewDir)));
                fixed fresnel = pow(1.0 - nDotV, _FresnelPow) * _FresnelAmt;

                // Tint crest + fresnel by water color (they're surface
                // effects, not sun glints), keep specular white for the
                // actual sun reflection. Otherwise stacking three white
                // highlights washes the green out.
                // All highlights tinted green — no white bleach at all.
                // Sun specular uses a slightly brighter green than crest+fresnel
                // so it still reads as a glint, just in-palette.
                fixed3 specTint    = _Color.rgb * 1.4;
                fixed3 surfaceTint = _Color.rgb * 1.2;
                fixed3 deepTint    = _Color.rgb * 1.5;
                fixed3 highlight   = specTint * spec
                                   + surfaceTint * (crest + fresnel)
                                   + deepTint    * deepCaustic;
                fixed3 waterRgb    = min(baseRGB + highlight, _Color.rgb * 1.28);

                // Cubemap reflection — sample the environment along the
                // reflection vector, blend by fresnel so the surface reads
                // mirror-like at grazing angles and tinted-water at top-down.
                // Reflection is tinted toward water color so the cubemap
                // can't bleach the surface to bright sky-white.
                fixed3 reflDir   = reflect(-normalize(i.viewDir), worldN);
                fixed3 cubeRefl  = texCUBE(_ReflectiveColorCube, reflDir).rgb;
                cubeRefl         = lerp(_Color.rgb * 1.2, cubeRefl, 0.6);
                fixed  reflMix   = saturate(fresnel * _ReflStrength);
                fixed3 finalRgb  = lerp(waterRgb, cubeRefl, reflMix);

                // Alpha varies slightly with ripple — wave crests denser,
                // troughs more see-through. Sells the depth illusion.
                fixed alpha = _Opacity * lerp(0.80, 1.05, ripple);
                return fixed4(finalRgb, saturate(alpha));
            }
            ENDCG
        }
    }

    Fallback "Transparent/Diffuse"
}
