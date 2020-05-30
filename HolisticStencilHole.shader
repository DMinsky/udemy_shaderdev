Shader "Holistic/StencilHole" {

	Properties {
		_MainTex ( "Main Texture", 2D ) = "white" {}
		_StencilRef ( "Stencil Ref", Float ) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _CompFunc ( "Compare Func", Float ) = 8
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ( "Stencil Operation", Float ) = 2
	}

	SubShader {
		Tags { 
			"Queue" = "Geometry-1"
		}

		ColorMask 0
		ZWrite Off

		Stencil {
			Ref [_StencilRef]
			Comp [_CompFunc]
			Pass [_StencilOp]
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