﻿Shader "CamShaders/OutlineCam"
{
    Properties
    {
         _OutlineColor ("Outline Color", Color) = (0,0,0,0)
		_Outline("Outline Thickness", Range(0, 3)) = 0.015
		_MainColor("Main Color", Color) = (1,0,0,1)
		_ShadowColor("Shadow Color", Color) = (1,0,0,1)
		_Threshold("Threshold", Range(0, 10)) = .5
    }
    SubShader
    {
        // No culling or depth
        Cull Front

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                // just invert the colors
                col.rgb = 1 - col.rgb;
                return col;
            }
            ENDCG
        }
    }
}
