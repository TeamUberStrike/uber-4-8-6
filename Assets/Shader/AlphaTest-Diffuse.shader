// Real Transparent/Cutout/Diffuse — restored from AssetRipper dummy stub.
// AssetRipper emitted a placeholder that drew foliage as opaque rectangles
// because it lacked alphatest:_Cutoff. Used by Ivy/foliage/fence/chain
// materials. Lit by Lambert lighting, alpha-discards pixels below cutoff,
// double-sided so leaves render from both faces (typical 4.6-era foliage).
Shader "Transparent/Cutout/Diffuse"
{
    Properties
    {
        _Color  ("Main Color",     Color)        = (1,1,1,1)
        _MainTex ("Base (RGB) Trans (A)", 2D)    = "white" {}
        _Cutoff ("Alpha cutoff",   Range(0,1))   = 0.5
    }
    SubShader
    {
        Tags { "Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout" }
        LOD 200
        Cull Off

        CGPROGRAM
        #pragma surface surf Lambert alphatest:_Cutoff

        sampler2D _MainTex;
        fixed4    _Color;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Alpha  = c.a;
        }
        ENDCG
    }
    Fallback "Transparent/Cutout/VertexLit"
}
