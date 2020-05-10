Shader "Holistic/Rim" {

	Properties {
		_RimColor ( "Rim Color", Color ) = ( 0, 0.5, 0.5, 0 )
		_RimPower ( "Rim Power", Range( 0.2, 8.0 ) ) = 3.0
	}

	SubShader {
		CGPROGRAM
		
		#pragma surface surf Lambert

		struct Input
		{
			float3 viewDir;
		};

		float4 _RimColor;
		float  _RimPower;

		void surf( Input IN, inout SurfaceOutput o ) {
			// Not sure if there is a need to normalize viewDir
			// since it looks already normalized.
			// Also, saturate here also has no visual effect
			// so I leaved a simplified version of code instead of original
			// half rim = 1 - saturate ( dot( normalize( IN.viewDir ), o.Normal ) );
			
			half rim = 1 - dot( ( IN.viewDir ), o.Normal );			
			o.Emission = _RimColor.rgb * pow( rim, _RimPower );
		}

		ENDCG
	}

	FallBack "Diffuse"

}