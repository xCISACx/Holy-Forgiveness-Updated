// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Toon Water 1"
{
	Properties
	{
		_WaveGuide("Wave Guide", 2D) = "white" {}
		_WaveSpeed("Wave Speed", Range( 0 , 5)) = 0.4512808
		_FoamColor("Foam Color", Color) = (1,1,1,0)
		_Color1("Color 1", Color) = (0,0.6295598,0.7264151,1)
		_Foam("Foam", 2D) = "white" {}
		_WaveHeight("Wave Height", Range( 0 , 5)) = 1.001184
		_FoamDistortion("Foam Distortion", 2D) = "white" {}
		[Toggle][Toggle]_LowPoly("Low Poly", Float) = 1
		_FoamDistortion2("Foam Distortion 2", Range( 0 , 1)) = 0.1
		_NormalOnlyNoPolyMode("Normal (Only No Poly Mode)", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float4 screenPos;
		};

		uniform sampler2D _WaveGuide;
		uniform float _WaveSpeed;
		uniform float _WaveHeight;
		uniform float _LowPoly;
		uniform sampler2D _NormalOnlyNoPolyMode;
		uniform float4 _NormalOnlyNoPolyMode_ST;
		uniform float4 _Color1;
		uniform float4 _FoamColor;
		uniform sampler2D _Foam;
		uniform sampler2D _FoamDistortion;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _FoamDistortion2;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 speed40 = ( _Time * _WaveSpeed );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float2 uv_TexCoord26 = v.texcoord.xy + ( speed40 + (ase_vertex3Pos).y ).xy;
			float3 ase_vertexNormal = v.normal.xyz;
			float3 VertexAnimation33 = ( ( tex2Dlod( _WaveGuide, float4( uv_TexCoord26, 0, 1.0) ).r - 0.5 ) * ( ase_vertexNormal * _WaveHeight ) );
			v.vertex.xyz += VertexAnimation33;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalOnlyNoPolyMode = i.uv_texcoord * _NormalOnlyNoPolyMode_ST.xy + _NormalOnlyNoPolyMode_ST.zw;
			float3 ase_worldPos = i.worldPos;
			float3 normalizeResult47 = normalize( ( cross( ddx( ase_worldPos ) , ddy( ase_worldPos ) ) + float3( 1E-09,0,0 ) ) );
			float3 Normal50 = lerp(UnpackNormal( tex2D( _NormalOnlyNoPolyMode, uv_NormalOnlyNoPolyMode ) ),normalizeResult47,_LowPoly);
			o.Normal = Normal50;
			o.Albedo = ( step( float4( 0,0,0,0 ) , float4( 0,0,0,0 ) ) + _Color1 ).rgb;
			float4 speed40 = ( _Time * _WaveSpeed );
			float2 panner56 = ( speed40.x * float2( 0.5,0.5 ) + i.uv_texcoord);
			float cos57 = cos( speed40.x );
			float sin57 = sin( speed40.x );
			float2 rotator57 = mul( panner56 - float2( 0,0 ) , float2x2( cos57 , -sin57 , sin57 , cos57 )) + float2( 0,0 );
			float clampResult60 = clamp( tex2D( _FoamDistortion, rotator57 ).r , 0.0 , 1.0 );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth61 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos )));
			float distanceDepth61 = abs( ( screenDepth61 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _FoamDistortion2 ) );
			float clampResult65 = clamp( ( clampResult60 * distanceDepth61 ) , 0.0 , 1.0 );
			float4 lerpResult68 = lerp( ( _FoamColor * tex2D( _Foam, rotator57 ) ) , float4(0,0,0,0) , clampResult65);
			float4 Emission69 = lerpResult68;
			o.Emission = Emission69.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16706
-58;406;1325;598;675.2656;249.3056;1.624845;True;False
Node;AmplifyShaderEditor.CommentaryNode;36;-1231.796,1346.019;Float;False;914.394;362.5317;Comment;4;40;39;38;37;Wave Speed;1,1,1,1;0;0
Node;AmplifyShaderEditor.TimeNode;38;-1110.899,1396.02;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;37;-1181.796,1593.552;Float;False;Property;_WaveSpeed;Wave Speed;1;0;Create;True;0;0;False;0;0.4512808;0.24;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-781.8617,1531.041;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;40;-560.4017,1438.695;Float;False;speed;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;53;-1138.319,1928.239;Float;False;2009.663;867.9782;Foam around objects;16;69;68;67;66;65;64;63;62;61;60;59;58;57;56;55;54;Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;54;-1120.319,2108.167;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;55;-1089.175,2357.909;Float;False;40;speed;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;52;-1230.74,771.2521;Float;False;2307.46;426.9862;Comment;12;34;23;24;25;26;29;28;27;30;31;32;33;Vertex Animation;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;41;-188.9101,1325.511;Float;False;1244.412;443.4576;Comment;9;50;49;48;47;46;45;44;43;42;Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;34;-1180.74,920.7151;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;56;-788.6268,2162.729;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;23;-857.1194,860.4338;Float;False;40;speed;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RotatorNode;57;-711.1856,2344.014;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;24;-941.9764,939.9871;Float;False;False;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;42;-177.4151,1590.342;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DdyOpNode;44;30.58491,1670.342;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;25;-656.2974,857.1514;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-716.3568,2594.857;Float;False;Property;_FoamDistortion2;Foam Distortion 2;10;0;Create;True;0;0;False;0;0.1;0.1785068;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DdxOpNode;43;30.58491,1574.342;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;59;-477.4159,2390.256;Float;True;Property;_FoamDistortion;Foam Distortion;7;0;Create;True;0;0;False;0;cd460ee4ac5c1e746b7a734cc7cc64dd;cd460ee4ac5c1e746b7a734cc7cc64dd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-467.6862,821.2521;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CrossProductOpNode;45;158.5849,1606.342;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;60;-185.2447,2475.703;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;61;-353.9668,2610.027;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;122.6827,1083.238;Float;False;Property;_WaveHeight;Wave Height;6;0;Create;True;0;0;False;0;1.001184;1.01;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;63;-215.6907,1978.239;Float;False;Property;_FoamColor;Foam Color;3;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;46;326.5889,1640.591;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;1E-09,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;62;-262.1788,2154.298;Float;True;Property;_Foam;Foam;5;0;Create;True;0;0;False;0;9fbef4b79ca3b784ba023cb1331520d5;9fbef4b79ca3b784ba023cb1331520d5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;27;-188.2233,827.2737;Float;True;Property;_WaveGuide;Wave Guide;0;0;Create;True;0;0;False;0;31890676c5b178840848afa665cb5a2f;31890676c5b178840848afa665cb5a2f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;28;166.9988,927.4282;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-16.98873,2600.282;Float;False;2;2;0;FLOAT;0.075;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;494.0527,1008.51;Float;False;2;2;0;FLOAT3;1,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;31;499.3577,854.8445;Float;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;65;179.4383,2563.517;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;48;185.2049,1375.511;Float;True;Property;_NormalOnlyNoPolyMode;Normal (Only No Poly Mode);11;0;Create;True;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalizeNode;47;462.5849,1670.342;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;153.0132,2218.041;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;66;9.530286,2399.933;Float;False;Constant;_Color2;Color 2;9;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;68;447.6143,2450.518;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;49;609.7289,1577.734;Float;False;Property;_LowPoly;Low Poly;8;1;[Toggle];Create;True;0;0;False;0;1;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;661.3619,987.3748;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;1;-1036.72,-340.6348;Float;False;2032.086;1020.818;;18;22;21;20;19;18;16;15;14;13;12;11;10;9;5;4;3;2;71;GOOD WATER;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;2;271.0471,395.1904;Float;False;Property;_Color1;Color 1;4;0;Create;True;0;0;False;0;0,0.6295598,0.7264151,1;0,0.8702703,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;33;814.7205,979.3967;Float;False;VertexAnimation;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;50;812.5017,1588.739;Float;False;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;69;628.3444,2496.627;Float;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;71;702.8748,232.9298;Float;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-963.642,495.7102;Float;False;Constant;_Float2;Float 2;11;0;Create;True;0;0;False;0;0.06;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;3;476.8692,89.85933;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;530.3998,213.0439;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-640.4618,-276.4688;Float;False;Constant;_Float4;Float 4;9;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-466.9338,-290.6348;Float;False;Constant;_Float7;Float 7;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-724.2936,165.8391;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-566.0927,-175.5399;Float;False;Constant;_Float5;Float 5;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-301.8834,-297.596;Float;False;Constant;_Float6;Float 6;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-986.7204,239.569;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;16;841.3649,314.7102;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;51;1211.792,301.3152;Float;False;50;Normal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;35;1130.386,437.1846;Float;False;33;VertexAnimation;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-724.2946,343.1582;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;15;-722.4656,480.2622;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;12;233.0527,-49.74392;Float;False;Property;_Color0;Color 0;2;0;Create;True;0;0;False;0;0.5518868,0.9261317,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-969.2521,377.8921;Float;False;Constant;_Float3;Float 3;5;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;13;-499.02,426.5881;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;70;1187.767,146.7938;Float;False;69;Emission;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;10;-49.0168,182.8497;Float;True;Property;_TextureSample2;Texture Sample 2;9;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1468.487,158.4648;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Toon Water 1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;39;0;38;0
WireConnection;39;1;37;0
WireConnection;40;0;39;0
WireConnection;56;0;54;0
WireConnection;56;1;55;0
WireConnection;57;0;56;0
WireConnection;57;2;55;0
WireConnection;24;0;34;0
WireConnection;44;0;42;0
WireConnection;25;0;23;0
WireConnection;25;1;24;0
WireConnection;43;0;42;0
WireConnection;59;1;57;0
WireConnection;26;1;25;0
WireConnection;45;0;43;0
WireConnection;45;1;44;0
WireConnection;60;0;59;1
WireConnection;61;0;58;0
WireConnection;46;0;45;0
WireConnection;62;1;57;0
WireConnection;27;1;26;0
WireConnection;64;0;60;0
WireConnection;64;1;61;0
WireConnection;30;0;28;0
WireConnection;30;1;29;0
WireConnection;31;0;27;1
WireConnection;65;0;64;0
WireConnection;47;0;46;0
WireConnection;67;0;63;0
WireConnection;67;1;62;0
WireConnection;68;0;67;0
WireConnection;68;1;66;0
WireConnection;68;2;65;0
WireConnection;49;0;48;0
WireConnection;49;1;47;0
WireConnection;32;0;31;0
WireConnection;32;1;30;0
WireConnection;33;0;32;0
WireConnection;50;0;49;0
WireConnection;69;0;68;0
WireConnection;3;0;12;0
WireConnection;3;1;10;1
WireConnection;9;0;3;0
WireConnection;9;1;10;1
WireConnection;4;1;14;0
WireConnection;16;0;71;0
WireConnection;16;1;2;0
WireConnection;19;0;14;0
WireConnection;19;1;5;0
WireConnection;15;1;18;0
WireConnection;13;0;19;0
WireConnection;13;2;15;0
WireConnection;10;1;13;0
WireConnection;0;0;16;0
WireConnection;0;1;51;0
WireConnection;0;2;70;0
WireConnection;0;11;35;0
ASEEND*/
//CHKSM=BA89AAC18EE74837A1917F6445D69A9F025417B3