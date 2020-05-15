Shader "Holistic/CustomBlinnLighting" {

	Properties {
		_Color     ( "Color", Color ) = ( 1, 1, 1, 1 )
		_SpecColor ( "Specular Color", Color ) = ( 1, 1, 1, 1 )
		_SpecPow   ( "Specular Power", Range( 0, 48 ) ) = 48.0
	}

	SubShader {
		CGPROGRAM
		
		#pragma surface surf CustomBlinn

		struct Input
		{
			float3 uv_MainTex;
		};

		float4 _Color;
		float _SpecPow;
		
		void surf( Input IN, inout SurfaceOutput o ) {
			o.Albedo = _Color.rgb;
		}

		half4 LightingCustomBlinn( SurfaceOutput s, half3 lightDir, half3 viewDir, half atten ) {
			// diffuse component
			// half diff = max( 0, dot( s.Normal, lightDir ) );
			half diff = dot( s.Normal, lightDir );
			
			// specular component	
			half3 hV = normalize( lightDir + viewDir );
			// half NdotH = max ( 0, dot( s.Normal, hV ) );
			half NdotH = dot( s.Normal, hV );
			half spec = pow( NdotH, _SpecPow );

			// result color
			half4 c;
			c.rgb = ( s.Albedo * _LightColor0.rgb * diff + spec * _LightColor0 ) * atten;
			c.a = s.Alpha;
			return c;
		}

		ENDCG
	}

	FallBack "Diffuse"

}