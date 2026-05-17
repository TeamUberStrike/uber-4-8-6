Shader "Unique/Transparent/Glass-Hangar" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
	_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
	_Cube ("Reflection Cubemap", CUBE) = "_Skybox" { TexGen CubeReflect }
}

SubShader {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	LOD 200

	CGPROGRAM
	#pragma surface surf Lambert alpha
	#pragma target 2.0

	sampler2D _MainTex;
	samplerCUBE _Cube;
	fixed4 _Color;
	fixed4 _ReflectColor;

	struct Input {
		float2 uv_MainTex;
		float3 worldRefl;
	};

	void surf (Input IN, inout SurfaceOutput o) {
		fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
		fixed4 c   = tex * _Color;
		fixed4 reflcol = texCUBE(_Cube, IN.worldRefl) * _ReflectColor;

		o.Albedo = c.rgb + reflcol.rgb * reflcol.a;
		o.Alpha  = c.a;
	}
	ENDCG
}

Fallback "Transparent/Diffuse"
}
