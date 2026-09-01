Shader "CMune/Water/Opaque_Flowing" {
Properties {
 _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
 _BumpMap ("Normalmap", 2D) = "bump" {}
 _Caustics ("_Caustics", 2D) = "black" {}
 _Cube ("Reflection Cubemap", CUBE) = "black" {}
 _Color ("Main Color", Color) = (0,0.313726,0.65098,1)
 _WaterColor_Dark ("Dark Water Color", Color) = (1,1,1,1)
 _ReflectColor ("Reflection Color", Color) = (0.72549,0.992157,1,0.501961)
 _Specular ("_Specular", Float) = 2
 _Gloss ("_Gloss", Float) = 1
 _Tiling ("_Tiling", Float) = 1.5
}
	// Reconstructed from the compiled program shipped in
	// UberStrike_Data/resources.assets @ 307673488, length 61657
	// (2636 lines, 16 d3d9 + 16 opengl SubPrograms, 0 d3d11).
	// Constants are transcribed from the ps_3_0 listing, not chosen:
	//   scroll 0.05 (_MainTex) / 0.07 (_BumpMap) on _Time.xy  -> def c8.x / c9.x
	//   specular exponent 128 * _Gloss                        -> def c9.z
	//   caustics tiling 3.375, deform 0.1, gain 1.5           -> c9.w / c10.w / c11.x
	//   Luminance weights .21997070/.70703125/.07098389       -> def c10.xyz
	// The shipped vertex program passes TEXCOORD0 and TEXCOORD1 through RAW and
	// binds no _MainTex_ST (0 occurrences of "_ST" in all 61,657 bytes), so the
	// UVs would ideally not come from uv_MainTex -- see the note above the Input struct
	// for why this build uses it anyway, and what that costs.
	// nolightmap: the shipped base pass has only LIGHTMAP_OFF variants.
	// _MainTex and _BumpMap are BOTH normal maps; _Caustics is a diffuse map;
	// _Cube is a Cubemap (Resources.Load<Texture2D> returns null on it).
	// _CausticsTiling / _CausticsDeform do not exist here and never did.
	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
		#pragma surface surf WaterFlowing noambient nolightmap
		#pragma target 3.0

		sampler2D   _MainTex;
		sampler2D   _BumpMap;
		sampler2D   _Caustics;
		samplerCUBE _Cube;

		fixed4 _Color;
		fixed4 _WaterColor_Dark;
		fixed4 _ReflectColor;
		float  _Specular;
		float  _Gloss;
		float  _Tiling;

		inline half4 LightingWaterFlowing (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
		{
			half3 h    = normalize (lightDir + viewDir);
			half  diff = max (0, dot (s.Normal, lightDir));
			half  nh   = max (0, dot (s.Normal, h));
			half  spec = pow (nh, _Gloss * 128.0) * Luminance (_LightColor0.rgb);

			half3 lightCol = _LightColor0.rgb * diff * (atten * 2);
			half  specAmt  = spec * (atten * 2) * _Specular;

			half4 c;
			c.rgb = lightCol * s.Albedo + lightCol * specAmt;
			c.a   = s.Alpha;
			return c;
		}

		// NOTE (2026-08-19): the faithful form of this used a custom "vertex:vert" with
		// out Input o, because the shipped vertex program passes texcoord0/1 through RAW and
		// binds no _MainTex_ST. Unity 4.6.5 rejects it: UNITY_INITIALIZE_OUTPUT(Input, o)
		// expands to o = (Input)0, and that struct cast is illegal here once Input carries
		// INTERNAL_DATA -- "Shader error: assignment of incompatible types at line 137",
		// which drops the whole shader to the pink error shader.
		//
		// uv_MainTex applies the material's _MainTex tiling/offset, which the shipped shader
		// does not. That is only equivalent while every material using this shader keeps
		// _MainTex at tiling (1,1) offset (0,0) -- Holo_Hydra.mat and
		// SpatterGun_ManOWar_Water_A.mat both do, and the skin bindings never set _MainTex ST.
		// Scale the water with _Tiling (1.5 gear / 0.5 weapon), NEVER with _MainTex tiling.
		struct Input {
			float2 uv_MainTex;
			float3 viewDir;
			float3 worldRefl;
			INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			float2 uv = IN.uv_MainTex * _Tiling;

			fixed3 n1 = UnpackNormal (tex2D (_MainTex, uv + _Time.xy * 0.05));
			fixed3 n2 = UnpackNormal (tex2D (_BumpMap, uv + _Time.xy * 0.07));

			o.Normal = normalize (n1 + n2);
			o.Albedo = _WaterColor_Dark.rgb;
			o.Alpha  = 1.0;

			half3 refl     = texCUBE (_Cube, WorldReflectionVector (IN, o.Normal)).rgb;
			half3 waterCol = lerp (_Color.rgb, _WaterColor_Dark.rgb, refl);

			half3 caustics = tex2D (_Caustics, IN.uv_MainTex * 3.375 + n2.xy * 0.1).rgb;
			half  ndotv    = dot (normalize (IN.viewDir), normalize (o.Normal));
			half3 fres     = (1.0 - ndotv) + caustics * 1.5;

			o.Emission = lerp (waterCol, _ReflectColor.rgb, fres);
		}
		ENDCG
	}
	Fallback "Diffuse"
}
