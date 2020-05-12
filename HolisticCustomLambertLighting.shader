Shader "Holistic/CustomLamberLighting" {

	Properties {
		_Color ( "Color", Color ) = ( 1, 1, 1, 1 )
	}

	SubShader {
		CGPROGRAM
		
		#pragma surface surf CustomLambert

		half4 LightingCustomLambert( SurfaceOutput s, float3 lightDir, half atten ) {
			half NdotL = dot( s.Normal, lightDir );
			half4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * NdotL * atten;
			c.a = s.Alpha;
			return c;
		}

		struct Input
		{
			float3 uv_MainTex;
		};

		float4 _Color;

		void surf( Input IN, inout SurfaceOutput o ) {
			o.Albedo = _Color.rgb;
		}

		ENDCG
	}

	FallBack "Diffuse"

}