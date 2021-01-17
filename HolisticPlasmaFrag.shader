Shader "Holistic/PlasmaFrag"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _Speed ("Speed", Range(0, 10)) = 1
        _Scale1 ("Scale 1", float) = 1
        _Scale2 ("Scale 2", float) = 1
        _Scale3 ("Scale 3", float) = 1
        _Scale4 ("Scale 4", float) = 1
    }
    
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
        };

        fixed4 _Color;
        float _Speed;
        float _Scale1;
        float _Scale2;
        float _Scale3;
        float _Scale4;

        void surf (Input IN, inout SurfaceOutput o)
        {
            float t = _Time.y * _Speed;
            float PI = 3.14;
            float c = sin(IN.worldPos.x * _Scale1 + t);
            c += sin(IN.worldPos.z * _Scale2 + t);
            c += sin(_Scale3 * (IN.worldPos.x * sin(t / 2.0) + IN.worldPos.z * cos(t / 3.0)) + t);

            // circular
            float c1 = pow(IN.worldPos.x + 0.5 * sin(t / 5.0), 2);
            float c2 = pow(IN.worldPos.z + 0.5 * cos(t / 3.0), 2);
            c += sin(sqrt(_Scale4 * (c1 + c2) + 1 + t));

            o.Albedo.r = sin(c/4.0 * PI);
            o.Albedo.g = sin(c/4.0 * PI + 2 * PI / 4.0);
            o.Albedo.b = sin(c/4.0 * PI + 4 * PI / 4.0);
            o.Albedo *= _Color;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
