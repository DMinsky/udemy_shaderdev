Shader "Holistic/AlphaBlendOneOne" {

	Properties {
		_MainTex ( "Main Texture", 2D ) = "black" {}
	}

	SubShader {
		Tags { "Queue" = "Transparent" }
		Blend One One
		Pass {
			SetTexture[_MainTex] { combine texture }
		}
	}        

	FallBack "Diffuse"

}