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

	// Transcribed 1:1 from the shipped compiled program
	// (sharedassets16.assets, Shader "Arch_Glass", ForwardBase ps_2_0):
	//     rgb   = _Color * lighting  +  tex.RED * (texCUBE(_Cube) * _ReflectColor.rgb)
	//     alpha = (1 - tex.RED) * _Color.a
	// _MainTex is a MASK: only its RED channel is read, it never tints Albedo,
	// and _ReflectColor.a is never read.
	void surf (Input IN, inout SurfaceOutput o) {
		fixed  mask = tex2D(_MainTex, IN.uv_MainTex).r;
		fixed3 refl = texCUBE(_Cube, IN.worldRefl).rgb * _ReflectColor.rgb;

		o.Albedo   = _Color.rgb;
		o.Emission = mask * refl;
		o.Alpha    = (1.0 - mask) * _Color.a;
	}
	ENDCG
}

Fallback "Transparent/VertexLit"
}
