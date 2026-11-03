Shader "Cross Platform Shaders/HeatDistort_3.0" {
Properties {
 _BumpAmt ("Distortion", Range(0,128)) = 10
 _MainTex ("Tint Color (RGB)", 2D) = "white" {}
 _BumpMap ("Normalmap", 2D) = "bump" {}
}
SubShader { 
 Tags { "QUEUE"="Overlay" "RenderType"="Overlay" }
 GrabPass {
  Name "BASE"
  Tags { "LIGHTMODE"="Always" }
 }
 Pass {
  Name "BASE"
  Tags { "LIGHTMODE"="Always" "QUEUE"="Overlay" "RenderType"="Overlay" }
  Fog { Mode Off }
Program "vp" {
// Platform d3d11 had shader errors
//   <no keywords>
// Platform d3d11_9x had shader errors
//   <no keywords>
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
PARAM c[13] = { { 0, 0.5 },
		state.matrix.mvp,
		state.matrix.texture[1],
		state.matrix.texture[2] };
TEMP R0;
TEMP R1;
DP4 R1.z, vertex.position, c[4];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MOV R0.w, R1.z;
DP4 R0.z, vertex.position, c[3];
MOV R0.x, R1;
MOV R0.y, R1;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
ADD R1.xy, R1.z, R1;
MOV R0.zw, c[0].x;
MOV R0.xy, vertex.texcoord[0];
DP4 result.texcoord[1].y, R0, c[6];
DP4 result.texcoord[1].x, R0, c[5];
DP4 result.texcoord[2].y, R0, c[10];
DP4 result.texcoord[2].x, R0, c[9];
MUL result.texcoord[0].xy, R1, c[0].y;
END
# 17 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [glstate_matrix_texture1]
Matrix 8 [glstate_matrix_texture2]
"vs_2_0
def c12, 0.50000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.z, v0, c3
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mov r0.y, r1
mov r0.w, r1.z
dp4 r0.z, v0, c2
mov r0.x, r1
mov oPos, r0
mov oT0.zw, r0
mov r1.y, -r1
add r1.xy, r1.z, r1
mov r0.zw, c12.y
mov r0.xy, v1
dp4 oT1.y, r0, c5
dp4 oT1.x, r0, c4
dp4 oT2.y, r0, c9
dp4 oT2.x, r0, c8
mul oT0.xy, r1, c12.x
"
}
}
Program "fp" {
// Platform d3d11 skipped due to earlier errors
// Platform d3d11_9x skipped due to earlier errors
// Platform d3d11 had shader errors
//   <no keywords>
// Platform d3d11_9x had shader errors
//   <no keywords>
SubProgram "opengl " {
Vector 0 [_GrabTexture_TexelSize]
Float 1 [_BumpAmt]
SetTexture 0 [_GrabTexture] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
OPTION ARB_fog_exp2;
PARAM c[3] = { program.local[0..1],
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[1], texture[1], 2D;
TEX R1, fragment.texcoord[2], texture[2], 2D;
MAD R0.xy, R0.wyzw, c[2].x, -c[2].y;
MUL R0.xy, R0, c[1].x;
MUL R0.xy, R0, c[0];
MAD R0.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
MOV R0.z, fragment.texcoord[0].w;
TXP R0, R0.xyzz, texture[0], 2D;
MUL result.color, R0, R1;
END
# 9 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_GrabTexture_TexelSize]
Float 1 [_BumpAmt]
SetTexture 0 [_GrabTexture] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s1
dcl_2d s0
dcl_2d s2
def c2, 2.00000000, -1.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s1
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c1.x
mul r0.xy, r0, c0
mad r1.xy, r0, t0.z, t0
mov r1.w, t0
texld r0, t2, s2
texldp r1, r1, s0
mul_pp r0, r1, r0
mov_pp oC0, r0
"
}
}
 }
}
SubShader { 
 Tags { "QUEUE"="Overlay" "RenderType"="Overlay" }
 Pass {
  Name "BASE"
  Tags { "QUEUE"="Overlay" "RenderType"="Overlay" }
  Fog { Mode Off }
  Blend DstColor Zero
  SetTexture [_MainTex] { combine texture }
 }
}
}