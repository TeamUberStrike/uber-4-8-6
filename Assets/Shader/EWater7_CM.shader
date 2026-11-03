Shader "Cross Platform Shaders/EasyWater7_CUBEMAP" {
Properties {
 _Color ("_Color", Color) = (1,1,1,1)
 _Texture1 ("_Texture1", 2D) = "black" {}
 _BumpMap1 ("_BumpMap1", 2D) = "black" {}
 _Texture2 ("_Texture2", 2D) = "black" {}
 _BumpMap2 ("_BumpMap2", 2D) = "black" {}
 _MainTexSpeed ("_MainTexSpeed", Float) = 0
 _Bump1Speed ("_Bump1Speed", Float) = 0
 _Texture2Speed ("_Texture2Speed", Float) = 0
 _Bump2Speed ("_Bump2Speed", Float) = 0
 _DistortionMap ("_DistortionMap", 2D) = "black" {}
 _DistortionSpeed ("_DistortionSpeed", Float) = 0
 _DistortionPower ("_DistortionPower", Float) = 0
 _Specular ("_Specular", Float) = 1
 _Gloss ("_Gloss", Float) = 0.3
 _Opacity ("_Opacity", Float) = 0
 _Reflection ("_Reflection", CUBE) = "black" {}
 _ReflectPower ("_ReflectPower", Float) = 0
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
Vector 23 [_DistortionMap_ST]
Vector 24 [_Texture1_ST]
Vector 25 [_Texture2_ST]
Vector 26 [_BumpMap1_ST]
Vector 27 [_BumpMap2_ST]
"3.0-!!ARBvp1.0
PARAM c[28] = { { 1 },
		state.matrix.mvp,
		program.local[5..27] };
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
ADD result.texcoord[5].xyz, R2, R3;
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
DP3 result.texcoord[3].y, R0, R2;
DP3 result.texcoord[4].y, R2, R3;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R3;
DP3 result.texcoord[4].x, vertex.attrib[14], R3;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[26].xyxy, c[26];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[25], c[25].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[27], c[27].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 47 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
Vector 22 [_DistortionMap_ST]
Vector 23 [_Texture1_ST]
Vector 24 [_Texture2_ST]
Vector 25 [_BumpMap1_ST]
Vector 26 [_BumpMap2_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c27, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c21.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c27.x
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
add o6.xyz, r1, r2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
mov r1.w, c27.x
mov r1.xyz, c12
dp4 r4.y, c13, r0
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c21.w, -v0
mov r1, c8
dp4 r4.x, c13, r1
dp3 o4.y, r2, r3
dp3 o5.y, r3, r4
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
mad o2.zw, v3.xyxy, c25.xyxy, c25
mad o2.xy, v3, c24, c24.zwzw
mad o3.xy, v3, c26, c26.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Vector 112 [_DistortionMap_ST]
Vector 128 [_Texture1_ST]
Vector 144 [_Texture2_ST]
Vector 160 [_BumpMap1_ST]
Vector 176 [_BumpMap2_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedfpidhadenalafjbghmakpcampoppjohdabaaaaaajmaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcnaagaaaaeaaaabaaleabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaa
aaaaaaaaahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaa
kgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
aeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
afaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaa
acaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_DistortionMap_ST]
Vector 18 [_Texture1_ST]
Vector 19 [_Texture2_ST]
Vector 20 [_BumpMap1_ST]
Vector 21 [_BumpMap2_ST]
"3.0-!!ARBvp1.0
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
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
DP3 result.texcoord[3].y, R0, R1;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[20].xyxy, c[20];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[19], c[19].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[21], c[21].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 23 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [unity_Scale]
Vector 14 [unity_LightmapST]
Vector 15 [_DistortionMap_ST]
Vector 16 [_Texture1_ST]
Vector 17 [_Texture2_ST]
Vector 18 [_BumpMap1_ST]
Vector 19 [_BumpMap2_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
mov r0.xyz, c12
mov r0.w, c20.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c13.w, -v0
dp3 o4.y, r0, r1
dp3 o4.z, v2, r0
dp3 o4.x, r0, v1
mad o1.zw, v3.xyxy, c16.xyxy, c16
mad o1.xy, v3, c15, c15.zwzw
mad o2.zw, v3.xyxy, c18.xyxy, c18
mad o2.xy, v3, c17, c17.zwzw
mad o3.xy, v3, c19, c19.zwzw
mad o5.xy, v4, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Vector 112 [unity_LightmapST]
Vector 128 [_DistortionMap_ST]
Vector 144 [_Texture1_ST]
Vector 160 [_Texture2_ST]
Vector 176 [_BumpMap1_ST]
Vector 192 [_BumpMap2_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedjomipkigohifnphamdanfbbpcaeomaolabaaaaaajmafaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcoiadaaaaeaaaabaapkaaaaaafjaaaaae
egiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaajaaaaaa
kgiocaaaaaaaaaaaajaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaalmccabaaa
acaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaaaaaaaaaa
alaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
amaaaaaaogikcaaaaaaaaaaaamaaaaaadcaaaaalmccabaaaadaaaaaaagbebaaa
aeaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadiaaaaah
hcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaa
bcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaa
aaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
eccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
Vector 24 [_DistortionMap_ST]
Vector 25 [_Texture1_ST]
Vector 26 [_Texture2_ST]
Vector 27 [_BumpMap1_ST]
Vector 28 [_BumpMap2_ST]
"3.0-!!ARBvp1.0
PARAM c[29] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..28] };
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
ADD result.texcoord[5].xyz, R2, R3;
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
DP3 result.texcoord[3].y, R0, R2;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[4].y, R2, R3;
DP3 result.texcoord[4].z, vertex.normal, R3;
DP3 result.texcoord[4].x, vertex.attrib[14], R3;
ADD result.texcoord[6].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[6].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[27].xyxy, c[27];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[26], c[26].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[28], c[28].zwzw;
END
# 52 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
Vector 24 [_DistortionMap_ST]
Vector 25 [_Texture1_ST]
Vector 26 [_Texture2_ST]
Vector 27 [_BumpMap1_ST]
Vector 28 [_BumpMap2_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c29, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c23.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c29.x
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
add o6.xyz, r1, r2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mov r1.w, c29.x
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
mul r1.xyz, r0.xyww, c29.y
mul r1.y, r1, c13.x
dp3 o4.y, r2, r3
dp3 o5.y, r3, r4
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
mad o7.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o7.zw, r0
mad o1.zw, v3.xyxy, c25.xyxy, c25
mad o1.xy, v3, c24, c24.zwzw
mad o2.zw, v3.xyxy, c27.xyxy, c27
mad o2.xy, v3, c26, c26.zwzw
mad o3.xy, v3, c28, c28.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 256
Vector 176 [_DistortionMap_ST]
Vector 192 [_Texture1_ST]
Vector 208 [_Texture2_ST]
Vector 224 [_BumpMap1_ST]
Vector 240 [_BumpMap2_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedhlpgjhnblcelfjhcfbfakgdngccdfaehabaaaaaaemajaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
giahaaaaeaaaabaankabaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
giaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaamaaaaaa
kgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadcaaaaalmccabaaa
acaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaoaaaaaakgiocaaaaaaaaaaa
aoaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
apaaaaaaogikcaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
aeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaaeaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaaafaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaaficaabaaa
abaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaa
egakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
aeaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaacaaaaaacmaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
ahaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaahaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 16 [unity_Scale]
Vector 17 [unity_LightmapST]
Vector 18 [_DistortionMap_ST]
Vector 19 [_Texture1_ST]
Vector 20 [_Texture2_ST]
Vector 21 [_BumpMap1_ST]
Vector 22 [_BumpMap2_ST]
"3.0-!!ARBvp1.0
PARAM c[23] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..22] };
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
DP3 result.texcoord[3].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, R2, vertex.attrib[14];
ADD result.texcoord[5].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[5].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 28 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_DistortionMap_ST]
Vector 18 [_Texture1_ST]
Vector 19 [_Texture2_ST]
Vector 20 [_BumpMap1_ST]
Vector 21 [_BumpMap2_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c22, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c12
mov r1.w, c22.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
dp3 o4.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c22.y
mul r1.y, r1, c13.x
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
mad o6.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o6.zw, r0
mad o1.zw, v3.xyxy, c18.xyxy, c18
mad o1.xy, v3, c17, c17.zwzw
mad o2.zw, v3.xyxy, c20.xyxy, c20
mad o2.xy, v3, c19, c19.zwzw
mad o3.xy, v3, c21, c21.zwzw
mad o5.xy, v4, c16, c16.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 272
Vector 176 [unity_LightmapST]
Vector 192 [_DistortionMap_ST]
Vector 208 [_Texture1_ST]
Vector 224 [_Texture2_ST]
Vector 240 [_BumpMap1_ST]
Vector 256 [_BumpMap2_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedpobbiimpoeigpkjcphecbokiajafgmgoabaaaaaaemagaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefciaaeaaaaeaaaabaacaabaaaafjaaaaaeegiocaaaaaaaaaaa
bbaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaamaaaaaaogikcaaaaaaaaaaaamaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaanaaaaaakgiocaaaaaaaaaaa
anaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
aoaaaaaaogikcaaaaaaaaaaaaoaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaapaaaaaakgiocaaaaaaaaaaaapaaaaaadcaaaaal
dccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaabaaaaaaaogikcaaa
aaaaaaaabaaaaaaadcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaaagiecaaa
aaaaaaaaalaaaaaakgiocaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaabaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
acaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaa
acaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaa
acaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaa
aeaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaaeaaaaaa
egbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
afaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
Vector 31 [_DistortionMap_ST]
Vector 32 [_Texture1_ST]
Vector 33 [_Texture2_ST]
Vector 34 [_BumpMap1_ST]
Vector 35 [_BumpMap2_ST]
"3.0-!!ARBvp1.0
PARAM c[36] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..35] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[30].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[16];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[15];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[17];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[18];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
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
MUL R0, R4.xyzz, R4.yzzx;
DP4 R3.z, R0, c[28];
DP4 R3.y, R0, c[27];
DP4 R3.x, R0, c[26];
MUL R1.w, R3, R3;
MAD R0.x, R4, R4, -R1.w;
MOV R0.w, c[0].x;
DP4 R2.z, R4, c[25];
DP4 R2.y, R4, c[24];
DP4 R2.x, R4, c[23];
ADD R2.xyz, R2, R3;
MUL R3.xyz, R0.x, c[29];
ADD R3.xyz, R2, R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
ADD result.texcoord[5].xyz, R3, R1;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0.xyz, c[13];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[30].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[14];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[3].y, R0, R2;
DP3 result.texcoord[4].y, R2, R3;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R3;
DP3 result.texcoord[4].x, vertex.attrib[14], R3;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[32].xyxy, c[32];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[31], c[31].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[34].xyxy, c[34];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[33], c[33].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[35], c[35].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 78 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
Vector 30 [_DistortionMap_ST]
Vector 31 [_Texture1_ST]
Vector 32 [_Texture2_ST]
Vector 33 [_BumpMap1_ST]
Vector 34 [_BumpMap2_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c35, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c29.w
dp4 r0.x, v0, c5
add r1, -r0.x, c15
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c14
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c35.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c16
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c17
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c35.x
dp4 r2.z, r4, c24
dp4 r2.y, r4, c23
dp4 r2.x, r4, c22
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c35.y
mul r0, r0, r1
mul r1.xyz, r0.y, c19
mad r1.xyz, r0.x, c18, r1
mad r0.xyz, r0.z, c20, r1
mad r1.xyz, r0.w, c21, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c27
dp4 r3.y, r0, c26
dp4 r3.x, r0, c25
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c28
add r2.xyz, r2, r3
add r2.xyz, r2, r0
add o6.xyz, r2, r1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
mov r1.w, c35.x
mov r1.xyz, c12
dp4 r4.y, c13, r0
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c29.w, -v0
mov r1, c8
dp4 r4.x, c13, r1
dp3 o4.y, r2, r3
dp3 o5.y, r3, r4
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
mad o1.zw, v3.xyxy, c31.xyxy, c31
mad o1.xy, v3, c30, c30.zwzw
mad o2.zw, v3.xyxy, c33.xyxy, c33
mad o2.xy, v3, c32, c32.zwzw
mad o3.xy, v3, c34, c34.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Vector 112 [_DistortionMap_ST]
Vector 128 [_Texture1_ST]
Vector 144 [_Texture2_ST]
Vector 160 [_BumpMap1_ST]
Vector 176 [_BumpMap2_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecediffeadjeeaegneebgfmbclfeplefnicjabaaaaaaomalaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefccaakaaaaeaaaabaaiiacaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
agaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaa
aaaaaaaaahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaa
kgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
aeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
afaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
abaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaabbaaaaaibcaabaaaabaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaia
ebaaaaaaacaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaa
fgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaa
adaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaa
acaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaakgakbaia
ebaaaaaaacaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaa
egaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaa
aaaaaaaaegaobaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaaj
pcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaa
dcaaaaajpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
adaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaa
acaaaaaaegaobaaaacaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaa
fgafbaaaaaaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaacaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaagaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
Vector 32 [_DistortionMap_ST]
Vector 33 [_Texture1_ST]
Vector 34 [_Texture2_ST]
Vector 35 [_BumpMap1_ST]
Vector 36 [_BumpMap2_ST]
"3.0-!!ARBvp1.0
PARAM c[37] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..36] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[31].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[17];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[16];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[18];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[19];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
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
MUL R0, R4.xyzz, R4.yzzx;
DP4 R3.z, R0, c[29];
DP4 R3.y, R0, c[28];
DP4 R3.x, R0, c[27];
MUL R1.w, R3, R3;
MOV R0.w, c[0].x;
MAD R0.x, R4, R4, -R1.w;
DP4 R2.z, R4, c[26];
DP4 R2.y, R4, c[25];
DP4 R2.x, R4, c[24];
ADD R2.xyz, R2, R3;
MUL R3.xyz, R0.x, c[30];
ADD R3.xyz, R2, R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
ADD result.texcoord[5].xyz, R3, R1;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0.xyz, c[13];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[31].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[15];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[3].y, R0, R2;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[4].y, R2, R3;
DP3 result.texcoord[4].z, vertex.normal, R3;
DP3 result.texcoord[4].x, vertex.attrib[14], R3;
ADD result.texcoord[6].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[6].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[33].xyxy, c[33];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[32], c[32].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[35].xyxy, c[35];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[34], c[34].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[36], c[36].zwzw;
END
# 83 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
Vector 32 [_DistortionMap_ST]
Vector 33 [_Texture1_ST]
Vector 34 [_Texture2_ST]
Vector 35 [_BumpMap1_ST]
Vector 36 [_BumpMap2_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c37, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c31.w
dp4 r0.x, v0, c5
add r1, -r0.x, c17
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c16
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c37.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c18
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c19
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c37.x
dp4 r2.z, r4, c26
dp4 r2.y, r4, c25
dp4 r2.x, r4, c24
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c37.y
mul r0, r0, r1
mul r1.xyz, r0.y, c21
mad r1.xyz, r0.x, c20, r1
mad r0.xyz, r0.z, c22, r1
mad r1.xyz, r0.w, c23, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c29
dp4 r3.y, r0, c28
dp4 r3.x, r0, c27
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c30
add r2.xyz, r2, r3
add r2.xyz, r2, r0
add o6.xyz, r2, r1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mov r1.w, c37.x
mov r1.xyz, c12
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c31.w, -v0
mov r1, c8
dp4 r4.x, c15, r1
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c37.z
mul r1.y, r1, c13.x
dp3 o4.y, r2, r3
dp3 o5.y, r3, r4
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
dp3 o5.z, v2, r4
dp3 o5.x, v1, r4
mad o7.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o7.zw, r0
mad o1.zw, v3.xyxy, c33.xyxy, c33
mad o1.xy, v3, c32, c32.zwzw
mad o2.zw, v3.xyxy, c35.xyxy, c35
mad o2.xy, v3, c34, c34.zwzw
mad o3.xy, v3, c36, c36.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 256
Vector 176 [_DistortionMap_ST]
Vector 192 [_Texture1_ST]
Vector 208 [_Texture2_ST]
Vector 224 [_BumpMap1_ST]
Vector 240 [_BumpMap2_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedfckjaaamedgcccadnpbdmgjnogdbfncoabaaaaaajmamaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaneaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaaneaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
liakaaaaeaaaabaakoacaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaad
hccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagfaaaaadpccabaaaahaaaaaa
giaaaaacahaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaamaaaaaa
kgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaadcaaaaalmccabaaa
acaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaoaaaaaakgiocaaaaaaaaaaa
aoaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
apaaaaaaogikcaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
aeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaaeaaaaaa
egbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaa
acaaaaaaegacbaaaacaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaaafaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaa
egacbaaaacaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaai
hcaabaaaacaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaadaaaaaafgafbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaacaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaacaaaaaaegaibaaa
adaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
acaaaaaaegadbaaaacaaaaaabbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaa
egakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
aeaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaakicaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadkaabaia
ebaaaaaaabaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaacmaaaaaa
pgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaadaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaadaaaaaaaaaaaaajpcaabaaaaeaaaaaafgafbaiaebaaaaaaadaaaaaa
egiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaafaaaaaafgafbaaaabaaaaaa
egaobaaaaeaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaa
aeaaaaaaaaaaaaajpcaabaaaagaaaaaaagaabaiaebaaaaaaadaaaaaaegiocaaa
acaaaaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaakgakbaiaebaaaaaaadaaaaaa
egiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaafaaaaaaegaobaaaagaaaaaa
agaabaaaabaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaa
adaaaaaakgakbaaaabaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaaaeaaaaaa
egaobaaaagaaaaaaegaobaaaagaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaa
adaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaegaobaaaaeaaaaaaeeaaaaaf
pcaabaaaaeaaaaaaegaobaaaadaaaaaadcaaaaanpcaabaaaadaaaaaaegaobaaa
adaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpaoaaaaakpcaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpegaobaaaadaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaaeaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
adaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaabaaaaaa
egiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaa
agaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaiaaaaaakgakbaaaabaaaaaaegacbaaaadaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaahhccabaaaagaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaahaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaahaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Float 3 [_MainTexSpeed]
Float 4 [_Bump1Speed]
Float 5 [_Texture2Speed]
Float 6 [_Bump2Speed]
Float 7 [_DistortionSpeed]
Float 8 [_DistortionPower]
Float 9 [_Specular]
Float 10 [_Gloss]
Float 11 [_Opacity]
Float 12 [_ReflectPower]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 5
"3.0-!!ARBfp1.0
PARAM c[15] = { program.local[0..12],
		{ 2, 1, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.y, c[4].x;
MOV R0.z, c[6].x;
MAD R1.xy, R0.y, c[0].x, fragment.texcoord[1].zwzw;
MOV R0.x, c[0];
MAD R0.xy, R0.x, c[7].x, fragment.texcoord[0];
TEX R0.yw, R0, texture[0], 2D;
MAD R4.xy, R0.wyzw, c[13].x, -c[13].y;
MAD R1.zw, R0.z, c[0].x, fragment.texcoord[2].xyxy;
MAD R0.zw, R4.xyxy, c[8].x, R1;
MAD R0.xy, R4, c[8].x, R1;
TEX R1, R0.zwzw, texture[4], 2D;
TEX R0, R0, texture[3], 2D;
ADD R2, R0, R1;
ADD R0.xy, R2.wyzw, -c[13].y;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[13].y;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
MUL R2.xyz, R2, c[14].w;
MUL R2.xyz, fragment.texcoord[3].xzyw, R2;
MUL R0.xyz, R0.w, R0;
RSQ R1.w, R1.w;
MOV R1.xyz, fragment.texcoord[4];
MAD R1.xyz, R1.w, fragment.texcoord[3], R1;
DP3 R1.w, R1, R1;
RSQ R0.w, R1.w;
MUL R1.xyz, R0.w, R1;
DP3 R0.w, R0, R1;
DP3 R1.w, R0, fragment.texcoord[4];
MAX R1.w, R1, c[13].z;
MUL R0.xyz, R1.w, c[1];
MAX R1.w, R0, c[13].z;
MOV R1.xyz, c[14];
MOV R0.w, c[13];
MUL R0.w, R0, c[10].x;
DP3 R1.x, R1, c[1];
POW R0.w, R1.w, R0.w;
MUL R0.w, R0, R1.x;
MUL R3, R0, c[13].x;
MOV R0.y, c[5].x;
MAD R0.zw, R0.y, c[0].x, fragment.texcoord[1].xyxy;
MAD R0.zw, R4.xyxy, c[8].x, R0;
TEX R1.xyz, R0.zwzw, texture[2], 2D;
MOV R0.x, c[3];
MAD R0.xy, R0.x, c[0].x, fragment.texcoord[0].zwzw;
MAD R0.xy, R4, c[8].x, R0;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, R1;
MUL R1.w, R3, c[9].x;
MAD R0.xy, R4, c[8].x, R0;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
MAD R0.w, fragment.texcoord[3].z, -R0, c[13].y;
MUL R0.xyz, R0, c[2];
MUL R1.xyz, R3, R1.w;
MAD R1.xyz, R0, R3, R1;
MUL R0.w, R0, c[12].x;
TEX R2.xyz, R2, texture[5], CUBE;
MUL R2.xyz, R2, R0.w;
MAD R0.xyz, R0, fragment.texcoord[5], R1;
ADD result.color.xyz, R0, R2;
MOV result.color.w, c[11].x;
END
# 66 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Float 3 [_MainTexSpeed]
Float 4 [_Bump1Speed]
Float 5 [_Texture2Speed]
Float 6 [_Bump2Speed]
Float 7 [_DistortionSpeed]
Float 8 [_DistortionPower]
Float 9 [_Specular]
Float 10 [_Gloss]
Float 11 [_Opacity]
Float 12 [_ReflectPower]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 5
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_cube s5
def c13, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c14, 128.00000000, 0.21997070, 0.70703125, 0.07098389
def c15, 0.50000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mov r0.x, c0
mad r0.zw, c4.x, r0.x, v1
mov r0.y, c7.x
mad r0.xy, c0.x, r0.y, v0
texld r1.yw, r0, s0
mov r1.x, c0
mad_pp r4.xy, r1.wyzw, c13.x, c13.y
mad r0.xy, c6.x, r1.x, v2
mad r1.xy, r4, c8.x, r0
mad r0.xy, r4, c8.x, r0.zwzw
texld r1, r1, s4
texld r0, r0, s3
add_pp r2, r0, r1
add_pp r0.xy, r2.wyzw, c13.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c13
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
dp3_pp r0.w, v3, v3
mul_pp r2.xyz, r2, c15.x
mul r2.xyz, v3.xzyw, r2
mov_pp r1.xyz, v4
rsq_pp r0.w, r0.w
mad_pp r3.xyz, r0.w, v3, r1
dp3_pp r1.x, r0, v4
dp3_pp r0.w, r3, r3
rsq_pp r0.w, r0.w
mul_pp r3.xyz, r0.w, r3
dp3_pp r0.x, r0, r3
mov_pp r0.w, c10.x
max_pp r1.x, r1, c13.w
mul_pp r1.xyz, r1.x, c1
max_pp r1.w, r0.x, c13
mul_pp r2.w, c14.x, r0
pow r0, r1.w, r2.w
mov_pp r3.xyz, c1
dp3_pp r0.y, c14.yzww, r3
mul r1.w, r0.x, r0.y
mul_pp r3, r1, c13.x
mov r0.y, c0.x
mad r1.xy, c5.x, r0.y, v1
mov r0.x, c0
mad r0.xy, c3.x, r0.x, v0.zwzw
mad r1.xy, r4, c8.x, r1
mad r0.xy, r4, c8.x, r0
mul_pp r0.w, r3, c9.x
texld r1.xyz, r1, s2
texld r0.xyz, r0, s1
mul r0.xyz, r0, r1
mul_pp r1.xyz, r3, r0.w
mad r0.xy, r4, c8.x, r0
mul r0.xyz, r0, c2
dp3 r0.w, v3, v3
mad_pp r1.xyz, r0, r3, r1
rsq r0.w, r0.w
mad r0.w, v3.z, -r0, c13.z
mul r0.w, r0, c12.x
texld r2.xyz, r2, s5
mul r2.xyz, r2, r0.w
mad_pp r0.xyz, r0, v5, r1
add_pp oC0.xyz, r0, r2
mov_pp oC0.w, c11.x
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_DistortionMap] 2D 4
SetTexture 1 [_Texture1] 2D 0
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 1
SetTexture 4 [_BumpMap2] 2D 3
SetTexture 5 [_Reflection] CUBE 5
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 48 [_Color]
Float 64 [_MainTexSpeed]
Float 68 [_Bump1Speed]
Float 72 [_Texture2Speed]
Float 76 [_Bump2Speed]
Float 80 [_DistortionSpeed]
Float 84 [_DistortionPower]
Float 88 [_Specular]
Float 92 [_Gloss]
Float 96 [_Opacity]
Float 100 [_ReflectPower]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedkopnkofnfhpblpkkjgeckcpnhffhkoggabaaaaaagaajaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcciaiaaaaeaaaaaaaakacaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafidaaaaeaahabaaa
afaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajocaabaaaaaaaaaaa
agbjbaaaaeaaaaaaagaabaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackbabaiaebaaaaaaaeaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaagaaaaaa
baaaaaahbcaabaaaabaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaa
aaaaaaaaagaabaaaabaaaaaadcaaaaaldcaabaaaabaaaaaaagiacaaaabaaaaaa
aaaaaaaapgipcaaaaaaaaaaaaeaaaaaaegbabaaaadaaaaaadcaaaaalmcaabaaa
abaaaaaaagiacaaaaaaaaaaaafaaaaaaagiacaaaabaaaaaaaaaaaaaaagbebaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaeaaaaaadcaaaaapmcaabaaaabaaaaaapgahbaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialp
aaaaialpdcaaaaakdcaabaaaabaaaaaaogakbaaaabaaaaaafgifcaaaaaaaaaaa
afaaaaaaegaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaaeaaaaaaaagabaaaadaaaaaadcaaaaalpcaabaaaadaaaaaaagiacaaa
abaaaaaaaaaaaaaakgifcaaaaaaaaaaaaeaaaaaaegbobaaaacaaaaaadcaaaaak
pcaabaaaadaaaaaaogaobaaaabaaaaaafgifcaaaaaaaaaaaafaaaaaaegaobaaa
adaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaadaaaaaaeghobaaaadaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaaaaaaaaakdcaabaaaaeaaaaaahgapbaaaacaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaakhcaabaaaacaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaigbbbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaa
egacbaaaacaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaaapaaaaahbcaabaaa
abaaaaaaegaabaaaaeaaaaaaegaabaaaaeaaaaaaddaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaeaaaaaaakaabaaa
abaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaa
eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaaeaaaaaa
agaabaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
aeaaaaaajgahbaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaafaaaaaa
egacbaaaaeaaaaaadeaaaaakgcaabaaaaaaaaaaafgagbaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaihcaabaaaaeaaaaaakgakbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaakhcaabaaaaeaaaaaaegacbaaa
aeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaacpaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaadkiacaaaaaaaaaaa
afaaaaaaabeaaaaaaaaaaaeddiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaabjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaabaaaaaal
ecaabaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaaaceaaaaakoehgbdopepndedp
hdgijbdnaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaaapaaaaaiccaabaaaaaaaaaaafgafbaaaaaaaaaaakgikcaaaaaaaaaaa
afaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaaaeaaaaaa
diaaaaaidcaabaaaabaaaaaaogakbaaaabaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaaldcaabaaaafaaaaaaagiacaaaabaaaaaaaaaaaaaaagiacaaaaaaaaaaa
aeaaaaaaogbkbaaaabaaaaaadcaaaaakmcaabaaaabaaaaaakgaobaaaabaaaaaa
fgifcaaaaaaaaaaaafaaaaaaagaebaaaafaaaaaaefaaaaajpcaabaaaafaaaaaa
ogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadcaaaaajdcaabaaa
abaaaaaaegaabaaaafaaaaaaegaabaaaadaaaaaaegaabaaaabaaaaaadiaaaaah
ecaabaaaabaaaaaackaabaaaadaaaaaackaabaaaafaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaajocaabaaa
aaaaaaaaagajbaaaabaaaaaaagajbaaaaeaaaaaafgaobaaaaaaaaaaadcaaaaaj
ocaabaaaaaaaaaaaagajbaaaabaaaaaaagbjbaaaagaaaaaafgaobaaaaaaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaadgaaaaagiccabaaaaaaaaaaaakiacaaaaaaaaaaaagaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Time]
Vector 1 [_Color]
Float 2 [_MainTexSpeed]
Float 3 [_Bump1Speed]
Float 4 [_Texture2Speed]
Float 5 [_Bump2Speed]
Float 6 [_DistortionSpeed]
Float 7 [_DistortionPower]
Float 8 [_Opacity]
Float 9 [_ReflectPower]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [unity_Lightmap] 2D 6
"3.0-!!ARBfp1.0
PARAM c[11] = { program.local[0..9],
		{ 2, 1, 8, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.y, c[2].x;
MOV R1.x, c[4];
MAD R0.zw, R0.y, c[0].x, fragment.texcoord[0];
MOV R0.x, c[0];
MAD R0.xy, R0.x, c[6].x, fragment.texcoord[0];
TEX R2.yw, R0, texture[0], 2D;
MAD R0.xy, R2.wyzw, c[10].x, -c[10].y;
MAD R1.xy, R1.x, c[0].x, fragment.texcoord[1];
MAD R1.xy, R0, c[7].x, R1;
MAD R0.zw, R0.xyxy, c[7].x, R0;
TEX R2.xyz, R1, texture[2], 2D;
TEX R1.xyz, R0.zwzw, texture[1], 2D;
MUL R1.xyz, R1, R2;
MAD R1.xy, R0, c[7].x, R1;
MUL R2.xyz, R1, c[1];
MOV R0.z, c[5].x;
MOV R1.x, c[3];
MAD R0.zw, R0.z, c[0].x, fragment.texcoord[2].xyxy;
MAD R0.zw, R0.xyxy, c[7].x, R0;
MAD R1.xy, R1.x, c[0].x, fragment.texcoord[1].zwzw;
MAD R0.xy, R0, c[7].x, R1;
TEX R1.xyz, R0.zwzw, texture[4], 2D;
TEX R0.xyz, R0, texture[3], 2D;
ADD R0.xyz, R0, R1;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
MUL R0.xyz, R0, c[10].w;
MUL R0.xyz, fragment.texcoord[3].xzyw, R0;
RSQ R0.w, R0.w;
MAD R0.w, fragment.texcoord[3].z, -R0, c[10].y;
TEX R1.xyz, R0, texture[5], CUBE;
MUL R1.w, R0, c[9].x;
TEX R0, fragment.texcoord[4], texture[6], 2D;
MUL R0.xyz, R0.w, R0;
MUL R1.xyz, R1, R1.w;
MUL R0.xyz, R0, R2;
MAD result.color.xyz, R0, c[10].z, R1;
MOV result.color.w, c[8].x;
END
# 37 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Time]
Vector 1 [_Color]
Float 2 [_MainTexSpeed]
Float 3 [_Bump1Speed]
Float 4 [_Texture2Speed]
Float 5 [_Bump2Speed]
Float 6 [_DistortionSpeed]
Float 7 [_DistortionPower]
Float 8 [_Opacity]
Float 9 [_ReflectPower]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [unity_Lightmap] 2D 6
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_cube s5
dcl_2d s6
def c10, 2.00000000, -1.00000000, 0.50000000, 1.00000000
def c11, 8.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xy
mov r0.y, c0.x
mov r1.x, c0
mad r0.zw, c2.x, r0.y, v0
mov r0.x, c6
mad r0.xy, c0.x, r0.x, v0
texld r2.yw, r0, s0
mad_pp r0.xy, r2.wyzw, c10.x, c10.y
mad r1.xy, c4.x, r1.x, v1
mad r2.xy, r0, c7.x, r1
mad r1.xy, r0, c7.x, r0.zwzw
texld r2.xyz, r2, s2
texld r1.xyz, r1, s1
mul r1.xyz, r1, r2
mad r1.xy, r0, c7.x, r1
mul r2.xyz, r1, c1
mov r0.w, c0.x
mad r1.xy, c5.x, r0.w, v2
mad r1.xy, r0, c7.x, r1
mov r0.z, c0.x
mad r0.zw, c3.x, r0.z, v1
mad r0.xy, r0, c7.x, r0.zwzw
dp3 r0.w, v3, v3
rsq r0.w, r0.w
mad r0.w, v3.z, -r0, c10
texld r1.xyz, r1, s4
texld r0.xyz, r0, s3
add_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c10.z
mul r0.xyz, v3.xzyw, r0
texld r1.xyz, r0, s5
mul r1.w, r0, c9.x
texld r0, v4, s6
mul_pp r0.xyz, r0.w, r0
mul r1.xyz, r1, r1.w
mul_pp r0.xyz, r0, r2
mad_pp oC0.xyz, r0, c11.x, r1
mov_pp oC0.w, c8.x
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_DistortionMap] 2D 4
SetTexture 1 [_Texture1] 2D 0
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 1
SetTexture 4 [_BumpMap2] 2D 3
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [unity_Lightmap] 2D 6
ConstBuffer "$Globals" 208
Vector 48 [_Color]
Float 64 [_MainTexSpeed]
Float 68 [_Bump1Speed]
Float 72 [_Texture2Speed]
Float 76 [_Bump2Speed]
Float 80 [_DistortionSpeed]
Float 84 [_DistortionPower]
Float 96 [_Opacity]
Float 100 [_ReflectPower]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedbcffmmhimepmhokdhlfplkhbdkllchdfabaaaaaakiagaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefciiafaaaa
eaaaaaaagcabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaafidaaaaeaahabaaaafaaaaaaffffaaaafibiaaae
aahabaaaagaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaadcaaaaal
dcaabaaaaaaaaaaaagiacaaaabaaaaaaaaaaaaaaagiacaaaaaaaaaaaaeaaaaaa
ogbkbaaaabaaaaaadcaaaaalmcaabaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
agiacaaaabaaaaaaaaaaaaaaagbebaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaeaaaaaadcaaaaapmcaabaaa
aaaaaaaapgahbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaaaea
aceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialpdcaaaaakdcaabaaaaaaaaaaa
ogakbaaaaaaaaaaafgifcaaaaaaaaaaaafaaaaaaegaabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
diaaaaaidcaabaaaaaaaaaaaogakbaaaaaaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaalpcaabaaaacaaaaaaagiacaaaabaaaaaaaaaaaaaakgifcaaaaaaaaaaa
aeaaaaaaegbobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaogaobaaaaaaaaaaa
fgifcaaaaaaaaaaaafaaaaaaegaobaaaacaaaaaaefaaaaajpcaabaaaadaaaaaa
egaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaogakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadcaaaaaj
dcaabaaaaeaaaaaaegaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaaaaaaaaaa
diaaaaahecaabaaaaeaaaaaackaabaaaabaaaaaackaabaaaadaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaal
dcaabaaaaaaaaaaaagiacaaaabaaaaaaaaaaaaaapgipcaaaaaaaaaaaaeaaaaaa
egbabaaaadaaaaaadcaaaaakdcaabaaaaaaaaaaaogakbaaaaaaaaaaafgifcaaa
aaaaaaaaafaaaaaaegaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaeaaaaaaaagabaaaadaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaigbbbaaaaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egacbaaaaaaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackbabaiaebaaaaaaaeaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaadaaaaaa
eghobaaaagaaaaaaaagabaaaagaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgapbaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaaaaaaaaadgaaaaagiccabaaaaaaaaaaaakiacaaaaaaaaaaa
agaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Float 3 [_MainTexSpeed]
Float 4 [_Bump1Speed]
Float 5 [_Texture2Speed]
Float 6 [_Bump2Speed]
Float 7 [_DistortionSpeed]
Float 8 [_DistortionPower]
Float 9 [_Specular]
Float 10 [_Gloss]
Float 11 [_Opacity]
Float 12 [_ReflectPower]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [_ShadowMapTexture] 2D 6
"3.0-!!ARBfp1.0
PARAM c[15] = { program.local[0..12],
		{ 2, 1, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.y, c[4].x;
MOV R0.z, c[6].x;
MAD R1.xy, R0.y, c[0].x, fragment.texcoord[1].zwzw;
MOV R0.x, c[0];
MAD R0.xy, R0.x, c[7].x, fragment.texcoord[0];
TEX R0.yw, R0, texture[0], 2D;
MAD R4.xy, R0.wyzw, c[13].x, -c[13].y;
MAD R1.zw, R0.z, c[0].x, fragment.texcoord[2].xyxy;
MAD R0.zw, R4.xyxy, c[8].x, R1;
MAD R0.xy, R4, c[8].x, R1;
TEX R1, R0.zwzw, texture[4], 2D;
TEX R0, R0, texture[3], 2D;
ADD R2, R0, R1;
ADD R0.xy, R2.wyzw, -c[13].y;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[13].y;
RSQ R0.z, R0.z;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
MUL R2.xyz, R2, c[14].w;
MUL R2.xyz, fragment.texcoord[3].xzyw, R2;
RCP R0.z, R0.z;
RSQ R0.w, R0.w;
MOV R1.xyz, fragment.texcoord[4];
MAD R1.xyz, R0.w, fragment.texcoord[3], R1;
DP3 R0.w, R0, R0;
DP3 R1.w, R1, R1;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, R0;
RSQ R1.w, R1.w;
MUL R1.xyz, R1.w, R1;
DP3 R0.w, R0, fragment.texcoord[4];
DP3 R0.x, R0, R1;
MAX R1.y, R0.w, c[13].z;
MAX R1.x, R0, c[13].z;
MOV R0.xyz, c[14];
MOV R0.w, c[13];
DP3 R0.y, R0, c[1];
MUL R0.w, R0, c[10].x;
POW R0.x, R1.x, R0.w;
MUL R0.w, R0.x, R0.y;
MUL R0.xyz, R1.y, c[1];
TXP R1.x, fragment.texcoord[6], texture[6], 2D;
MUL R0, R1.x, R0;
MUL R3, R0, c[13].x;
MOV R0.y, c[5].x;
MAD R0.zw, R0.y, c[0].x, fragment.texcoord[1].xyxy;
MAD R0.zw, R4.xyxy, c[8].x, R0;
TEX R1.xyz, R0.zwzw, texture[2], 2D;
MOV R0.x, c[3];
MAD R0.xy, R0.x, c[0].x, fragment.texcoord[0].zwzw;
MAD R0.xy, R4, c[8].x, R0;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, R1;
MUL R1.w, R3, c[9].x;
MAD R0.xy, R4, c[8].x, R0;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
MAD R0.w, fragment.texcoord[3].z, -R0, c[13].y;
MUL R0.xyz, R0, c[2];
MUL R1.xyz, R3, R1.w;
MAD R1.xyz, R0, R3, R1;
MUL R0.w, R0, c[12].x;
TEX R2.xyz, R2, texture[5], CUBE;
MUL R2.xyz, R2, R0.w;
MAD R0.xyz, R0, fragment.texcoord[5], R1;
ADD result.color.xyz, R0, R2;
MOV result.color.w, c[11].x;
END
# 68 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Float 3 [_MainTexSpeed]
Float 4 [_Bump1Speed]
Float 5 [_Texture2Speed]
Float 6 [_Bump2Speed]
Float 7 [_DistortionSpeed]
Float 8 [_DistortionPower]
Float 9 [_Specular]
Float 10 [_Gloss]
Float 11 [_Opacity]
Float 12 [_ReflectPower]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [_ShadowMapTexture] 2D 6
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_cube s5
dcl_2d s6
def c13, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c14, 128.00000000, 0.21997070, 0.70703125, 0.07098389
def c15, 0.50000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
dcl_texcoord6 v6
mov r0.x, c0
mad r0.zw, c4.x, r0.x, v1
mov r0.y, c7.x
mad r0.xy, c0.x, r0.y, v0
texld r1.yw, r0, s0
mov r1.x, c0
mad_pp r4.xy, r1.wyzw, c13.x, c13.y
mad r0.xy, c6.x, r1.x, v2
mad r1.xy, r4, c8.x, r0
mad r0.xy, r4, c8.x, r0.zwzw
texld r0, r0, s3
texld r1, r1, s4
add_pp r2, r0, r1
add_pp r0.xy, r2.wyzw, c13.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c13
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
dp3_pp r1.w, v3, v3
mul_pp r2.xyz, r2, c15.x
mul r2.xyz, v3.xzyw, r2
mul_pp r0.xyz, r0.w, r0
rsq_pp r1.w, r1.w
mov_pp r1.xyz, v4
mad_pp r1.xyz, r1.w, v3, r1
dp3_pp r1.w, r0, v4
dp3_pp r0.w, r1, r1
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r1
dp3_pp r0.x, r0, r1
mov_pp r0.w, c10.x
mul_pp r1.y, c14.x, r0.w
max_pp r1.x, r0, c13.w
pow r0, r1.x, r1.y
mov_pp r1.xyz, c1
dp3_pp r0.y, c14.yzww, r1
mul r0.w, r0.x, r0.y
max_pp r1.w, r1, c13
texldp r1.x, v6, s6
mul_pp r0.xyz, r1.w, c1
mul_pp r0, r1.x, r0
mul_pp r3, r0, c13.x
mov r0.y, c0.x
mad r1.xy, c5.x, r0.y, v1
mov r0.x, c0
mad r0.xy, c3.x, r0.x, v0.zwzw
mad r1.xy, r4, c8.x, r1
mad r0.xy, r4, c8.x, r0
mul_pp r0.w, r3, c9.x
texld r1.xyz, r1, s2
texld r0.xyz, r0, s1
mul r0.xyz, r0, r1
mul_pp r1.xyz, r3, r0.w
mad r0.xy, r4, c8.x, r0
mul r0.xyz, r0, c2
dp3 r0.w, v3, v3
mad_pp r1.xyz, r0, r3, r1
rsq r0.w, r0.w
mad r0.w, v3.z, -r0, c13.z
mul r0.w, r0, c12.x
texld r2.xyz, r2, s5
mul r2.xyz, r2, r0.w
mad_pp r0.xyz, r0, v5, r1
add_pp oC0.xyz, r0, r2
mov_pp oC0.w, c11.x
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_DistortionMap] 2D 5
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 3
SetTexture 3 [_BumpMap1] 2D 2
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 6
SetTexture 6 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 256
Vector 16 [_LightColor0]
Vector 112 [_Color]
Float 128 [_MainTexSpeed]
Float 132 [_Bump1Speed]
Float 136 [_Texture2Speed]
Float 140 [_Bump2Speed]
Float 144 [_DistortionSpeed]
Float 148 [_DistortionPower]
Float 152 [_Specular]
Float 156 [_Gloss]
Float 160 [_Opacity]
Float 164 [_ReflectPower]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedlfdfcghoemcdimohmjakedphbfpmhapnabaaaaaapaajaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaahaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckaaiaaaaeaaaaaaaciacaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
fkaaaaadaagabaaaagaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafidaaaae
aahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaa
agaaaaaagcbaaaadlcbabaaaahaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajocaabaaaaaaaaaaa
agbjbaaaaeaaaaaaagaabaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackbabaiaebaaaaaaaeaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaa
baaaaaahbcaabaaaabaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaa
aaaaaaaaagaabaaaabaaaaaadcaaaaaldcaabaaaabaaaaaaagiacaaaabaaaaaa
aaaaaaaapgipcaaaaaaaaaaaaiaaaaaaegbabaaaadaaaaaadcaaaaalmcaabaaa
abaaaaaaagiacaaaaaaaaaaaajaaaaaaagiacaaaabaaaaaaaaaaaaaaagbebaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaafaaaaaadcaaaaapmcaabaaaabaaaaaapgahbaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialp
aaaaialpdcaaaaakdcaabaaaabaaaaaaogakbaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaaegaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaalpcaabaaaadaaaaaaagiacaaa
abaaaaaaaaaaaaaakgifcaaaaaaaaaaaaiaaaaaaegbobaaaacaaaaaadcaaaaak
pcaabaaaadaaaaaaogaobaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaaegaobaaa
adaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaadaaaaaaeghobaaaadaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaa
acaaaaaaaagabaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaaaaaaaaakdcaabaaaaeaaaaaahgapbaaaacaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaakhcaabaaaacaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaigbbbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaa
egacbaaaacaaaaaaeghobaaaafaaaaaaaagabaaaagaaaaaaapaaaaahbcaabaaa
abaaaaaaegaabaaaaeaaaaaaegaabaaaaeaaaaaaddaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaeaaaaaaakaabaaa
abaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaa
eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaaeaaaaaa
agaabaaaabaaaaaaegacbaaaaeaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaa
aeaaaaaajgahbaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaafaaaaaa
egacbaaaaeaaaaaadeaaaaakgcaabaaaaaaaaaaafgagbaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaaihcaabaaaaeaaaaaakgakbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaacpaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaaiecaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaabeaaaaa
aaaaaaeddiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
bjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaabaaaaaalecaabaaaaaaaaaaa
egiccaaaaaaaaaaaabaaaaaaaceaaaaakoehgbdopepndedphdgijbdnaaaaaaaa
diaaaaahicaabaaaaeaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaah
gcaabaaaaaaaaaaaagbbbaaaahaaaaaapgbpbaaaahaaaaaaefaaaaajpcaabaaa
afaaaaaajgafbaaaaaaaaaaaeghobaaaagaaaaaaaagabaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaaakaabaaaafaaaaaaakaabaaaafaaaaaadiaaaaahpcaabaaa
aeaaaaaafgafbaaaaaaaaaaaegaobaaaaeaaaaaadiaaaaaiccaabaaaaaaaaaaa
dkaabaaaaeaaaaaackiacaaaaaaaaaaaajaaaaaadiaaaaahocaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagajbaaaaeaaaaaadiaaaaaidcaabaaaabaaaaaaogakbaaa
abaaaaaafgifcaaaaaaaaaaaajaaaaaadcaaaaaldcaabaaaafaaaaaaagiacaaa
abaaaaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaaogbkbaaaabaaaaaadcaaaaak
mcaabaaaabaaaaaakgaobaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaaagaebaaa
afaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaajdcaabaaaabaaaaaaegaabaaaafaaaaaaegaabaaa
adaaaaaaegaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaadaaaaaa
ckaabaaaafaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaahaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaaagajbaaa
aeaaaaaafgaobaaaaaaaaaaadcaaaaajocaabaaaaaaaaaaaagajbaaaabaaaaaa
agbjbaaaagaaaaaafgaobaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
acaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaagiccabaaaaaaaaaaa
akiacaaaaaaaaaaaakaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Time]
Vector 1 [_Color]
Float 2 [_MainTexSpeed]
Float 3 [_Bump1Speed]
Float 4 [_Texture2Speed]
Float 5 [_Bump2Speed]
Float 6 [_DistortionSpeed]
Float 7 [_DistortionPower]
Float 8 [_Opacity]
Float 9 [_ReflectPower]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [_ShadowMapTexture] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
"3.0-!!ARBfp1.0
PARAM c[11] = { program.local[0..9],
		{ 2, 1, 8, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.y, c[2].x;
MOV R0.z, c[4].x;
MAD R1.xy, R0.y, c[0].x, fragment.texcoord[0].zwzw;
MOV R0.x, c[0];
MAD R0.xy, R0.x, c[6].x, fragment.texcoord[0];
TEX R0.yw, R0, texture[0], 2D;
MAD R2.xy, R0.wyzw, c[10].x, -c[10].y;
MAD R1.zw, R0.z, c[0].x, fragment.texcoord[1].xyxy;
MAD R0.zw, R2.xyxy, c[7].x, R1;
MAD R0.xy, R2, c[7].x, R1;
TEX R1.xyz, R0.zwzw, texture[2], 2D;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, R1;
MAD R0.xy, R2, c[7].x, R0;
MUL R1.xyz, R0, c[1];
MOV R0.x, c[3];
MOV R0.z, c[5].x;
MAD R0.xy, R0.x, c[0].x, fragment.texcoord[1].zwzw;
MAD R0.zw, R0.z, c[0].x, fragment.texcoord[2].xyxy;
MAD R0.xy, R2, c[7].x, R0;
MAD R2.xy, R2, c[7].x, R0.zwzw;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
MAD R0.w, fragment.texcoord[3].z, -R0, c[10].y;
TEX R2.xyz, R2, texture[4], 2D;
TEX R0.xyz, R0, texture[3], 2D;
ADD R0.xyz, R0, R2;
MUL R0.xyz, R0, c[10].w;
MUL R0.xyz, fragment.texcoord[3].xzyw, R0;
MUL R0.w, R0, c[9].x;
TEX R0.xyz, R0, texture[5], CUBE;
MUL R2.xyz, R0, R0.w;
TEX R0, fragment.texcoord[4], texture[7], 2D;
MUL R3.xyz, R0.w, R0;
TXP R4.x, fragment.texcoord[5], texture[6], 2D;
MUL R0.xyz, R0, R4.x;
MUL R3.xyz, R3, c[10].z;
MUL R0.xyz, R0, c[10].x;
MUL R4.xyz, R3, R4.x;
MIN R0.xyz, R3, R0;
MAX R0.xyz, R0, R4;
MAD result.color.xyz, R1, R0, R2;
MOV result.color.w, c[8].x;
END
# 43 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Time]
Vector 1 [_Color]
Float 2 [_MainTexSpeed]
Float 3 [_Bump1Speed]
Float 4 [_Texture2Speed]
Float 5 [_Bump2Speed]
Float 6 [_DistortionSpeed]
Float 7 [_DistortionPower]
Float 8 [_Opacity]
Float 9 [_ReflectPower]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [_ShadowMapTexture] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_cube s5
dcl_2d s6
dcl_2d s7
def c10, 2.00000000, -1.00000000, 8.00000000, 0.50000000
def c11, 1.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xy
dcl_texcoord5 v5
mov r0.y, c0.x
mad r0.zw, c2.x, r0.y, v0
mov r0.x, c6
mad r0.xy, c0.x, r0.x, v0
texld r1.yw, r0, s0
mov r1.x, c0
mad_pp r2.xy, r1.wyzw, c10.x, c10.y
mad r0.xy, c4.x, r1.x, v1
mad r1.xy, r2, c7.x, r0
mad r0.xy, r2, c7.x, r0.zwzw
texld r1.xyz, r1, s2
texld r0.xyz, r0, s1
mul r0.xyz, r0, r1
mad r0.xy, r2, c7.x, r0
mul r1.xyz, r0, c1
mov r0.x, c0
mov r0.z, c0.x
mad r0.xy, c3.x, r0.x, v1.zwzw
mad r0.zw, c5.x, r0.z, v2.xyxy
mad r0.xy, r2, c7.x, r0
mad r2.xy, r2, c7.x, r0.zwzw
dp3 r0.w, v3, v3
rsq r0.w, r0.w
mad r0.w, v3.z, -r0, c11.x
texld r2.xyz, r2, s4
texld r0.xyz, r0, s3
add_pp r0.xyz, r0, r2
mul_pp r0.xyz, r0, c10.w
mul r0.xyz, v3.xzyw, r0
mul r0.w, r0, c9.x
texld r0.xyz, r0, s5
mul r2.xyz, r0, r0.w
texld r0, v4, s7
mul_pp r3.xyz, r0.w, r0
texldp r4.x, v5, s6
mul_pp r0.xyz, r0, r4.x
mul_pp r3.xyz, r3, c10.z
mul_pp r0.xyz, r0, c10.x
mul_pp r4.xyz, r3, r4.x
min_pp r0.xyz, r3, r0
max_pp r0.xyz, r0, r4
mad_pp oC0.xyz, r1, r0, r2
mov_pp oC0.w, c8.x
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_DistortionMap] 2D 5
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 3
SetTexture 3 [_BumpMap1] 2D 2
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 6
SetTexture 6 [_ShadowMapTexture] 2D 0
SetTexture 7 [unity_Lightmap] 2D 7
ConstBuffer "$Globals" 272
Vector 112 [_Color]
Float 128 [_MainTexSpeed]
Float 132 [_Bump1Speed]
Float 136 [_Texture2Speed]
Float 140 [_Bump2Speed]
Float 144 [_DistortionSpeed]
Float 148 [_DistortionPower]
Float 160 [_Opacity]
Float 164 [_ReflectPower]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedgfgllkbbhnknihcjkngpekijdpdeanpcabaaaaaaleahaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchmagaaaaeaaaaaaajpabaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafkaaaaadaagabaaaahaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
fibiaaaeaahabaaaaeaaaaaaffffaaaafidaaaaeaahabaaaafaaaaaaffffaaaa
fibiaaaeaahabaaaagaaaaaaffffaaaafibiaaaeaahabaaaahaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaa
adaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
lcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaagaaaaaaaagabaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaahaaaaaaaagabaaaahaaaaaadiaaaaah
ocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaabaaaaaaddaaaaahocaabaaaaaaaaaaafgaobaaa
aaaaaaaaagajbaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadeaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaaldcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaaagiacaaa
aaaaaaaaaiaaaaaaogbkbaaaabaaaaaadcaaaaalmcaabaaaabaaaaaaagiacaaa
aaaaaaaaajaaaaaaagiacaaaabaaaaaaaaaaaaaaagbebaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaafaaaaaa
dcaaaaapmcaabaaaabaaaaaapgahbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialpdcaaaaak
dcaabaaaabaaaaaaogakbaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaaegaabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaaidcaabaaaabaaaaaaogakbaaaabaaaaaafgifcaaa
aaaaaaaaajaaaaaadcaaaaalpcaabaaaadaaaaaaagiacaaaabaaaaaaaaaaaaaa
kgifcaaaaaaaaaaaaiaaaaaaegbobaaaacaaaaaadcaaaaakpcaabaaaadaaaaaa
ogaobaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaaegaobaaaadaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaa
efaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaadaaaaaaaagabaaa
acaaaaaadcaaaaajdcaabaaaafaaaaaaegaabaaaacaaaaaaegaabaaaaeaaaaaa
egaabaaaabaaaaaadiaaaaahecaabaaaafaaaaaackaabaaaacaaaaaackaabaaa
aeaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaafaaaaaaegiccaaaaaaaaaaa
ahaaaaaadcaaaaaldcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaapgipcaaa
aaaaaaaaaiaaaaaaegbabaaaadaaaaaadcaaaaakdcaabaaaabaaaaaaogakbaaa
abaaaaaafgifcaaaaaaaaaaaajaaaaaaegaabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaigbbbaaaaeaaaaaaefaaaaaj
pcaabaaaabaaaaaaegacbaaaabaaaaaaeghobaaaafaaaaaaaagabaaaagaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackbabaia
ebaaaaaaaeaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaa
aaaaaaaaakiacaaaaaaaaaaaakaaaaaadoaaaaab"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_DistortionMap_ST]
Vector 21 [_Texture1_ST]
Vector 22 [_Texture2_ST]
Vector 23 [_BumpMap1_ST]
Vector 24 [_BumpMap2_ST]
"3.0-!!ARBvp1.0
PARAM c[25] = { { 1 },
		state.matrix.mvp,
		program.local[5..24] };
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
DP3 result.texcoord[3].y, R0, R1;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[4].y, R1, R2;
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
DP4 result.texcoord[5].z, R0, c[15];
DP4 result.texcoord[5].y, R0, c[14];
DP4 result.texcoord[5].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[23].xyxy, c[23];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[24], c[24].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 37 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_DistortionMap_ST]
Vector 20 [_Texture1_ST]
Vector 21 [_Texture2_ST]
Vector 22 [_BumpMap1_ST]
Vector 23 [_BumpMap2_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c24, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c24.x
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
dp3 o4.y, r0, r2
dp3 o4.z, v2, r0
dp3 o4.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o5.y, r2, r3
dp3 o5.z, v2, r3
dp3 o5.x, v1, r3
dp4 o6.z, r0, c14
dp4 o6.y, r0, c13
dp4 o6.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
mad o2.zw, v3.xyxy, c22.xyxy, c22
mad o2.xy, v3, c21, c21.zwzw
mad o3.xy, v3, c23, c23.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 256
Matrix 48 [_LightMatrix0]
Vector 176 [_DistortionMap_ST]
Vector 192 [_Texture1_ST]
Vector 208 [_Texture2_ST]
Vector 224 [_BumpMap1_ST]
Vector 240 [_BumpMap2_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedkobfnpkophfbiacjcdknkgdgnomigconabaaaaaapaahaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcceagaaaaeaaaabaaijabaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaoaaaaaa
kgiocaaaaaaaaaaaaoaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Vector 11 [unity_Scale]
Vector 12 [_DistortionMap_ST]
Vector 13 [_Texture1_ST]
Vector 14 [_Texture2_ST]
Vector 15 [_BumpMap1_ST]
Vector 16 [_BumpMap2_ST]
"3.0-!!ARBvp1.0
PARAM c[17] = { { 1 },
		state.matrix.mvp,
		program.local[5..16] };
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
DP3 result.texcoord[3].y, R3, R1;
DP3 result.texcoord[4].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R3;
DP3 result.texcoord[3].x, R3, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[13].xyxy, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[12], c[12].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[15].xyxy, c[15];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[14], c[14].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 29 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_WorldSpaceLightPos0]
Vector 10 [unity_Scale]
Vector 11 [_DistortionMap_ST]
Vector 12 [_Texture1_ST]
Vector 13 [_Texture2_ST]
Vector 14 [_BumpMap1_ST]
Vector 15 [_BumpMap2_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c16, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c16.x
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
dp3 o4.y, r4, r2
dp3 o5.y, r2, r3
dp3 o4.z, v2, r4
dp3 o4.x, r4, v1
dp3 o5.z, v2, r3
dp3 o5.x, v1, r3
mad o1.zw, v3.xyxy, c12.xyxy, c12
mad o1.xy, v3, c11, c11.zwzw
mad o2.zw, v3.xyxy, c14.xyxy, c14
mad o2.xy, v3, c13, c13.zwzw
mad o3.xy, v3, c15, c15.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Vector 112 [_DistortionMap_ST]
Vector 128 [_Texture1_ST]
Vector 144 [_Texture2_ST]
Vector 160 [_BumpMap1_ST]
Vector 176 [_BumpMap2_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedbmcbfmedlbmpeffjngoboelafkjelibaabaaaaaahaagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefclmaeaaaaeaaaabaacpabaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaa
ahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
aiaaaaaakgiocaaaaaaaaaaaaiaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaa
aaaaaaaaakaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaaaaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
aeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
afaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaafaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_DistortionMap_ST]
Vector 21 [_Texture1_ST]
Vector 22 [_Texture2_ST]
Vector 23 [_BumpMap1_ST]
Vector 24 [_BumpMap2_ST]
"3.0-!!ARBvp1.0
PARAM c[25] = { { 1 },
		state.matrix.mvp,
		program.local[5..24] };
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
DP3 result.texcoord[3].y, R0, R1;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[4].y, R1, R2;
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
DP4 result.texcoord[5].w, R0, c[16];
DP4 result.texcoord[5].z, R0, c[15];
DP4 result.texcoord[5].y, R0, c[14];
DP4 result.texcoord[5].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[23].xyxy, c[23];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[24], c[24].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 38 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_DistortionMap_ST]
Vector 20 [_Texture1_ST]
Vector 21 [_Texture2_ST]
Vector 22 [_BumpMap1_ST]
Vector 23 [_BumpMap2_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c24, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c24.x
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
dp3 o4.y, r0, r2
dp3 o4.z, v2, r0
dp3 o4.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o5.y, r2, r3
dp3 o5.z, v2, r3
dp3 o5.x, v1, r3
dp4 o6.w, r0, c15
dp4 o6.z, r0, c14
dp4 o6.y, r0, c13
dp4 o6.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
mad o2.zw, v3.xyxy, c22.xyxy, c22
mad o2.xy, v3, c21, c21.zwzw
mad o3.xy, v3, c23, c23.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 256
Matrix 48 [_LightMatrix0]
Vector 176 [_DistortionMap_ST]
Vector 192 [_Texture1_ST]
Vector 208 [_Texture2_ST]
Vector 224 [_BumpMap1_ST]
Vector 240 [_BumpMap2_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedjbkabondhibahgojfkdkeompgcbakdcjabaaaaaapaahaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcceagaaaaeaaaabaaijabaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaoaaaaaa
kgiocaaaaaaaaaaaaoaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaagaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_DistortionMap_ST]
Vector 21 [_Texture1_ST]
Vector 22 [_Texture2_ST]
Vector 23 [_BumpMap1_ST]
Vector 24 [_BumpMap2_ST]
"3.0-!!ARBvp1.0
PARAM c[25] = { { 1 },
		state.matrix.mvp,
		program.local[5..24] };
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
DP3 result.texcoord[3].y, R0, R1;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[4].y, R1, R2;
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
DP4 result.texcoord[5].z, R0, c[15];
DP4 result.texcoord[5].y, R0, c[14];
DP4 result.texcoord[5].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[23].xyxy, c[23];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[24], c[24].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 37 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_DistortionMap_ST]
Vector 20 [_Texture1_ST]
Vector 21 [_Texture2_ST]
Vector 22 [_BumpMap1_ST]
Vector 23 [_BumpMap2_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c24, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c24.x
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
dp3 o4.y, r0, r2
dp3 o4.z, v2, r0
dp3 o4.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o5.y, r2, r3
dp3 o5.z, v2, r3
dp3 o5.x, v1, r3
dp4 o6.z, r0, c14
dp4 o6.y, r0, c13
dp4 o6.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
mad o2.zw, v3.xyxy, c22.xyxy, c22
mad o2.xy, v3, c21, c21.zwzw
mad o3.xy, v3, c23, c23.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 256
Matrix 48 [_LightMatrix0]
Vector 176 [_DistortionMap_ST]
Vector 192 [_Texture1_ST]
Vector 208 [_Texture2_ST]
Vector 224 [_BumpMap1_ST]
Vector 240 [_BumpMap2_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedkobfnpkophfbiacjcdknkgdgnomigconabaaaaaapaahaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcceagaaaaeaaaabaaijabaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaoaaaaaa
kgiocaaaaaaaaaaaaoaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaapaaaaaaogikcaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_DistortionMap_ST]
Vector 21 [_Texture1_ST]
Vector 22 [_Texture2_ST]
Vector 23 [_BumpMap1_ST]
Vector 24 [_BumpMap2_ST]
"3.0-!!ARBvp1.0
PARAM c[25] = { { 1 },
		state.matrix.mvp,
		program.local[5..24] };
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
DP3 result.texcoord[3].y, R3, R1;
DP3 result.texcoord[4].y, R1, R2;
DP3 result.texcoord[3].z, vertex.normal, R3;
DP3 result.texcoord[3].x, R3, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R2;
DP3 result.texcoord[4].x, vertex.attrib[14], R2;
DP4 result.texcoord[5].y, R0, c[14];
DP4 result.texcoord[5].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[23].xyxy, c[23];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[24], c[24].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_DistortionMap_ST]
Vector 20 [_Texture1_ST]
Vector 21 [_Texture2_ST]
Vector 22 [_BumpMap1_ST]
Vector 23 [_BumpMap2_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c24, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c24.x
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
dp3 o4.y, r4, r2
dp3 o5.y, r2, r3
dp3 o4.z, v2, r4
dp3 o4.x, r4, v1
dp3 o5.z, v2, r3
dp3 o5.x, v1, r3
dp4 o6.y, r0, c13
dp4 o6.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
mad o2.zw, v3.xyxy, c22.xyxy, c22
mad o2.xy, v3, c21, c21.zwzw
mad o3.xy, v3, c23, c23.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 256
Matrix 48 [_LightMatrix0]
Vector 176 [_DistortionMap_ST]
Vector 192 [_Texture1_ST]
Vector 208 [_Texture2_ST]
Vector 224 [_BumpMap1_ST]
Vector 240 [_BumpMap2_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedkilljmppemfjahjgfhoonhgjcodcahibabaaaaaameahaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcpiafaaaaeaaaabaahoabaaaafjaaaaaeegiocaaaaaaaaaaa
baaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
abaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaa
aaaaaaaaalaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaamaaaaaakgiocaaaaaaaaaaaamaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaanaaaaaaogikcaaaaaaaaaaaanaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaoaaaaaa
kgiocaaaaaaaaaaaaoaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
amaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaa
aeaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaaagaabaaa
aaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaa
afaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakmccabaaaadaaaaaa
agiecaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaagaebaaaaaaaaaaadcaaaaal
dccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaapaaaaaaogikcaaa
aaaaaaaaapaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaafaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaafaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaafaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
doaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Float 3 [_MainTexSpeed]
Float 4 [_Bump1Speed]
Float 5 [_Texture2Speed]
Float 6 [_Bump2Speed]
Float 7 [_DistortionSpeed]
Float 8 [_DistortionPower]
Float 9 [_Specular]
Float 10 [_Gloss]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_LightTexture0] 2D 5
"3.0-!!ARBfp1.0
PARAM c[14] = { program.local[0..11],
		{ 0, 2, 1, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.y, c[4].x;
MOV R0.z, c[6].x;
MAD R1.xy, R0.y, c[0].x, fragment.texcoord[1].zwzw;
MOV R0.x, c[0];
MAD R0.xy, R0.x, c[7].x, fragment.texcoord[0];
TEX R0.yw, R0, texture[0], 2D;
MAD R3.xy, R0.wyzw, c[12].y, -c[12].z;
MAD R1.zw, R0.z, c[0].x, fragment.texcoord[2].xyxy;
MAD R0.zw, R3.xyxy, c[8].x, R1;
MAD R0.xy, R3, c[8].x, R1;
TEX R1.yw, R0.zwzw, texture[4], 2D;
TEX R0.yw, R0, texture[3], 2D;
ADD R0.xy, R0.ywzw, R1.ywzw;
ADD R1.xy, R0.yxzw, -c[12].z;
MUL R0.xy, R1, R1;
ADD_SAT R0.x, R0, R0.y;
ADD R0.x, -R0, c[12].z;
DP3 R1.z, fragment.texcoord[4], fragment.texcoord[4];
RSQ R0.w, R0.x;
DP3 R0.y, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.x, R0.y;
MUL R0.xyz, R0.x, fragment.texcoord[3];
RSQ R1.z, R1.z;
MAD R2.xyz, R1.z, fragment.texcoord[4], R0;
RCP R1.z, R0.w;
DP3 R1.w, R2, R2;
DP3 R0.w, R1, R1;
RSQ R1.w, R1.w;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R1;
MUL R2.xyz, R1.w, R2;
DP3 R0.w, R1, R2;
DP3 R1.y, R1, R0;
MAX R1.x, R0.w, c[12];
MOV R0.xyz, c[13];
MOV R0.w, c[12];
DP3 R0.y, R0, c[1];
MUL R0.w, R0, c[10].x;
POW R0.x, R1.x, R0.w;
MUL R1.w, R0.x, R0.y;
MAX R0.y, R1, c[12].x;
DP3 R0.x, fragment.texcoord[5], fragment.texcoord[5];
MUL R1.xyz, R0.y, c[1];
TEX R0.w, R0.x, texture[5], 2D;
MUL R0, R0.w, R1;
MUL R2, R0, c[12].y;
MOV R0.y, c[5].x;
MAD R1.xy, R0.y, c[0].x, fragment.texcoord[1];
MOV R0.x, c[3];
MAD R0.xy, R0.x, c[0].x, fragment.texcoord[0].zwzw;
MAD R1.xy, R3, c[8].x, R1;
MAD R0.xy, R3, c[8].x, R0;
TEX R1.xyz, R1, texture[2], 2D;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, R1;
MUL R0.w, R2, c[9].x;
MAD R0.xy, R3, c[8].x, R0;
MUL R1.xyz, R2, R0.w;
MUL R0.xyz, R0, c[2];
MAD result.color.xyz, R0, R2, R1;
MOV result.color.w, c[12].x;
END
# 61 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Float 3 [_MainTexSpeed]
Float 4 [_Bump1Speed]
Float 5 [_Texture2Speed]
Float 6 [_Bump2Speed]
Float 7 [_DistortionSpeed]
Float 8 [_DistortionPower]
Float 9 [_Specular]
Float 10 [_Gloss]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_LightTexture0] 2D 5
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c11, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c12, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mov r0.x, c0
mad r0.zw, c4.x, r0.x, v1
mov r0.y, c7.x
mad r0.xy, c0.x, r0.y, v0
texld r1.yw, r0, s0
mov r1.x, c0
mad_pp r3.xy, r1.wyzw, c11.x, c11.y
mad r0.xy, c6.x, r1.x, v2
mad r1.xy, r3, c8.x, r0
mad r0.xy, r3, c8.x, r0.zwzw
texld r1.yw, r1, s4
texld r0.yw, r0, s3
add_pp r0.xy, r0.ywzw, r1.ywzw
add_pp r0.xy, r0.yxzw, c11.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c11
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
dp3_pp r1.x, v3, v3
rsq_pp r1.x, r1.x
dp3_pp r1.w, v4, v4
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, r1.x, v3
rsq_pp r1.w, r1.w
mad_pp r2.xyz, r1.w, v4, r1
dp3_pp r1.w, r2, r2
dp3_pp r2.w, r0, r1
rsq_pp r0.w, r1.w
mul_pp r1.xyz, r0.w, r2
dp3_pp r0.x, r0, r1
mov_pp r0.w, c10.x
mul_pp r1.y, c12.x, r0.w
max_pp r1.x, r0, c11.w
pow r0, r1.x, r1.y
mov_pp r1.xyz, c1
dp3_pp r0.y, c12.yzww, r1
mul r1.w, r0.x, r0.y
max_pp r0.y, r2.w, c11.w
dp3 r0.x, v5, v5
mul_pp r1.xyz, r0.y, c1
texld r0.x, r0.x, s5
mul_pp r0, r0.x, r1
mul_pp r2, r0, c11.x
mov r0.y, c0.x
mad r1.xy, c5.x, r0.y, v1
mov r0.x, c0
mad r0.xy, c3.x, r0.x, v0.zwzw
mad r1.xy, r3, c8.x, r1
mad r0.xy, r3, c8.x, r0
texld r1.xyz, r1, s2
texld r0.xyz, r0, s1
mul r0.xyz, r0, r1
mul_pp r0.w, r2, c9.x
mad r0.xy, r3, c8.x, r0
mul_pp r1.xyz, r2, r0.w
mul r0.xyz, r0, c2
mad_pp oC0.xyz, r0, r2, r1
mov_pp oC0.w, c11
"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
SetTexture 0 [_DistortionMap] 2D 5
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 3
SetTexture 3 [_BumpMap1] 2D 2
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Vector 16 [_LightColor0]
Vector 112 [_Color]
Float 128 [_MainTexSpeed]
Float 132 [_Bump1Speed]
Float 136 [_Texture2Speed]
Float 140 [_Bump2Speed]
Float 144 [_DistortionSpeed]
Float 148 [_DistortionPower]
Float 152 [_Specular]
Float 156 [_Gloss]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedfepjmkjhhijdlmlcjencdcnpnppihfimabaaaaaaaaajaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmiahaaaaeaaaaaaapcabaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagbjbaaaaeaaaaaa
dcaaaaajhcaabaaaabaaaaaaegbcbaaaafaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaaldcaabaaaacaaaaaaagiacaaa
abaaaaaaaaaaaaaapgipcaaaaaaaaaaaaiaaaaaaegbabaaaadaaaaaadcaaaaal
mcaabaaaacaaaaaaagiacaaaaaaaaaaaajaaaaaaagiacaaaabaaaaaaaaaaaaaa
agbebaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaafaaaaaadcaaaaapmcaabaaaacaaaaaapgahbaaaadaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaa
aaaaialpaaaaialpdcaaaaakdcaabaaaacaaaaaaogakbaaaacaaaaaafgifcaaa
aaaaaaaaajaaaaaaegaabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
acaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaalpcaabaaaaeaaaaaa
agiacaaaabaaaaaaaaaaaaaakgifcaaaaaaaaaaaaiaaaaaaegbobaaaacaaaaaa
dcaaaaakpcaabaaaaeaaaaaaogaobaaaacaaaaaafgifcaaaaaaaaaaaajaaaaaa
egaobaaaaeaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaaeaaaaaaeghobaaa
adaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaaeaaaaaa
eghobaaaacaaaaaaaagabaaaadaaaaaaaaaaaaahdcaabaaaacaaaaaahgapbaaa
adaaaaaahgapbaaaafaaaaaaaaaaaaakdcaabaaaadaaaaaaegaabaaaacaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaa
egaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaaakaabaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaaagaabaaa
aaaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaadaaaaaa
egacbaaaabaaaaaabaaaaaahccaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaa
adaaaaaadeaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaaabaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaiccaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaabeaaaaaaaaaaaed
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaalccaabaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaaaceaaaaakoehgbdopepndedphdgijbdnaaaaaaaadiaaaaah
icaabaaaabaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaaaaaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaackiacaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaaidcaabaaaacaaaaaaogakbaaaacaaaaaa
fgifcaaaaaaaaaaaajaaaaaadcaaaaaldcaabaaaadaaaaaaagiacaaaabaaaaaa
aaaaaaaaagiacaaaaaaaaaaaaiaaaaaaogbkbaaaabaaaaaadcaaaaakmcaabaaa
acaaaaaakgaobaaaacaaaaaafgifcaaaaaaaaaaaajaaaaaaagaebaaaadaaaaaa
efaaaaajpcaabaaaadaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaadaaaaaaegaabaaaaeaaaaaa
egaabaaaacaaaaaadiaaaaahecaabaaaacaaaaaackaabaaaaeaaaaaackaabaaa
adaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
ahaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Float 3 [_MainTexSpeed]
Float 4 [_Bump1Speed]
Float 5 [_Texture2Speed]
Float 6 [_Bump2Speed]
Float 7 [_DistortionSpeed]
Float 8 [_DistortionPower]
Float 9 [_Specular]
Float 10 [_Gloss]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
"3.0-!!ARBfp1.0
PARAM c[14] = { program.local[0..11],
		{ 0, 2, 1, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[4];
MOV R0.z, c[0].x;
MAD R0.zw, R0.z, c[7].x, fragment.texcoord[0].xyxy;
TEX R1.yw, R0.zwzw, texture[0], 2D;
MOV R1.x, c[6];
MAD R3.xy, R1.wyzw, c[12].y, -c[12].z;
MAD R0.zw, R1.x, c[0].x, fragment.texcoord[2].xyxy;
MAD R0.zw, R3.xyxy, c[8].x, R0;
MAD R0.xy, R0.x, c[0].x, fragment.texcoord[1].zwzw;
TEX R1.yw, R0.zwzw, texture[4], 2D;
MAD R0.xy, R3, c[8].x, R0;
TEX R0.yw, R0, texture[3], 2D;
ADD R0.xy, R0.ywzw, R1.ywzw;
ADD R0.xy, R0.yxzw, -c[12].z;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[12];
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R1.w, fragment.texcoord[4], fragment.texcoord[4];
DP3 R0.w, R0, R0;
RSQ R1.w, R1.w;
MOV R1.xyz, fragment.texcoord[3];
MAD R1.xyz, R1.w, fragment.texcoord[4], R1;
RSQ R1.w, R0.w;
MUL R0.xyz, R1.w, R0;
DP3 R0.w, R1, R1;
RSQ R1.w, R0.w;
DP3 R0.w, R0, fragment.texcoord[3];
MUL R1.xyz, R1.w, R1;
MAX R1.w, R0, c[12].x;
DP3 R0.w, R0, R1;
MUL R0.xyz, R1.w, c[1];
MOV R1.xyz, c[13];
MAX R1.w, R0, c[12].x;
MOV R0.w, c[12];
MUL R0.w, R0, c[10].x;
DP3 R1.x, R1, c[1];
POW R0.w, R1.w, R0.w;
MUL R0.w, R0, R1.x;
MUL R2, R0, c[12].y;
MOV R0.y, c[5].x;
MAD R1.xy, R0.y, c[0].x, fragment.texcoord[1];
MOV R0.x, c[3];
MAD R0.xy, R0.x, c[0].x, fragment.texcoord[0].zwzw;
MAD R1.xy, R3, c[8].x, R1;
MAD R0.xy, R3, c[8].x, R0;
TEX R1.xyz, R1, texture[2], 2D;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, R1;
MUL R0.w, R2, c[9].x;
MAD R0.xy, R3, c[8].x, R0;
MUL R1.xyz, R2, R0.w;
MUL R0.xyz, R0, c[2];
MAD result.color.xyz, R0, R2, R1;
MOV result.color.w, c[12].x;
END
# 56 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Float 3 [_MainTexSpeed]
Float 4 [_Bump1Speed]
Float 5 [_Texture2Speed]
Float 6 [_Bump2Speed]
Float 7 [_DistortionSpeed]
Float 8 [_DistortionPower]
Float 9 [_Specular]
Float 10 [_Gloss]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c11, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c12, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
mov r0.z, c7.x
mad r1.xy, c0.x, r0.z, v0
texld r1.yw, r1, s0
mov r0.x, c0
mov r0.z, c0.x
mad_pp r3.xy, r1.wyzw, c11.x, c11.y
mad r0.zw, c6.x, r0.z, v2.xyxy
mad r1.xy, r3, c8.x, r0.zwzw
mad r0.xy, c4.x, r0.x, v1.zwzw
mad r0.xy, r3, c8.x, r0
texld r1.yw, r1, s4
texld r0.yw, r0, s3
add_pp r0.xy, r0.ywzw, r1.ywzw
add_pp r0.xy, r0.yxzw, c11.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c11
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
dp3_pp r0.w, v4, v4
mov_pp r1.xyz, v3
rsq_pp r0.w, r0.w
mad_pp r2.xyz, r0.w, v4, r1
dp3_pp r1.x, r0, v3
dp3_pp r0.w, r2, r2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, r2
dp3_pp r0.x, r0, r2
mov_pp r0.w, c10.x
max_pp r1.x, r1, c11.w
mul_pp r1.xyz, r1.x, c1
mul_pp r2.x, c12, r0.w
max_pp r1.w, r0.x, c11
pow r0, r1.w, r2.x
mov_pp r2.xyz, c1
dp3_pp r0.y, c12.yzww, r2
mul r1.w, r0.x, r0.y
mul_pp r2, r1, c11.x
mov r0.y, c0.x
mad r1.xy, c5.x, r0.y, v1
mov r0.x, c0
mad r0.xy, c3.x, r0.x, v0.zwzw
mad r1.xy, r3, c8.x, r1
mad r0.xy, r3, c8.x, r0
texld r1.xyz, r1, s2
texld r0.xyz, r0, s1
mul r0.xyz, r0, r1
mul_pp r0.w, r2, c9.x
mad r0.xy, r3, c8.x, r0
mul_pp r1.xyz, r2, r0.w
mul r0.xyz, r0, c2
mad_pp oC0.xyz, r0, r2, r1
mov_pp oC0.w, c11
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_DistortionMap] 2D 4
SetTexture 1 [_Texture1] 2D 0
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 1
SetTexture 4 [_BumpMap2] 2D 3
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 48 [_Color]
Float 64 [_MainTexSpeed]
Float 68 [_Bump1Speed]
Float 72 [_Texture2Speed]
Float 76 [_Bump2Speed]
Float 80 [_DistortionSpeed]
Float 84 [_DistortionPower]
Float 88 [_Specular]
Float 92 [_Gloss]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecednfifbmmbncdhkkkmhklfkjchjboeogpgabaaaaaaceaiaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaeahaaaa
eaaaaaaambabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
afaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
egbcbaaaafaaaaaaagaabaaaaaaaaaaaegbcbaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaaldcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaapgipcaaa
aaaaaaaaaeaaaaaaegbabaaaadaaaaaadcaaaaalmcaabaaaabaaaaaaagiacaaa
aaaaaaaaafaaaaaaagiacaaaabaaaaaaaaaaaaaaagbebaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaeaaaaaa
dcaaaaapmcaabaaaabaaaaaapgahbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialpdcaaaaak
dcaabaaaabaaaaaaogakbaaaabaaaaaafgifcaaaaaaaaaaaafaaaaaaegaabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaeaaaaaa
aagabaaaadaaaaaadcaaaaalpcaabaaaadaaaaaaagiacaaaabaaaaaaaaaaaaaa
kgifcaaaaaaaaaaaaeaaaaaaegbobaaaacaaaaaadcaaaaakpcaabaaaadaaaaaa
ogaobaaaabaaaaaafgifcaaaaaaaaaaaafaaaaaaegaobaaaadaaaaaaefaaaaaj
pcaabaaaaeaaaaaaogakbaaaadaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaaaaaaaahdcaabaaaabaaaaaahgapbaaaacaaaaaahgapbaaaaeaaaaaa
aaaaaaakdcaabaaaacaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaa
acaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaacaaaaaadkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaah
ccaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
diaaaaaiocaabaaaaaaaaaaafgafbaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaa
diaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaea
aaaaaaeaaaaaaaeacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaabaaaaaadkiacaaaaaaaaaaaafaaaaaaabeaaaaaaaaaaaeddiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaabjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabaaaaaalbcaabaaaabaaaaaaegiccaaaaaaaaaaa
abaaaaaaaceaaaaakoehgbdopepndedphdgijbdnaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaaapaaaaaibcaabaaaaaaaaaaa
agaabaaaaaaaaaaakgikcaaaaaaaaaaaafaaaaaadiaaaaahhcaabaaaacaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaaogakbaaa
abaaaaaafgifcaaaaaaaaaaaafaaaaaadcaaaaaldcaabaaaaeaaaaaaagiacaaa
abaaaaaaaaaaaaaaagiacaaaaaaaaaaaaeaaaaaaogbkbaaaabaaaaaadcaaaaak
mcaabaaaabaaaaaakgaobaaaabaaaaaafgifcaaaaaaaaaaaafaaaaaaagaebaaa
aeaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaadcaaaaajdcaabaaaabaaaaaaegaabaaaaeaaaaaaegaabaaa
adaaaaaaegaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaadaaaaaa
ckaabaaaaeaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaadaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaa
aaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaab"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Float 3 [_MainTexSpeed]
Float 4 [_Bump1Speed]
Float 5 [_Texture2Speed]
Float 6 [_Bump2Speed]
Float 7 [_DistortionSpeed]
Float 8 [_DistortionPower]
Float 9 [_Specular]
Float 10 [_Gloss]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_LightTexture0] 2D 5
SetTexture 6 [_LightTextureB0] 2D 6
"3.0-!!ARBfp1.0
PARAM c[14] = { program.local[0..11],
		{ 0, 2, 1, 0.5 },
		{ 128, 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.y, c[4].x;
MOV R0.z, c[6].x;
MAD R1.xy, R0.y, c[0].x, fragment.texcoord[1].zwzw;
MOV R0.x, c[0];
MAD R0.xy, R0.x, c[7].x, fragment.texcoord[0];
TEX R0.yw, R0, texture[0], 2D;
MAD R3.xy, R0.wyzw, c[12].y, -c[12].z;
MAD R1.zw, R0.z, c[0].x, fragment.texcoord[2].xyxy;
MAD R0.zw, R3.xyxy, c[8].x, R1;
MAD R0.xy, R3, c[8].x, R1;
TEX R1.yw, R0.zwzw, texture[4], 2D;
TEX R0.yw, R0, texture[3], 2D;
ADD R0.xy, R0.ywzw, R1.ywzw;
ADD R1.xy, R0.yxzw, -c[12].z;
MUL R0.xy, R1, R1;
ADD_SAT R0.x, R0, R0.y;
ADD R0.x, -R0, c[12].z;
RSQ R0.x, R0.x;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
RCP R1.z, R0.x;
DP3 R0.y, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.x, R0.y;
MUL R0.xyz, R0.x, fragment.texcoord[3];
RSQ R0.w, R0.w;
MAD R2.xyz, R0.w, fragment.texcoord[4], R0;
DP3 R0.w, R1, R1;
DP3 R1.w, R2, R2;
RSQ R0.w, R0.w;
RSQ R1.w, R1.w;
MUL R1.xyz, R0.w, R1;
MUL R2.xyz, R1.w, R2;
DP3 R1.w, R1, R0;
MOV R0, c[13];
DP3 R1.x, R1, R2;
DP3 R0.y, R0.yzww, c[1];
MAX R1.x, R1, c[12];
MUL R0.x, R0, c[10];
POW R0.x, R1.x, R0.x;
MUL R2.w, R0.x, R0.y;
MAX R0.y, R1.w, c[12].x;
DP3 R0.z, fragment.texcoord[5], fragment.texcoord[5];
MUL R2.xyz, R0.y, c[1];
RCP R0.x, fragment.texcoord[5].w;
MAD R0.xy, fragment.texcoord[5], R0.x, c[12].w;
TEX R0.w, R0, texture[5], 2D;
SLT R0.x, c[12], fragment.texcoord[5].z;
MUL R0.x, R0, R0.w;
TEX R1.w, R0.z, texture[6], 2D;
MUL R0.x, R0, R1.w;
MUL R0, R0.x, R2;
MUL R2, R0, c[12].y;
MOV R0.y, c[5].x;
MAD R1.xy, R0.y, c[0].x, fragment.texcoord[1];
MOV R0.x, c[3];
MAD R0.xy, R0.x, c[0].x, fragment.texcoord[0].zwzw;
MAD R1.xy, R3, c[8].x, R1;
MAD R0.xy, R3, c[8].x, R0;
TEX R1.xyz, R1, texture[2], 2D;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, R1;
MUL R0.w, R2, c[9].x;
MAD R0.xy, R3, c[8].x, R0;
MUL R1.xyz, R2, R0.w;
MUL R0.xyz, R0, c[2];
MAD result.color.xyz, R0, R2, R1;
MOV result.color.w, c[12].x;
END
# 66 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Float 3 [_MainTexSpeed]
Float 4 [_Bump1Speed]
Float 5 [_Texture2Speed]
Float 6 [_Bump2Speed]
Float 7 [_DistortionSpeed]
Float 8 [_DistortionPower]
Float 9 [_Specular]
Float 10 [_Gloss]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_LightTexture0] 2D 5
SetTexture 6 [_LightTextureB0] 2D 6
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c11, 2.00000000, -1.00000000, 0.00000000, 1.00000000
def c12, 0.50000000, 128.00000000, 0, 0
def c13, 0.21997070, 0.70703125, 0.07098389, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5
mov r0.x, c0
mad r0.zw, c4.x, r0.x, v1
mov r0.y, c7.x
mad r0.xy, c0.x, r0.y, v0
texld r1.yw, r0, s0
mov r1.x, c0
mad r0.xy, c6.x, r1.x, v2
mad_pp r1.xy, r1.wyzw, c11.x, c11.y
mad r2.xy, r1, c8.x, r0
mad r0.xy, r1, c8.x, r0.zwzw
dp3_pp r1.z, v3, v3
rsq_pp r1.w, r1.z
dp3_pp r1.z, v4, v4
texld r2.yw, r2, s4
texld r0.yw, r0, s3
add_pp r0.xy, r0.ywzw, r2.ywzw
add_pp r0.xy, r0.yxzw, c11.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c11.w
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r1.w, v3
rsq_pp r1.z, r1.z
mad_pp r3.xyz, r1.z, v4, r2
dp3_pp r1.z, r3, r3
rsq_pp r0.w, r1.z
dp3_pp r1.z, r0, r2
mul_pp r2.xyz, r0.w, r3
dp3_pp r0.x, r0, r2
mov_pp r0.w, c10.x
mul_pp r2.x, c12.y, r0.w
max_pp r1.w, r0.x, c11.z
pow r0, r1.w, r2.x
mov_pp r2.xyz, c1
dp3_pp r0.y, c13, r2
mul r2.w, r0.x, r0.y
max_pp r0.y, r1.z, c11.z
mul_pp r2.xyz, r0.y, c1
rcp r0.x, v5.w
mad r3.xy, v5, r0.x, c12.x
dp3 r0.x, v5, v5
texld r0.w, r3, s5
cmp r0.y, -v5.z, c11.z, c11.w
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s6
mul_pp r0.x, r0.y, r0
mul_pp r0, r0.x, r2
mul_pp r3, r0, c11.x
mov r0.y, c0.x
mad r1.zw, c5.x, r0.y, v1.xyxy
mov r0.x, c0
mad r0.xy, c3.x, r0.x, v0.zwzw
mad r2.xy, r1, c8.x, r1.zwzw
mad r0.xy, r1, c8.x, r0
texld r2.xyz, r2, s2
texld r0.xyz, r0, s1
mul r0.xyz, r0, r2
mul_pp r0.w, r3, c9.x
mad r0.xy, r1, c8.x, r0
mul_pp r2.xyz, r3, r0.w
mul r0.xyz, r0, c2
mad_pp oC0.xyz, r0, r3, r2
mov_pp oC0.w, c11.z
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
SetTexture 0 [_DistortionMap] 2D 6
SetTexture 1 [_Texture1] 2D 2
SetTexture 2 [_Texture2] 2D 4
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 5
SetTexture 5 [_LightTexture0] 2D 0
SetTexture 6 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 256
Vector 16 [_LightColor0]
Vector 112 [_Color]
Float 128 [_MainTexSpeed]
Float 132 [_Bump1Speed]
Float 136 [_Texture2Speed]
Float 140 [_Bump2Speed]
Float 144 [_DistortionSpeed]
Float 148 [_DistortionPower]
Float 152 [_Specular]
Float 156 [_Gloss]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedfnfmkjdhmplafgofheimcmcdjdpcbafmabaaaaaaniajaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckaaiaaaaeaaaaaaaciacaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
dcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gcbaaaadpcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaagaaaaaapgbpbaaaagaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaafaaaaaa
aagabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaa
agaaaaaaabaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaah
ccaabaaaaaaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaa
abaaaaaafgafbaaaaaaaaaaaeghobaaaagaaaaaaaagabaaaabaaaaaaapaaaaah
bcaabaaaaaaaaaaaagaabaaaaaaaaaaaagaabaaaabaaaaaabaaaaaahccaabaaa
aaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaa
aeaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaakgakbaaaaaaaaaaaegbcbaaaaeaaaaaadcaaaaajocaabaaaaaaaaaaa
agbjbaaaafaaaaaafgafbaaaaaaaaaaaagajbaaaabaaaaaabaaaaaahicaabaaa
abaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaapgapbaaa
abaaaaaadcaaaaaldcaabaaaacaaaaaaagiacaaaabaaaaaaaaaaaaaapgipcaaa
aaaaaaaaaiaaaaaaegbabaaaadaaaaaadcaaaaalmcaabaaaacaaaaaaagiacaaa
aaaaaaaaajaaaaaaagiacaaaabaaaaaaaaaaaaaaagbebaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaagaaaaaa
dcaaaaapmcaabaaaacaaaaaapgahbaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialpdcaaaaak
dcaabaaaacaaaaaaogakbaaaacaaaaaafgifcaaaaaaaaaaaajaaaaaaegaabaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaaeaaaaaa
aagabaaaafaaaaaadcaaaaalpcaabaaaaeaaaaaaagiacaaaabaaaaaaaaaaaaaa
kgifcaaaaaaaaaaaaiaaaaaaegbobaaaacaaaaaadcaaaaakpcaabaaaaeaaaaaa
ogaobaaaacaaaaaafgifcaaaaaaaaaaaajaaaaaaegaobaaaaeaaaaaaefaaaaaj
pcaabaaaafaaaaaaogakbaaaaeaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaa
aeaaaaaaaaaaaaahdcaabaaaacaaaaaahgapbaaaadaaaaaahgapbaaaafaaaaaa
aaaaaaakdcaabaaaadaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaadkaabaaaabaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegacbaaaadaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaadaaaaaajgahbaaaaaaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadeaaaaakgcaabaaa
aaaaaaaafgagbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaa
cpaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaa
dkiacaaaaaaaaaaaajaaaaaaabeaaaaaaaaaaaeddiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaabaaaaaalecaabaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaaaceaaaaa
koehgbdopepndedphdgijbdnaaaaaaaadiaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaa
aaaaaaaaajaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaidcaabaaaacaaaaaaogakbaaaacaaaaaafgifcaaaaaaaaaaa
ajaaaaaadcaaaaaldcaabaaaadaaaaaaagiacaaaabaaaaaaaaaaaaaaagiacaaa
aaaaaaaaaiaaaaaaogbkbaaaabaaaaaadcaaaaakmcaabaaaacaaaaaakgaobaaa
acaaaaaafgifcaaaaaaaaaaaajaaaaaaagaebaaaadaaaaaaefaaaaajpcaabaaa
adaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaj
dcaabaaaacaaaaaaegaabaaaadaaaaaaegaabaaaaeaaaaaaegaabaaaacaaaaaa
diaaaaahecaabaaaacaaaaaackaabaaaaeaaaaaackaabaaaadaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Float 3 [_MainTexSpeed]
Float 4 [_Bump1Speed]
Float 5 [_Texture2Speed]
Float 6 [_Bump2Speed]
Float 7 [_DistortionSpeed]
Float 8 [_DistortionPower]
Float 9 [_Specular]
Float 10 [_Gloss]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_LightTextureB0] 2D 5
SetTexture 6 [_LightTexture0] CUBE 6
"3.0-!!ARBfp1.0
PARAM c[14] = { program.local[0..11],
		{ 0, 2, 1, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.y, c[4].x;
MOV R0.z, c[6].x;
MAD R1.xy, R0.y, c[0].x, fragment.texcoord[1].zwzw;
MOV R0.x, c[0];
MAD R0.xy, R0.x, c[7].x, fragment.texcoord[0];
TEX R0.yw, R0, texture[0], 2D;
MAD R3.xy, R0.wyzw, c[12].y, -c[12].z;
MAD R1.zw, R0.z, c[0].x, fragment.texcoord[2].xyxy;
MAD R0.zw, R3.xyxy, c[8].x, R1;
MAD R0.xy, R3, c[8].x, R1;
TEX R1.yw, R0.zwzw, texture[4], 2D;
TEX R0.yw, R0, texture[3], 2D;
ADD R0.xy, R0.ywzw, R1.ywzw;
ADD R1.xy, R0.yxzw, -c[12].z;
MUL R0.xy, R1, R1;
ADD_SAT R0.x, R0, R0.y;
ADD R0.x, -R0, c[12].z;
RSQ R0.x, R0.x;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
RCP R1.z, R0.x;
DP3 R0.y, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.x, R0.y;
MUL R0.xyz, R0.x, fragment.texcoord[3];
RSQ R0.w, R0.w;
MAD R2.xyz, R0.w, fragment.texcoord[4], R0;
DP3 R0.w, R1, R1;
DP3 R1.w, R2, R2;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R1;
RSQ R1.w, R1.w;
MOV R0.w, c[12];
DP3 R0.y, R1, R0;
MUL R2.xyz, R1.w, R2;
DP3 R0.x, R1, R2;
MAX R1.y, R0, c[12].x;
MAX R1.x, R0, c[12];
MOV R0.xyz, c[13];
DP3 R0.y, R0, c[1];
MUL R0.w, R0, c[10].x;
POW R0.x, R1.x, R0.w;
MUL R2.w, R0.x, R0.y;
DP3 R0.x, fragment.texcoord[5], fragment.texcoord[5];
MUL R2.xyz, R1.y, c[1];
TEX R0.w, fragment.texcoord[5], texture[6], CUBE;
TEX R1.w, R0.x, texture[5], 2D;
MUL R0.x, R1.w, R0.w;
MUL R0, R0.x, R2;
MUL R2, R0, c[12].y;
MOV R0.y, c[5].x;
MAD R1.xy, R0.y, c[0].x, fragment.texcoord[1];
MOV R0.x, c[3];
MAD R0.xy, R0.x, c[0].x, fragment.texcoord[0].zwzw;
MAD R1.xy, R3, c[8].x, R1;
MAD R0.xy, R3, c[8].x, R0;
TEX R1.xyz, R1, texture[2], 2D;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, R1;
MUL R0.w, R2, c[9].x;
MAD R0.xy, R3, c[8].x, R0;
MUL R1.xyz, R2, R0.w;
MUL R0.xyz, R0, c[2];
MAD result.color.xyz, R0, R2, R1;
MOV result.color.w, c[12].x;
END
# 63 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Float 3 [_MainTexSpeed]
Float 4 [_Bump1Speed]
Float 5 [_Texture2Speed]
Float 6 [_Bump2Speed]
Float 7 [_DistortionSpeed]
Float 8 [_DistortionPower]
Float 9 [_Specular]
Float 10 [_Gloss]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_LightTextureB0] 2D 5
SetTexture 6 [_LightTexture0] CUBE 6
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_cube s6
def c11, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c12, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xyz
mov r0.z, c7.x
mad r1.xy, c0.x, r0.z, v0
texld r1.yw, r1, s0
mov r0.x, c0
mov r0.z, c0.x
mad_pp r3.xy, r1.wyzw, c11.x, c11.y
mad r0.zw, c6.x, r0.z, v2.xyxy
mad r1.xy, r3, c8.x, r0.zwzw
texld r1.yw, r1, s4
mad r0.xy, c4.x, r0.x, v1.zwzw
mad r0.xy, r3, c8.x, r0
texld r0.yw, r0, s3
add_pp r0.xy, r0.ywzw, r1.ywzw
add_pp r0.xy, r0.yxzw, c11.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c11
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
dp3_pp r1.x, v3, v3
rsq_pp r1.x, r1.x
dp3_pp r1.w, v4, v4
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, r1.x, v3
rsq_pp r1.w, r1.w
mad_pp r2.xyz, r1.w, v4, r1
dp3_pp r1.x, r0, r1
dp3_pp r0.w, r2, r2
max_pp r2.w, r1.x, c11
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r2
dp3_pp r0.x, r0, r1
mov_pp r0.w, c10.x
mul_pp r1.y, c12.x, r0.w
max_pp r1.x, r0, c11.w
pow r0, r1.x, r1.y
mov_pp r1.xyz, c1
dp3_pp r0.y, c12.yzww, r1
mul r1.w, r0.x, r0.y
dp3 r0.x, v5, v5
mul_pp r1.xyz, r2.w, c1
texld r0.w, v5, s6
texld r0.x, r0.x, s5
mul r0.x, r0, r0.w
mul_pp r0, r0.x, r1
mul_pp r2, r0, c11.x
mov r0.y, c0.x
mad r1.xy, c5.x, r0.y, v1
mov r0.x, c0
mad r0.xy, c3.x, r0.x, v0.zwzw
mad r1.xy, r3, c8.x, r1
mad r0.xy, r3, c8.x, r0
texld r1.xyz, r1, s2
texld r0.xyz, r0, s1
mul r0.xyz, r0, r1
mul_pp r0.w, r2, c9.x
mad r0.xy, r3, c8.x, r0
mul_pp r1.xyz, r2, r0.w
mul r0.xyz, r0, c2
mad_pp oC0.xyz, r0, r2, r1
mov_pp oC0.w, c11
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_DistortionMap] 2D 6
SetTexture 1 [_Texture1] 2D 2
SetTexture 2 [_Texture2] 2D 4
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 5
SetTexture 5 [_LightTextureB0] 2D 1
SetTexture 6 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 256
Vector 16 [_LightColor0]
Vector 112 [_Color]
Float 128 [_MainTexSpeed]
Float 132 [_Bump1Speed]
Float 136 [_Texture2Speed]
Float 140 [_Bump2Speed]
Float 144 [_DistortionSpeed]
Float 148 [_DistortionPower]
Float 152 [_Specular]
Float 156 [_Gloss]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedbgehcblkjkiglcjjpojookacgblofdfdabaaaaaaeaajaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaiaiaaaaeaaaaaaaacacaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafidaaaaeaahabaaaagaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
dcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagbjbaaaaeaaaaaadcaaaaaj
hcaabaaaabaaaaaaegbcbaaaafaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaaldcaabaaaacaaaaaaagiacaaaabaaaaaa
aaaaaaaapgipcaaaaaaaaaaaaiaaaaaaegbabaaaadaaaaaadcaaaaalmcaabaaa
acaaaaaaagiacaaaaaaaaaaaajaaaaaaagiacaaaabaaaaaaaaaaaaaaagbebaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaagaaaaaadcaaaaapmcaabaaaacaaaaaapgahbaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialp
aaaaialpdcaaaaakdcaabaaaacaaaaaaogakbaaaacaaaaaafgifcaaaaaaaaaaa
ajaaaaaaegaabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaafaaaaaadcaaaaalpcaabaaaaeaaaaaaagiacaaa
abaaaaaaaaaaaaaakgifcaaaaaaaaaaaaiaaaaaaegbobaaaacaaaaaadcaaaaak
pcaabaaaaeaaaaaaogaobaaaacaaaaaafgifcaaaaaaaaaaaajaaaaaaegaobaaa
aeaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaaeaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaaeaaaaaaeghobaaa
acaaaaaaaagabaaaaeaaaaaaaaaaaaahdcaabaaaacaaaaaahgapbaaaadaaaaaa
hgapbaaaafaaaaaaaaaaaaakdcaabaaaadaaaaaaegaabaaaacaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaaegaabaaa
adaaaaaaegaabaaaadaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaaakaabaaaaaaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaadaaaaaaagaabaaaaaaaaaaa
egacbaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
abaaaaaabaaaaaahccaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaadaaaaaa
deaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaaabeaaaaaaaaaaaeddiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabaaaaaalccaabaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaaaceaaaaakoehgbdopepndedphdgijbdnaaaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaaaaaaaaaagaabaaa
aaaaaaaaeghobaaaafaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
egbcbaaaagaaaaaaeghobaaaagaaaaaaaagabaaaaaaaaaaaapaaaaahbcaabaaa
aaaaaaaaagaabaaaaaaaaaaapgapbaaaadaaaaaadiaaaaahpcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaackiacaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaaidcaabaaaacaaaaaaogakbaaaacaaaaaa
fgifcaaaaaaaaaaaajaaaaaadcaaaaaldcaabaaaadaaaaaaagiacaaaabaaaaaa
aaaaaaaaagiacaaaaaaaaaaaaiaaaaaaogbkbaaaabaaaaaadcaaaaakmcaabaaa
acaaaaaakgaobaaaacaaaaaafgifcaaaaaaaaaaaajaaaaaaagaebaaaadaaaaaa
efaaaaajpcaabaaaadaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaajdcaabaaaacaaaaaaegaabaaaadaaaaaaegaabaaaaeaaaaaa
egaabaaaacaaaaaadiaaaaahecaabaaaacaaaaaackaabaaaaeaaaaaackaabaaa
adaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
ahaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Float 3 [_MainTexSpeed]
Float 4 [_Bump1Speed]
Float 5 [_Texture2Speed]
Float 6 [_Bump2Speed]
Float 7 [_DistortionSpeed]
Float 8 [_DistortionPower]
Float 9 [_Specular]
Float 10 [_Gloss]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_LightTexture0] 2D 5
"3.0-!!ARBfp1.0
PARAM c[14] = { program.local[0..11],
		{ 0, 2, 1, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[4];
MOV R0.z, c[0].x;
MAD R0.zw, R0.z, c[7].x, fragment.texcoord[0].xyxy;
TEX R1.yw, R0.zwzw, texture[0], 2D;
MOV R1.x, c[6];
MAD R3.xy, R1.wyzw, c[12].y, -c[12].z;
MAD R0.zw, R1.x, c[0].x, fragment.texcoord[2].xyxy;
MAD R0.zw, R3.xyxy, c[8].x, R0;
MAD R0.xy, R0.x, c[0].x, fragment.texcoord[1].zwzw;
TEX R1.yw, R0.zwzw, texture[4], 2D;
MAD R0.xy, R3, c[8].x, R0;
TEX R0.yw, R0, texture[3], 2D;
ADD R0.xy, R0.ywzw, R1.ywzw;
ADD R0.xy, R0.yxzw, -c[12].z;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[12];
RSQ R0.z, R0.z;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
RCP R0.z, R0.z;
RSQ R0.w, R0.w;
MOV R1.xyz, fragment.texcoord[3];
MAD R1.xyz, R0.w, fragment.texcoord[4], R1;
DP3 R0.w, R0, R0;
RSQ R1.w, R0.w;
MUL R0.xyz, R1.w, R0;
DP3 R2.x, R1, R1;
RSQ R0.w, R2.x;
MUL R1.xyz, R0.w, R1;
DP3 R0.w, R0, fragment.texcoord[3];
DP3 R0.x, R0, R1;
MAX R1.x, R0.w, c[12];
MAX R1.y, R0.x, c[12].x;
MOV R0.xyz, c[13];
MOV R0.w, c[12];
DP3 R0.y, R0, c[1];
MUL R0.w, R0, c[10].x;
POW R0.x, R1.y, R0.w;
MUL R0.w, R0.x, R0.y;
MUL R0.xyz, R1.x, c[1];
TEX R1.w, fragment.texcoord[5], texture[5], 2D;
MUL R0, R1.w, R0;
MUL R2, R0, c[12].y;
MOV R0.y, c[5].x;
MAD R1.xy, R0.y, c[0].x, fragment.texcoord[1];
MOV R0.x, c[3];
MAD R0.xy, R0.x, c[0].x, fragment.texcoord[0].zwzw;
MAD R1.xy, R3, c[8].x, R1;
MAD R0.xy, R3, c[8].x, R0;
TEX R1.xyz, R1, texture[2], 2D;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, R1;
MUL R0.w, R2, c[9].x;
MAD R0.xy, R3, c[8].x, R0;
MUL R1.xyz, R2, R0.w;
MUL R0.xyz, R0, c[2];
MAD result.color.xyz, R0, R2, R1;
MOV result.color.w, c[12].x;
END
# 58 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_Time]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Float 3 [_MainTexSpeed]
Float 4 [_Bump1Speed]
Float 5 [_Texture2Speed]
Float 6 [_Bump2Speed]
Float 7 [_DistortionSpeed]
Float 8 [_DistortionPower]
Float 9 [_Specular]
Float 10 [_Gloss]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_LightTexture0] 2D 5
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c11, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c12, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
dcl_texcoord5 v5.xy
mov r0.z, c7.x
mad r1.xy, c0.x, r0.z, v0
texld r1.yw, r1, s0
mov r0.x, c0
mov r0.z, c0.x
mad_pp r3.xy, r1.wyzw, c11.x, c11.y
mad r0.zw, c6.x, r0.z, v2.xyxy
mad r1.xy, r3, c8.x, r0.zwzw
mad r0.xy, c4.x, r0.x, v1.zwzw
mad r0.xy, r3, c8.x, r0
texld r1.yw, r1, s4
texld r0.yw, r0, s3
add_pp r0.xy, r0.ywzw, r1.ywzw
add_pp r0.xy, r0.yxzw, c11.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c11
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
dp3_pp r1.w, v4, v4
mul_pp r0.xyz, r0.w, r0
rsq_pp r1.w, r1.w
mov_pp r1.xyz, v3
mad_pp r1.xyz, r1.w, v4, r1
dp3_pp r1.w, r0, v3
dp3_pp r0.w, r1, r1
rsq_pp r0.w, r0.w
mul_pp r1.xyz, r0.w, r1
dp3_pp r0.x, r0, r1
mov_pp r0.w, c10.x
mul_pp r1.y, c12.x, r0.w
max_pp r1.x, r0, c11.w
pow r0, r1.x, r1.y
mov_pp r1.xyz, c1
dp3_pp r0.y, c12.yzww, r1
max_pp r1.w, r1, c11
mul r0.w, r0.x, r0.y
mul_pp r0.xyz, r1.w, c1
texld r1.w, v5, s5
mul_pp r0, r1.w, r0
mul_pp r2, r0, c11.x
mov r0.y, c0.x
mad r1.xy, c5.x, r0.y, v1
mov r0.x, c0
mad r0.xy, c3.x, r0.x, v0.zwzw
mad r1.xy, r3, c8.x, r1
mad r0.xy, r3, c8.x, r0
texld r1.xyz, r1, s2
texld r0.xyz, r0, s1
mul r0.xyz, r0, r1
mul_pp r0.w, r2, c9.x
mad r0.xy, r3, c8.x, r0
mul_pp r1.xyz, r2, r0.w
mul r0.xyz, r0, c2
mad_pp oC0.xyz, r0, r2, r1
mov_pp oC0.w, c11
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_DistortionMap] 2D 5
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 3
SetTexture 3 [_BumpMap1] 2D 2
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 256
Vector 16 [_LightColor0]
Vector 112 [_Color]
Float 128 [_MainTexSpeed]
Float 132 [_Bump1Speed]
Float 136 [_Texture2Speed]
Float 140 [_Bump2Speed]
Float 144 [_DistortionSpeed]
Float 148 [_DistortionPower]
Float 152 [_Specular]
Float 156 [_Gloss]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedplmengnlphonjchgfldcimcjaiaoghbbabaaaaaajiaiaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgaahaaaaeaaaaaaaniabaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
afaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
egbcbaaaafaaaaaaagaabaaaaaaaaaaaegbcbaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaaldcaabaaaabaaaaaaagiacaaaabaaaaaaaaaaaaaapgipcaaa
aaaaaaaaaiaaaaaaegbabaaaadaaaaaadcaaaaalmcaabaaaabaaaaaaagiacaaa
aaaaaaaaajaaaaaaagiacaaaabaaaaaaaaaaaaaaagbebaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaafaaaaaa
dcaaaaapmcaabaaaabaaaaaapgahbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialpdcaaaaak
dcaabaaaabaaaaaaogakbaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaaegaabaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadcaaaaalpcaabaaaadaaaaaaagiacaaaabaaaaaaaaaaaaaa
kgifcaaaaaaaaaaaaiaaaaaaegbobaaaacaaaaaadcaaaaakpcaabaaaadaaaaaa
ogaobaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaaegaobaaaadaaaaaaefaaaaaj
pcaabaaaaeaaaaaaogakbaaaadaaaaaaeghobaaaadaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaacaaaaaaaagabaaa
adaaaaaaaaaaaaahdcaabaaaabaaaaaahgapbaaaacaaaaaahgapbaaaaeaaaaaa
aaaaaaakdcaabaaaacaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaa
acaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaacaaaaaadkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaah
ccaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
diaaaaaihcaabaaaacaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
dkiacaaaaaaaaaaaajaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabaaaaaalccaabaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaaaceaaaaa
koehgbdopepndedphdgijbdnaaaaaaaadiaaaaahicaabaaaacaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaadaaaaaa
eghobaaaafaaaaaaaagabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaacaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaa
aaaaaaaaajaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaaidcaabaaaabaaaaaaogakbaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaadcaaaaaldcaabaaaaeaaaaaaagiacaaaabaaaaaaaaaaaaaaagiacaaa
aaaaaaaaaiaaaaaaogbkbaaaabaaaaaadcaaaaakmcaabaaaabaaaaaakgaobaaa
abaaaaaafgifcaaaaaaaaaaaajaaaaaaagaebaaaaeaaaaaaefaaaaajpcaabaaa
aeaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaj
dcaabaaaabaaaaaaegaabaaaaeaaaaaaegaabaaaadaaaaaaegaabaaaabaaaaaa
diaaaaahecaabaaaabaaaaaackaabaaaadaaaaaackaabaaaaeaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
Vector 10 [_DistortionMap_ST]
Vector 11 [_BumpMap1_ST]
Vector 12 [_BumpMap2_ST]
"3.0-!!ARBvp1.0
PARAM c[13] = { program.local[0],
		state.matrix.mvp,
		program.local[5..12] };
TEMP R0;
TEMP R1;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
DP3 R0.y, R1, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[2].xyz, R0, c[9].w;
DP3 R0.y, R1, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[3].xyz, R0, c[9].w;
DP3 R0.y, R1, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[4].xyz, R0, c[9].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[11].xyxy, c[11];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[12], c[12].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 23 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
Vector 9 [_DistortionMap_ST]
Vector 10 [_BumpMap1_ST]
Vector 11 [_BumpMap2_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
dp3 r0.y, r1, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul o3.xyz, r0, c8.w
dp3 r0.y, r1, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul o4.xyz, r0, c8.w
dp3 r0.y, r1, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul o5.xyz, r0, c8.w
mad o1.zw, v3.xyxy, c10.xyxy, c10
mad o1.xy, v3, c9, c9.zwzw
mad o2.xy, v3, c11, c11.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 160
Vector 112 [_DistortionMap_ST]
Vector 128 [_BumpMap1_ST]
Vector 144 [_BumpMap2_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefieceddpongifmfbkladcfegdpmflhcjkdjoihabaaaaaabeagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcgaaeaaaaeaaaabaabiabaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacadaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaa
ahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
aiaaaaaakgiocaaaaaaaaaaaaiaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadiaaaaah
hcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadgaaaaag
bcaabaaaabaaaaaaakiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaa
akiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaaakiacaaaabaaaaaa
aoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
ecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihccabaaa
adaaaaaaegacbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadgaaaaagbcaabaaa
abaaaaaabkiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaabkiacaaa
abaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaabkiacaaaabaaaaaaaoaaaaaa
baaaaaahccaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaa
acaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihccabaaaaeaaaaaa
egacbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadgaaaaagbcaabaaaabaaaaaa
ckiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaackiacaaaabaaaaaa
anaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaabaaaaaaaoaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaaaaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaapgipcaaaabaaaaaabeaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_Time]
Float 1 [_Bump1Speed]
Float 2 [_Bump2Speed]
Float 3 [_DistortionSpeed]
Float 4 [_DistortionPower]
Float 5 [_Gloss]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_BumpMap2] 2D 2
"3.0-!!ARBfp1.0
PARAM c[7] = { program.local[0..5],
		{ 2, 1, 0.5 } };
TEMP R0;
TEMP R1;
MOV R0.y, c[1].x;
MOV R0.z, c[2].x;
MAD R1.xy, R0.y, c[0].x, fragment.texcoord[0].zwzw;
MOV R0.x, c[0];
MAD R0.xy, R0.x, c[3].x, fragment.texcoord[0];
TEX R0.yw, R0, texture[0], 2D;
MAD R1.zw, R0.z, c[0].x, fragment.texcoord[1].xyxy;
MAD R0.xy, R0.wyzw, c[6].x, -c[6].y;
MAD R0.zw, R0.xyxy, c[4].x, R1;
MAD R0.xy, R0, c[4].x, R1;
TEX R1.yw, R0.zwzw, texture[2], 2D;
TEX R0.yw, R0, texture[1], 2D;
ADD R0.xy, R0.ywzw, R1.ywzw;
ADD R0.xy, R0.yxzw, -c[6].y;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[6].y;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R0;
DP3 R0.z, fragment.texcoord[4], R1;
DP3 R0.x, R1, fragment.texcoord[2];
DP3 R0.y, R1, fragment.texcoord[3];
MAD result.color.xyz, R0, c[6].z, c[6].z;
MOV result.color.w, c[5].x;
END
# 27 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Time]
Float 1 [_Bump1Speed]
Float 2 [_Bump2Speed]
Float 3 [_DistortionSpeed]
Float 4 [_DistortionPower]
Float 5 [_Gloss]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_BumpMap1] 2D 1
SetTexture 2 [_BumpMap2] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c6, 2.00000000, -1.00000000, 1.00000000, 0.50000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xy
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
mov r0.x, c0
mad r0.zw, c1.x, r0.x, v0
mov r0.y, c3.x
mad r0.xy, c0.x, r0.y, v0
texld r1.yw, r0, s0
mov r1.x, c0
mad r0.xy, c2.x, r1.x, v1
mad_pp r1.xy, r1.wyzw, c6.x, c6.y
mad r0.xy, r1, c4.x, r0
mad r1.xy, r1, c4.x, r0.zwzw
texld r0.yw, r0, s2
texld r1.yw, r1, s1
add_pp r0.xy, r1.ywzw, r0.ywzw
add_pp r0.xy, r0.yxzw, c6.y
mul_pp r0.zw, r0.xyxy, r0.xyxy
add_pp_sat r0.z, r0, r0.w
add_pp r0.z, -r0, c6
rsq_pp r0.z, r0.z
rcp_pp r0.z, r0.z
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r0.xyz, r0.w, r0
dp3 r1.z, v4, r0
dp3 r1.x, r0, v2
dp3 r1.y, r0, v3
mad_pp oC0.xyz, r1, c6.w, c6.w
mov_pp oC0.w, c5.x
"
}
SubProgram "d3d11 " {
SetTexture 0 [_DistortionMap] 2D 2
SetTexture 1 [_BumpMap1] 2D 0
SetTexture 2 [_BumpMap2] 2D 1
ConstBuffer "$Globals" 160
Float 68 [_Bump1Speed]
Float 76 [_Bump2Speed]
Float 80 [_DistortionSpeed]
Float 84 [_DistortionPower]
Float 92 [_Gloss]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedjgjdomghjhgnpffciidhgejefndkljbpabaaaaaabaafaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpaadaaaa
eaaaaaaapmaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaadcaaaaaldcaabaaaaaaaaaaaagiacaaaaaaaaaaa
afaaaaaaagiacaaaabaaaaaaaaaaaaaaegbabaaaabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaap
dcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadcaaaaalmcaabaaa
aaaaaaaaagiacaaaabaaaaaaaaaaaaaafgifcaaaaaaaaaaaaeaaaaaakgbobaaa
abaaaaaadcaaaaakmcaabaaaaaaaaaaaagaebaaaaaaaaaaafgifcaaaaaaaaaaa
afaaaaaakgaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadcaaaaalmcaabaaaaaaaaaaaagiacaaa
abaaaaaaaaaaaaaapgipcaaaaaaaaaaaaeaaaaaaagbebaaaacaaaaaadcaaaaak
dcaabaaaaaaaaaaaegaabaaaaaaaaaaafgifcaaaaaaaaaaaafaaaaaaogakbaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaabaaaaaaaaaaaaahdcaabaaaaaaaaaaahgapbaaaaaaaaaaahgapbaaa
abaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaaaaaaaaa
egaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaa
baaaaaahccaabaaaabaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaabaaaaaah
ecaabaaaabaaaaaaegbcbaaaafaaaaaaegacbaaaaaaaaaaadcaaaaaphccabaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaagiccabaaaaaaaaaaa
dkiacaaaaaaaaaaaafaaaaaadoaaaaab"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
Vector 23 [_DistortionMap_ST]
Vector 24 [_Texture1_ST]
Vector 25 [_Texture2_ST]
Vector 26 [_BumpMap1_ST]
Vector 27 [_BumpMap2_ST]
"3.0-!!ARBvp1.0
PARAM c[28] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..27] };
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
ADD result.texcoord[5].xyz, R2, R3;
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[22].w, -vertex.position;
DP3 result.texcoord[3].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, R2, vertex.attrib[14];
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[26].xyxy, c[26];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[25], c[25].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[27], c[27].zwzw;
END
# 45 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
Vector 23 [_DistortionMap_ST]
Vector 24 [_Texture1_ST]
Vector 25 [_Texture2_ST]
Vector 26 [_BumpMap1_ST]
Vector 27 [_BumpMap2_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c28, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c22.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c28.x
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
add o6.xyz, r2, r3
mov r1.w, c28.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c22.w, -v0
dp3 o4.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c28.y
mul r1.y, r1, c13.x
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
mad o5.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o5.zw, r0
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
mad o2.zw, v3.xyxy, c26.xyxy, c26
mad o2.xy, v3, c25, c25.zwzw
mad o3.xy, v3, c27, c27.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Vector 112 [_DistortionMap_ST]
Vector 128 [_Texture1_ST]
Vector 144 [_Texture2_ST]
Vector 160 [_BumpMap1_ST]
Vector 176 [_BumpMap2_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedcloplbnokdoiahgnkgjidafglpkfimncabaaaaaacmaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcgaagaaaaeaaaabaajiabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaiaaaaaakgiocaaa
aaaaaaaaaiaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaacaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaa
egacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaa
aaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaa
aaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaa
aaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaa
bbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
dcaaaaakhccabaaaagaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_Object2World]
Matrix 13 [_World2Object]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
Vector 22 [_DistortionMap_ST]
Vector 23 [_Texture1_ST]
Vector 24 [_Texture2_ST]
Vector 25 [_BumpMap1_ST]
Vector 26 [_BumpMap2_ST]
"3.0-!!ARBvp1.0
PARAM c[27] = { { 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..26] };
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
DP3 result.texcoord[3].y, R2, R0;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[18].x;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0];
ADD R0.y, R0.x, -c[19].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[19];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, R2, vertex.attrib[14];
MOV result.texcoord[4].zw, R0;
MUL result.texcoord[6].xyz, R1, c[19].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[23].xyxy, c[23];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[24], c[24].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[26], c[26].zwzw;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[21], c[21].zwzw;
MUL result.texcoord[6].w, -R0.x, R0.y;
END
# 37 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
Vector 22 [_DistortionMap_ST]
Vector 23 [_Texture1_ST]
Vector 24 [_Texture2_ST]
Vector 25 [_BumpMap1_ST]
Vector 26 [_BumpMap2_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c27, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c16
mov r1.w, c27.x
dp4 r0.w, v0, c7
dp4 r2.z, r1, c14
dp4 r2.x, r1, c12
dp4 r2.y, r1, c13
mad r2.xyz, r2, c20.w, -v0
dp3 o4.y, r2, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c27.y
mul r1.y, r1, c17.x
mad o5.xy, r1.z, c18.zwzw, r1
mov o0, r0
mov r0.x, c19.w
add r0.y, c27.x, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c19
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
mov o5.zw, r0
mul o7.xyz, r1, c19.w
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
mad o2.zw, v3.xyxy, c25.xyxy, c25
mad o2.xy, v3, c24, c24.zwzw
mad o3.xy, v3, c26, c26.zwzw
mad o6.xy, v4, c21, c21.zwzw
mul o7.w, -r0.x, r0.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 240
Vector 112 [unity_LightmapST]
Vector 128 [_DistortionMap_ST]
Vector 144 [_Texture1_ST]
Vector 160 [_Texture2_ST]
Vector 176 [_BumpMap1_ST]
Vector 192 [_BumpMap2_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 400 [unity_ShadowFadeCenterAndType]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecednmigjhfioceiaanilgecjlgmbnjhbeooabaaaaaadiaiaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
feagaaaaeaaaabaajfabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaa
ogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaajaaaaaakgiocaaaaaaaaaaaajaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaa
akaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
alaaaaaakgiocaaaaaaaaaaaalaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaamaaaaaaogikcaaaaaaaaaaaamaaaaaadcaaaaal
mccabaaaadaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
acaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaa
agaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaia
ebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaagaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
Vector 23 [_DistortionMap_ST]
Vector 24 [_Texture1_ST]
Vector 25 [_Texture2_ST]
Vector 26 [_BumpMap1_ST]
Vector 27 [_BumpMap2_ST]
"3.0-!!ARBvp1.0
PARAM c[28] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..27] };
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
ADD result.texcoord[5].xyz, R2, R3;
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[22].w, -vertex.position;
DP3 result.texcoord[3].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, R2, vertex.attrib[14];
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[26].xyxy, c[26];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[25], c[25].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[27], c[27].zwzw;
END
# 45 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
Vector 23 [_DistortionMap_ST]
Vector 24 [_Texture1_ST]
Vector 25 [_Texture2_ST]
Vector 26 [_BumpMap1_ST]
Vector 27 [_BumpMap2_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
def c28, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c22.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c28.x
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
add o6.xyz, r2, r3
mov r1.w, c28.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c22.w, -v0
dp3 o4.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c28.y
mul r1.y, r1, c13.x
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
mad o5.xy, r1.z, c14.zwzw, r1
mov o0, r0
mov o5.zw, r0
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
mad o2.zw, v3.xyxy, c26.xyxy, c26
mad o2.xy, v3, c25, c25.zwzw
mad o3.xy, v3, c27, c27.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 208
Vector 112 [_DistortionMap_ST]
Vector 128 [_Texture1_ST]
Vector 144 [_Texture2_ST]
Vector 160 [_BumpMap1_ST]
Vector 176 [_BumpMap2_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedcloplbnokdoiahgnkgjidafglpkfimncabaaaaaacmaiaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaagaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcgaagaaaaeaaaabaajiabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagfaaaaadpccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaiaaaaaakgiocaaa
aaaaaaaaaiaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaacaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaa
egacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaa
aaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaa
aaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaa
aaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaa
bbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
dcaaaaakhccabaaaagaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_Object2World]
Matrix 13 [_World2Object]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_ProjectionParams]
Vector 19 [unity_ShadowFadeCenterAndType]
Vector 20 [unity_Scale]
Vector 21 [unity_LightmapST]
Vector 22 [_DistortionMap_ST]
Vector 23 [_Texture1_ST]
Vector 24 [_Texture2_ST]
Vector 25 [_BumpMap1_ST]
Vector 26 [_BumpMap2_ST]
"3.0-!!ARBvp1.0
PARAM c[27] = { { 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..26] };
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
DP3 result.texcoord[3].y, R2, R0;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[18].x;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0];
ADD R0.y, R0.x, -c[19].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[19];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, R2, vertex.attrib[14];
MOV result.texcoord[4].zw, R0;
MUL result.texcoord[6].xyz, R1, c[19].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[23].xyxy, c[23];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[24], c[24].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[26], c[26].zwzw;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[21], c[21].zwzw;
MUL result.texcoord[6].w, -R0.x, R0.y;
END
# 37 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
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
Vector 22 [_DistortionMap_ST]
Vector 23 [_Texture1_ST]
Vector 24 [_Texture2_ST]
Vector 25 [_BumpMap1_ST]
Vector 26 [_BumpMap2_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_texcoord5 o6
dcl_texcoord6 o7
def c27, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c16
mov r1.w, c27.x
dp4 r0.w, v0, c7
dp4 r2.z, r1, c14
dp4 r2.x, r1, c12
dp4 r2.y, r1, c13
mad r2.xyz, r2, c20.w, -v0
dp3 o4.y, r2, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c27.y
mul r1.y, r1, c17.x
mad o5.xy, r1.z, c18.zwzw, r1
mov o0, r0
mov r0.x, c19.w
add r0.y, c27.x, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c19
dp3 o4.z, v2, r2
dp3 o4.x, r2, v1
mov o5.zw, r0
mul o7.xyz, r1, c19.w
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
mad o2.zw, v3.xyxy, c25.xyxy, c25
mad o2.xy, v3, c24, c24.zwzw
mad o3.xy, v3, c26, c26.zwzw
mad o6.xy, v4, c21, c21.zwzw
mul o7.w, -r0.x, r0.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 240
Vector 112 [unity_LightmapST]
Vector 128 [_DistortionMap_ST]
Vector 144 [_Texture1_ST]
Vector 160 [_Texture2_ST]
Vector 176 [_BumpMap1_ST]
Vector 192 [_BumpMap2_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 400 [unity_ShadowFadeCenterAndType]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecednmigjhfioceiaanilgecjlgmbnjhbeooabaaaaaadiaiaaaaadaaaaaa
cmaaaaaapeaaaaaanmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheooaaaaaaaaiaaaaaa
aiaaaaaamiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaneaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaneaaaaaaafaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaaneaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaaneaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
feagaaaaeaaaabaajfabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaa
ogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaajaaaaaakgiocaaaaaaaaaaaajaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaa
akaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
alaaaaaakgiocaaaaaaaaaaaalaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaamaaaaaaogikcaaaaaaaaaaaamaaaaaadcaaaaal
mccabaaaadaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaa
aaaaaaaaahaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
acaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaa
agaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaia
ebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaagaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Time]
Vector 1 [_Color]
Float 2 [_MainTexSpeed]
Float 3 [_Bump1Speed]
Float 4 [_Texture2Speed]
Float 5 [_Bump2Speed]
Float 6 [_DistortionSpeed]
Float 7 [_DistortionPower]
Float 8 [_Specular]
Float 9 [_Opacity]
Float 10 [_ReflectPower]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [_LightBuffer] 2D 6
"3.0-!!ARBfp1.0
PARAM c[12] = { program.local[0..10],
		{ 2, 1, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.y, c[2].x;
MOV R0.z, c[4].x;
MAD R1.xy, R0.y, c[0].x, fragment.texcoord[0].zwzw;
MOV R0.x, c[0];
MAD R0.xy, R0.x, c[6].x, fragment.texcoord[0];
TEX R0.yw, R0, texture[0], 2D;
MAD R1.zw, R0.z, c[0].x, fragment.texcoord[1].xyxy;
MAD R0.zw, R0.xywy, c[11].x, -c[11].y;
MAD R1.zw, R0, c[7].x, R1;
MAD R0.xy, R0.zwzw, c[7].x, R1;
TEX R2.xyz, R1.zwzw, texture[2], 2D;
TEX R1.xyz, R0, texture[1], 2D;
MUL R2.xyz, R1, R2;
TXP R1, fragment.texcoord[4], texture[6], 2D;
MAD R2.xy, R0.zwzw, c[7].x, R2;
LG2 R0.x, R1.w;
MUL R0.x, -R0, c[8];
LG2 R1.x, R1.x;
LG2 R1.z, R1.z;
LG2 R1.y, R1.y;
ADD R3.xyz, -R1, fragment.texcoord[5];
MUL R4.xyz, R3, R0.x;
MOV R0.x, c[3];
MOV R1.x, c[5];
MAD R0.xy, R0.x, c[0].x, fragment.texcoord[1].zwzw;
MAD R1.xy, R1.x, c[0].x, fragment.texcoord[2];
MAD R1.xy, R0.zwzw, c[7].x, R1;
MAD R0.xy, R0.zwzw, c[7].x, R0;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
MAD R0.w, fragment.texcoord[3].z, -R0, c[11].y;
TEX R1.xyz, R1, texture[4], 2D;
TEX R0.xyz, R0, texture[3], 2D;
ADD R0.xyz, R0, R1;
MUL R2.xyz, R2, c[1];
MUL R0.xyz, R0, c[11].z;
MUL R0.xyz, fragment.texcoord[3].xzyw, R0;
MUL R0.w, R0, c[10].x;
TEX R0.xyz, R0, texture[5], CUBE;
MUL R0.xyz, R0, R0.w;
MAD R1.xyz, R2, R3, R4;
ADD result.color.xyz, R1, R0;
MOV result.color.w, c[9].x;
END
# 43 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Time]
Vector 1 [_Color]
Float 2 [_MainTexSpeed]
Float 3 [_Bump1Speed]
Float 4 [_Texture2Speed]
Float 5 [_Bump2Speed]
Float 6 [_DistortionSpeed]
Float 7 [_DistortionPower]
Float 8 [_Specular]
Float 9 [_Opacity]
Float 10 [_ReflectPower]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [_LightBuffer] 2D 6
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_cube s5
dcl_2d s6
def c11, 2.00000000, -1.00000000, 0.50000000, 1.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
mov r0.y, c0.x
mov r0.z, c0.x
mad r1.zw, c2.x, r0.y, v0
mov r0.x, c6
mad r0.xy, c0.x, r0.x, v0
texld r0.yw, r0, s0
mad r1.xy, c4.x, r0.z, v1
mad_pp r0.zw, r0.xywy, c11.x, c11.y
mad r1.xy, r0.zwzw, c7.x, r1
mad r0.xy, r0.zwzw, c7.x, r1.zwzw
texld r2.xyz, r1, s2
texld r1.xyz, r0, s1
mul r2.xyz, r1, r2
texldp r1, v4, s6
mad r2.xy, r0.zwzw, c7.x, r2
log_pp r0.x, r1.w
mul_pp r0.x, -r0, c8
log_pp r1.x, r1.x
log_pp r1.z, r1.z
log_pp r1.y, r1.y
add_pp r3.xyz, -r1, v5
mul_pp r4.xyz, r3, r0.x
mov r0.x, c0
mov r1.x, c0
mad r0.xy, c3.x, r0.x, v1.zwzw
mad r1.xy, c5.x, r1.x, v2
mad r1.xy, r0.zwzw, c7.x, r1
mad r0.xy, r0.zwzw, c7.x, r0
dp3 r0.w, v3, v3
rsq r0.w, r0.w
mad r0.w, v3.z, -r0, c11
texld r1.xyz, r1, s4
texld r0.xyz, r0, s3
add_pp r0.xyz, r0, r1
mul r2.xyz, r2, c1
mul_pp r0.xyz, r0, c11.z
mul r0.xyz, v3.xzyw, r0
mul r0.w, r0, c10.x
texld r0.xyz, r0, s5
mul r0.xyz, r0, r0.w
mad_pp r1.xyz, r2, r3, r4
add_pp oC0.xyz, r1, r0
mov_pp oC0.w, c9.x
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_DistortionMap] 2D 4
SetTexture 1 [_Texture1] 2D 0
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 1
SetTexture 4 [_BumpMap2] 2D 3
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [_LightBuffer] 2D 6
ConstBuffer "$Globals" 208
Vector 48 [_Color]
Float 64 [_MainTexSpeed]
Float 68 [_Bump1Speed]
Float 72 [_Texture2Speed]
Float 76 [_Bump2Speed]
Float 80 [_DistortionSpeed]
Float 84 [_DistortionPower]
Float 88 [_Specular]
Float 96 [_Opacity]
Float 100 [_ReflectPower]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedkjapfcgmklcolkkaeomijapflncknoajabaaaaaacmahaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpeafaaaaeaaaaaaahnabaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaafidaaaaeaahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
dcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaa
gcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaa
dcaaaaaldcaabaaaaaaaaaaaagiacaaaabaaaaaaaaaaaaaaagiacaaaaaaaaaaa
aeaaaaaaogbkbaaaabaaaaaadcaaaaalmcaabaaaaaaaaaaaagiacaaaaaaaaaaa
afaaaaaaagiacaaaabaaaaaaaaaaaaaaagbebaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaeaaaaaadcaaaaap
mcaabaaaaaaaaaaapgahbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaea
aaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialpdcaaaaakdcaabaaa
aaaaaaaaogakbaaaaaaaaaaafgifcaaaaaaaaaaaafaaaaaaegaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaidcaabaaaaaaaaaaaogakbaaaaaaaaaaafgifcaaaaaaaaaaa
afaaaaaadcaaaaalpcaabaaaacaaaaaaagiacaaaabaaaaaaaaaaaaaakgifcaaa
aaaaaaaaaeaaaaaaegbobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaogaobaaa
aaaaaaaafgifcaaaaaaaaaaaafaaaaaaegaobaaaacaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaa
dcaaaaajdcaabaaaaeaaaaaaegaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaa
aaaaaaaadiaaaaahecaabaaaaeaaaaaackaabaaaabaaaaaackaabaaaadaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaaadaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaaaaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaa
cpaaaaafpcaabaaaadaaaaaaegaobaaaadaaaaaadiaaaaajbcaabaaaaaaaaaaa
dkaabaiaebaaaaaaadaaaaaackiacaaaaaaaaaaaafaaaaaaaaaaaaaihcaabaaa
adaaaaaaegacbaiaebaaaaaaadaaaaaaegbcbaaaagaaaaaadiaaaaahhcaabaaa
aeaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackbabaiaebaaaaaaaeaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaabkiacaaaaaaaaaaaagaaaaaadcaaaaaldcaabaaaadaaaaaaagiacaaa
abaaaaaaaaaaaaaapgipcaaaaaaaaaaaaeaaaaaaegbabaaaadaaaaaadcaaaaak
gcaabaaaaaaaaaaakgalbaaaaaaaaaaafgifcaaaaaaaaaaaafaaaaaaagabbaaa
adaaaaaaefaaaaajpcaabaaaadaaaaaajgafbaaaaaaaaaaaeghobaaaaeaaaaaa
aagabaaaadaaaaaaaaaaaaahocaabaaaaaaaaaaaagajbaaaacaaaaaaagajbaaa
adaaaaaadiaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaadpaaaaaadpaaaaaadpdiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agbgbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaaeghobaaa
afaaaaaaaagabaaaafaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaaakiacaaa
aaaaaaaaagaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Time]
Vector 1 [_Color]
Float 2 [_MainTexSpeed]
Float 3 [_Bump1Speed]
Float 4 [_Texture2Speed]
Float 5 [_Bump2Speed]
Float 6 [_DistortionSpeed]
Float 7 [_DistortionPower]
Float 8 [_Specular]
Float 9 [_Opacity]
Float 10 [_ReflectPower]
Vector 11 [unity_LightmapFade]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [_LightBuffer] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
SetTexture 8 [unity_LightmapInd] 2D 8
"3.0-!!ARBfp1.0
PARAM c[13] = { program.local[0..11],
		{ 2, 1, 8, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[5], texture[7], 2D;
MUL R0.xyz, R0.w, R0;
TEX R1, fragment.texcoord[5], texture[8], 2D;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[12].z;
DP4 R0.w, fragment.texcoord[6], fragment.texcoord[6];
RSQ R0.w, R0.w;
RCP R1.w, R0.w;
MAD R2.xyz, R0, c[12].z, -R1;
TXP R0, fragment.texcoord[4], texture[6], 2D;
MAD_SAT R1.w, R1, c[11].z, c[11];
MAD R1.xyz, R1.w, R2, R1;
LG2 R0.w, R0.w;
LG2 R0.x, R0.x;
LG2 R0.y, R0.y;
LG2 R0.z, R0.z;
ADD R3.xyz, -R0, R1;
MUL R1.w, -R0, c[8].x;
MOV R0.y, c[2].x;
MOV R1.x, c[4];
MAD R0.zw, R0.y, c[0].x, fragment.texcoord[0];
MOV R0.x, c[0];
MAD R0.xy, R0.x, c[6].x, fragment.texcoord[0];
TEX R2.yw, R0, texture[0], 2D;
MAD R0.xy, R2.wyzw, c[12].x, -c[12].y;
MAD R1.xy, R1.x, c[0].x, fragment.texcoord[1];
MAD R1.xy, R0, c[7].x, R1;
MAD R0.zw, R0.xyxy, c[7].x, R0;
TEX R2.xyz, R1, texture[2], 2D;
TEX R1.xyz, R0.zwzw, texture[1], 2D;
MUL R1.xyz, R1, R2;
MAD R1.xy, R0, c[7].x, R1;
MUL R2.xyz, R1, c[1];
MOV R0.z, c[3].x;
MOV R1.x, c[5];
MAD R0.zw, R0.z, c[0].x, fragment.texcoord[1];
MAD R1.xy, R1.x, c[0].x, fragment.texcoord[2];
MAD R1.xy, R0, c[7].x, R1;
MAD R0.zw, R0.xyxy, c[7].x, R0;
TEX R0.xyz, R0.zwzw, texture[3], 2D;
TEX R1.xyz, R1, texture[4], 2D;
ADD R0.xyz, R0, R1;
MUL R4.xyz, R3, R1.w;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
MUL R0.xyz, R0, c[12].w;
MAD R0.w, fragment.texcoord[3].z, -R0, c[12].y;
MUL R0.xyz, fragment.texcoord[3].xzyw, R0;
MUL R0.w, R0, c[10].x;
TEX R0.xyz, R0, texture[5], CUBE;
MUL R0.xyz, R0, R0.w;
MAD R1.xyz, R2, R3, R4;
ADD result.color.xyz, R1, R0;
MOV result.color.w, c[9].x;
END
# 54 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Time]
Vector 1 [_Color]
Float 2 [_MainTexSpeed]
Float 3 [_Bump1Speed]
Float 4 [_Texture2Speed]
Float 5 [_Bump2Speed]
Float 6 [_DistortionSpeed]
Float 7 [_DistortionPower]
Float 8 [_Specular]
Float 9 [_Opacity]
Float 10 [_ReflectPower]
Vector 11 [unity_LightmapFade]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [_LightBuffer] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
SetTexture 8 [unity_LightmapInd] 2D 8
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_cube s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
def c12, 2.00000000, -1.00000000, 8.00000000, 0.50000000
def c13, 1.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
dcl_texcoord6 v6
texld r0, v5, s7
mul_pp r0.xyz, r0.w, r0
texld r1, v5, s8
mul_pp r1.xyz, r1.w, r1
mul_pp r1.xyz, r1, c12.z
dp4 r0.w, v6, v6
rsq r0.w, r0.w
rcp r1.w, r0.w
mad_pp r2.xyz, r0, c12.z, -r1
texldp r0, v4, s6
mad_sat r1.w, r1, c11.z, c11
mad_pp r1.xyz, r1.w, r2, r1
log_pp r0.w, r0.w
log_pp r0.x, r0.x
log_pp r0.y, r0.y
log_pp r0.z, r0.z
add_pp r3.xyz, -r0, r1
mul_pp r1.w, -r0, c8.x
mov r0.z, c6.x
mad r1.xy, c0.x, r0.z, v0
mov r0.x, c0
texld r2.yw, r1, s0
mov r0.z, c0.x
mad r1.xy, c4.x, r0.z, v1
mad_pp r0.zw, r2.xywy, c12.x, c12.y
mad r1.xy, r0.zwzw, c7.x, r1
mad r0.xy, c2.x, r0.x, v0.zwzw
mad r0.xy, r0.zwzw, c7.x, r0
texld r2.xyz, r1, s2
texld r1.xyz, r0, s1
mul r1.xyz, r1, r2
mad r1.xy, r0.zwzw, c7.x, r1
mul r2.xyz, r1, c1
mov r0.x, c0
mov r1.x, c0
mad r0.xy, c3.x, r0.x, v1.zwzw
mad r1.xy, c5.x, r1.x, v2
mad r1.xy, r0.zwzw, c7.x, r1
mad r0.xy, r0.zwzw, c7.x, r0
dp3 r0.w, v3, v3
rsq r0.w, r0.w
mad r0.w, v3.z, -r0, c13.x
texld r1.xyz, r1, s4
texld r0.xyz, r0, s3
add_pp r0.xyz, r0, r1
mul_pp r4.xyz, r3, r1.w
mul_pp r0.xyz, r0, c12.w
mul r0.xyz, v3.xzyw, r0
mul r0.w, r0, c10.x
texld r0.xyz, r0, s5
mul r0.xyz, r0, r0.w
mad_pp r1.xyz, r2, r3, r4
add_pp oC0.xyz, r1, r0
mov_pp oC0.w, c9.x
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_DistortionMap] 2D 4
SetTexture 1 [_Texture1] 2D 0
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 1
SetTexture 4 [_BumpMap2] 2D 3
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [_LightBuffer] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
SetTexture 8 [unity_LightmapInd] 2D 8
ConstBuffer "$Globals" 240
Vector 48 [_Color]
Float 64 [_MainTexSpeed]
Float 68 [_Bump1Speed]
Float 72 [_Texture2Speed]
Float 76 [_Bump2Speed]
Float 80 [_DistortionSpeed]
Float 84 [_DistortionPower]
Float 88 [_Specular]
Float 96 [_Opacity]
Float 100 [_ReflectPower]
Vector 208 [unity_LightmapFade]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedchbldhcpbokiolpknpfkaibolhceloikabaaaaaammaiaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefchmahaaaaeaaaaaaanpabaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
fkaaaaadaagabaaaagaaaaaafkaaaaadaagabaaaahaaaaaafkaaaaadaagabaaa
aiaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafidaaaaeaahabaaaafaaaaaa
ffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaafibiaaaeaahabaaaahaaaaaa
ffffaaaafibiaaaeaahabaaaaiaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagcbaaaad
pcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaabbaaaaah
bcaabaaaaaaaaaaaegbobaaaagaaaaaaegbobaaaagaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadccaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckiacaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaanaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaaiaaaaaaaagabaaaaiaaaaaadiaaaaah
ccaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaa
aaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaadaaaaaaeghobaaaahaaaaaaaagabaaaahaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaajgahbaiaebaaaaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaa
cpaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaajicaabaaaaaaaaaaa
dkaabaiaebaaaaaaabaaaaaackiacaaaaaaaaaaaafaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaaldcaabaaaacaaaaaa
agiacaaaabaaaaaaaaaaaaaaagiacaaaaaaaaaaaaeaaaaaaogbkbaaaabaaaaaa
dcaaaaalmcaabaaaacaaaaaaagiacaaaaaaaaaaaafaaaaaaagiacaaaabaaaaaa
aaaaaaaaagbebaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaeaaaaaadcaaaaapmcaabaaaacaaaaaapgahbaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaa
aaaaaaaaaaaaialpaaaaialpdcaaaaakdcaabaaaacaaaaaaogakbaaaacaaaaaa
fgifcaaaaaaaaaaaafaaaaaaegaabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaa
egaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaaidcaabaaa
acaaaaaaogakbaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaadcaaaaalpcaabaaa
aeaaaaaaagiacaaaabaaaaaaaaaaaaaakgifcaaaaaaaaaaaaeaaaaaaegbobaaa
acaaaaaadcaaaaakpcaabaaaaeaaaaaaogaobaaaacaaaaaafgifcaaaaaaaaaaa
afaaaaaaegaobaaaaeaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaaeaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaa
aeaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadcaaaaajdcaabaaaagaaaaaa
egaabaaaadaaaaaaegaabaaaafaaaaaaegaabaaaacaaaaaadiaaaaahecaabaaa
agaaaaaackaabaaaadaaaaaackaabaaaafaaaaaadiaaaaaihcaabaaaadaaaaaa
egacbaaaagaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackbabaiaebaaaaaaaeaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaagaaaaaadcaaaaaldcaabaaaabaaaaaaagiacaaa
abaaaaaaaaaaaaaapgipcaaaaaaaaaaaaeaaaaaaegbabaaaadaaaaaadcaaaaak
dcaabaaaabaaaaaaogakbaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaaegaabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaaeaaaaaa
aagabaaaadaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
aeaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
igbbbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaegacbaaaabaaaaaaeghobaaa
afaaaaaaaagabaaaafaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaagiccabaaaaaaaaaaaakiacaaa
aaaaaaaaagaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Time]
Vector 1 [_Color]
Float 2 [_MainTexSpeed]
Float 3 [_Bump1Speed]
Float 4 [_Texture2Speed]
Float 5 [_Bump2Speed]
Float 6 [_DistortionSpeed]
Float 7 [_DistortionPower]
Float 8 [_Specular]
Float 9 [_Opacity]
Float 10 [_ReflectPower]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [_LightBuffer] 2D 6
"3.0-!!ARBfp1.0
PARAM c[12] = { program.local[0..10],
		{ 2, 1, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.y, c[3].x;
MOV R0.z, c[5].x;
MAD R1.zw, R0.z, c[0].x, fragment.texcoord[2].xyxy;
MAD R1.xy, R0.y, c[0].x, fragment.texcoord[1].zwzw;
MOV R0.x, c[0];
MAD R0.xy, R0.x, c[6].x, fragment.texcoord[0];
TEX R0.yw, R0, texture[0], 2D;
MAD R3.xy, R0.wyzw, c[11].x, -c[11].y;
MAD R0.zw, R3.xyxy, c[7].x, R1;
MAD R0.xy, R3, c[7].x, R1;
TEX R1.xyz, R0.zwzw, texture[4], 2D;
TEX R0.xyz, R0, texture[3], 2D;
ADD R0.xyz, R0, R1;
MUL R2.xyz, R0, c[11].z;
MOV R0.y, c[4].x;
MAD R0.zw, R0.y, c[0].x, fragment.texcoord[1].xyxy;
MAD R0.zw, R3.xyxy, c[7].x, R0;
MOV R0.x, c[2];
MAD R0.xy, R0.x, c[0].x, fragment.texcoord[0].zwzw;
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.w, R1.w;
MAD R1.w, fragment.texcoord[3].z, -R1, c[11].y;
TEX R1.xyz, R0.zwzw, texture[2], 2D;
MAD R0.xy, R3, c[7].x, R0;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, R1;
MUL R1.xyz, fragment.texcoord[3].xzyw, R2;
MAD R0.xy, R3, c[7].x, R0;
MUL R2.xyz, R0, c[1];
TXP R0, fragment.texcoord[4], texture[6], 2D;
ADD R0.xyz, R0, fragment.texcoord[5];
MUL R0.w, R0, c[8].x;
MUL R3.xyz, R0, R0.w;
TEX R1.xyz, R1, texture[5], CUBE;
MUL R1.w, R1, c[10].x;
MUL R1.xyz, R1, R1.w;
MAD R0.xyz, R2, R0, R3;
ADD result.color.xyz, R0, R1;
MOV result.color.w, c[9].x;
END
# 39 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Time]
Vector 1 [_Color]
Float 2 [_MainTexSpeed]
Float 3 [_Bump1Speed]
Float 4 [_Texture2Speed]
Float 5 [_Bump2Speed]
Float 6 [_DistortionSpeed]
Float 7 [_DistortionPower]
Float 8 [_Specular]
Float 9 [_Opacity]
Float 10 [_ReflectPower]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [_LightBuffer] 2D 6
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_cube s5
dcl_2d s6
def c11, 2.00000000, -1.00000000, 0.50000000, 1.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5.xyz
mov r0.y, c0.x
mad r0.zw, c3.x, r0.y, v1
mov r0.x, c6
mad r0.xy, c0.x, r0.x, v0
texld r1.yw, r0, s0
mad_pp r3.xy, r1.wyzw, c11.x, c11.y
mov r1.x, c0
mad r0.xy, c5.x, r1.x, v2
mad r1.xy, r3, c7.x, r0
mad r0.xy, r3, c7.x, r0.zwzw
dp3 r1.w, v3, v3
rsq r1.w, r1.w
mad r1.w, v3.z, -r1, c11
texld r1.xyz, r1, s4
texld r0.xyz, r0, s3
add_pp r0.xyz, r0, r1
mul_pp r2.xyz, r0, c11.z
mov r0.y, c0.x
mad r0.zw, c4.x, r0.y, v1.xyxy
mad r1.xy, r3, c7.x, r0.zwzw
mov r0.x, c0
mad r0.xy, c2.x, r0.x, v0.zwzw
mad r0.xy, r3, c7.x, r0
texld r0.xyz, r0, s1
texld r1.xyz, r1, s2
mul r1.xyz, r0, r1
mul r0.xyz, v3.xzyw, r2
mad r1.xy, r3, c7.x, r1
mul r2.xyz, r1, c1
texld r1.xyz, r0, s5
texldp r0, v4, s6
mul r1.w, r1, c10.x
add_pp r0.xyz, r0, v5
mul_pp r0.w, r0, c8.x
mul_pp r3.xyz, r0, r0.w
mul r1.xyz, r1, r1.w
mad_pp r0.xyz, r2, r0, r3
add_pp oC0.xyz, r0, r1
mov_pp oC0.w, c9.x
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_DistortionMap] 2D 4
SetTexture 1 [_Texture1] 2D 0
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 1
SetTexture 4 [_BumpMap2] 2D 3
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [_LightBuffer] 2D 6
ConstBuffer "$Globals" 208
Vector 48 [_Color]
Float 64 [_MainTexSpeed]
Float 68 [_Bump1Speed]
Float 72 [_Texture2Speed]
Float 76 [_Bump2Speed]
Float 80 [_DistortionSpeed]
Float 84 [_DistortionPower]
Float 88 [_Specular]
Float 96 [_Opacity]
Float 100 [_ReflectPower]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedbchfeocojgbmdlambbdbkpdganaefmloabaaaaaabaahaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcniafaaaaeaaaaaaahgabaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaafidaaaaeaahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
dcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaa
gcbaaaadhcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaa
dcaaaaaldcaabaaaaaaaaaaaagiacaaaabaaaaaaaaaaaaaaagiacaaaaaaaaaaa
aeaaaaaaogbkbaaaabaaaaaadcaaaaalmcaabaaaaaaaaaaaagiacaaaaaaaaaaa
afaaaaaaagiacaaaabaaaaaaaaaaaaaaagbebaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaeaaaaaadcaaaaap
mcaabaaaaaaaaaaapgahbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaea
aaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialpdcaaaaakdcaabaaa
aaaaaaaaogakbaaaaaaaaaaafgifcaaaaaaaaaaaafaaaaaaegaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadiaaaaaidcaabaaaaaaaaaaaogakbaaaaaaaaaaafgifcaaaaaaaaaaa
afaaaaaadcaaaaalpcaabaaaacaaaaaaagiacaaaabaaaaaaaaaaaaaakgifcaaa
aaaaaaaaaeaaaaaaegbobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaogaobaaa
aaaaaaaafgifcaaaaaaaaaaaafaaaaaaegaobaaaacaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaa
dcaaaaajdcaabaaaaeaaaaaaegaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaa
aaaaaaaadiaaaaahecaabaaaaeaaaaaackaabaaaabaaaaaackaabaaaadaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaaadaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaaaaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaa
diaaaaaibcaabaaaaaaaaaaadkaabaaaadaaaaaackiacaaaaaaaaaaaafaaaaaa
aaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegbcbaaaagaaaaaadiaaaaah
hcaabaaaaeaaaaaaagaabaaaaaaaaaaaegacbaaaadaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackbabaiaebaaaaaa
aeaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaaaaaaaaaaaagaaaaaadcaaaaaldcaabaaaadaaaaaa
agiacaaaabaaaaaaaaaaaaaapgipcaaaaaaaaaaaaeaaaaaaegbabaaaadaaaaaa
dcaaaaakgcaabaaaaaaaaaaakgalbaaaaaaaaaaafgifcaaaaaaaaaaaafaaaaaa
agabbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaajgafbaaaaaaaaaaaeghobaaa
aeaaaaaaaagabaaaadaaaaaaaaaaaaahocaabaaaaaaaaaaaagajbaaaacaaaaaa
agajbaaaadaaaaaadiaaaaakocaabaaaaaaaaaaafgaobaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaadpaaaaaadpaaaaaadpdiaaaaahocaabaaaaaaaaaaafgaobaaa
aaaaaaaaagbgbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaajgahbaaaaaaaaaaa
eghobaaaafaaaaaaaagabaaaafaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
acaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaa
akiacaaaaaaaaaaaagaaaaaadoaaaaab"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Time]
Vector 1 [_Color]
Float 2 [_MainTexSpeed]
Float 3 [_Bump1Speed]
Float 4 [_Texture2Speed]
Float 5 [_Bump2Speed]
Float 6 [_DistortionSpeed]
Float 7 [_DistortionPower]
Float 8 [_Specular]
Float 9 [_Opacity]
Float 10 [_ReflectPower]
Vector 11 [unity_LightmapFade]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [_LightBuffer] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
SetTexture 8 [unity_LightmapInd] 2D 8
"3.0-!!ARBfp1.0
PARAM c[13] = { program.local[0..11],
		{ 2, 1, 8, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.x, c[2];
MOV R0.y, c[0].x;
MAD R0.zw, R0.y, c[6].x, fragment.texcoord[0].xyxy;
TEX R0.yw, R0.zwzw, texture[0], 2D;
MAD R2.xy, R0.wyzw, c[12].x, -c[12].y;
MAD R1.xy, R0.x, c[0].x, fragment.texcoord[0].zwzw;
MOV R0.x, c[4];
MAD R1.zw, R0.x, c[0].x, fragment.texcoord[1].xyxy;
MAD R0.xy, R2, c[7].x, R1.zwzw;
MAD R1.xy, R2, c[7].x, R1;
TEX R3, fragment.texcoord[5], texture[7], 2D;
DP4 R0.w, fragment.texcoord[6], fragment.texcoord[6];
RSQ R0.w, R0.w;
RCP R0.w, R0.w;
TEX R1.xyz, R1, texture[1], 2D;
TEX R0.xyz, R0, texture[2], 2D;
MUL R0.xyz, R1, R0;
MAD R0.xy, R2, c[7].x, R0;
TEX R1, fragment.texcoord[5], texture[8], 2D;
MUL R4.xyz, R3.w, R3;
MUL R1.xyz, R1.w, R1;
MUL R3.xyz, R1, c[12].z;
MAD R4.xyz, R4, c[12].z, -R3;
MAD_SAT R0.w, R0, c[11].z, c[11];
MAD R3.xyz, R0.w, R4, R3;
TXP R1, fragment.texcoord[4], texture[6], 2D;
MUL R0.w, R1, c[8].x;
ADD R1.xyz, R1, R3;
MUL R3.xyz, R1, R0.w;
MOV R0.w, c[5].x;
MAD R2.zw, R0.w, c[0].x, fragment.texcoord[2].xyxy;
MUL R0.xyz, R0, c[1];
MOV R1.w, c[3].x;
MAD R4.xy, R1.w, c[0].x, fragment.texcoord[1].zwzw;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
MAD R0.w, fragment.texcoord[3].z, -R0, c[12].y;
MAD R4.xy, R2, c[7].x, R4;
MAD R4.zw, R2.xyxy, c[7].x, R2;
TEX R2.xyz, R4, texture[3], 2D;
TEX R4.xyz, R4.zwzw, texture[4], 2D;
ADD R2.xyz, R2, R4;
MUL R2.xyz, R2, c[12].w;
MUL R2.xyz, fragment.texcoord[3].xzyw, R2;
MUL R0.w, R0, c[10].x;
TEX R2.xyz, R2, texture[5], CUBE;
MUL R2.xyz, R2, R0.w;
MAD R0.xyz, R0, R1, R3;
ADD result.color.xyz, R0, R2;
MOV result.color.w, c[9].x;
END
# 50 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Time]
Vector 1 [_Color]
Float 2 [_MainTexSpeed]
Float 3 [_Bump1Speed]
Float 4 [_Texture2Speed]
Float 5 [_Bump2Speed]
Float 6 [_DistortionSpeed]
Float 7 [_DistortionPower]
Float 8 [_Specular]
Float 9 [_Opacity]
Float 10 [_ReflectPower]
Vector 11 [unity_LightmapFade]
SetTexture 0 [_DistortionMap] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 3
SetTexture 4 [_BumpMap2] 2D 4
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [_LightBuffer] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
SetTexture 8 [unity_LightmapInd] 2D 8
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_cube s5
dcl_2d s6
dcl_2d s7
dcl_2d s8
def c12, 2.00000000, -1.00000000, 8.00000000, 0.50000000
def c13, 1.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1
dcl_texcoord2 v2.xy
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
dcl_texcoord5 v5.xy
dcl_texcoord6 v6
mov r0.x, c0
mov r0.z, c0.x
texld r3, v5, s8
mul_pp r3.xyz, r3.w, r3
mad r1.zw, c4.x, r0.z, v1.xyxy
texldp r4, v4, s6
mul_pp r3.xyz, r3, c12.z
mad r1.xy, c2.x, r0.x, v0.zwzw
mov r0.y, c6.x
mad r0.xy, c0.x, r0.y, v0
texld r0.yw, r0, s0
mad_pp r0.zw, r0.xywy, c12.x, c12.y
mad r0.xy, r0.zwzw, c7.x, r1.zwzw
texld r2.xyz, r0, s2
mad r1.xy, r0.zwzw, c7.x, r1
texld r1.xyz, r1, s1
mul r1.xyz, r1, r2
mad r1.xy, r0.zwzw, c7.x, r1
texld r2, v5, s7
mul_pp r2.xyz, r2.w, r2
dp4 r0.x, v6, v6
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r2.xyz, r2, c12.z, -r3
mad_sat r0.x, r0, c11.z, c11.w
mad_pp r2.xyz, r0.x, r2, r3
add_pp r2.xyz, r4, r2
mul_pp r0.x, r4.w, c8
mul_pp r3.xyz, r2, r0.x
mul r1.xyz, r1, c1
mov r0.x, c0
mov r1.w, c0.x
mad r0.xy, c3.x, r0.x, v1.zwzw
mad r4.xy, c5.x, r1.w, v2
mad r4.xy, r0.zwzw, c7.x, r4
mad r0.xy, r0.zwzw, c7.x, r0
dp3 r0.w, v3, v3
rsq r0.w, r0.w
mad r0.w, v3.z, -r0, c13.x
texld r0.xyz, r0, s3
texld r4.xyz, r4, s4
add_pp r0.xyz, r0, r4
mul_pp r0.xyz, r0, c12.w
mul r0.xyz, v3.xzyw, r0
mul r0.w, r0, c10.x
texld r0.xyz, r0, s5
mul r0.xyz, r0, r0.w
mad_pp r1.xyz, r1, r2, r3
add_pp oC0.xyz, r1, r0
mov_pp oC0.w, c9.x
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_DistortionMap] 2D 4
SetTexture 1 [_Texture1] 2D 0
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_BumpMap1] 2D 1
SetTexture 4 [_BumpMap2] 2D 3
SetTexture 5 [_Reflection] CUBE 5
SetTexture 6 [_LightBuffer] 2D 6
SetTexture 7 [unity_Lightmap] 2D 7
SetTexture 8 [unity_LightmapInd] 2D 8
ConstBuffer "$Globals" 240
Vector 48 [_Color]
Float 64 [_MainTexSpeed]
Float 68 [_Bump1Speed]
Float 72 [_Texture2Speed]
Float 76 [_Bump2Speed]
Float 80 [_DistortionSpeed]
Float 84 [_DistortionPower]
Float 88 [_Specular]
Float 96 [_Opacity]
Float 100 [_ReflectPower]
Vector 208 [unity_LightmapFade]
ConstBuffer "UnityPerCamera" 128
Vector 0 [_Time]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefieceddolohgapaelmooimahfaaahfekaeljhiabaaaaaalaaiaaaaadaaaaaa
cmaaaaaabeabaaaaeiabaaaaejfdeheooaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaneaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaneaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaneaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaneaaaaaa
afaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaaneaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaaneaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaaneaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcgaahaaaaeaaaaaaaniabaaaafjaaaaaeegiocaaa
aaaaaaaaaoaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
fkaaaaadaagabaaaagaaaaaafkaaaaadaagabaaaahaaaaaafkaaaaadaagabaaa
aiaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafidaaaaeaahabaaaafaaaaaa
ffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaafibiaaaeaahabaaaahaaaaaa
ffffaaaafibiaaaeaahabaaaaiaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagcbaaaad
pcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacahaaaaaabbaaaaah
bcaabaaaaaaaaaaaegbobaaaagaaaaaaegbobaaaagaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadccaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckiacaaaaaaaaaaaanaaaaaadkiacaaaaaaaaaaaanaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaaiaaaaaaaagabaaaaiaaaaaadiaaaaah
ccaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaa
aaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaadaaaaaaeghobaaaahaaaaaaaagabaaaahaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaajgahbaiaebaaaaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaabaaaaaackiacaaaaaaaaaaaafaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaaldcaabaaa
acaaaaaaagiacaaaabaaaaaaaaaaaaaaagiacaaaaaaaaaaaaeaaaaaaogbkbaaa
abaaaaaadcaaaaalmcaabaaaacaaaaaaagiacaaaaaaaaaaaafaaaaaaagiacaaa
abaaaaaaaaaaaaaaagbebaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaeaaaaaadcaaaaapmcaabaaaacaaaaaa
pgahbaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaceaaaaa
aaaaaaaaaaaaaaaaaaaaialpaaaaialpdcaaaaakdcaabaaaacaaaaaaogakbaaa
acaaaaaafgifcaaaaaaaaaaaafaaaaaaegaabaaaacaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaai
dcaabaaaacaaaaaaogakbaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaadcaaaaal
pcaabaaaaeaaaaaaagiacaaaabaaaaaaaaaaaaaakgifcaaaaaaaaaaaaeaaaaaa
egbobaaaacaaaaaadcaaaaakpcaabaaaaeaaaaaaogaobaaaacaaaaaafgifcaaa
aaaaaaaaafaaaaaaegaobaaaaeaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaa
aeaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaa
ogakbaaaaeaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadcaaaaajdcaabaaa
agaaaaaaegaabaaaadaaaaaaegaabaaaafaaaaaaegaabaaaacaaaaaadiaaaaah
ecaabaaaagaaaaaackaabaaaadaaaaaackaabaaaafaaaaaadiaaaaaihcaabaaa
adaaaaaaegacbaaaagaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackbabaiaebaaaaaa
aeaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaaiicaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkiacaaaaaaaaaaaagaaaaaadcaaaaaldcaabaaaabaaaaaa
agiacaaaabaaaaaaaaaaaaaapgipcaaaaaaaaaaaaeaaaaaaegbabaaaadaaaaaa
dcaaaaakdcaabaaaabaaaaaaogakbaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
egaabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
aeaaaaaaaagabaaaadaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaaeaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaigbbbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaegacbaaaabaaaaaa
eghobaaaafaaaaaaaagabaaaafaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaagiccabaaaaaaaaaaa
akiacaaaaaaaaaaaagaaaaaadoaaaaab"
}
}
 }
}
Fallback "Diffuse"
}