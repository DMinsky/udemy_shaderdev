Shader "Holistic/PlasmaVert"
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
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            fixed4 _Color;
            float _Speed;
            float _Scale1;
            float _Scale2;
            float _Scale3;

            float _Scale4;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float4 vertColor : COLOR0;
            };

            v2f vert(appdata v)
            {
                v2f o;
                UNITY_INITIALIZE_OUTPUT(v2f, o);
                o.vertex = UnityObjectToClipPos( v.vertex );
                float t = _Time.y * _Speed;
                float PI = 3.14;
                float c = sin(v.vertex.x * _Scale1 + t);
                c += sin(v.vertex.z * _Scale2 + t);
                c += sin(_Scale3 * (v.vertex.x * sin(t / 2.0) + v.vertex.z * cos(t / 3.0)) + t);

                // circular
                float c1 = pow(v.vertex.x + 0.5 * sin(t / 5.0), 2);
                float c2 = pow(v.vertex.z + 0.5 * cos(t / 3.0), 2);
                c += sin(sqrt(_Scale4 * (c1 + c2) + 1 + t));

                o.vertColor.r = sin(c/4.0 * PI);
                o.vertColor.g = sin(c/4.0 * PI + 2 * PI / 4.0);
                o.vertColor.b = sin(c/4.0 * PI + 4 * PI / 4.0);
                return o;
            }

            fixed4 frag(v2f IN) : SV_Target
            {
                return IN.vertColor;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
