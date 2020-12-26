Shader "Holistic/SimpleOutline"
{
    Properties
    {
        _MainTex ( "Albedo (RGB)", 2D ) = "white" {}
        _OutlineColor ( "Outline Color", Color ) = ( 1, 1, 1, 1 )
        _OutlineWidth ( "Outline Width", Range( 0.01, 0.1 ) ) = 0.05
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        
        ZWrite Off
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        struct appdata
        {
            float4 vertex: POSITION;
            float3 normal: NORMAL;
            float4 texcoord: TEXCOORD0;
            float4 texcoord1: TEXCOORD1;
            float4 texcoord2: TEXCOORD2;
        };

        fixed4 _OutlineColor;
        half _OutlineWidth;

        void vert( inout appdata v )
        {
            v.vertex.xyz += v.normal * _OutlineWidth;
        }

        void surf( Input IN, inout SurfaceOutput o )
        {
            o.Emission = _OutlineColor;
        }
        ENDCG

        ZWrite On
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf( Input IN, inout SurfaceOutput o )
        {
            fixed4 c = tex2D( _MainTex, IN.uv_MainTex );
            o.Albedo = c.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
