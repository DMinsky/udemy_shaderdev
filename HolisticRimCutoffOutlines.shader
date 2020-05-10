Shader "Holistic/RimCutoffOutlines" {

	Properties {
		_RimOutColor  ( "Rim Out Color", Color ) = ( 1, 0, 0, 0 )
		_RimInColor   ( "Rim In Color", Color )  = ( 0, 1, 0, 0 )
		_RimOutCutoff ( "Rim Out Cutoff", Range( 0.01, 1 ) ) = 0.5
		_RimInCutoff  ( "Rim In Cutoff", Range( 0.01, 1 ) )  = 0.3
	}

	SubShader {
		CGPROGRAM
		
		#pragma surface surf Lambert

		struct Input
		{
			float3 viewDir;
		};

		float4 _RimOutColor;
		float4 _RimInColor;
		float  _RimOutCutoff;
		float  _RimInCutoff;

		void surf( Input IN, inout SurfaceOutput o ) {
			half rim = 1 - dot( ( IN.viewDir ), o.Normal );			
			o.Emission = rim > _RimOutCutoff ? _RimOutColor : rim > _RimInCutoff ? _RimInColor : 0;
		}

		ENDCG
	}

	FallBack "Diffuse"

}