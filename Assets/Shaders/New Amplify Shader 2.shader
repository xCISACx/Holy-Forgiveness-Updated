// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader 2"
{
	Properties
	{
		_Color0("Color 0", Color) = (0.5518868,0.9261317,1,1)
		_Color1("Color 1", Color) = (0,0.6295598,0.7264151,1)
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color0;
		uniform sampler2D _TextureSample2;
		uniform float4 _Color1;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 appendResult6 = (float2(0.0 , 0.04));
			float2 panner7 = ( 1.0 * _Time.y * appendResult6 + ( i.uv_texcoord * 0.95 ));
			o.Albedo = ( ( ( _Color0 + float4( 0,0,0,0 ) ) * tex2D( _TextureSample2, ( float2( 0,0 ) + panner7 ) ) ) + _Color1 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16706
1;504;1325;739;1329.617;597.9751;1.836905;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1084.794,-143.7398;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-1067.326,-5.416718;Float;False;Constant;_Float3;Float 3;5;0;Create;True;0;0;False;0;0.95;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1061.715,112.4014;Float;False;Constant;_Float2;Float 2;11;0;Create;True;0;0;False;0;0.04;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;6;-820.5391,96.9534;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-822.368,-40.1506;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;7;-597.0934,43.2793;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-499.3551,-155.5187;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;12;-94.86485,-474.5908;Float;False;Property;_Color0;Color 0;0;0;Create;True;0;0;False;0;0.5518868,0.9261317,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;13;111.5311,-274.9152;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;8;-361.7432,-128.5816;Float;True;Property;_TextureSample2;Texture Sample 2;2;0;Create;True;0;0;False;0;f86e96ffba88a8344b18f3f37ac350f1;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;44.16696,-96.05169;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;11;78.58221,113.9428;Float;False;Property;_Color1;Color 1;1;0;Create;True;0;0;False;0;0,0.6295598,0.7264151,1;0,0.8702703,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-273.3943,-453.1984;Float;False;Constant;_Float6;Float 6;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;15;314.5792,-97.99288;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-374.1523,-396.6406;Float;False;Constant;_Float7;Float 7;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-329.0893,-288.7924;Float;False;Constant;_Float4;Float 4;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-315.3377,-202.5588;Float;False;Constant;_Float5;Float 5;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-822.3671,-217.4697;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;886.2271,-225.1666;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;New Amplify Shader 2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;1;5;0
WireConnection;3;0;1;0
WireConnection;3;1;4;0
WireConnection;7;0;3;0
WireConnection;7;2;6;0
WireConnection;9;1;7;0
WireConnection;13;0;12;0
WireConnection;8;1;9;0
WireConnection;14;0;13;0
WireConnection;14;1;8;0
WireConnection;15;0;14;0
WireConnection;15;1;11;0
WireConnection;2;1;1;0
WireConnection;0;0;15;0
ASEEND*/
//CHKSM=4D9AEF175863E969F7A52F928DE6DA1FEF54A10C