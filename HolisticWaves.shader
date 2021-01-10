Shader "Holistic/Waves"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Color ("Tint Color", Color) = (1,1,1,1)
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
        fixed4 _Color;
        float _Freq;
        float _Amplitude;
        float _Speed;

        struct Input
        {
            float2 uv_MainTex;
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
            float t = _Time * _Speed;
            float waveHeigh = sin(v.vertex.x * _Freq + t) * _Amplitude;
            v.vertex.y = v.vertex.y + waveHeigh;
            // Penny's normal calculation is broken anyway
            // v.normal = normalize(float3(v.normal.x + waveHeigh, v.normal.y, v.normal.z));
            o.vertColor = waveHeigh + 2;
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb * IN.vertColor;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
