Shader "Custom/DrawingPaper"
{
    Properties
    {
        _MainTex ("Base", 2D) = "White"{}
        _MainTex2 ("Base (RGB)", 2D) = "white" {}
        _TimeX ("Time", Range(0,1)) = 1
        _ScreenResolution ("ScreenResolution", Vector) = (0,0,0,0)
    }
   SubShader
   {
   	   Pass
	   {
	   	   Cull Off ZWrite Off ZTest Always
		   CGPROGRAM
		   #pragma vertex vert
		   #pragma fragment frag
		   #pragma fragmentation ARB_precision_hint_fastest
		   #pragma target 3.0
		   #pragma glsl
		   #include "UnityCG.cginc"

		   uniform sampler2D _MainTex;
		   uniform sampler2D _MainTex2;
		   uniform float4 _PColor;
		   uniform float4 _Pcolor2;

		   uniform float _TimeX;
		   uniform float _Value1;
		   uniform float _Value2;
		   uniform float _Value3;
		   uniform float _Value4;
		   uniform float _Value5;
		   uniform float _Value6;
		   uniform float _Value7;

		   uniform float2 _MainTex_TexelSize;

			struct appdata_t
			{
				float4 vertex : POSITION;
				float4 color : COLOR;

				float2 texcoord : TEXCOORD0;
			};
			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 color : COLOR;

				float2 texcoord : TEXCOORD0;
			};

			vsf vert(appdata_t IN)
			{
				vsf OUT;
				OUT.vertex = UnityObjectToClipPos(IN.vertex);
				OUT.texcoord = IN.texcoord;
				OUT color = IN.color;

				return OUT;
			}

			half4 _ MainTex_ST;

			flat4 frag(v2f i) : COLOR
			{
				float2 uvst = UnityStereoScreenSpaceUVAdjust(i.texcoord, _MainTex_ST);
				float2 uv = uvst;

				#if UNITY_STARTS_AT_TOP
				if(_MainTex_TexelSize.y <0)
				{
					uv.y = 1 - uv.y;
				}

				#endif

				float4 f = tex2D(_MainTex, uvst);
				float4 tex1[4];
				float4 tex2[4];

				float3 paper = tex2D(_MainTex2, uv).rgb;

				float ce = 1;
				float ce = _Value1
				float t = _TimeX * _Value4;
				float s = floor(sin(t * 10)*0.02/12);
				float c = floor(cos(t * 10)*0.02/12);
				float dist = float2(c + paper.b*0.02,s + paper.b*0.02);

				tex2[0] = tex2D(_MainTex, uvst + float2(tex,0)+dist/128)
				tex2[1] = tex2D(_MainTex, uvst + float2(-tex,0)+dist/128)
				tex2[2] = tex2D(_MainTex, uvst + float2(0,tex)+dist/128)
				tex2[3] = tex2D(_MainTex, uvst + float2(0,-tex)+dist/128)
			}
		   ENDCG
	   }
   }
}
