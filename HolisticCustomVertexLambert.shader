﻿Shader "Holistic/CustomVertexLambert"
{
    Properties
    {
        _MainTex ( "Texture", 2D ) = "white" {}
    }
    SubShader
    {        
        Pass
        {
            Tags { "LightMode" = "ForwardBase" }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "UnityLightingCommon.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 diff : COLOR0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert( appdata v )
            {
                v2f o;
                o.vertex = UnityObjectToClipPos( v.vertex );
                o.uv = TRANSFORM_TEX( v.uv, _MainTex );
                float3 worldNormal = UnityObjectToWorldNormal( v.normal );
                float ndotl = max( 0, dot( worldNormal, _WorldSpaceLightPos0.xyz ) );
                o.diff = ndotl * _LightColor0;
                return o;
            }

            fixed4 frag( v2f i ) : SV_Target
            {
                fixed4 col = tex2D( _MainTex, i.uv );
                col *= i.diff;
                return col;
            }
            ENDCG
        }
    }
}
