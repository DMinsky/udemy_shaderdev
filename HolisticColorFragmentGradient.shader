Shader "Holistic/ColorFragmentGradient"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = 0;
                // for 640x480 resolution
                col.r = ( i.vertex.x - 100 ) / 440.0;
                col.g = i.vertex.y / 440.0;
                return col;
            }
            ENDCG
        }
    }
}
