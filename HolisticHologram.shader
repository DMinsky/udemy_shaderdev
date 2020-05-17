Shader "Holistic/Hologram" {

	Properties {
		_RimColor ( "Rim Color", Color ) = ( 0, 0.5, 0.5, 0 )
		_RimPower ( "Rim Power", Range( 0.2, 8.0 ) ) = 3.0
	}

	SubShader {
		Pass {
			ZWrite On
			ColorMask 0
		}

		Tags {
			"Queue" = "Transparent"
		}

		CGPROGRAM
		
		#pragma surface surf Lambert alpha:fade

		struct Input
		{
			float3 viewDir;
		};

		float4 _RimColor;
		float  _RimPower;

		void surf( Input IN, inout SurfaceOutput o ) {			
			half rim = 1 - dot( ( IN.viewDir ), o.Normal );			
			o.Emission = _RimColor.rgb * pow( rim, _RimPower );
			o.Alpha = rim;
		}

		ENDCG
	}

	FallBack "Diffuse"

}