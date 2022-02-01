// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Toon Water 2"
{
	Properties
	{
		_Texture3("Texture 3", 2D) = "white" {}
		_OuterStep2("Outer Step 2", Range( 0 , 1)) = 0.3798557
		_InnerStep2("Inner Step 2", Range( 0 , 1)) = 0.2470633
		_Float17("Float 17", Range( 0 , 1)) = 0.23
		_Color7("Color 7", Color) = (0.5518868,0.9261317,1,1)
		_Float18("Float 18", Range( 0 , 1)) = 0.01
		_Color4("Color 4", Color) = (0,0.6295598,0.7264151,1)
		_TextureSample6("Texture Sample 6", 2D) = "white" {}
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

		uniform float4 _Color4;
		uniform float _OuterStep2;
		uniform sampler2D _TextureSample6;
		uniform sampler2D _Texture3;
		uniform float _Float18;
		uniform float _Float17;
		uniform float _InnerStep2;
		uniform float4 _Color7;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 temp_cast_0 = (_OuterStep2).xxxx;
			float2 temp_cast_1 = (0.22).xx;
			float2 uv_TexCoord258 = i.uv_texcoord * temp_cast_1 + float2( 3.67,4 );
			float simplePerlin2D275 = snoise( uv_TexCoord258 );
			float2 appendResult262 = (float2(0.0 , _Float18));
			float2 panner268 = ( 1.0 * _Time.y * appendResult262 + ( uv_TexCoord258 * _Float17 ));
			float4 temp_output_247_0 = step( temp_cast_0 , tex2D( _TextureSample6, tex2D( _Texture3, ( simplePerlin2D275 + tex2D( _Texture3, panner268 ) ).rg ).rg ) );
			float4 temp_cast_4 = (_InnerStep2).xxxx;
			float4 temp_cast_7 = (_OuterStep2).xxxx;
			o.Albedo = ( ( _Color4 * temp_output_247_0 ) + ( ( step( temp_cast_4 , tex2D( _TextureSample6, tex2D( _Texture3, ( simplePerlin2D275 + tex2D( _Texture3, panner268 ) ).rg ).rg ) ) - temp_output_247_0 ) * _Color7 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16706
1;1;1203;1057;1709.319;-5300.112;3.642039;True;False
Node;AmplifyShaderEditor.CommentaryNode;257;-240.7803,5965.835;Float;False;2954.858;1157.983;;31;274;273;272;270;269;268;267;266;265;264;263;262;261;260;259;258;254;253;252;251;250;249;248;247;246;245;244;27;275;287;290;TOONIER WATER;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;285;-379.3093,6678.715;Float;False;Constant;_Vector7;Vector 7;27;0;Create;True;0;0;False;0;3.67,4;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;276;-387.4619,6515.287;Float;False;Constant;_Vector6;Vector 6;27;0;Create;True;0;0;False;0;0.22,3.11;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;258;-167.4251,6614.219;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;260;-190.7803,6868.576;Float;False;Property;_Float18;Float 18;28;0;Create;True;0;0;False;0;0.01;0.02;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;259;-181.9257,6764.53;Float;False;Property;_Float17;Float 17;19;0;Create;True;0;0;False;0;0.23;0.83;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;262;96.82968,6854.913;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;261;95.0007,6717.809;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;267;-227.5467,6235.38;Float;True;Property;_Texture3;Texture 3;9;0;Create;True;0;0;False;0;None;182a8e4623858c745a22ad25fbd3a0c7;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.PannerNode;268;320.2754,6801.239;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;275;257.5669,6505.576;Float;True;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;287;517.7236,6725.91;Float;True;Property;_TextureSample8;Texture Sample 8;16;0;Create;True;0;0;False;0;None;b3c4ae949b5d8634fbd9788420c7f71b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;272;611.1215,6543.756;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;273;755.3553,6476.875;Float;True;Property;_TextureSample7;Texture Sample 7;16;0;Create;True;0;0;False;0;None;b3c4ae949b5d8634fbd9788420c7f71b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;290;1085.184,6702.583;Float;True;Property;_TextureSample6;Texture Sample 6;32;0;Create;True;0;0;False;0;None;b3c4ae949b5d8634fbd9788420c7f71b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;245;1125.626,6423.55;Float;False;Property;_InnerStep2;Inner Step 2;14;0;Create;True;0;0;False;0;0.2470633;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;246;1140.22,6230.591;Float;False;Property;_OuterStep2;Outer Step 2;13;0;Create;True;0;0;False;0;0.3798557;0.03;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;244;1242.375,6326.26;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;248;1430.472,6402.472;Float;False;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;247;1445.065,6293.829;Float;False;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;250;1615.343,6434.265;Float;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;249;1522.101,6049.328;Float;False;Property;_Color4;Color 4;31;0;Create;True;0;0;False;0;0,0.6295598,0.7264151,1;0,0.8702703,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;251;1571.096,6622.078;Float;False;Property;_Color7;Color 7;25;0;Create;True;0;0;False;0;0.5518868,0.9261317,1,1;0.4858491,0.9334629,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;216;-303.9174,4274.585;Float;False;2954.858;1157.983;;28;191;192;190;194;193;199;195;198;215;196;197;200;201;209;210;202;188;187;186;185;189;206;212;203;214;213;204;208;TOONIER WATER;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;252;1834.332,6553.098;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;253;1827.144,6268.458;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;211;-323.7423,2874.111;Float;False;2032.086;1020.818;;21;176;171;177;175;173;181;162;174;180;183;178;165;167;166;169;168;170;172;163;179;182;GOOD WATER;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;263;352.3615,6084.016;Float;False;Constant;_Float19;Float 19;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;231;-995.7906,5358.886;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;183;246.0443,2924.111;Float;False;Constant;_Float7;Float 7;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;269;491.7444,6378.052;Float;False;Constant;_Float23;Float 23;9;0;Create;True;0;0;False;0;0.34;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;197;257.1383,5109.989;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StepOpNode;189;1591.999,5000.571;Float;False;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;185;1606.592,4891.928;Float;False;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;187;1287.153,5021.649;Float;False;Constant;_OuterStep;Outer Step;9;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;174;213.9582,3641.334;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;193;33.69265,5163.663;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;179;741.0809,3455.192;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT2;0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;240;-1418.894,5294.665;Float;False;Property;_Vector5;Vector 5;17;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;215;434.1669,4324.585;Float;False;Constant;_Float8;Float 8;9;0;Create;True;0;0;False;0;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;241;-1634.051,5493.256;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;238;-1545,5121.706;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;198;106.7717,4421.211;Float;False;Constant;_Float11;Float 11;9;0;Create;True;0;0;False;0;1.69;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;158;871.5052,1203.617;Float;True;RadialUVDistortion;-1;;4;051d65e7699b41a4c800363fd0e822b2;0;7;60;SAMPLER2D;0.0;False;1;FLOAT2;1,1;False;11;FLOAT2;0,0;False;65;FLOAT;1;False;68;FLOAT2;1,1;False;47;FLOAT2;1,1;False;29;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;136;795.4615,1860.055;Float;True;Property;_TextureSample1;Texture Sample 1;10;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;266;497.304,6015.835;Float;False;Constant;_Float22;Float 22;9;0;Create;True;0;0;False;0;0.67;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;225;-1167.91,4529.234;Float;False;Constant;_NoiseValue;Noise Value;8;0;Create;True;0;0;False;0;2.53;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;227;-988.0338,4644.246;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;190;-253.9174,5177.326;Float;False;Property;_Speed;Speed;29;0;Create;True;0;0;False;0;0.01;0.02;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;270;622.3787,6137.018;Float;False;RadialUVDistortion;-1;;7;051d65e7699b41a4c800363fd0e822b2;0;7;60;SAMPLER2D;0.0;False;1;FLOAT2;1,1;False;11;FLOAT2;0,0;False;65;FLOAT;1;False;68;FLOAT2;1,1;False;47;FLOAT2;1,1;False;29;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;255;2910.624,6237.538;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;125;44.19902,1617.243;Float;False;Constant;_Noise1Scale;Noise 1 Scale;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;150;1771.461,1636.055;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;209;432.1561,4896.626;Float;True;Property;_TextureSample5;Texture Sample 5;10;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;226;-1177.955,4780.03;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;203;1669.713,5225.569;Float;False;Property;_Color2;Color 2;24;0;Create;True;0;0;False;0;0.5518868,0.9261317,1,1;0.4858491,0.9334629,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;167;946.0309,3165.002;Float;False;Property;_Color0;Color 0;23;0;Create;True;0;0;False;0;0.5518868,0.9261317,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;220;-1652.903,4799.084;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;192;-213.0938,5061.292;Float;False;Property;_Zoom;Zoom;20;0;Create;True;0;0;False;0;0.23;0.81;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;265;169.9087,6112.461;Float;False;Constant;_Float21;Float 21;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;305;1222.572,7562.838;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;304;1079.089,7744.731;Float;False;Constant;_Color8;Color 8;9;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;303;1248.997,7908.315;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;302;807.3804,7499.096;Float;True;Property;_Foam;Foam;6;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;301;1052.57,7945.08;Float;False;2;2;0;FLOAT;0.075;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;300;853.8684,7323.036;Float;False;Property;_FoamColor;Foam Color;5;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DepthFade;299;715.5923,7954.825;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;298;884.3145,7820.501;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;297;592.1433,7735.054;Float;True;Property;_FoamDistortion;Foam Distortion;8;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;296;353.2024,7939.656;Float;False;Property;_FoamDist;Foam Dist;10;0;Create;True;0;0;False;0;0.1;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;295;358.3735,7688.813;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;294;280.9323,7507.527;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;293;-50.75954,7452.965;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;292;-19.61549,7702.707;Float;False;-1;;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;159;612.9362,1221.601;Float;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;False;0;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;228;-738.2097,4582.577;Float;True;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;195;190.0657,4507.861;Float;False;Constant;_Float10;Float 10;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;204;2153.481,5043.191;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;199;289.2245,4392.766;Float;False;Constant;_Float12;Float 12;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;229;-721.6058,4346.762;Float;False;Constant;_RippleColour;Ripple Colour;10;0;Create;True;0;0;False;0;0,0.9908628,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;208;31.86465,4849.24;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;236;-1743.939,5191.639;Float;False;Property;_Vector2;Vector 2;3;0;Create;True;0;0;False;0;10,10;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;160;631.0231,1099.901;Float;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;130;301.9544,1964.572;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;201;595.4706,4436.711;Float;False;RadialUVDistortion;-1;;6;051d65e7699b41a4c800363fd0e822b2;0;7;60;SAMPLER2D;0.0;False;1;FLOAT2;1,1;False;11;FLOAT2;0,0;False;65;FLOAT;1;False;68;FLOAT2;1,1;False;47;FLOAT2;1,1;False;29;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;200;428.6073,4686.802;Float;False;Constant;_Float13;Float 13;9;0;Create;True;0;0;False;0;3.55;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;188;1403.902,4924.359;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;142;-510.9142,1473.269;Float;False;Property;_TimeScaleNoise;TimeScaleNoise;11;0;Create;True;0;0;False;0;0;0.1204917;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;218;-1811.369,4806.358;Float;False;Constant;_TimeScale;Time Scale;9;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;182;411.0947,2917.15;Float;False;Constant;_Float6;Float 6;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;223;-1434.781,4779.671;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;128;55.168,1862.2;Float;False;Constant;_Noise2Scale;Noise 2 Scale;5;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;133;491.4615,1684.055;Float;True;Property;_Texture1;Texture 1;0;0;Create;True;0;0;False;0;None;182a8e4623858c745a22ad25fbd3a0c7;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleAddOpNode;221;-1563.852,4427.535;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;202;965.8284,4843.589;Float;True;Property;_TextureSample4;Texture Sample 4;21;0;Create;True;0;0;False;0;None;b3c4ae949b5d8634fbd9788420c7f71b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;152;1665.2,1931.52;Float;False;Property;_Color5;Color 5;26;0;Create;True;0;0;False;0;0,0.6295598,0.7264151,1;0,0.6295598,0.7264151,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;212;1776.87,5032.364;Float;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;230;-1379.671,5070.948;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;186;1301.747,4828.69;Float;False;Constant;_InnerStep;Inner Step;9;0;Create;True;0;0;False;0;0.03396714;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;217;-1773.521,4335.72;Float;False;Property;_Tiling;Tiling;7;0;Create;True;0;0;False;0;100,100;1.91,1.67;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;222;-1398.523,4376.778;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;210;784.261,4923.846;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT2;0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;132;46.02701,1520.356;Float;False;Constant;_Noise1Speed;Noise 1 Speed;11;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;180;72.51634,2938.277;Float;False;Constant;_Float4;Float 4;9;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;264;253.2028,6199.111;Float;False;Constant;_Float20;Float 20;9;0;Create;True;0;0;False;0;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;213;1988.671,4866.557;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;172;-11.31549,3380.585;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;166;1258.672,3290.112;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;237;-1437.746,4600.494;Float;False;Property;_Vector4;Vector 4;16;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;140;470.6961,1364.343;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;224;-1197.86,4948.73;Float;False;Constant;_SinOffset;SinOffset;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;162;-17.82811,3131.558;Float;True;Property;_Texture0;Texture 0;2;0;Create;True;0;0;False;0;None;182a8e4623858c745a22ad25fbd3a0c7;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;176;-250.6639,3710.456;Float;False;Constant;_Float2;Float 2;11;0;Create;True;0;0;False;0;0.06;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;163;388.976,3427.972;Float;True;Property;_TextureSample2;Texture Sample 2;10;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;171;-273.7423,3454.315;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;169;1324.433,3462.228;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;135;827.4616,1540.055;Float;True;Property;_TextureSample0;Texture Sample 0;10;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;155;1483.461,1412.055;Float;False;Property;_Color6;Color 6;22;0;Create;True;0;0;False;0;0.5518868,0.9261317,1,1;0.5518868,0.9261317,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;175;-9.487486,3695.008;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;243;2864.961,5999.838;Float;True;2;0;COLOR;0,0,0,0;False;1;COLOR;4.005236,4.005236,4.005236,1;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;165;945.8678,3401.843;Float;True;Property;_TextureSample3;Texture Sample 3;18;0;Create;True;0;0;False;0;None;b3c4ae949b5d8634fbd9788420c7f71b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;170;1554.343,3529.456;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;151;1948.483,1661.59;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;181;146.8855,3039.206;Float;False;Constant;_Float5;Float 5;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;235;-1754.669,5029.891;Float;False;Property;_Vector3;Vector 3;12;0;Create;True;0;0;False;0;100,100;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;177;-256.274,3592.638;Float;False;Constant;_Float3;Float 3;5;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;242;-755.9657,5244.049;Float;True;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;274;35.48574,6442.108;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;137;1211.462,1764.055;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;194;31.86367,5026.559;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;127;525.4,1910.897;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;173;-11.31647,3557.904;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;141;-220.0876,1363.782;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;168;1079.891,3687.929;Float;False;Property;_Color1;Color 1;27;0;Create;True;0;0;False;0;0,0.6295598,0.7264151,1;0,0.8702703,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;129;300.1254,1827.467;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;232;-1159.103,5474.201;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;306;1517.173,7795.316;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SinOpNode;144;16.86085,1285.895;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;234;-1792.517,5500.529;Float;False;Constant;_Float14;Float 14;9;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;254;1991.954,6445.092;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;157;2204.885,1781.798;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;256;2876.07,6020.802;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;122;307.1667,1497.559;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;178;444.1462,3110.219;Float;False;RadialUVDistortion;-1;;5;051d65e7699b41a4c800363fd0e822b2;0;7;60;SAMPLER2D;0.0;False;1;FLOAT2;1,1;False;11;FLOAT2;0,0;False;65;FLOAT;1;False;68;FLOAT2;1,1;False;47;FLOAT2;1,1;False;29;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;124;60.77798,1980.019;Float;False;Constant;_Noise2Speed;Noise 2 Speed;11;0;Create;True;0;0;False;0;0.06;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;123;300.1263,1650.148;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;126;37.69963,1723.878;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;161;1264.447,1485.394;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;214;1995.859,5151.197;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;196;25.35204,4600.212;Float;True;Property;_Texture2;Texture 2;4;0;Create;True;0;0;False;0;None;182a8e4623858c745a22ad25fbd3a0c7;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;307;1697.904,7841.425;Float;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;233;-1264.897,5229.825;Float;False;Constant;_Float9;Float 9;8;0;Create;True;0;0;False;0;65.22753;0;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;191;-230.5622,4922.969;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;131;537.6161,1547.994;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SinOpNode;239;-1403.528,5477.976;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;149;1399.95,1744.084;Float;True;Property;_Mask;Mask;15;0;Create;True;0;0;False;0;None;b3c4ae949b5d8634fbd9788420c7f71b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;206;1683.628,4647.427;Float;False;Property;_Color3;Color 3;30;0;Create;True;0;0;False;0;0,0.6295598,0.7264151,1;0,0.8702703,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;219;-1762.791,4497.467;Float;False;Property;_Offset;Offset;1;0;Create;True;0;0;False;0;10,10;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;27;2352.422,6379.081;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Toon Water 2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;258;0;276;1
WireConnection;258;1;285;0
WireConnection;262;1;260;0
WireConnection;261;0;258;0
WireConnection;261;1;259;0
WireConnection;268;0;261;0
WireConnection;268;2;262;0
WireConnection;275;0;258;0
WireConnection;287;0;267;0
WireConnection;287;1;268;0
WireConnection;272;0;275;0
WireConnection;272;1;287;0
WireConnection;273;0;267;0
WireConnection;273;1;272;0
WireConnection;290;1;273;0
WireConnection;244;0;290;0
WireConnection;248;0;245;0
WireConnection;248;1;244;0
WireConnection;247;0;246;0
WireConnection;247;1;244;0
WireConnection;250;0;248;0
WireConnection;250;1;247;0
WireConnection;252;0;250;0
WireConnection;252;1;251;0
WireConnection;253;0;249;0
WireConnection;253;1;247;0
WireConnection;231;0;232;0
WireConnection;231;1;233;0
WireConnection;197;0;194;0
WireConnection;197;2;193;0
WireConnection;189;0;187;0
WireConnection;189;1;188;0
WireConnection;185;0;186;0
WireConnection;185;1;188;0
WireConnection;174;0;173;0
WireConnection;174;2;175;0
WireConnection;193;1;190;0
WireConnection;179;0;163;0
WireConnection;179;1;178;0
WireConnection;241;0;234;0
WireConnection;238;0;235;0
WireConnection;238;1;236;0
WireConnection;158;60;133;0
WireConnection;158;1;160;0
WireConnection;158;11;159;0
WireConnection;136;0;133;0
WireConnection;136;1;127;0
WireConnection;227;0;226;0
WireConnection;227;1;225;0
WireConnection;227;2;224;0
WireConnection;270;60;267;0
WireConnection;270;1;263;0
WireConnection;270;11;266;0
WireConnection;270;65;265;0
WireConnection;270;68;269;0
WireConnection;270;47;264;0
WireConnection;255;0;256;0
WireConnection;150;0;155;0
WireConnection;150;1;149;1
WireConnection;209;0;196;0
WireConnection;209;1;197;0
WireConnection;226;0;222;0
WireConnection;220;0;218;0
WireConnection;305;0;300;0
WireConnection;305;1;302;0
WireConnection;303;0;301;0
WireConnection;302;1;295;0
WireConnection;301;0;298;0
WireConnection;301;1;299;0
WireConnection;299;0;296;0
WireConnection;298;0;297;1
WireConnection;297;1;295;0
WireConnection;295;0;294;0
WireConnection;295;2;292;0
WireConnection;294;0;293;0
WireConnection;294;1;292;0
WireConnection;228;0;227;0
WireConnection;204;0;213;0
WireConnection;204;1;214;0
WireConnection;208;1;191;0
WireConnection;130;1;124;0
WireConnection;201;60;196;0
WireConnection;201;1;199;0
WireConnection;201;11;215;0
WireConnection;201;65;198;0
WireConnection;201;68;200;0
WireConnection;201;47;195;0
WireConnection;188;0;202;0
WireConnection;223;0;220;0
WireConnection;221;0;217;0
WireConnection;221;1;219;0
WireConnection;202;1;210;0
WireConnection;212;0;189;0
WireConnection;212;1;185;0
WireConnection;230;0;238;0
WireConnection;230;1;238;0
WireConnection;222;0;221;0
WireConnection;222;1;221;0
WireConnection;210;0;209;0
WireConnection;210;1;201;0
WireConnection;213;0;206;0
WireConnection;213;1;185;0
WireConnection;172;1;171;0
WireConnection;166;0;167;0
WireConnection;166;1;165;1
WireConnection;140;0;144;0
WireConnection;140;1;122;0
WireConnection;163;0;162;0
WireConnection;163;1;174;0
WireConnection;169;0;166;0
WireConnection;169;1;165;1
WireConnection;135;0;133;0
WireConnection;175;1;176;0
WireConnection;165;1;179;0
WireConnection;170;0;169;0
WireConnection;170;1;168;0
WireConnection;151;0;150;0
WireConnection;151;1;149;1
WireConnection;242;0;231;0
WireConnection;137;0;135;0
WireConnection;137;1;136;0
WireConnection;194;0;191;0
WireConnection;194;1;192;0
WireConnection;127;0;129;0
WireConnection;127;2;130;0
WireConnection;173;0;171;0
WireConnection;173;1;177;0
WireConnection;141;0;142;0
WireConnection;129;0;126;0
WireConnection;129;1;128;0
WireConnection;232;0;230;0
WireConnection;232;1;239;0
WireConnection;306;0;305;0
WireConnection;306;1;304;0
WireConnection;306;2;303;0
WireConnection;144;0;141;0
WireConnection;254;0;253;0
WireConnection;254;1;252;0
WireConnection;157;0;151;0
WireConnection;157;1;152;0
WireConnection;122;0;125;0
WireConnection;122;1;132;0
WireConnection;178;60;162;0
WireConnection;178;1;183;0
WireConnection;178;65;180;0
WireConnection;178;68;182;0
WireConnection;178;47;181;0
WireConnection;123;1;126;0
WireConnection;214;0;212;0
WireConnection;214;1;203;0
WireConnection;307;0;306;0
WireConnection;131;1;122;0
WireConnection;239;0;241;0
WireConnection;149;1;137;0
WireConnection;27;0;254;0
ASEEND*/
//CHKSM=FA747CA4E57C5C637811615BDB9F239DF8836C70