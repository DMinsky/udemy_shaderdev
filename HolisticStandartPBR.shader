Shader "Holistic/StandardPBR" {

	Properties {
		_Color ( "Color", Color ) = ( 1, 1, 1, 1 )
		// In the original Lesson 30 it's called MetallicTex
		// Also, smoothness in Standard Unity Material goes to (A) channel
		// but we use (R) here
		_SmoothnessTex ( "Smoothness (R)", 2D ) = "white" {}
		_Metallic ( "Metallic Amount", Range( 0, 1 ) ) = 0
		_Emission ( "Emission Amount", Range( 0, 1 ) ) = 0
	}

	SubShader {
		CGPROGRAM
		
		#pragma surface surf Standard

		struct Input
		{
			float2 uv_SmoothnessTex;
		};

		float4    _Color;
		sampler2D _SmoothnessTex;
		half      _Metallic;
		half      _Emission;

		void surf( Input IN, inout SurfaceOutputStandard o ) {
			o.Albedo = _Color.rgb;
			float smoothness = tex2D( _SmoothnessTex, IN.uv_SmoothnessTex ).r;
			o.Smoothness = smoothness;
			o.Metallic = _Metallic;
			o.Emission = _Emission * smoothness;
		}

		ENDCG
	}

	FallBack "Diffuse"

}