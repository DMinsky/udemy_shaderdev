﻿Shader "Holistic/VFDiffuseShadow"
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
            #pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight

            #include "UnityCG.cginc"
            #include "UnityLightingCommon.cginc"
            #include "Lighting.cginc"
            #include "AutoLight.cginc"

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
                float4 pos : SV_POSITION;
                SHADOW_COORDS(1)
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert( appdata v )
            {
                v2f o;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.uv = TRANSFORM_TEX( v.uv, _MainTex );
                float3 worldNormal = UnityObjectToWorldNormal( v.normal );
                float ndotl = max( 0, dot( worldNormal, _WorldSpaceLightPos0.xyz ) );
                o.diff = ndotl * _LightColor0;
                TRANSFER_SHADOW( o );
                return o;
            }

            fixed4 frag( v2f i ) : SV_Target
            {
                fixed4 col = tex2D( _MainTex, i.uv );
                fixed shadow = SHADOW_ATTENUATION( i );
                col *= i.diff * shadow;
                return col;
            }
            ENDCG
        }
        Pass
        {
            Tags { "LightMode" = "ShadowCaster" }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster

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
                V2F_SHADOW_CASTER;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert( appdata v )
            {
                v2f o;
                TRANSFER_SHADOW_CASTER_NORMALOFFSET( o );
                return o;
            }

            fixed4 frag( v2f i ) : SV_Target
            {
                SHADOW_CASTER_FRAGMENT( i );
            }
            ENDCG
        }
    }
}
