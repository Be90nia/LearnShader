﻿Shader "LearnShader/001"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _testFloat("testFloat",Range(0,360)) = 1
        _testColor("testColor",color) = (1,1,1,1)
        _testVec("testVec",vector) = (0,0,0,0)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 pos : POSITION;
                float4 color : COLOR;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float4 color : COLOR;
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
            float _testFloat;
            float4 _testColor;
            float4 _testVec;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.pos);
                o.uv = v.uv;
                o.color = v.color;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
               float x = i.uv.x - 0.5;
               float y = i.uv.y - 0.5;

               //float r = _testFloat / 360.0 * 2 * 3.1415926;
               float r = radians(_testFloat);
               
               float a = cos(r);
               float b = -sin(r);
               float c = sin(r);
               float d = cos(r);

               float nx = a*x + b*y + 0.5;
               float ny = c*x + d*y + 0.5;

               float2 uv = float2(nx,ny);
               /*
               float2x2 rotateMat = float2x2(
                   cos(r), -sin(r),
                   sin(r), cos(r)
               );

               float2 uv = mul(rotateMat, i.uv - 0.5) + 0.5;
               */
               float4 o = tex2D(_MainTex, uv);
               return o;
            }
            ENDCG
        }
    }
}
