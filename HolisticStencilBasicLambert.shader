Shader "Holistic/StencilBasicLambert" {

	Properties {
		_MainTex ( "Main Texture", 2D ) = "white" {}
		_StencilRef ( "Stencil Ref", Float ) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _CompFunc ( "Compare Func", Float ) = 3
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ( "Stencil Operation", Float ) = 0
	}

	SubShader {
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
			o.Albedo = tex2D( _MainTex, IN.uv_MainTex );
		}

		ENDCG
	}

	FallBack "Diffuse"

}