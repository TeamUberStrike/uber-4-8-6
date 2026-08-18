// Ported to Unity 6 (Built-in RP) from the uber471-unity465 branch, where this
// shader already had a real body while main still carried the ForgeRipper stub.
// Real Unlit/Transparent Colored (SoftClip) shader. AssetRipper emitted a dummy surface shader stub
// (#pragma surface surf Lambert) requiring vertex normals which NGUI's dynamic
// quad meshes lack. Replaced with proper vertex+fragment unlit reading only
// POSITION + COLOR + TEXCOORD0. Soft-clip variants don't implement NGUI's
// _ClipRange0/_ClipArgs0 math yet — content past scroll-panel edges may leak.
Shader "Unlit/Transparent Colored (SoftClip)"
{
    Properties
    {
        _MainTex ("Base (RGB), Alpha (A)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
        LOD 100
        Blend SrcAlpha OneMinusSrcAlpha
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
                o.vertex   = UnityObjectToClipPos(v.vertex);
                o.color    = v.color;
                o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.texcoord) * i.color;
                return col;
            }
            ENDCG
        }
    }
}
