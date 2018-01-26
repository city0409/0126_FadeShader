Shader "Custom/FadeShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("MainTex (RGB)", 2D) = "white" {}
		_SecondTex("SecondTex (RGB)", 2D) = "white" {}
		_FadeValue ("FadeValue", Range(0,1)) = 0.5
		_MainAlpha("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" "Queue"="Transparent"}
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert alpha

		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _SecondTex; 

		struct Input {
			float2 uv_MainTex;
			float2 uv_SecondTex;
		};

		half _FadeValue;
		half _MainAlpha;
		fixed4 _Color;


		void surf (Input IN, inout SurfaceOutput  o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			fixed4 s = tex2D(_SecondTex, IN.uv_SecondTex) * _Color;

			o.Albedo = c.rgb*_FadeValue+s.rgb*(1- _FadeValue);
			o.Alpha = (c.a*_FadeValue+s.a*(1- _FadeValue))*_MainAlpha;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
