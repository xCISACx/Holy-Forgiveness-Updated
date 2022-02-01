// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_Offset("Offset", Vector) = (10,10,0,0)
		_Tiling("Tiling", Vector) = (100,100,0,0)
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

		uniform float2 _Tiling;
		uniform float2 _Offset;


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
			float4 color84 = IsGammaSpace() ? float4(0,0.9908628,1,1) : float4(0,0.97934,1,1);
			float2 temp_output_70_0 = ( _Tiling + _Offset );
			float2 uv_TexCoord4 = i.uv_texcoord * temp_output_70_0 + temp_output_70_0;
			float simplePerlin2D108 = snoise( (( uv_TexCoord4 + sin( _Time.y ) )*3.0 + 1.0) );
			o.Albedo = pow( ( color84 * simplePerlin2D108 ) , float4( 4.005236,4.005236,4.005236,1 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16706
1;1;1203;1057;4321.422;904.5434;4.231629;True;False
Node;AmplifyShaderEditor.Vector2Node;67;-3392.786,605.1774;Float;False;Property;_Tiling;Tiling;2;0;Create;True;0;0;False;0;100,100;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;69;-3430.634,1075.816;Float;False;Constant;_TimeScale;Time Scale;9;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;3;-3382.056,766.9248;Float;False;Property;_Offset;Offset;0;0;Create;True;0;0;False;0;10,10;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;78;-3272.168,1068.542;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;70;-3183.117,696.9922;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SinOpNode;57;-3041.645,1053.262;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-3017.788,646.2357;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-2817.125,1218.188;Float;False;Constant;_SinOffset;SinOffset;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-2787.175,798.6917;Float;False;Constant;_NoiseValue;Noise Value;8;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;71;-2797.22,1049.488;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;5;-2607.299,913.7038;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;108;-2361.644,845.7811;Float;True;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;84;-2340.871,616.2196;Float;False;Constant;_RippleColour;Ripple Colour;10;0;Create;True;0;0;False;0;0,0.9908628,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;39;-4043.662,-730.7509;Float;False;835.6508;341.2334;Comment;4;48;47;46;45;N dot L;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;41;-4003.185,-153.8874;Float;False;717.6841;295.7439;Comment;3;44;43;42;Light Falloff;0.9947262,1,0.6176471,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;112;-2083.841,746.712;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;7;-2558.859,-996.0349;Float;False;2938.463;877.6871;Comment;25;32;31;30;29;28;27;26;25;24;23;22;21;20;19;18;17;16;15;14;13;12;11;10;9;8;Base Colour;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;34;-4171.127,-1311.88;Float;False;1370.182;280;Comment;5;40;38;37;36;35;Normals;0.5220588,0.6044625,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;105;-1315.084,1967.919;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;-1558.348,1575.473;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;38;-3229.101,-1257.584;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;10;-865.2119,-819.2852;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;37;-3470.737,-1256.64;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-572.3362,-463.6476;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-1879.208,1738.809;Float;False;Constant;_RippleSlimness;RippleSlimness;10;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;15;-971.5376,-644.2616;Float;False;Property;_WaveTint;Wave Tint;10;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;75;-126.2063,797.6097;Float;False;ExistingDepth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;90;-658.8153,1344.555;Float;False;Constant;_Color1;Color 1;10;0;Create;True;0;0;False;0;0,0.6943891,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;53;284.9265,-70.4575;Float;False;Constant;_Color0;Color 0;8;0;Create;True;0;0;False;0;0,1,0.7765689,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;-193.2229,1199.66;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;92;-1572.839,2187.284;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;18;-2492.107,-903.4026;Float;False;48;NormalDotLight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;21;-2082.831,-530.6293;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;71.69864,901.5442;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;136.6031,-643.176;Float;False;BaseColour;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;26;-1633.999,-458.2797;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-2162.912,-836.4104;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-632.1401,-233.3475;Float;False;OutlineWidth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-1851.58,-457.4286;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightPos;23;-2410.564,-392.2412;Float;False;0;3;FLOAT4;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.CustomExpressionNode;54;-1806.816,1483.824;Float;False;     float2 g = floor(UV * CellDensity)@$    float2 f = frac(UV * CellDensity)@$    float t = 8.0@$    float3 res = float3(8.0, 0.0, 0.0)@$    float r = 0.0@$    for(int y=-1@ y<=1@ y++)$    {$        for(int x=-1@ x<=1@ x++)$        {$            float2 lattice = float2(x,y)@$            float2 iUV = lattice + g@$         $            float2x2 m = float2x2(15.27, 47.63, 99.41, 89.98)@$            iUV = frac(sin(mul(iUV, m)) * 46839.32)@$            float2 offset = float2(sin(iUV.y*+AngleOffset)*0.5+0.5, cos(iUV.x*AngleOffset)*0.5+0.5)@$            float d = distance(lattice + offset, f)@$            if(d < res.x)$            {$                res = float3(d, offset.x, offset.y)@$                r = res.x@$                Cells = res.y@$            }$        }$    }$    return r@$;7;False;4;True;UV;FLOAT2;5,5;In;;Float;False;True;AngleOffset;FLOAT;0;In;;Float;False;True;CellDensity;FLOAT;0;In;;Float;False;True;Cells;FLOAT;0;Out;;Float;False;My Custom Expression;False;False;0;5;0;FLOAT;0;False;1;FLOAT2;5,5;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;2;FLOAT;0;FLOAT;5
Node;AmplifyShaderEditor.LerpOp;29;-1277.82,-521.7454;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;47;-3669.37,-643.9521;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;99;-1552.604,2447.691;Float;False;Constant;_Noise2Speed;Noise 2 Speed;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;97;-1095.719,2009.964;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;65;-161.9494,347.0849;Half;True;Constant;_UV;UV;8;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.NoiseGeneratorNode;1;-750.9893,1037.182;Float;True;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;42;-3907.481,-103.8875;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;35;-4121.127,-1235.371;Float;False;Property;_Float1;Float 1;12;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;101;-1569.183,2084.914;Float;False;Constant;_Noise1Scale;Noise 1 Scale;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;40;-3043.945,-1256.133;Float;False;NewNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;76;-383.3561,538.3539;Float;True;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-1135.467,-946.0347;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-136.1412,-662.1956;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;73;-757.0687,765.725;Float;True;Property;_TextureSample1;Texture Sample 1;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;17;-2508.86,-803.6898;Float;False;Property;_CellOffset;Cell Offset;6;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;117;-1243.06,1406.564;Float;True;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;16;-1039.545,-417.6136;Float;True;Property;_ColorRGBOutlineWidthA;Color (RGB) Outline Width (A);9;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;102;-1311.428,2432.243;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;107;-403.041,2139.229;Float;True;Property;_TextureSample3;Texture Sample 3;15;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;28;-1778.842,-300.0698;Float;False;Property;_ShadowContribution;Shadow Contribution;7;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;-3974.603,-683.7509;Float;False;40;NewNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;98;-1567.355,1988.027;Float;False;Constant;_Noise1Speed;Noise 1 Speed;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-2203.581,-697.6129;Float;False;Property;_CellSharpness;Cell Sharpness;8;0;Create;True;0;0;False;0;0.01;0;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;36;-3788.52,-1263.88;Float;True;Property;_TextureSample0;Texture Sample 0;11;2;[Normal];[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;45;-3993.662,-568.5175;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ScaleAndOffsetNode;11;-568.6849,-626.7224;Float;False;3;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LinearDepthNode;72;-371.0243,809.549;Float;False;0;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;106;-543.2006,2320.807;Float;True;Property;_TextureSample2;Texture Sample 2;14;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;44;-3544.501,-41.25959;Float;False;LightColourFalloff;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;22;-1883.69,-814.7072;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;48;-3451.011,-640.6364;Float;False;NormalDotLight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;126;-2232.819,1204.233;Float;False;Constant;_Color2;Color 2;10;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-1526.821,-710.1117;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;123;-2884.162,1499.283;Float;False;Constant;_Float2;Float 2;8;0;Create;True;0;0;False;0;65.22753;0;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-1120.609,-708.7878;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-3411.782,1769.987;Float;False;Constant;_Float0;Float 0;9;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;128;-2375.231,1513.507;Float;True;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;121;-3253.316,1762.713;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-1313.257,2295.139;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;100;-1558.214,2329.872;Float;False;Constant;_Noise2Scale;Noise 2 Scale;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;103;-1083.105,2373.691;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LightColorNode;30;-1521.371,-927.5333;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.ComponentMaskNode;9;-374.3284,-433.048;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;24;-1709.932,-848.4591;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;79;-1624.628,1079.904;Float;True;2;0;COLOR;0,0,0,0;False;1;COLOR;4.005236,4.005236,4.005236,1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;124;-2778.368,1743.659;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;125;-2615.056,1628.343;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;132;-2998.936,1340.406;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;130;-3373.934,1299.348;Float;False;Property;_Vector3;Vector 3;3;0;Create;True;0;0;False;0;100,100;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;129;-3363.204,1461.096;Float;False;Property;_Vector2;Vector 2;1;0;Create;True;0;0;False;0;10,10;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;118;-3057.011,869.9512;Float;False;Property;_Vector0;Vector 0;4;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;131;-3164.265,1391.163;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SinOpNode;122;-3022.793,1747.433;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;127;-3038.159,1564.122;Float;False;Property;_Vector1;Vector 1;5;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-3719.186,-37.7266;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;93;-1313.256,2117.819;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-1346.206,824.7691;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;78;0;69;0
WireConnection;70;0;67;0
WireConnection;70;1;3;0
WireConnection;57;0;78;0
WireConnection;4;0;70;0
WireConnection;4;1;70;0
WireConnection;71;0;4;0
WireConnection;71;1;57;0
WireConnection;5;0;71;0
WireConnection;5;1;56;0
WireConnection;5;2;6;0
WireConnection;108;0;5;0
WireConnection;112;0;84;0
WireConnection;112;1;108;0
WireConnection;105;1;98;0
WireConnection;89;0;54;0
WireConnection;89;1;81;0
WireConnection;38;0;37;0
WireConnection;10;0;31;0
WireConnection;10;1;32;0
WireConnection;37;0;36;0
WireConnection;8;0;16;0
WireConnection;8;1;15;0
WireConnection;75;0;72;0
WireConnection;83;0;1;0
WireConnection;14;0;12;0
WireConnection;26;0;25;0
WireConnection;19;0;18;0
WireConnection;19;1;17;0
WireConnection;13;0;16;4
WireConnection;25;0;21;0
WireConnection;25;1;23;2
WireConnection;29;0;26;0
WireConnection;29;1;27;0
WireConnection;29;2;28;0
WireConnection;47;0;46;0
WireConnection;47;1;45;0
WireConnection;97;0;93;0
WireConnection;97;2;105;0
WireConnection;40;0;38;0
WireConnection;31;1;30;2
WireConnection;31;2;26;0
WireConnection;12;0;10;0
WireConnection;12;1;9;0
WireConnection;12;2;11;0
WireConnection;102;1;99;0
WireConnection;36;5;35;0
WireConnection;11;0;16;0
WireConnection;72;0;73;0
WireConnection;44;0;43;0
WireConnection;22;0;19;0
WireConnection;22;1;20;0
WireConnection;48;0;47;0
WireConnection;27;0;24;0
WireConnection;32;0;30;1
WireConnection;32;1;29;0
WireConnection;128;0;125;0
WireConnection;121;0;120;0
WireConnection;94;0;92;0
WireConnection;94;1;100;0
WireConnection;103;0;94;0
WireConnection;103;2;102;0
WireConnection;9;0;8;0
WireConnection;24;0;22;0
WireConnection;79;0;112;0
WireConnection;124;0;132;0
WireConnection;124;1;122;0
WireConnection;125;0;124;0
WireConnection;125;1;123;0
WireConnection;132;0;131;0
WireConnection;132;1;131;0
WireConnection;131;0;130;0
WireConnection;131;1;129;0
WireConnection;122;0;121;0
WireConnection;43;0;42;1
WireConnection;93;0;101;0
WireConnection;93;1;92;0
WireConnection;0;0;79;0
ASEEND*/
//CHKSM=D4AF9432C5BF9A6F0ABD0CEA76FCD05204D549B5