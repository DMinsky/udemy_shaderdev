Shader "Holistic/ScrollUV"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _SecondTex ("Second Albedo (RGB)", 2D) = "white" {}
        _ScrollX ("Scroll X Speed", Range(-5, 5)) = 0
        _ScrollY ("Scroll Y Speed", Range(-5, 5)) = 0
        _ScrollSpeedOffset ("Scroll Speed Offset", Range(-5, 5)) = 0.5
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        sampler2D _SecondTex;
        float _ScrollX;        
        float _ScrollY;        
        float _ScrollSpeedOffset;        

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_SecondTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            _ScrollX *= _Time;
            _ScrollY *= _Time;
            float2 newuv1 = float2(_ScrollX, _ScrollY) + IN.uv_MainTex;
            float2 newuv2 = float2(_ScrollX * _ScrollSpeedOffset, _ScrollY * _ScrollSpeedOffset) + IN.uv_SecondTex;
            fixed4 c1 = tex2D (_MainTex, newuv1);
            fixed4 c2 = tex2D (_SecondTex, newuv2);
            o.Albedo = (c1 + c2) * 0.5;
        }
        ENDCG
    }
}
