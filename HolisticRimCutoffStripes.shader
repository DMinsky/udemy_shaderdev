Shader "Holistic/RimCutoffStripes" {

	Properties {
		_DiffuseTex   ( "Diffuse Tex", 2D ) = "white" {} 
		_Stripe1Color ( "Stripe 1 Color", Color )  = ( 1, 0, 0, 0 )
		_Stripe2Color ( "Stripe 2 Color", Color )  = ( 0, 1, 0, 0 )
		_StripeWidth  ( "Stripe Width", Range( 0.01, 20 ) ) = 20
		_StripeCutoff ( "Stripe Cutoff", Range( 0.01, 1 ) ) = 0.5
	}

	SubShader {
		CGPROGRAM
		
		#pragma surface surf Lambert

		struct Input {
			float3 viewDir;
			float3 worldPos;
			float2 uv_DiffuseTex;
		};

		float3 worldPos;
		sampler2D _DiffuseTex;
		float4 _Stripe1Color;
		float4 _Stripe2Color;
		float  _StripeWidth;
		float  _StripeCutoff;

		void surf( Input IN, inout SurfaceOutput o ) {
			o.Albedo = tex2D( _DiffuseTex, IN.uv_DiffuseTex ).rgb;
			half rim = 1 - dot( ( IN.viewDir ), o.Normal );			
			o.Emission = frac( IN.viewDir.y * _StripeWidth * 0.5 ) > _StripeCutoff ? _Stripe1Color : _Stripe2Color;
		}

		ENDCG
	}

	FallBack "Diffuse"

}