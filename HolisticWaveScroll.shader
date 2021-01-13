Shader "Holistic/WaveScroll"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _SecondTex ("Second Albedo (RGB)", 2D) = "white" {}
        _ScrollX ("Scroll X Speed", Range(-10, 10)) = 0
        _ScrollY ("Scroll Y Speed", Range(-10, 10)) = 0
        _ScrollSpeedOffset ("Scroll Speed Offset", Range(-10, 10)) = 0.5
        _Freq ("Frequency", Range(0, 100)) = 12
        _Amplitude ("Amplitede", Range(0, 10)) = 1
        _Speed ("Speed", Range(0, 60)) = 10        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Lambert fullforwardshadows vertex:vert

        sampler2D _MainTex;
        sampler2D _SecondTex;
        float _ScrollX;        
        float _ScrollY;        
        float _ScrollSpeedOffset;
        float _Freq;
        float _Amplitude;
        float _Speed;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_SecondTex;
            float3 vertColor;
        };

        struct appdata
		{
			float4 vertex: POSITION;
			float3 normal: NORMAL;
			float4 texcoord: TEXCOORD0;
			float4 texcoord1: TEXCOORD1; // You need texcoord1 for the lightmap
			float4 texcoord2: TEXCOORD2; // You need texcoord2 for dynamic GI
		};

        void vert(inout appdata v, out Input o)
        {
            UNITY_INITIALIZE_OUTPUT(Input, o);
            float t = _Time.y * _Speed;
            float waveHeigh = sin(v.vertex.x * _Freq + t) * _Amplitude;
            v.vertex.y = v.vertex.y + waveHeigh;
            // Penny's normal calculation is broken anyway
            // v.normal = normalize(float3(v.normal.x + waveHeigh, v.normal.y, v.normal.z));
            o.vertColor = waveHeigh + 2;
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            _ScrollX *= _Time.y;
            _ScrollY *= _Time.y;
            float2 newuv1 = float2(_ScrollX, _ScrollY) + IN.uv_MainTex;
            float2 newuv2 = float2(_ScrollX * _ScrollSpeedOffset, _ScrollY * _ScrollSpeedOffset) + IN.uv_SecondTex;
            fixed4 c1 = tex2D (_MainTex, newuv1);
            fixed4 c2 = tex2D (_SecondTex, newuv2);
            o.Albedo = (c1 + c2) * 0.5 * IN.vertColor;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
