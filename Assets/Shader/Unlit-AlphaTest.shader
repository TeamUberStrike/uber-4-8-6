// Ported to Unity 6 (Built-in RP) from the uber471-unity465 branch, where this
// shader already had a real body while main still carried the ForgeRipper stub.
// Real Unlit/Transparent Cutout — restored from AssetRipper dummy stub.
// AssetRipper emitted a placeholder that drew foliage as opaque rectangles.
// Used by Ivy_Leave and similar Cmune unlit-cutout foliage materials.
// Double-sided, no lighting, alpha-clip below _Cutoff.
Shader "Unlit/Transparent Cutout"
{
    Properties
    {
        _MainTex ("Base (RGB) Trans (A)", 2D)  = "white" {}
        _Cutoff ("Alpha cutoff",  Range(0,1))  = 0.5
    }
    SubShader
    {
        Tags { "Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout" }
        LOD 100
        Cull Off
        Lighting Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4    _MainTex_ST;
            float     _Cutoff;

            struct appdata
            {
                float4 vertex   : POSITION;
                float2 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex   : SV_POSITION;
                float2 texcoord : TEXCOORD0;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex   = UnityObjectToClipPos(v.vertex);
                o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 c = tex2D(_MainTex, i.texcoord);
                clip(c.a - _Cutoff);
                return c;
            }
            ENDCG
        }
    }
}
