Shader "Holistic/BasicLambertAlpha" {

	Properties {
		_MainTex ( "Main Texture", 2D ) = "white" {}
	}

	SubShader {
		Tags {
			"Queue" = "Transparent"
		}
		CGPROGRAM
		
		#pragma surface surf Lambert alpha:fade

		struct Input
		{
			float2 uv_MainTex;
		};

		sampler2D _MainTex;

		void surf( Input IN, inout SurfaceOutput o ) {
			float4 color = tex2D( _MainTex, IN.uv_MainTex );
			o.Albedo = color.rgb;
			o.Alpha  = color.a;
		}

		ENDCG
	}

	FallBack "Diffuse"

}