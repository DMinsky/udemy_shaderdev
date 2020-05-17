Shader "Holistic/BasicLambert" {

	Properties {
		_Color ( "Color", Color ) = ( 1, 1, 1, 1 )

		// All these properties does nothing in Lamber model
		_SpecColor ( "Spec Color", Color ) = ( 1, 1, 1, 1 )
		_Spec  ( "Specular", Range( 0, 1 ) ) = 0.5
		_Gloss ( "Gloss", Range( 0, 1 ) )    = 0.5
	}

	SubShader {
		CGPROGRAM
		
		#pragma surface surf Lambert

		struct Input
		{
			float2 uv_MainTex;
		};

		float4 _Color;

		// _SpecColor already included by Unity itself

		// All these properties does nothing in Lamber model
		half  _Spec;
		fixed _Gloss;

		void surf( Input IN, inout SurfaceOutput o ) {
			o.Albedo   = _Color.rgb;
			// All these properties does nothing in Lamber model
			o.Specular = _Spec;
			o.Gloss    = _Gloss;
		}

		ENDCG
	}

	FallBack "Diffuse"

}