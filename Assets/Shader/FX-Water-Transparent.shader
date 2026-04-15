// Transparent water shader for map surfaces on the Unity 6 BIRP port.
// Purpose: produce a translucent water surface that shows the game geometry
// underneath, reflects the environment via a static cubemap (no runtime
// camera rendering required), and scrolls a bumpmap for wave motion.
//
// Designed to consume the same material properties as FX/Water (FX-Water.shader),
// so the 5 map water materials that were cloned from Menu Water can swap to
// this shader via a single GUID change and still resolve all their textures.
Shader "FX/Water Transparent" {
Properties {
    _BumpMap ("Normalmap", 2D) = "bump" {}
    _BumpScale ("Wave intensity", Range(0, 2)) = 1.0
    WaveSpeed ("Wave speed (xy,zw)", Vector) = (0.3, 0.2, -0.2, -0.4)
    _ReflectiveColorCube ("Environment cubemap", Cube) = "" {}
    _RefrColor ("Water tint (underneath)", Color) = (0.5, 0.8, 0.95, 1)
    _HorizonColor ("Horizon color", Color) = (0.14, 0.23, 0.38, 1)
    _FresnelPower ("Fresnel power", Range(0.5, 5)) = 2.0
    _Alpha ("Surface alpha", Range(0, 1)) = 0.55
    _MainTex ("Fallback texture", 2D) = "white" {}
}

SubShader {
    Tags { "Queue"="Transparent" "RenderType"="Transparent" "IgnoreProjector"="True" }
    LOD 200
    Blend SrcAlpha OneMinusSrcAlpha
    ZWrite Off
    Cull Off

    Pass {
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        #pragma target 2.5
        #include "UnityCG.cginc"

        sampler2D _BumpMap;
        float4 _BumpMap_ST;
        float _BumpScale;
        float4 WaveSpeed;
        samplerCUBE _ReflectiveColorCube;
        fixed4 _RefrColor;
        fixed4 _HorizonColor;
        float _FresnelPower;
        float _Alpha;

        struct appdata {
            float4 vertex : POSITION;
            float3 normal : NORMAL;
            float2 uv : TEXCOORD0;
        };

        struct v2f {
            float4 pos : SV_POSITION;
            float2 uv1 : TEXCOORD0;
            float2 uv2 : TEXCOORD1;
            float3 viewDir : TEXCOORD2;
            float3 worldNormal : TEXCOORD3;
        };

        v2f vert(appdata v) {
            v2f o;
            o.pos = UnityObjectToClipPos(v.vertex);

            // Two scrolling UV sets for the bumpmap to break up tiling.
            // Time scale 0.005 → ~10s per wave cycle with WaveSpeed (19,9,-16,-7) from Menu Water.
            float2 baseUV = TRANSFORM_TEX(v.uv, _BumpMap);
            o.uv1 = baseUV + WaveSpeed.xy * _Time.y * 0.001;
            o.uv2 = baseUV + WaveSpeed.zw * _Time.y * 0.001;

            o.viewDir = normalize(WorldSpaceViewDir(v.vertex));
            o.worldNormal = UnityObjectToWorldNormal(v.normal);
            return o;
        }

        fixed4 frag(v2f i) : SV_Target {
            // Sample two scrolling bumpmaps, average, unpack as tangent-space normal
            half3 bump1 = UnpackNormal(tex2D(_BumpMap, i.uv1));
            half3 bump2 = UnpackNormal(tex2D(_BumpMap, i.uv2));
            half3 bump = normalize(bump1 + bump2);

            // Perturb world normal by bump scaled by intensity (0.5 makes waves clearly visible)
            half3 normal = normalize(i.worldNormal + bump * _BumpScale * 0.5);

            // Reflect view direction to sample environment cubemap
            half3 reflDir = reflect(-i.viewDir, normal);
            fixed4 envColor = texCUBE(_ReflectiveColorCube, reflDir);

            // Fresnel term — at grazing angles → cubemap reflection; straight down → refraction tint
            half fresnel = pow(1.0 - saturate(dot(normal, i.viewDir)), _FresnelPower);

            // Blend underneath-tint with reflection based on fresnel
            fixed4 col;
            col.rgb = lerp(_RefrColor.rgb, envColor.rgb, fresnel);
            col.a = _Alpha;
            return col;
        }
        ENDCG
    }
}
Fallback "Diffuse"
}
