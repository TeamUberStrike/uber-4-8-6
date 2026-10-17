Shader "LoadingShader" {
SubShader { 
 Tags { "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
Program "vp" {
// Platform d3d11 had shader errors
//   Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
//   Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
//   Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
//   Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Vector 22 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[20];
DP4 R3.y, R1, c[19];
DP4 R3.x, R1, c[18];
ADD R2.xyz, R2, R3;
MAD R0.x, R0, R0, -R0.y;
MUL R3.xyz, R0.x, c[21];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
ADD result.texcoord[3].xyz, R2, R3;
MOV R0.xyz, c[13];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[22].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[14];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
DP4 result.texcoord[0].z, vertex.position, c[7];
DP4 result.texcoord[0].y, vertex.position, c[6];
DP4 result.texcoord[0].x, vertex.position, c[5];
END
# 45 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Vector 21 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mul r1.xyz, v2, c21.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c22.x
dp4 r2.z, r0, c16
dp4 r2.y, r0, c15
dp4 r2.x, r0, c14
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c19
dp4 r3.y, r1, c18
dp4 r3.x, r1, c17
add r1.xyz, r2, r3
mad r0.x, r0, r0, -r0.y
mul r2.xyz, r0.x, c20
add o4.xyz, r1, r2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
mov r1.w, c22.x
mov r1.xyz, c12
dp4 r4.y, c13, r0
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c21.w, -v0
mov r1, c8
dp4 r4.x, c13, r1
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
"3.0-!!ARBvp1.0
PARAM c[17] = { { 1 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[13];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[15].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
MAD result.texcoord[2].xy, vertex.texcoord[1], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
DP4 result.texcoord[0].z, vertex.position, c[7];
DP4 result.texcoord[0].y, vertex.position, c[6];
DP4 result.texcoord[0].x, vertex.position, c[5];
END
# 21 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [unity_Scale]
Vector 14 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c15, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord1 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
mov r0.xyz, c12
mov r0.w, c15.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c13.w, -v0
dp3 o2.y, r0, r1
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
mad o3.xy, v3, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
"3.0-!!ARBvp1.0
PARAM c[17] = { { 1 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[13];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[15].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
MAD result.texcoord[2].xy, vertex.texcoord[1], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
DP4 result.texcoord[0].z, vertex.position, c[7];
DP4 result.texcoord[0].y, vertex.position, c[6];
DP4 result.texcoord[0].x, vertex.position, c[5];
END
# 21 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [unity_Scale]
Vector 14 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c15, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord1 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
mov r0.xyz, c12
mov r0.w, c15.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c13.w, -v0
dp3 o2.y, r0, r1
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
mad o3.xy, v3, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[24] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[23].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[18];
DP4 R2.y, R0, c[17];
DP4 R2.x, R0, c[16];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[21];
DP4 R3.y, R1, c[20];
DP4 R3.x, R1, c[19];
ADD R2.xyz, R2, R3;
MAD R0.x, R0, R0, -R0.y;
MUL R3.xyz, R0.x, c[22];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
ADD result.texcoord[3].xyz, R2, R3;
MOV R0.w, c[0].x;
MOV R0.xyz, c[13];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[23].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[15];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
DP4 result.texcoord[0].z, vertex.position, c[7];
DP4 result.texcoord[0].y, vertex.position, c[6];
DP4 result.texcoord[0].x, vertex.position, c[5];
END
# 50 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c24, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mul r1.xyz, v2, c23.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c24.x
dp4 r2.z, r0, c18
dp4 r2.y, r0, c17
dp4 r2.x, r0, c16
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c21
dp4 r3.y, r1, c20
dp4 r3.x, r1, c19
add r1.xyz, r2, r3
mad r0.x, r0, r0, -r0.y
mul r2.xyz, r0.x, c22
add o4.xyz, r1, r2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mov r1.w, c24.x
mov r1.xyz, c12
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c23.w, -v0
mov r1, c8
dp4 r4.x, c15, r1
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c24.y
mul r1.y, r1, c13.x
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
mad o5.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o5.zw, r0
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 16 [unity_Scale]
Vector 17 [unity_LightmapST]
"3.0-!!ARBvp1.0
PARAM c[18] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[16].w, -vertex.position;
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[17], c[17].zwzw;
DP4 result.texcoord[0].z, vertex.position, c[7];
DP4 result.texcoord[0].y, vertex.position, c[6];
DP4 result.texcoord[0].x, vertex.position, c[5];
END
# 26 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c17, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord1 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c12
mov r1.w, c17.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c17.y
mul r1.y, r1, c13.x
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mad o4.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o4.zw, r0
mad o3.xy, v3, c16, c16.zwzw
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 16 [unity_Scale]
Vector 17 [unity_LightmapST]
"3.0-!!ARBvp1.0
PARAM c[18] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[16].w, -vertex.position;
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[17], c[17].zwzw;
DP4 result.texcoord[0].z, vertex.position, c[7];
DP4 result.texcoord[0].y, vertex.position, c[6];
DP4 result.texcoord[0].x, vertex.position, c[5];
END
# 26 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c17, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord1 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c12
mov r1.w, c17.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c17.y
mul r1.y, r1, c13.x
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mad o4.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o4.zw, r0
mad o3.xy, v3, c16, c16.zwzw
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Vector 30 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[31] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..30] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.xyz, vertex.normal, c[30].w;
DP4 R4.zw, vertex.position, c[6];
ADD R2, -R4.z, c[16];
DP3 R4.z, R3, c[6];
DP3 R5.x, R3, c[5];
DP3 R3.x, R3, c[7];
DP4 R3.w, vertex.position, c[5];
MUL R0, R4.z, R2;
ADD R1, -R3.w, c[15];
MUL R2, R2, R2;
MOV R5.z, R3.x;
MOV R5.y, R4.z;
MOV R5.w, c[0].x;
MAD R0, R5.x, R1, R0;
DP4 R4.xy, vertex.position, c[7];
MAD R2, R1, R1, R2;
ADD R1, -R4.x, c[17];
MAD R2, R1, R1, R2;
MAD R0, R3.x, R1, R0;
MUL R1, R2, c[18];
ADD R1, R1, c[0].x;
RSQ R2.x, R2.x;
RSQ R2.y, R2.y;
RSQ R2.z, R2.z;
RSQ R2.w, R2.w;
MUL R0, R0, R2;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[20];
MAD R1.xyz, R0.x, c[19], R1;
MAD R0.xyz, R0.z, c[21], R1;
MAD R1.xyz, R0.w, c[22], R0;
MUL R0, R5.xyzz, R5.yzzx;
DP4 R3.z, R0, c[28];
DP4 R3.y, R0, c[27];
DP4 R3.x, R0, c[26];
MUL R1.w, R4.z, R4.z;
MAD R0.x, R5, R5, -R1.w;
MOV R1.w, c[0].x;
DP4 R2.z, R5, c[25];
DP4 R2.y, R5, c[24];
DP4 R2.x, R5, c[23];
ADD R2.xyz, R2, R3;
MUL R3.xyz, R0.x, c[29];
ADD R3.xyz, R2, R3;
ADD result.texcoord[3].xyz, R3, R1;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R1.xyz, c[13];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R1.xyz, R2, c[30].w, -vertex.position;
MUL R2.xyz, R0, vertex.attrib[14].w;
MOV R0, c[14];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
DP4 R3.z, R0, c[11];
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
MOV R3.x, R4.w;
MOV R3.y, R4;
DP3 result.texcoord[1].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R1;
DP3 result.texcoord[1].x, R1, vertex.attrib[14];
MOV result.texcoord[0].xyz, R3.wxyw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 76 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 17 [unity_4LightAtten0]
Vector 18 [unity_LightColor0]
Vector 19 [unity_LightColor1]
Vector 20 [unity_LightColor2]
Vector 21 [unity_LightColor3]
Vector 22 [unity_SHAr]
Vector 23 [unity_SHAg]
Vector 24 [unity_SHAb]
Vector 25 [unity_SHBr]
Vector 26 [unity_SHBg]
Vector 27 [unity_SHBb]
Vector 28 [unity_SHC]
Vector 29 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c30, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mul r3.xyz, v2, c29.w
dp4 r4.zw, v0, c5
add r2, -r4.z, c15
dp3 r4.z, r3, c5
dp3 r5.x, r3, c4
dp3 r3.x, r3, c6
dp4 r3.w, v0, c4
mul r0, r4.z, r2
add r1, -r3.w, c14
mul r2, r2, r2
mov r5.z, r3.x
mov r5.y, r4.z
mad r0, r5.x, r1, r0
mov r5.w, c30.x
dp4 r4.xy, v0, c6
mad r2, r1, r1, r2
add r1, -r4.x, c16
mad r2, r1, r1, r2
mad r0, r3.x, r1, r0
mul r1, r2, c17
add r1, r1, c30.x
rsq r2.x, r2.x
rsq r2.y, r2.y
rsq r2.z, r2.z
rsq r2.w, r2.w
mul r0, r0, r2
dp4 r2.z, r5, c24
dp4 r2.y, r5, c23
dp4 r2.x, r5, c22
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c30.y
mul r0, r0, r1
mul r1.xyz, r0.y, c19
mad r1.xyz, r0.x, c18, r1
mad r0.xyz, r0.z, c20, r1
mad r1.xyz, r0.w, c21, r0
mul r0, r5.xyzz, r5.yzzx
mul r1.w, r4.z, r4.z
dp4 r3.z, r0, c27
dp4 r3.y, r0, c26
dp4 r3.x, r0, c25
mad r1.w, r5.x, r5.x, -r1
mul r0.xyz, r1.w, c28
add r2.xyz, r2, r3
add r2.xyz, r2, r0
add o4.xyz, r2, r1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r5.z, c13, r0
mov r0, c9
mov r1.w, c30.x
mov r1.xyz, c12
dp4 r5.y, c13, r0
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c29.w, -v0
mov r1, c8
dp4 r5.x, c13, r1
dp3 o2.y, r2, r3
dp3 o3.y, r3, r5
mov r3.x, r4.w
mov r3.y, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r5
dp3 o3.x, v1, r5
mov o1.xyz, r3.wxyw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Vector 31 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[32] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..31] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.xyz, vertex.normal, c[31].w;
DP4 R4.zw, vertex.position, c[6];
ADD R2, -R4.z, c[17];
DP3 R4.z, R3, c[6];
DP3 R5.x, R3, c[5];
DP3 R3.x, R3, c[7];
DP4 R3.w, vertex.position, c[5];
MUL R0, R4.z, R2;
ADD R1, -R3.w, c[16];
MUL R2, R2, R2;
MOV R5.z, R3.x;
MOV R5.y, R4.z;
MOV R5.w, c[0].x;
MAD R0, R5.x, R1, R0;
DP4 R4.xy, vertex.position, c[7];
MAD R2, R1, R1, R2;
ADD R1, -R4.x, c[18];
MAD R2, R1, R1, R2;
MAD R0, R3.x, R1, R0;
MUL R1, R2, c[19];
ADD R1, R1, c[0].x;
RSQ R2.x, R2.x;
RSQ R2.y, R2.y;
RSQ R2.z, R2.z;
RSQ R2.w, R2.w;
MUL R0, R0, R2;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[21];
MAD R1.xyz, R0.x, c[20], R1;
MAD R0.xyz, R0.z, c[22], R1;
MAD R1.xyz, R0.w, c[23], R0;
MUL R0, R5.xyzz, R5.yzzx;
DP4 R3.z, R0, c[29];
DP4 R3.y, R0, c[28];
DP4 R3.x, R0, c[27];
MUL R1.w, R4.z, R4.z;
MAD R0.x, R5, R5, -R1.w;
MOV R1.w, c[0].x;
DP4 R2.z, R5, c[26];
DP4 R2.y, R5, c[25];
DP4 R2.x, R5, c[24];
ADD R2.xyz, R2, R3;
MUL R3.xyz, R0.x, c[30];
ADD R3.xyz, R2, R3;
ADD result.texcoord[3].xyz, R3, R1;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R1.xyz, c[13];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R1.xyz, R2, c[31].w, -vertex.position;
MUL R2.xyz, R0, vertex.attrib[14].w;
MOV R0, c[15];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
DP4 R3.z, R0, c[11];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
DP3 result.texcoord[1].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R1;
DP3 result.texcoord[1].x, R1, vertex.attrib[14];
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[14].x;
MOV R3.x, R4.w;
MOV R3.y, R4;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MOV result.texcoord[0].xyz, R3.wxyw;
END
# 81 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Vector 31 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c32, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mul r3.xyz, v2, c31.w
dp4 r4.zw, v0, c5
add r2, -r4.z, c17
dp3 r4.z, r3, c5
dp3 r5.x, r3, c4
dp3 r3.x, r3, c6
dp4 r3.w, v0, c4
mul r0, r4.z, r2
add r1, -r3.w, c16
mul r2, r2, r2
mov r5.z, r3.x
mov r5.y, r4.z
mad r0, r5.x, r1, r0
mov r5.w, c32.x
dp4 r4.xy, v0, c6
mad r2, r1, r1, r2
add r1, -r4.x, c18
mad r2, r1, r1, r2
mad r0, r3.x, r1, r0
mul r1, r2, c19
add r1, r1, c32.x
rsq r2.x, r2.x
rsq r2.y, r2.y
rsq r2.z, r2.z
rsq r2.w, r2.w
mul r0, r0, r2
dp4 r2.z, r5, c26
dp4 r2.y, r5, c25
dp4 r2.x, r5, c24
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c32.y
mul r0, r0, r1
mul r1.xyz, r0.y, c21
mad r1.xyz, r0.x, c20, r1
mad r0.xyz, r0.z, c22, r1
mad r1.xyz, r0.w, c23, r0
mul r0, r5.xyzz, r5.yzzx
mul r1.w, r4.z, r4.z
dp4 r3.z, r0, c29
dp4 r3.y, r0, c28
dp4 r3.x, r0, c27
mad r1.w, r5.x, r5.x, -r1
mul r0.xyz, r1.w, c30
add r2.xyz, r2, r3
add r2.xyz, r2, r0
add o4.xyz, r2, r1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r5.z, c15, r0
mov r0, c9
dp4 r5.y, c15, r0
mov r1.w, c32.x
mov r1.xyz, c12
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c31.w, -v0
mov r1, c8
dp4 r5.x, c15, r1
dp3 o2.y, r2, r3
dp3 o3.y, r3, r5
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c32.z
mul r1.y, r1, c13.x
mov r3.x, r4.w
mov r3.y, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r5
dp3 o3.x, v1, r5
mad o5.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o5.zw, r0
mov o1.xyz, r3.wxyw
"
}
}
Program "fp" {
// Platform d3d11 skipped due to earlier errors
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..4],
		{ 0.42745, 1, 0, 23.333 },
		{ 0.15000001, 0.85000002, 0.075000003, 8 },
		{ 0.5, 5 } };
TEMP R0;
TEMP R1;
MOV R1.xyz, fragment.texcoord[0];
MOV R1.w, c[5].y;
DP4 R0.z, R1, c[2];
DP4 R0.x, R1, c[0];
DP4 R0.y, R1, c[1];
MUL R0.xyz, R0, c[6].w;
MOV R0.w, c[7].x;
MAD R0.z, R0.w, c[4], R0;
FRC R0.y, R0;
FRC R0.x, R0;
FRC R0.z, R0;
SGE R0.y, c[6].z, R0;
SGE R0.x, c[6].z, R0;
MAX R0.w, R0.x, R0.y;
SGE R0.y, c[6].z, R0.z;
MUL R1.x, R0.y, c[7].y;
MAX R0.w, R0, R1.x;
MOV R0.x, c[5].w;
MUL R0.xyz, R0.x, c[4];
SIN R0.x, R0.x;
SIN R0.z, R0.z;
SIN R0.y, R0.y;
MAD_SAT R0.xyz, R0, c[6].x, c[6].y;
MUL R0.xyz, R0, R0.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.w, R1.x;
MAD R0.xyz, -R0.w, fragment.texcoord[1].z, R0;
ADD R0.xyz, R0, c[5].y;
MUL result.color.xyz, R0, c[5];
MOV result.color.w, c[5].y;
END
# 30 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"ps_3_0
def c5, 23.33300018, 0.15915491, 0.50000000, 8.00000000
def c6, 6.28318501, -3.14159298, 1.00000000, 0.00000000
def c7, 0.07500000, 5.00000000, 0.00000000, 0
def c8, 0.15000001, 0.85000002, 0, 0
def c9, 0.42745000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
mov r1.w, c6.z
mov r1.xyz, v0
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r0.xyz, r0, c5.w
frc r0.y, r0
frc r0.x, r0
add r0.y, -r0, c7.x
add r0.x, -r0, c7
mov r1.xyz, c4
mul r1.xyz, c5.x, r1
cmp r0.y, r0, c6.z, c6.w
cmp r0.x, r0, c6.z, c6.w
max r1.w, r0.x, r0.y
mov r0.x, c4.z
mad r0.y, c5.z, r0.x, r0.z
mad r0.x, r1, c5.y, c5.z
frc r0.x, r0
frc r0.y, r0
add r0.y, -r0, c7.x
cmp r2.x, r0.y, c7.y, c7.z
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c5.y, c5
frc r0.y, r0.z
mad r0.x, r1.y, c5.y, c5.z
max r2.x, r1.w, r2
mad r0.y, r0, c6.x, c6
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.z, r1.y
mad_sat r1.xyz, r0, c8.x, c8.y
dp3 r0.x, v1, v1
mul r1.xyz, r1, r2.x
rsq r0.x, r0.x
mad r0.xyz, -r0.x, v1.z, r1
add r0.xyz, r0, c6.z
mul oC0.xyz, r0, c9
mov_pp oC0.w, c6.z
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..4],
		{ 0.42745, 1, 0, 23.333 },
		{ 0.15000001, 0.85000002, 0.075000003, 8 },
		{ 0.5, 5 } };
TEMP R0;
TEMP R1;
MOV R1.xyz, fragment.texcoord[0];
MOV R1.w, c[5].y;
DP4 R0.z, R1, c[2];
DP4 R0.x, R1, c[0];
DP4 R0.y, R1, c[1];
MUL R0.xyz, R0, c[6].w;
MOV R0.w, c[7].x;
MAD R0.z, R0.w, c[4], R0;
FRC R0.y, R0;
FRC R0.x, R0;
FRC R0.z, R0;
SGE R0.y, c[6].z, R0;
SGE R0.x, c[6].z, R0;
MAX R0.w, R0.x, R0.y;
SGE R0.y, c[6].z, R0.z;
MUL R1.x, R0.y, c[7].y;
MAX R0.w, R0, R1.x;
MOV R0.x, c[5].w;
MUL R0.xyz, R0.x, c[4];
SIN R0.x, R0.x;
SIN R0.z, R0.z;
SIN R0.y, R0.y;
MAD_SAT R0.xyz, R0, c[6].x, c[6].y;
MUL R0.xyz, R0, R0.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.w, R1.x;
MAD R0.xyz, -R0.w, fragment.texcoord[1].z, R0;
ADD R0.xyz, R0, c[5].y;
MUL result.color.xyz, R0, c[5];
MOV result.color.w, c[5].y;
END
# 30 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"ps_3_0
def c5, 23.33300018, 0.15915491, 0.50000000, 8.00000000
def c6, 6.28318501, -3.14159298, 1.00000000, 0.00000000
def c7, 0.07500000, 5.00000000, 0.00000000, 0
def c8, 0.15000001, 0.85000002, 0, 0
def c9, 0.42745000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
mov r1.w, c6.z
mov r1.xyz, v0
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r0.xyz, r0, c5.w
frc r0.y, r0
frc r0.x, r0
add r0.y, -r0, c7.x
add r0.x, -r0, c7
mov r1.xyz, c4
mul r1.xyz, c5.x, r1
cmp r0.y, r0, c6.z, c6.w
cmp r0.x, r0, c6.z, c6.w
max r1.w, r0.x, r0.y
mov r0.x, c4.z
mad r0.y, c5.z, r0.x, r0.z
mad r0.x, r1, c5.y, c5.z
frc r0.x, r0
frc r0.y, r0
add r0.y, -r0, c7.x
cmp r2.x, r0.y, c7.y, c7.z
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c5.y, c5
frc r0.y, r0.z
mad r0.x, r1.y, c5.y, c5.z
max r2.x, r1.w, r2
mad r0.y, r0, c6.x, c6
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.z, r1.y
mad_sat r1.xyz, r0, c8.x, c8.y
dp3 r0.x, v1, v1
mul r1.xyz, r1, r2.x
rsq r0.x, r0.x
mad r0.xyz, -r0.x, v1.z, r1
add r0.xyz, r0, c6.z
mul oC0.xyz, r0, c9
mov_pp oC0.w, c6.z
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..4],
		{ 0.42745, 1, 0, 23.333 },
		{ 0.15000001, 0.85000002, 0.075000003, 8 },
		{ 0.5, 5 } };
TEMP R0;
TEMP R1;
MOV R1.xyz, fragment.texcoord[0];
MOV R1.w, c[5].y;
DP4 R0.z, R1, c[2];
DP4 R0.x, R1, c[0];
DP4 R0.y, R1, c[1];
MUL R0.xyz, R0, c[6].w;
MOV R0.w, c[7].x;
MAD R0.z, R0.w, c[4], R0;
FRC R0.y, R0;
FRC R0.x, R0;
FRC R0.z, R0;
SGE R0.y, c[6].z, R0;
SGE R0.x, c[6].z, R0;
MAX R0.w, R0.x, R0.y;
SGE R0.y, c[6].z, R0.z;
MUL R1.x, R0.y, c[7].y;
MAX R0.w, R0, R1.x;
MOV R0.x, c[5].w;
MUL R0.xyz, R0.x, c[4];
SIN R0.x, R0.x;
SIN R0.z, R0.z;
SIN R0.y, R0.y;
MAD_SAT R0.xyz, R0, c[6].x, c[6].y;
MUL R0.xyz, R0, R0.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.w, R1.x;
MAD R0.xyz, -R0.w, fragment.texcoord[1].z, R0;
ADD R0.xyz, R0, c[5].y;
MUL result.color.xyz, R0, c[5];
MOV result.color.w, c[5].y;
END
# 30 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"ps_3_0
def c5, 23.33300018, 0.15915491, 0.50000000, 8.00000000
def c6, 6.28318501, -3.14159298, 1.00000000, 0.00000000
def c7, 0.07500000, 5.00000000, 0.00000000, 0
def c8, 0.15000001, 0.85000002, 0, 0
def c9, 0.42745000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
mov r1.w, c6.z
mov r1.xyz, v0
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r0.xyz, r0, c5.w
frc r0.y, r0
frc r0.x, r0
add r0.y, -r0, c7.x
add r0.x, -r0, c7
mov r1.xyz, c4
mul r1.xyz, c5.x, r1
cmp r0.y, r0, c6.z, c6.w
cmp r0.x, r0, c6.z, c6.w
max r1.w, r0.x, r0.y
mov r0.x, c4.z
mad r0.y, c5.z, r0.x, r0.z
mad r0.x, r1, c5.y, c5.z
frc r0.x, r0
frc r0.y, r0
add r0.y, -r0, c7.x
cmp r2.x, r0.y, c7.y, c7.z
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c5.y, c5
frc r0.y, r0.z
mad r0.x, r1.y, c5.y, c5.z
max r2.x, r1.w, r2
mad r0.y, r0, c6.x, c6
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.z, r1.y
mad_sat r1.xyz, r0, c8.x, c8.y
dp3 r0.x, v1, v1
mul r1.xyz, r1, r2.x
rsq r0.x, r0.x
mad r0.xyz, -r0.x, v1.z, r1
add r0.xyz, r0, c6.z
mul oC0.xyz, r0, c9
mov_pp oC0.w, c6.z
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..4],
		{ 0.42745, 1, 0, 23.333 },
		{ 0.15000001, 0.85000002, 0.075000003, 8 },
		{ 0.5, 5 } };
TEMP R0;
TEMP R1;
MOV R1.xyz, fragment.texcoord[0];
MOV R1.w, c[5].y;
DP4 R0.z, R1, c[2];
DP4 R0.x, R1, c[0];
DP4 R0.y, R1, c[1];
MUL R0.xyz, R0, c[6].w;
MOV R0.w, c[7].x;
MAD R0.z, R0.w, c[4], R0;
FRC R0.y, R0;
FRC R0.x, R0;
FRC R0.z, R0;
SGE R0.y, c[6].z, R0;
SGE R0.x, c[6].z, R0;
MAX R0.w, R0.x, R0.y;
SGE R0.y, c[6].z, R0.z;
MUL R1.x, R0.y, c[7].y;
MAX R0.w, R0, R1.x;
MOV R0.x, c[5].w;
MUL R0.xyz, R0.x, c[4];
SIN R0.x, R0.x;
SIN R0.z, R0.z;
SIN R0.y, R0.y;
MAD_SAT R0.xyz, R0, c[6].x, c[6].y;
MUL R0.xyz, R0, R0.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.w, R1.x;
MAD R0.xyz, -R0.w, fragment.texcoord[1].z, R0;
ADD R0.xyz, R0, c[5].y;
MUL result.color.xyz, R0, c[5];
MOV result.color.w, c[5].y;
END
# 30 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"ps_3_0
def c5, 23.33300018, 0.15915491, 0.50000000, 8.00000000
def c6, 6.28318501, -3.14159298, 1.00000000, 0.00000000
def c7, 0.07500000, 5.00000000, 0.00000000, 0
def c8, 0.15000001, 0.85000002, 0, 0
def c9, 0.42745000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
mov r1.w, c6.z
mov r1.xyz, v0
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r0.xyz, r0, c5.w
frc r0.y, r0
frc r0.x, r0
add r0.y, -r0, c7.x
add r0.x, -r0, c7
mov r1.xyz, c4
mul r1.xyz, c5.x, r1
cmp r0.y, r0, c6.z, c6.w
cmp r0.x, r0, c6.z, c6.w
max r1.w, r0.x, r0.y
mov r0.x, c4.z
mad r0.y, c5.z, r0.x, r0.z
mad r0.x, r1, c5.y, c5.z
frc r0.x, r0
frc r0.y, r0
add r0.y, -r0, c7.x
cmp r2.x, r0.y, c7.y, c7.z
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c5.y, c5
frc r0.y, r0.z
mad r0.x, r1.y, c5.y, c5.z
max r2.x, r1.w, r2
mad r0.y, r0, c6.x, c6
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.z, r1.y
mad_sat r1.xyz, r0, c8.x, c8.y
dp3 r0.x, v1, v1
mul r1.xyz, r1, r2.x
rsq r0.x, r0.x
mad r0.xyz, -r0.x, v1.z, r1
add r0.xyz, r0, c6.z
mul oC0.xyz, r0, c9
mov_pp oC0.w, c6.z
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..4],
		{ 1, 0.42745, 0, 23.333 },
		{ 0.15000001, 0.85000002, 0.075000003, 8 },
		{ 0.5, 5 } };
TEMP R0;
TEMP R1;
MOV R1.xyz, fragment.texcoord[0];
MOV R1.w, c[5].x;
DP4 R0.z, R1, c[2];
DP4 R0.x, R1, c[0];
DP4 R0.y, R1, c[1];
MUL R0.xyz, R0, c[6].w;
MOV R0.w, c[7].x;
MAD R0.z, R0.w, c[4], R0;
FRC R0.y, R0;
FRC R0.x, R0;
FRC R0.z, R0;
SGE R0.y, c[6].z, R0;
SGE R0.x, c[6].z, R0;
MAX R0.w, R0.x, R0.y;
SGE R0.y, c[6].z, R0.z;
MUL R1.x, R0.y, c[7].y;
MAX R0.w, R0, R1.x;
MOV R0.x, c[5].w;
MUL R0.xyz, R0.x, c[4];
SIN R0.x, R0.x;
SIN R0.z, R0.z;
SIN R0.y, R0.y;
MAD_SAT R0.xyz, R0, c[6].x, c[6].y;
MUL R0.xyz, R0, R0.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.w, R1.x;
MAD R0.xyz, -R0.w, fragment.texcoord[1].z, R0;
ADD R0.xyz, R0, c[5].x;
MUL result.color.xyz, R0, c[5].yxzw;
MOV result.color.w, c[5].x;
END
# 30 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"ps_3_0
def c5, 23.33300018, 0.15915491, 0.50000000, 8.00000000
def c6, 6.28318501, -3.14159298, 1.00000000, 0.00000000
def c7, 0.07500000, 5.00000000, 0.00000000, 0
def c8, 0.15000001, 0.85000002, 0, 0
def c9, 0.42745000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
mov r1.w, c6.z
mov r1.xyz, v0
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r0.xyz, r0, c5.w
frc r0.y, r0
frc r0.x, r0
add r0.y, -r0, c7.x
add r0.x, -r0, c7
mov r1.xyz, c4
mul r1.xyz, c5.x, r1
cmp r0.y, r0, c6.z, c6.w
cmp r0.x, r0, c6.z, c6.w
max r1.w, r0.x, r0.y
mov r0.x, c4.z
mad r0.y, c5.z, r0.x, r0.z
mad r0.x, r1, c5.y, c5.z
frc r0.x, r0
frc r0.y, r0
add r0.y, -r0, c7.x
cmp r2.x, r0.y, c7.y, c7.z
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c5.y, c5
frc r0.y, r0.z
mad r0.x, r1.y, c5.y, c5.z
max r2.x, r1.w, r2
mad r0.y, r0, c6.x, c6
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.z, r1.y
mad_sat r1.xyz, r0, c8.x, c8.y
dp3 r0.x, v1, v1
mul r1.xyz, r1, r2.x
rsq r0.x, r0.x
mad r0.xyz, -r0.x, v1.z, r1
add r0.xyz, r0, c6.z
mul oC0.xyz, r0, c9
mov_pp oC0.w, c6.z
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..4],
		{ 1, 0.42745, 0, 23.333 },
		{ 0.15000001, 0.85000002, 0.075000003, 8 },
		{ 0.5, 5 } };
TEMP R0;
TEMP R1;
MOV R1.xyz, fragment.texcoord[0];
MOV R1.w, c[5].x;
DP4 R0.z, R1, c[2];
DP4 R0.x, R1, c[0];
DP4 R0.y, R1, c[1];
MUL R0.xyz, R0, c[6].w;
MOV R0.w, c[7].x;
MAD R0.z, R0.w, c[4], R0;
FRC R0.y, R0;
FRC R0.x, R0;
FRC R0.z, R0;
SGE R0.y, c[6].z, R0;
SGE R0.x, c[6].z, R0;
MAX R0.w, R0.x, R0.y;
SGE R0.y, c[6].z, R0.z;
MUL R1.x, R0.y, c[7].y;
MAX R0.w, R0, R1.x;
MOV R0.x, c[5].w;
MUL R0.xyz, R0.x, c[4];
SIN R0.x, R0.x;
SIN R0.z, R0.z;
SIN R0.y, R0.y;
MAD_SAT R0.xyz, R0, c[6].x, c[6].y;
MUL R0.xyz, R0, R0.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.w, R1.x;
MAD R0.xyz, -R0.w, fragment.texcoord[1].z, R0;
ADD R0.xyz, R0, c[5].x;
MUL result.color.xyz, R0, c[5].yxzw;
MOV result.color.w, c[5].x;
END
# 30 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"ps_3_0
def c5, 23.33300018, 0.15915491, 0.50000000, 8.00000000
def c6, 6.28318501, -3.14159298, 1.00000000, 0.00000000
def c7, 0.07500000, 5.00000000, 0.00000000, 0
def c8, 0.15000001, 0.85000002, 0, 0
def c9, 0.42745000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
mov r1.w, c6.z
mov r1.xyz, v0
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r0.xyz, r0, c5.w
frc r0.y, r0
frc r0.x, r0
add r0.y, -r0, c7.x
add r0.x, -r0, c7
mov r1.xyz, c4
mul r1.xyz, c5.x, r1
cmp r0.y, r0, c6.z, c6.w
cmp r0.x, r0, c6.z, c6.w
max r1.w, r0.x, r0.y
mov r0.x, c4.z
mad r0.y, c5.z, r0.x, r0.z
mad r0.x, r1, c5.y, c5.z
frc r0.x, r0
frc r0.y, r0
add r0.y, -r0, c7.x
cmp r2.x, r0.y, c7.y, c7.z
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c5.y, c5
frc r0.y, r0.z
mad r0.x, r1.y, c5.y, c5.z
max r2.x, r1.w, r2
mad r0.y, r0, c6.x, c6
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.z, r1.y
mad_sat r1.xyz, r0, c8.x, c8.y
dp3 r0.x, v1, v1
mul r1.xyz, r1, r2.x
rsq r0.x, r0.x
mad r0.xyz, -r0.x, v1.z, r1
add r0.xyz, r0, c6.z
mul oC0.xyz, r0, c9
mov_pp oC0.w, c6.z
"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
Program "vp" {
// Platform d3d11 had shader errors
//   Keywords { "POINT" }
//   Keywords { "DIRECTIONAL" }
//   Keywords { "SPOT" }
//   Keywords { "POINT_COOKIE" }
//   Keywords { "DIRECTIONAL_COOKIE" }
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[20] = { { 1 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP3 result.texcoord[0].y, R0, R1;
DP3 result.texcoord[0].z, vertex.normal, R0;
DP3 result.texcoord[0].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[1].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, vertex.attrib[14], R2;
DP4 result.texcoord[2].z, R0, c[15];
DP4 result.texcoord[2].y, R0, c[14];
DP4 result.texcoord[2].x, R0, c[13];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 32 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c19, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.w, c19.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp3 o1.y, r0, r2
dp3 o1.z, v2, r0
dp3 o1.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o2.y, r2, r3
dp3 o2.z, v2, r3
dp3 o2.x, v1, r3
dp4 o3.z, r0, c14
dp4 o3.y, r0, c13
dp4 o3.x, r0, c12
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Vector 11 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[12] = { { 1 },
		state.matrix.mvp,
		program.local[5..11] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[9];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[7];
DP4 R2.y, R1, c[6];
DP4 R2.x, R1, c[5];
MAD R2.xyz, R2, c[11].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[10];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[7];
DP4 R3.y, R0, c[6];
DP4 R3.x, R0, c[5];
DP3 result.texcoord[0].y, R3, R1;
DP3 result.texcoord[1].y, R1, R2;
DP3 result.texcoord[0].z, vertex.normal, R3;
DP3 result.texcoord[0].x, R3, vertex.attrib[14];
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, vertex.attrib[14], R2;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 24 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_WorldSpaceLightPos0]
Vector 10 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c11, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.w, c11.x
mov r0.xyz, c8
dp4 r1.z, r0, c6
dp4 r1.y, r0, c5
dp4 r1.x, r0, c4
mad r3.xyz, r1, c10.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c6
dp4 r4.z, c9, r0
mov r0, c5
mov r1, c4
dp4 r4.y, c9, r0
dp4 r4.x, c9, r1
dp3 o1.y, r4, r2
dp3 o2.y, r2, r3
dp3 o1.z, v2, r4
dp3 o1.x, r4, v1
dp3 o2.z, v2, r3
dp3 o2.x, v1, r3
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[20] = { { 1 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[0].y, R0, R1;
DP3 result.texcoord[0].z, vertex.normal, R0;
DP3 result.texcoord[0].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[1].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, vertex.attrib[14], R2;
DP4 result.texcoord[2].w, R0, c[16];
DP4 result.texcoord[2].z, R0, c[15];
DP4 result.texcoord[2].y, R0, c[14];
DP4 result.texcoord[2].x, R0, c[13];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 33 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c19, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.w, c19.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp4 r0.w, v0, c7
dp3 o1.y, r0, r2
dp3 o1.z, v2, r0
dp3 o1.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o2.y, r2, r3
dp3 o2.z, v2, r3
dp3 o2.x, v1, r3
dp4 o3.w, r0, c15
dp4 o3.z, r0, c14
dp4 o3.y, r0, c13
dp4 o3.x, r0, c12
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[20] = { { 1 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP3 result.texcoord[0].y, R0, R1;
DP3 result.texcoord[0].z, vertex.normal, R0;
DP3 result.texcoord[0].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[1].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, vertex.attrib[14], R2;
DP4 result.texcoord[2].z, R0, c[15];
DP4 result.texcoord[2].y, R0, c[14];
DP4 result.texcoord[2].x, R0, c[13];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 32 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c19, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.w, c19.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp3 o1.y, r0, r2
dp3 o1.z, v2, r0
dp3 o1.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o2.y, r2, r3
dp3 o2.z, v2, r3
dp3 o2.x, v1, r3
dp4 o3.z, r0, c14
dp4 o3.y, r0, c13
dp4 o3.x, r0, c12
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[20] = { { 1 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[0].y, R3, R1;
DP3 result.texcoord[1].y, R1, R2;
DP3 result.texcoord[0].z, vertex.normal, R3;
DP3 result.texcoord[0].x, R3, vertex.attrib[14];
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, vertex.attrib[14], R2;
DP4 result.texcoord[2].y, R0, c[14];
DP4 result.texcoord[2].x, R0, c[13];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 30 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c19, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.w, c19.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o1.y, r4, r2
dp3 o2.y, r2, r3
dp3 o1.z, v2, r4
dp3 o1.x, r4, v1
dp3 o2.z, v2, r3
dp3 o2.x, v1, r3
dp4 o3.y, r0, c13
dp4 o3.x, r0, c12
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
}
Program "fp" {
// Platform d3d11 skipped due to earlier errors
SubProgram "opengl " {
Keywords { "POINT" }
"3.0-!!ARBfp1.0
PARAM c[1] = { { 0 } };
MOV result.color, c[0].x;
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
"ps_3_0
def c0, 0.00000000, 0, 0, 0
mov_pp oC0, c0.x
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
"3.0-!!ARBfp1.0
PARAM c[1] = { { 0 } };
MOV result.color, c[0].x;
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
"ps_3_0
def c0, 0.00000000, 0, 0, 0
mov_pp oC0, c0.x
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
"3.0-!!ARBfp1.0
PARAM c[1] = { { 0 } };
MOV result.color, c[0].x;
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
"ps_3_0
def c0, 0.00000000, 0, 0, 0
mov_pp oC0, c0.x
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
"3.0-!!ARBfp1.0
PARAM c[1] = { { 0 } };
MOV result.color, c[0].x;
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
"ps_3_0
def c0, 0.00000000, 0, 0, 0
mov_pp oC0, c0.x
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
"3.0-!!ARBfp1.0
PARAM c[1] = { { 0 } };
MOV result.color, c[0].x;
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
"ps_3_0
def c0, 0.00000000, 0, 0, 0
mov_pp oC0, c0.x
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
// Platform d3d11 skipped due to earlier errors
// Platform d3d11 had shader errors
//   <no keywords>
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
TEMP R1;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
DP3 R0.y, R1, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[0].xyz, R0, c[9].w;
DP3 R0.y, R1, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[1].xyz, R0, c[9].w;
DP3 R0.y, R1, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[2].xyz, R0, c[9].w;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 20 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
dp3 r0.y, r1, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o1.xyz, r0, c8.w
dp3 r0.y, r1, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o2.xyz, r0, c8.w
dp3 r0.y, r1, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o3.xyz, r0, c8.w
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
}
Program "fp" {
// Platform d3d11 skipped due to earlier errors
// Platform d3d11 skipped due to earlier errors
SubProgram "opengl " {
"3.0-!!ARBfp1.0
PARAM c[1] = { { 0, 0.5 } };
TEMP R0;
MOV R0.z, fragment.texcoord[2];
MOV R0.x, fragment.texcoord[0].z;
MOV R0.y, fragment.texcoord[1].z;
MAD result.color.xyz, R0, c[0].y, c[0].y;
MOV result.color.w, c[0].x;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
"ps_3_0
def c0, 0.50000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
mov_pp r0.z, v2
mov_pp r0.x, v0.z
mov_pp r0.y, v1.z
mad_pp oC0.xyz, r0, c0.x, c0.x
mov_pp oC0.w, c0.y
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
  ZWrite Off
Program "vp" {
// Platform d3d11 had shader errors
//   Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
//   Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
//   Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
//   Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
//   Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
//   Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Vector 22 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[23] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[20];
DP4 R3.x, R1, c[18];
DP4 R3.y, R1, c[19];
ADD R2.xyz, R2, R3;
MAD R0.w, R0.x, R0.x, -R0.y;
MUL R3.xyz, R0.w, c[21];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[13];
ADD result.texcoord[3].xyz, R2, R3;
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[22].w, -vertex.position;
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
DP4 result.texcoord[0].z, vertex.position, c[7];
DP4 result.texcoord[0].y, vertex.position, c[6];
DP4 result.texcoord[0].x, vertex.position, c[5];
END
# 43 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Vector 22 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c23, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mul r1.xyz, v2, c22.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c23.x
dp4 r2.z, r0, c17
dp4 r2.y, r0, c16
dp4 r2.x, r0, c15
mul r0.y, r2.w, r2.w
mad r0.w, r0.x, r0.x, -r0.y
dp4 r3.z, r1, c20
dp4 r3.y, r1, c19
dp4 r3.x, r1, c18
add r2.xyz, r2, r3
mul r3.xyz, r0.w, c21
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c12
add o4.xyz, r2, r3
mov r1.w, c23.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c22.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c23.y
mul r1.y, r1, c13.x
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mad o3.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o3.zw, r0
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_Object2World]
Matrix 13 [_World2Object]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
"3.0-!!ARBvp1.0
PARAM c[22] = { { 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..21] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[8];
DP4 R2.z, R1, c[15];
DP4 R2.x, R1, c[13];
DP4 R2.y, R1, c[14];
MAD R2.xyz, R2, c[20].w, -vertex.position;
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MOV result.position, R0;
MUL R1.y, R1, c[18].x;
MOV result.texcoord[2].zw, R0;
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
DP4 R0.z, vertex.position, c[11];
ADD result.texcoord[2].xy, R1, R1.z;
ADD R1.xyz, R0, -c[19];
MOV result.texcoord[0].xyz, R0;
MOV R0.x, c[0];
ADD R0.y, R0.x, -c[19].w;
DP4 R0.x, vertex.position, c[3];
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
MUL result.texcoord[4].xyz, R1, c[19].w;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[21], c[21].zwzw;
MUL result.texcoord[4].w, -R0.x, R0.y;
END
# 33 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord1 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c16
mov r1.w, c22.x
dp4 r0.w, v0, c7
dp4 r2.z, r1, c14
dp4 r2.x, r1, c12
dp4 r2.y, r1, c13
mad r2.xyz, r2, c20.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c22.y
mov o0, r0
mul r1.y, r1, c17.x
mov o3.zw, r0
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.z, v0, c10
mad o3.xy, r1.z, c18.zwzw, r1
add r1.xyz, r0, -c19
mov o1.xyz, r0
mov r0.x, c19.w
add r0.y, c22.x, -r0.x
dp4 r0.x, v0, c2
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mul o5.xyz, r1, c19.w
mad o4.xy, v3, c21, c21.zwzw
mul o5.w, -r0.x, r0.y
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
"3.0-!!ARBvp1.0
PARAM c[17] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[15].w, -vertex.position;
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[16], c[16].zwzw;
DP4 result.texcoord[0].z, vertex.position, c[7];
DP4 result.texcoord[0].y, vertex.position, c[6];
DP4 result.texcoord[0].x, vertex.position, c[5];
END
# 26 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c17, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord1 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c12
mov r1.w, c17.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c17.y
mul r1.y, r1, c13.x
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mad o3.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o3.zw, r0
mad o4.xy, v3, c16, c16.zwzw
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Vector 22 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[23] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[20];
DP4 R3.x, R1, c[18];
DP4 R3.y, R1, c[19];
ADD R2.xyz, R2, R3;
MAD R0.w, R0.x, R0.x, -R0.y;
MUL R3.xyz, R0.w, c[21];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[13];
ADD result.texcoord[3].xyz, R2, R3;
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[22].w, -vertex.position;
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
DP4 result.texcoord[0].z, vertex.position, c[7];
DP4 result.texcoord[0].y, vertex.position, c[6];
DP4 result.texcoord[0].x, vertex.position, c[5];
END
# 43 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Vector 22 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c23, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mul r1.xyz, v2, c22.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c23.x
dp4 r2.z, r0, c17
dp4 r2.y, r0, c16
dp4 r2.x, r0, c15
mul r0.y, r2.w, r2.w
mad r0.w, r0.x, r0.x, -r0.y
dp4 r3.z, r1, c20
dp4 r3.y, r1, c19
dp4 r3.x, r1, c18
add r2.xyz, r2, r3
mul r3.xyz, r0.w, c21
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c12
add o4.xyz, r2, r3
mov r1.w, c23.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c22.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c23.y
mul r1.y, r1, c13.x
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mad o3.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o3.zw, r0
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_Object2World]
Matrix 13 [_World2Object]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
"3.0-!!ARBvp1.0
PARAM c[22] = { { 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..21] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[8];
DP4 R2.z, R1, c[15];
DP4 R2.x, R1, c[13];
DP4 R2.y, R1, c[14];
MAD R2.xyz, R2, c[20].w, -vertex.position;
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MOV result.position, R0;
MUL R1.y, R1, c[18].x;
MOV result.texcoord[2].zw, R0;
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
DP4 R0.z, vertex.position, c[11];
ADD result.texcoord[2].xy, R1, R1.z;
ADD R1.xyz, R0, -c[19];
MOV result.texcoord[0].xyz, R0;
MOV R0.x, c[0];
ADD R0.y, R0.x, -c[19].w;
DP4 R0.x, vertex.position, c[3];
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
MUL result.texcoord[4].xyz, R1, c[19].w;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[21], c[21].zwzw;
MUL result.texcoord[4].w, -R0.x, R0.y;
END
# 33 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord1 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c16
mov r1.w, c22.x
dp4 r0.w, v0, c7
dp4 r2.z, r1, c14
dp4 r2.x, r1, c12
dp4 r2.y, r1, c13
mad r2.xyz, r2, c20.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c22.y
mov o0, r0
mul r1.y, r1, c17.x
mov o3.zw, r0
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
dp4 r0.z, v0, c10
mad o3.xy, r1.z, c18.zwzw, r1
add r1.xyz, r0, -c19
mov o1.xyz, r0
mov r0.x, c19.w
add r0.y, c22.x, -r0.x
dp4 r0.x, v0, c2
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mul o5.xyz, r1, c19.w
mad o4.xy, v3, c21, c21.zwzw
mul o5.w, -r0.x, r0.y
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
"3.0-!!ARBvp1.0
PARAM c[17] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[15].w, -vertex.position;
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[16], c[16].zwzw;
DP4 result.texcoord[0].z, vertex.position, c[7];
DP4 result.texcoord[0].y, vertex.position, c[6];
DP4 result.texcoord[0].x, vertex.position, c[5];
END
# 26 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c17, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord1 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c12
mov r1.w, c17.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c17.y
mul r1.y, r1, c13.x
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mad o3.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o3.zw, r0
mad o4.xy, v3, c16, c16.zwzw
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}
}
Program "fp" {
// Platform d3d11 skipped due to earlier errors
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..4],
		{ 0.42745, 1, 0, 23.333 },
		{ 0.15000001, 0.85000002, 0.075000003, 8 },
		{ 0.5, 5 } };
TEMP R0;
TEMP R1;
MOV R1.xyz, fragment.texcoord[0];
MOV R1.w, c[5].y;
DP4 R0.z, R1, c[2];
DP4 R0.x, R1, c[0];
DP4 R0.y, R1, c[1];
MUL R0.xyz, R0, c[6].w;
MOV R0.w, c[7].x;
MAD R0.z, R0.w, c[4], R0;
FRC R0.y, R0;
FRC R0.x, R0;
FRC R0.z, R0;
SGE R0.y, c[6].z, R0;
SGE R0.x, c[6].z, R0;
MAX R0.w, R0.x, R0.y;
SGE R0.y, c[6].z, R0.z;
MUL R1.x, R0.y, c[7].y;
MAX R0.w, R0, R1.x;
MOV R0.x, c[5].w;
MUL R0.xyz, R0.x, c[4];
SIN R0.x, R0.x;
SIN R0.z, R0.z;
SIN R0.y, R0.y;
MAD_SAT R0.xyz, R0, c[6].x, c[6].y;
MUL R0.xyz, R0, R0.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.w, R1.x;
MAD R0.xyz, -R0.w, fragment.texcoord[1].z, R0;
ADD R0.xyz, R0, c[5].y;
MUL result.color.xyz, R0, c[5];
MOV result.color.w, c[5].y;
END
# 30 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"ps_3_0
def c5, 23.33300018, 0.15915491, 0.50000000, 8.00000000
def c6, 6.28318501, -3.14159298, 1.00000000, 0.00000000
def c7, 0.07500000, 5.00000000, 0.00000000, 0
def c8, 0.15000001, 0.85000002, 0, 0
def c9, 0.42745000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
mov r1.w, c6.z
mov r1.xyz, v0
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r0.xyz, r0, c5.w
frc r0.y, r0
frc r0.x, r0
add r0.y, -r0, c7.x
add r0.x, -r0, c7
mov r1.xyz, c4
mul r1.xyz, c5.x, r1
cmp r0.y, r0, c6.z, c6.w
cmp r0.x, r0, c6.z, c6.w
max r1.w, r0.x, r0.y
mov r0.x, c4.z
mad r0.y, c5.z, r0.x, r0.z
mad r0.x, r1, c5.y, c5.z
frc r0.x, r0
frc r0.y, r0
add r0.y, -r0, c7.x
cmp r2.x, r0.y, c7.y, c7.z
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c5.y, c5
frc r0.y, r0.z
mad r0.x, r1.y, c5.y, c5.z
max r2.x, r1.w, r2
mad r0.y, r0, c6.x, c6
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.z, r1.y
mad_sat r1.xyz, r0, c8.x, c8.y
dp3 r0.x, v1, v1
mul r1.xyz, r1, r2.x
rsq r0.x, r0.x
mad r0.xyz, -r0.x, v1.z, r1
add r0.xyz, r0, c6.z
mul oC0.xyz, r0, c9
mov_pp oC0.w, c6.z
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..4],
		{ 0.42745, 1, 0, 23.333 },
		{ 0.15000001, 0.85000002, 0.075000003, 8 },
		{ 0.5, 5 } };
TEMP R0;
TEMP R1;
MOV R1.xyz, fragment.texcoord[0];
MOV R1.w, c[5].y;
DP4 R0.z, R1, c[2];
DP4 R0.x, R1, c[0];
DP4 R0.y, R1, c[1];
MUL R0.xyz, R0, c[6].w;
MOV R0.w, c[7].x;
MAD R0.z, R0.w, c[4], R0;
FRC R0.y, R0;
FRC R0.x, R0;
FRC R0.z, R0;
SGE R0.y, c[6].z, R0;
SGE R0.x, c[6].z, R0;
MAX R0.w, R0.x, R0.y;
SGE R0.y, c[6].z, R0.z;
MUL R1.x, R0.y, c[7].y;
MAX R0.w, R0, R1.x;
MOV R0.x, c[5].w;
MUL R0.xyz, R0.x, c[4];
SIN R0.x, R0.x;
SIN R0.z, R0.z;
SIN R0.y, R0.y;
MAD_SAT R0.xyz, R0, c[6].x, c[6].y;
MUL R0.xyz, R0, R0.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.w, R1.x;
MAD R0.xyz, -R0.w, fragment.texcoord[1].z, R0;
ADD R0.xyz, R0, c[5].y;
MUL result.color.xyz, R0, c[5];
MOV result.color.w, c[5].y;
END
# 30 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"ps_3_0
def c5, 23.33300018, 0.15915491, 0.50000000, 8.00000000
def c6, 6.28318501, -3.14159298, 1.00000000, 0.00000000
def c7, 0.07500000, 5.00000000, 0.00000000, 0
def c8, 0.15000001, 0.85000002, 0, 0
def c9, 0.42745000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
mov r1.w, c6.z
mov r1.xyz, v0
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r0.xyz, r0, c5.w
frc r0.y, r0
frc r0.x, r0
add r0.y, -r0, c7.x
add r0.x, -r0, c7
mov r1.xyz, c4
mul r1.xyz, c5.x, r1
cmp r0.y, r0, c6.z, c6.w
cmp r0.x, r0, c6.z, c6.w
max r1.w, r0.x, r0.y
mov r0.x, c4.z
mad r0.y, c5.z, r0.x, r0.z
mad r0.x, r1, c5.y, c5.z
frc r0.x, r0
frc r0.y, r0
add r0.y, -r0, c7.x
cmp r2.x, r0.y, c7.y, c7.z
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c5.y, c5
frc r0.y, r0.z
mad r0.x, r1.y, c5.y, c5.z
max r2.x, r1.w, r2
mad r0.y, r0, c6.x, c6
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.z, r1.y
mad_sat r1.xyz, r0, c8.x, c8.y
dp3 r0.x, v1, v1
mul r1.xyz, r1, r2.x
rsq r0.x, r0.x
mad r0.xyz, -r0.x, v1.z, r1
add r0.xyz, r0, c6.z
mul oC0.xyz, r0, c9
mov_pp oC0.w, c6.z
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..4],
		{ 0.42745, 1, 0, 23.333 },
		{ 0.15000001, 0.85000002, 0.075000003, 8 },
		{ 0.5, 5 } };
TEMP R0;
TEMP R1;
MOV R1.xyz, fragment.texcoord[0];
MOV R1.w, c[5].y;
DP4 R0.z, R1, c[2];
DP4 R0.x, R1, c[0];
DP4 R0.y, R1, c[1];
MUL R0.xyz, R0, c[6].w;
MOV R0.w, c[7].x;
MAD R0.z, R0.w, c[4], R0;
FRC R0.y, R0;
FRC R0.x, R0;
FRC R0.z, R0;
SGE R0.y, c[6].z, R0;
SGE R0.x, c[6].z, R0;
MAX R0.w, R0.x, R0.y;
SGE R0.y, c[6].z, R0.z;
MUL R1.x, R0.y, c[7].y;
MAX R0.w, R0, R1.x;
MOV R0.x, c[5].w;
MUL R0.xyz, R0.x, c[4];
SIN R0.x, R0.x;
SIN R0.z, R0.z;
SIN R0.y, R0.y;
MAD_SAT R0.xyz, R0, c[6].x, c[6].y;
MUL R0.xyz, R0, R0.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.w, R1.x;
MAD R0.xyz, -R0.w, fragment.texcoord[1].z, R0;
ADD R0.xyz, R0, c[5].y;
MUL result.color.xyz, R0, c[5];
MOV result.color.w, c[5].y;
END
# 30 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"ps_3_0
def c5, 23.33300018, 0.15915491, 0.50000000, 8.00000000
def c6, 6.28318501, -3.14159298, 1.00000000, 0.00000000
def c7, 0.07500000, 5.00000000, 0.00000000, 0
def c8, 0.15000001, 0.85000002, 0, 0
def c9, 0.42745000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
mov r1.w, c6.z
mov r1.xyz, v0
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r0.xyz, r0, c5.w
frc r0.y, r0
frc r0.x, r0
add r0.y, -r0, c7.x
add r0.x, -r0, c7
mov r1.xyz, c4
mul r1.xyz, c5.x, r1
cmp r0.y, r0, c6.z, c6.w
cmp r0.x, r0, c6.z, c6.w
max r1.w, r0.x, r0.y
mov r0.x, c4.z
mad r0.y, c5.z, r0.x, r0.z
mad r0.x, r1, c5.y, c5.z
frc r0.x, r0
frc r0.y, r0
add r0.y, -r0, c7.x
cmp r2.x, r0.y, c7.y, c7.z
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c5.y, c5
frc r0.y, r0.z
mad r0.x, r1.y, c5.y, c5.z
max r2.x, r1.w, r2
mad r0.y, r0, c6.x, c6
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.z, r1.y
mad_sat r1.xyz, r0, c8.x, c8.y
dp3 r0.x, v1, v1
mul r1.xyz, r1, r2.x
rsq r0.x, r0.x
mad r0.xyz, -r0.x, v1.z, r1
add r0.xyz, r0, c6.z
mul oC0.xyz, r0, c9
mov_pp oC0.w, c6.z
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..4],
		{ 0.42745, 1, 0, 23.333 },
		{ 0.15000001, 0.85000002, 0.075000003, 8 },
		{ 0.5, 5 } };
TEMP R0;
TEMP R1;
MOV R1.xyz, fragment.texcoord[0];
MOV R1.w, c[5].y;
DP4 R0.z, R1, c[2];
DP4 R0.x, R1, c[0];
DP4 R0.y, R1, c[1];
MUL R0.xyz, R0, c[6].w;
MOV R0.w, c[7].x;
MAD R0.z, R0.w, c[4], R0;
FRC R0.y, R0;
FRC R0.x, R0;
FRC R0.z, R0;
SGE R0.y, c[6].z, R0;
SGE R0.x, c[6].z, R0;
MAX R0.w, R0.x, R0.y;
SGE R0.y, c[6].z, R0.z;
MUL R1.x, R0.y, c[7].y;
MAX R0.w, R0, R1.x;
MOV R0.x, c[5].w;
MUL R0.xyz, R0.x, c[4];
SIN R0.x, R0.x;
SIN R0.z, R0.z;
SIN R0.y, R0.y;
MAD_SAT R0.xyz, R0, c[6].x, c[6].y;
MUL R0.xyz, R0, R0.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.w, R1.x;
MAD R0.xyz, -R0.w, fragment.texcoord[1].z, R0;
ADD R0.xyz, R0, c[5].y;
MUL result.color.xyz, R0, c[5];
MOV result.color.w, c[5].y;
END
# 30 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"ps_3_0
def c5, 23.33300018, 0.15915491, 0.50000000, 8.00000000
def c6, 6.28318501, -3.14159298, 1.00000000, 0.00000000
def c7, 0.07500000, 5.00000000, 0.00000000, 0
def c8, 0.15000001, 0.85000002, 0, 0
def c9, 0.42745000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
mov r1.w, c6.z
mov r1.xyz, v0
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r0.xyz, r0, c5.w
frc r0.y, r0
frc r0.x, r0
add r0.y, -r0, c7.x
add r0.x, -r0, c7
mov r1.xyz, c4
mul r1.xyz, c5.x, r1
cmp r0.y, r0, c6.z, c6.w
cmp r0.x, r0, c6.z, c6.w
max r1.w, r0.x, r0.y
mov r0.x, c4.z
mad r0.y, c5.z, r0.x, r0.z
mad r0.x, r1, c5.y, c5.z
frc r0.x, r0
frc r0.y, r0
add r0.y, -r0, c7.x
cmp r2.x, r0.y, c7.y, c7.z
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c5.y, c5
frc r0.y, r0.z
mad r0.x, r1.y, c5.y, c5.z
max r2.x, r1.w, r2
mad r0.y, r0, c6.x, c6
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.z, r1.y
mad_sat r1.xyz, r0, c8.x, c8.y
dp3 r0.x, v1, v1
mul r1.xyz, r1, r2.x
rsq r0.x, r0.x
mad r0.xyz, -r0.x, v1.z, r1
add r0.xyz, r0, c6.z
mul oC0.xyz, r0, c9
mov_pp oC0.w, c6.z
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..4],
		{ 0.42745, 1, 0, 23.333 },
		{ 0.15000001, 0.85000002, 0.075000003, 8 },
		{ 0.5, 5 } };
TEMP R0;
TEMP R1;
MOV R1.xyz, fragment.texcoord[0];
MOV R1.w, c[5].y;
DP4 R0.z, R1, c[2];
DP4 R0.x, R1, c[0];
DP4 R0.y, R1, c[1];
MUL R0.xyz, R0, c[6].w;
MOV R0.w, c[7].x;
MAD R0.z, R0.w, c[4], R0;
FRC R0.y, R0;
FRC R0.x, R0;
FRC R0.z, R0;
SGE R0.y, c[6].z, R0;
SGE R0.x, c[6].z, R0;
MAX R0.w, R0.x, R0.y;
SGE R0.y, c[6].z, R0.z;
MUL R1.x, R0.y, c[7].y;
MAX R0.w, R0, R1.x;
MOV R0.x, c[5].w;
MUL R0.xyz, R0.x, c[4];
SIN R0.x, R0.x;
SIN R0.z, R0.z;
SIN R0.y, R0.y;
MAD_SAT R0.xyz, R0, c[6].x, c[6].y;
MUL R0.xyz, R0, R0.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.w, R1.x;
MAD R0.xyz, -R0.w, fragment.texcoord[1].z, R0;
ADD R0.xyz, R0, c[5].y;
MUL result.color.xyz, R0, c[5];
MOV result.color.w, c[5].y;
END
# 30 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"ps_3_0
def c5, 23.33300018, 0.15915491, 0.50000000, 8.00000000
def c6, 6.28318501, -3.14159298, 1.00000000, 0.00000000
def c7, 0.07500000, 5.00000000, 0.00000000, 0
def c8, 0.15000001, 0.85000002, 0, 0
def c9, 0.42745000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
mov r1.w, c6.z
mov r1.xyz, v0
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r0.xyz, r0, c5.w
frc r0.y, r0
frc r0.x, r0
add r0.y, -r0, c7.x
add r0.x, -r0, c7
mov r1.xyz, c4
mul r1.xyz, c5.x, r1
cmp r0.y, r0, c6.z, c6.w
cmp r0.x, r0, c6.z, c6.w
max r1.w, r0.x, r0.y
mov r0.x, c4.z
mad r0.y, c5.z, r0.x, r0.z
mad r0.x, r1, c5.y, c5.z
frc r0.x, r0
frc r0.y, r0
add r0.y, -r0, c7.x
cmp r2.x, r0.y, c7.y, c7.z
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c5.y, c5
frc r0.y, r0.z
mad r0.x, r1.y, c5.y, c5.z
max r2.x, r1.w, r2
mad r0.y, r0, c6.x, c6
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.z, r1.y
mad_sat r1.xyz, r0, c8.x, c8.y
dp3 r0.x, v1, v1
mul r1.xyz, r1, r2.x
rsq r0.x, r0.x
mad r0.xyz, -r0.x, v1.z, r1
add r0.xyz, r0, c6.z
mul oC0.xyz, r0, c9
mov_pp oC0.w, c6.z
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"3.0-!!ARBfp1.0
PARAM c[8] = { program.local[0..4],
		{ 0.42745, 1, 0, 23.333 },
		{ 0.15000001, 0.85000002, 0.075000003, 8 },
		{ 0.5, 5 } };
TEMP R0;
TEMP R1;
MOV R1.xyz, fragment.texcoord[0];
MOV R1.w, c[5].y;
DP4 R0.z, R1, c[2];
DP4 R0.x, R1, c[0];
DP4 R0.y, R1, c[1];
MUL R0.xyz, R0, c[6].w;
MOV R0.w, c[7].x;
MAD R0.z, R0.w, c[4], R0;
FRC R0.y, R0;
FRC R0.x, R0;
FRC R0.z, R0;
SGE R0.y, c[6].z, R0;
SGE R0.x, c[6].z, R0;
MAX R0.w, R0.x, R0.y;
SGE R0.y, c[6].z, R0.z;
MUL R1.x, R0.y, c[7].y;
MAX R0.w, R0, R1.x;
MOV R0.x, c[5].w;
MUL R0.xyz, R0.x, c[4];
SIN R0.x, R0.x;
SIN R0.z, R0.z;
SIN R0.y, R0.y;
MAD_SAT R0.xyz, R0, c[6].x, c[6].y;
MUL R0.xyz, R0, R0.w;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.w, R1.x;
MAD R0.xyz, -R0.w, fragment.texcoord[1].z, R0;
ADD R0.xyz, R0, c[5].y;
MUL result.color.xyz, R0, c[5];
MOV result.color.w, c[5].y;
END
# 30 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
"ps_3_0
def c5, 23.33300018, 0.15915491, 0.50000000, 8.00000000
def c6, 6.28318501, -3.14159298, 1.00000000, 0.00000000
def c7, 0.07500000, 5.00000000, 0.00000000, 0
def c8, 0.15000001, 0.85000002, 0, 0
def c9, 0.42745000, 1.00000000, 0.00000000, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
mov r1.w, c6.z
mov r1.xyz, v0
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r0.xyz, r0, c5.w
frc r0.y, r0
frc r0.x, r0
add r0.y, -r0, c7.x
add r0.x, -r0, c7
mov r1.xyz, c4
mul r1.xyz, c5.x, r1
cmp r0.y, r0, c6.z, c6.w
cmp r0.x, r0, c6.z, c6.w
max r1.w, r0.x, r0.y
mov r0.x, c4.z
mad r0.y, c5.z, r0.x, r0.z
mad r0.x, r1, c5.y, c5.z
frc r0.x, r0
frc r0.y, r0
add r0.y, -r0, c7.x
cmp r2.x, r0.y, c7.y, c7.z
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.x, r0.y
mad r0.z, r1, c5.y, c5
frc r0.y, r0.z
mad r0.x, r1.y, c5.y, c5.z
max r2.x, r1.w, r2
mad r0.y, r0, c6.x, c6
sincos r1.xy, r0.y
frc r0.x, r0
mad r1.x, r0, c6, c6.y
sincos r0.xy, r1.x
mov r0.z, r1.y
mad_sat r1.xyz, r0, c8.x, c8.y
dp3 r0.x, v1, v1
mul r1.xyz, r1, r2.x
rsq r0.x, r0.x
mad r0.xyz, -r0.x, v1.z, r1
add r0.xyz, r0, c6.z
mul oC0.xyz, r0, c9
mov_pp oC0.w, c6.z
"
}
}
 }
}
Fallback "Diffuse"
}