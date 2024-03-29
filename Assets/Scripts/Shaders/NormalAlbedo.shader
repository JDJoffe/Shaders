﻿// this section allows for easy sorting of out shader in the shader menu
Shader "Lesson/Normal Albedo"
{
		// public properties seen on a material
	Properties
	{
	// var name is _Texture , display name is Texture
	// it is of type 2D and the default untextured colour is Black
	_Texture("Texture",2D) = "Black"{}
	
	// uses rgb colour value to create xyz depth to the material
	// bump tells unity this material needs to be marked as a normal map so it can be used correctly
	_NormalMap("Normal",2D) = "Bump"{}
	}
	// you can have multiple SubShaders that run at different GPU levels on different platforms
	SubShader
	{
		// tags are basically Key-Value pairs
		// inside a SubShader tags are used to determine rendering order and other parameters of a shader
		// rendertype tag categorizes shadeers into several predefined groups
		Tags
		{
			"RenderType" = "Opaque"
			
		}
		// this is the start of our C for Graphics Language
		CGPROGRAM
		// the material type of maincolour is Lambert
		// the surface of our model is affected by the mainColour function
		// Lambert is a flat material with no highlights/ it is matte
		#pragma surface MainColour Lambert
		// this connects our _Texture var that is in the Properties section to our 2D _Texture var in CG
		sampler2D _Texture;
		// connects _NormapMap from properties to the _NormalMap var in CG
		sampler2D _NormalMap;
		struct Input
		{
		// this is in reference to our UV map of our model
		// UV maps are wrappings of a model
		// The letters U and V denote the axes of the 2d texture because x and y and z are already used to denot the axes of the 3d object in model space
			float2 uv_Texture;
			// UV map link to the _NormalMap image
			float2 uv_NormalMap;
		};
		void MainColour(Input IN, inout SurfaceOutput o)
		{
		// albedo is a reference to the surface image and rgb of our model
		// we are setting the models surface to the colour of our texture2d and matching the texture to our models UV mapping
		o.Albedo = tex2D(_Texture, IN.uv_Texture).rgb;

		//_NormalMap is in reference to the bump map in Properties
		// UnpackNormal is required because the file is currently compressed, we need to decompress to get the true value from the image
		// bump maps are visible when light reflects off
		// the light is bounced off at angles according to the image RGB or XYZ Value
		// this makes the image look like it has depth
		o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
		}
		// this is the end of our C for Graphics Language
		ENDCG
	}
	// cache as exception for shaders (lambert and texture)
	FallBack "Diffuse"
}
