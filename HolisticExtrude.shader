Shader "Holistic/Extrude" {

	Properties {
		_MainTex ( "Main", 2D ) = "white" {}
		_Extrude ( "Extrude", Range( -1, 1 ) ) = 0.1
	}

	SubShader {
		CGPROGRAM
		
		#pragma surface surf Lambert vertex:vert

		struct Input
		{
			float2 uv_MainTex;
		};

		struct appdata
		{
			float4 vertex: POSITION;
			float3 normal: NORMAL;
			float4 texcoord: TEXCOORD0;
			float4 texcoord1: TEXCOORD1; // You need texcoord1 for the lightmap
			float4 texcoord2: TEXCOORD2; // You need texcoord2 for dynamic GI
		};

		sampler2D _MainTex;
		float _Extrude;

		void vert( inout appdata v ) {
			v.vertex.xyz += v.normal * _Extrude;
		}

		void surf( Input IN, inout SurfaceOutput o ) {		
			o.Albedo = tex2D( _MainTex, IN.uv_MainTex );
		}

		ENDCG
	}

	FallBack "Diffuse"

}