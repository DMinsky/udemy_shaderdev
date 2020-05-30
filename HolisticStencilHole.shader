Shader "Holistic/StencilHole" {

	Properties {
		_MainTex ( "Main Texture", 2D ) = "white" {}
	}

	SubShader {
		Tags { 
			"Queue" = "Geometry-1"
		}

		ColorMask 0
		ZWrite Off

		Stencil {
			Ref 1
			Comp Always
			Pass Replace
		}

		CGPROGRAM
		
		#pragma surface surf Lambert

		struct Input
		{
			float2 uv_MainTex;
		};

		sampler2D _MainTex;

		void surf( Input IN, inout SurfaceOutput o ) {
			fixed4 c = tex2D( _MainTex, IN.uv_MainTex );
			o.Albedo = c.rgb;
			o.Alpha  = c.a;
		}

		ENDCG
	}

	FallBack "Diffuse"

}