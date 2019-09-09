// this section allows for easy sorting of out shader in the shader menu
Shader "Lesson/Albedo"
{
	// public properties seen on a material
	Properties
	{
	// var name is _Texture , display name is Texture
	// it is of type 2D and the default untextured colour is Black
	_Texture("Texture",2D) = "Black"{}
	
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
		//
		struct Input
		{
		// this is in reference to our UV map of our model
		// UV maps are wrappings of a model
		// The letters U and V denote the axes of the 2d texture because x and y and z are already used to denot the axes of the 3d object in model space
			float2 uv_Texture;
		};
		void MainColour(Input IN, inout SurfaceOutput o)
		{
		// albedo is a reference to the surface image and rgb of our model
		// we are setting the models surface to the colour of our texture2d and matching the texture to our models UV mapping
		o.Albedo = tex2D(_Texture, IN.uv_Texture).rgb;
		}
		// this is the end of our C for Graphics Language
		ENDCG
	}
	// cache as exception for shaders (lambert and texture)
	FallBack "Diffuse"
}
