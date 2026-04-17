// Unlit/Texture — restored from DummyShaderTextExporter stub.
// Simple unlit texture shader. No lighting, no transparency. Used by health pickup
// materials and other HUD/indicator textures.
Shader "Unlit/Texture" {
Properties {
    _MainTex ("Base (RGB)", 2D) = "white" {}
}
SubShader {
    Tags { "RenderType"="Opaque" }
    Lighting Off

    Pass {
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        #pragma target 2.5
        #include "UnityCG.cginc"

        sampler2D _MainTex;
        float4 _MainTex_ST;

        struct appdata {
            float4 vertex : POSITION;
            float2 texcoord : TEXCOORD0;
            UNITY_VERTEX_INPUT_INSTANCE_ID
        };

        struct v2f {
            float4 vertex : SV_POSITION;
            float2 texcoord : TEXCOORD0;
            UNITY_VERTEX_OUTPUT_STEREO
        };

        v2f vert(appdata v) {
            v2f o;
            UNITY_SETUP_INSTANCE_ID(v);
            UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
            o.vertex = UnityObjectToClipPos(v.vertex);
            o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
            return o;
        }

        fixed4 frag(v2f i) : SV_Target {
            return tex2D(_MainTex, i.texcoord);
        }
        ENDCG
    }
}
}
