Shader "AIE/Unlit/InverseOutline"
{
    Properties
    {
        _OutlineColour("Outline Colour", Color) = (1,1,1,1)
        _OutlineThickness("Outline Thickness", Range(0,1)) = 0.1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            Cull Front

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
            };

            struct v2f
            {
                half3 normal : NORMAL;
                float4 vertex : SV_POSITION;
            };

            float4 _OutlineColour;
            float _OutlineThickness;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex + normalize(v.normal) * _OutlineThickness * 0.05);
                o.normal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return _OutlineColour;
            }
            ENDCG
        }
    }
}
