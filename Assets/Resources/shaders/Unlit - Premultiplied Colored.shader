// Real Unlit/Premultiplied Colored shader. AssetRipper emitted a dummy surface
// shader (#pragma surface surf Lambert) here — Lambert lighting needs vertex
// normals, but NGUI's dynamic quad meshes (AtlasMainMenu, InterparkFontAtlas,
// etc.) don't have them, so Unity refused to render the menu UI in 2026-05-16
// Editor offline-bypass testing. Replaced with a proper vertex+fragment unlit
// shader matching Cmune's original NGUI atlas binding: reads only POSITION +
// COLOR + TEXCOORD0 (NGUI's vertex format), premultiplied-alpha blending,
// transparent queue, no lighting.
Shader "Unlit/Premultiplied Colored"
{
    Properties
    {
        _MainTex ("Base (RGB), Alpha (A)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
        LOD 100
        Blend One OneMinusSrcAlpha
        Cull Off
        Lighting Off
        ZWrite Off
        Fog { Mode Off }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata_t
            {
                float4 vertex   : POSITION;
                fixed4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex   : SV_POSITION;
                fixed4 color    : COLOR;
                half2  texcoord : TEXCOORD0;
            };

            sampler2D _MainTex;
            float4    _MainTex_ST;

            v2f vert(appdata_t v)
            {
                v2f o;
                o.vertex   = mul(UNITY_MATRIX_MVP, v.vertex);
                o.color    = v.color;
                o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return tex2D(_MainTex, i.texcoord) * i.color;
            }
            ENDCG
        }
    }
}
