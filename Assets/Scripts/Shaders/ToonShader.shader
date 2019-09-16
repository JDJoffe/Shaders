Shader "Custom/ToonShader"
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
		Pass
		{
		
		
			Cull Front
			//HLSL program snippets are written between CGPROGRAM and ENDCG keywords, or alternatively between HLSLPROGRAM and ENDHLSL. 
			//The latter form does not automatically include HLSLSupport and UnityShaderVariables built-in header files.
			CGPROGRAM
			//define vertex structures
			#include "UnityCG.cginc"
			//At the start of the snippet compilation directives can be given as #pragma statements. Directives indicating which shader functions to compile:
			

			//#pragma vertex name - compile function name as the vertex shader.
			//for building the function
			#pragma vertex vert
			//#pragma fragment name - compile function name as the fragment shader
			//for coloring the function
			#pragma fragment frag

			// cgprogram vars
			uniform float _Outline;
			uniform float4 _OutlineColor;
			uniform float4 _ShadowColor;
			uniform float4 _MainColor;
			
			//vertex to float
			//To access different vertex data, you need to declare the vertex structure yourself, or add input parameters to the vertex shader. 
			//Vertex data is identified by Cg/HLSL semantics, and must be from the following list:

			//POSITION is the vertex position, typically a float3 or float4.
			//NORMAL is the vertex normal, typically a float3.
			//TEXCOORD0 is the first UV coordinate, typically float2, float3 or float4.
			//TEXCOORD1, TEXCOORD2 and TEXCOORD3 are the 2nd, 3rd and 4th UV coordinates, respectively.
			//TANGENT is the tangent vector (used for normal mapping), typically a float4.
			//COLOR is the per-vertex color, typically a float4.
			struct v2f
			{
			
				float4 pos : POSITION;
				float4 color : COLOR;
			};

			//Often, vertex data inputs are declared in a structure, instead of listing them one by one. 
			//Several commonly used vertex structures are defined in UnityCG.cginc include file, and in most cases it’s enough just to use those. 
			//The structures are: 

			//appdata_base: position, normal and one texture coordinate.
			//appdata_tan: position, tangent, normal and one texture coordinate.
			//appdata_full: position, tangent, normal, four texture coordinates and color.

			//use appdata_base to store the position, normal and texture coord
			v2f vert(appdata_base v)
			{
			//vertex to float variable
				 v2f OUT;
				 //vertex to float.position value = 
				 OUT.pos = UnityObjectToClipPos(v.vertex);
				 float3 norm = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
				 float2 offset = TransformViewToProjection(norm.xy);
				 OUT.pos.xy += offset * _Outline;
				 OUT.color = _OutlineColor;
				
				 return OUT;
			}

			

			half4 frag(v2f i) :COLOR
			{
				return i.color;
			}
			ENDCG
		}

		Pass 
		{
			Cull Back
			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma vertex vert
			#pragma fragment frag

			float4 _MainColor;
			float4 _ShadowColor;
			float _Threshold;

			struct v2f
			{
				float4 pos : POSITION;
				float3 normal : NORMAL;
			};

			v2f vert(appdata_base v)
			{
				 v2f OUT;
				 OUT.pos = UnityObjectToClipPos(v.vertex);
				 OUT.normal = mul(unity_ObjectToWorld, float4(v.normal, 0.0)).xyz;
				 return OUT;
			}

			half4 frag(v2f i) : COLOR
			{
				float d = dot(_WorldSpaceLightPos0, i.normal)+.5;
				return step(_Threshold, d) ? _MainColor : _ShadowColor;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}