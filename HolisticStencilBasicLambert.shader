Shader "Holistic/StencilBasicLambert" {

	Properties {
		_MainTex ( "Main Texture", 2D ) = "white" {}
	}

	SubShader {
		Stencil {
			Ref 1
			Comp NotEqual
			Pass Keep
		}
		
		CGPROGRAM
		
		#pragma surface surf Lambert

		struct Input
		{
			float2 uv_MainTex;
		};

		sampler2D _MainTex;

		void surf( Input IN, inout SurfaceOutput o ) {
			o.Albedo = tex2D( _MainTex, IN.uv_MainTex );
		}

		ENDCG
	}

	FallBack "Diffuse"

}