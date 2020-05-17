Shader "Holistic/CustomRampLighting" {

	Properties {
		_Color   ( "Color", Color ) = ( 1, 1, 1, 1 )
		_RampTex ( "Ramp Texture", 2D ) = "white" {}
	}

	SubShader {
		CGPROGRAM
		
		#pragma surface surf CustomRamp

		float4 _Color;
		sampler2D _RampTex;

		struct Input
		{
			float2 uv_RampTex;
		};

		void surf( Input IN, inout SurfaceOutput o ) {
			o.Albedo = _Color.rgb;
		}

		half4 LightingCustomRamp( SurfaceOutput s, float3 lightDir, half atten ) {
			half NdotL = dot( s.Normal, lightDir );
			half halfLamber = NdotL * 0.5 + 0.5;
			half4 rampColor = tex2D( _RampTex, halfLamber );
			half4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * rampColor;
			c.a = s.Alpha;
			return c;
		}

		ENDCG
	}

	FallBack "Diffuse"

}