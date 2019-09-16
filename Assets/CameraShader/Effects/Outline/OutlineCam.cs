using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OutlineCam : MonoBehaviour
{
    public Color outlineColor;
    public Color mainColor;
    public Color shadowColor;
    public float thickness;
    public float threshold;
    Material material;
   public Shader shader;
   
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (material == null)
        {
            material = new Material(shader);
            material.hideFlags = HideFlags.DontSave;
        }
        material.SetColor("_OutlineColor", outlineColor);
        material.SetColor("_MainColor", mainColor);
        material.SetColor("_ShadowColor", shadowColor);
        material.SetFloat("_Outline", thickness);
        material.SetFloat("_Threshold", threshold);
       
        Graphics.Blit(source, destination, material);
    }
}
