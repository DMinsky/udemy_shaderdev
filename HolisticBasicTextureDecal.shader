Shader "Holistic/BasicTextureDecal" {

	Properties {
		_MainTex ( "Main Texture", 2D ) = "white" {}
		_DecalTex ( "Decal Texture", 2D ) = "white" {}
		[Toggle] _ShowDecal ( "Show Decal", Float ) = 1
	}

	SubShader {
		CGPROGRAM
		
		#pragma surface surf Lambert

		struct Input {
			float2 uv_MainTex;
		};

		sampler2D _MainTex;
		sampler2D _DecalTex;
		float     _ShowDecal;

		void surf( Input IN, inout SurfaceOutput o ) {
			float3 a = tex2D( _MainTex, IN.uv_MainTex ).rgb;
			float3 b = tex2D( _DecalTex, IN.uv_MainTex ).rgb * _ShowDecal;
			o.Albedo = b.r > 0.99 ? b : a;
		}

		ENDCG
	}

	FallBack "Diffuse"

}