Shader "Cross Platform Shaders/Unique/Rock Blend" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _MossTex ("Base (RGB)", 2D) = "white" {}
 _Fading ("Fading", Range(1,10)) = 5
 _Threshold ("Threshold", Range(0,1)) = 0.5
 _FadeColor ("Fade Control", Vector) = (0,0,1,1)
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [unity_SHAr]
Vector 10 [unity_SHAg]
Vector 11 [unity_SHAb]
Vector 12 [unity_SHBr]
Vector 13 [unity_SHBg]
Vector 14 [unity_SHBb]
Vector 15 [unity_SHC]
Vector 16 [unity_Scale]
Vector 17 [_MainTex_ST]
Vector 18 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[19] = { { 1 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[16].w;
DP3 R3.w, R1, c[6];
DP3 R2.w, R1, c[7];
DP3 R0.x, R1, c[5];
MOV R0.y, R3.w;
MOV R0.z, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.y, R0, c[10];
DP4 R2.x, R0, c[9];
MUL R0.y, R3.w, R3.w;
DP4 R3.z, R1, c[14];
DP4 R3.y, R1, c[13];
DP4 R3.x, R1, c[12];
MAD R0.y, R0.x, R0.x, -R0;
MUL R1.xyz, R0.y, c[15];
ADD R2.xyz, R2, R3;
ADD result.texcoord[3].xyz, R2, R1;
MOV result.texcoord[2].z, R2.w;
MOV result.texcoord[2].y, R3.w;
MOV result.texcoord[2].x, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
DP3 result.texcoord[1].z, vertex.normal, c[7];
DP3 result.texcoord[1].y, vertex.normal, c[6];
DP3 result.texcoord[1].x, vertex.normal, c[5];
END
# 31 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_SHAr]
Vector 9 [unity_SHAg]
Vector 10 [unity_SHAb]
Vector 11 [unity_SHBr]
Vector 12 [unity_SHBg]
Vector 13 [unity_SHBb]
Vector 14 [unity_SHC]
Vector 15 [unity_Scale]
Vector 16 [_MainTex_ST]
Vector 17 [_MossTex_ST]
"vs_2_0
def c18, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c15.w
dp3 r3.w, r1, c5
dp3 r2.w, r1, c6
dp3 r0.x, r1, c4
mov r0.y, r3.w
mov r0.z, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c18.x
dp4 r2.z, r0, c10
dp4 r2.y, r0, c9
dp4 r2.x, r0, c8
mul r0.y, r3.w, r3.w
dp4 r3.z, r1, c13
dp4 r3.y, r1, c12
dp4 r3.x, r1, c11
mad r0.y, r0.x, r0.x, -r0
mul r1.xyz, r0.y, c14
add r2.xyz, r2, r3
add oT3.xyz, r2, r1
mov oT2.z, r2.w
mov oT2.y, r3.w
mov oT2.x, r0
mad oT0.zw, v2.xyxy, c17.xyxy, c17
mad oT0.xy, v2, c16, c16.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
dp3 oT1.z, v1, c6
dp3 oT1.y, v1, c5
dp3 oT1.x, v1, c4
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 112
Vector 80 [_MainTex_ST]
Vector 96 [_MossTex_ST]
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
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedmjaeodafikdligogklafdodijaeonjfgabaaaaaamaafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcceaeaaaaeaaaabaa
ajabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
cnaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacaeaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
agaaaaaakgiocaaaaaaaaaaaagaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
acaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaa
aaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
abaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaa
abaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaa
abaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaaeaaaaaa
egiccaaaabaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 112
Vector 80 [_MainTex_ST]
Vector 96 [_MossTex_ST]
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
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedlaapkiddlnjdiolnmjogdofnofdghefdabaaaaaafiaiaaaaaeaaaaaa
daaaaaaameacaaaapaagaaaaliahaaaaebgpgodjimacaaaaimacaaaaaaacpopp
ciacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaafaa
acaaabaaaaaaaaaaabaacgaaahaaadaaaaaaaaaaacaaaaaaaeaaakaaaaaaaaaa
acaaamaaadaaaoaaaaaaaaaaacaabeaaabaabbaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbcaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaadaaeejaacaaeeka
acaaoekaafaaaaadaaaaahiaacaaffjaapaaoekaaeaaaaaeaaaaahiaaoaaoeka
acaaaajaaaaaoeiaaeaaaaaeabaaahoabaaaoekaacaakkjaaaaaoeiaafaaaaad
aaaaahiaacaaoejabbaappkaafaaaaadabaaahiaaaaaffiaapaaoekaaeaaaaae
aaaaaliaaoaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahiabaaaoekaaaaakkia
aaaapeiaabaaaaacaaaaaiiabcaaaakaajaaaaadabaaabiaadaaoekaaaaaoeia
ajaaaaadabaaaciaaeaaoekaaaaaoeiaajaaaaadabaaaeiaafaaoekaaaaaoeia
afaaaaadacaaapiaaaaacjiaaaaakeiaajaaaaadadaaabiaagaaoekaacaaoeia
ajaaaaadadaaaciaahaaoekaacaaoeiaajaaaaadadaaaeiaaiaaoekaacaaoeia
acaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaadaaaaaiiaaaaaffiaaaaaffia
aeaaaaaeaaaaaiiaaaaaaaiaaaaaaaiaaaaappibabaaaaacacaaahoaaaaaoeia
aeaaaaaeadaaahoaajaaoekaaaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffja
alaaoekaaeaaaaaeaaaaapiaakaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
amaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
ppppaaaafdeieefcceaeaaaaeaaaabaaajabaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaacaaaaaa
egacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
acaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
dgaaaaafhccabaaaadaaaaaaegacbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaabaaaaaacgaaaaaa
egaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaabaaaaaachaaaaaa
egaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaabaaaaaaciaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaa
acaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaabaaaaaacmaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Vector 9 [unity_LightmapST]
Vector 10 [_MainTex_ST]
Vector 11 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[12] = { program.local[0],
		state.matrix.mvp,
		program.local[5..11] };
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[11].xyxy, c[11];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[9], c[9].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
DP3 result.texcoord[1].z, vertex.normal, c[7];
DP3 result.texcoord[1].y, vertex.normal, c[6];
DP3 result.texcoord[1].x, vertex.normal, c[5];
END
# 10 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_LightmapST]
Vector 9 [_MainTex_ST]
Vector 10 [_MossTex_ST]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mad oT0.zw, v2.xyxy, c10.xyxy, c10
mad oT0.xy, v2, c9, c9.zwzw
mad oT2.xy, v3, c8, c8.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
dp3 oT1.z, v1, c6
dp3 oT1.y, v1, c5
dp3 oT1.x, v1, c4
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 128
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_MossTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedbjjgmhnbioapcdfjelckmlimnkilkalmabaaaaaakiadaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
ceacaaaaeaaaabaaijaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaae
egiocaaaabaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaa
aaaaaaaaahaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaadcaaaaaldccabaaa
adaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 128
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_MossTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedcacodfeddfgcndpoifobojdhdnhjhmnnabaaaaaabiafaaaaaeaaaaaa
daaaaaaajmabaaaamiadaaaajaaeaaaaebgpgodjgeabaaaageabaaaaaaacpopp
biabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaafaa
adaaabaaaaaaaaaaabaaaaaaaeaaaeaaaaaaaaaaabaaamaaadaaaiaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoa
adaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeejaadaaeekaadaaoeka
afaaaaadaaaaahiaacaaffjaajaaoekaaeaaaaaeaaaaahiaaiaaoekaacaaaaja
aaaaoeiaaeaaaaaeabaaahoaakaaoekaacaakkjaaaaaoeiaaeaaaaaeacaaadoa
aeaaoejaabaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaafaaoekaaeaaaaae
aaaaapiaaeaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefc
ceacaaaaeaaaabaaijaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaae
egiocaaaabaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaa
aaaaaaaaahaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaadcaaaaaldccabaaa
adaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Vector 9 [unity_LightmapST]
Vector 10 [_MainTex_ST]
Vector 11 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[12] = { program.local[0],
		state.matrix.mvp,
		program.local[5..11] };
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[11].xyxy, c[11];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[9], c[9].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
DP3 result.texcoord[1].z, vertex.normal, c[7];
DP3 result.texcoord[1].y, vertex.normal, c[6];
DP3 result.texcoord[1].x, vertex.normal, c[5];
END
# 10 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_LightmapST]
Vector 9 [_MainTex_ST]
Vector 10 [_MossTex_ST]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mad oT0.zw, v2.xyxy, c10.xyxy, c10
mad oT0.xy, v2, c9, c9.zwzw
mad oT2.xy, v3, c8, c8.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
dp3 oT1.z, v1, c6
dp3 oT1.y, v1, c5
dp3 oT1.x, v1, c4
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 128
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_MossTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedbjjgmhnbioapcdfjelckmlimnkilkalmabaaaaaakiadaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
ceacaaaaeaaaabaaijaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaae
egiocaaaabaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaa
aaaaaaaaahaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaadcaaaaaldccabaaa
adaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 128
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_MossTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedcacodfeddfgcndpoifobojdhdnhjhmnnabaaaaaabiafaaaaaeaaaaaa
daaaaaaajmabaaaamiadaaaajaaeaaaaebgpgodjgeabaaaageabaaaaaaacpopp
biabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaafaa
adaaabaaaaaaaaaaabaaaaaaaeaaaeaaaaaaaaaaabaaamaaadaaaiaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoa
adaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeejaadaaeekaadaaoeka
afaaaaadaaaaahiaacaaffjaajaaoekaaeaaaaaeaaaaahiaaiaaoekaacaaaaja
aaaaoeiaaeaaaaaeabaaahoaakaaoekaacaakkjaaaaaoeiaaeaaaaaeacaaadoa
aeaaoejaabaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaafaaoekaaeaaaaae
aaaaapiaaeaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefc
ceacaaaaeaaaabaaijaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaae
egiocaaaabaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaa
aaaaaaaaahaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaadcaaaaaldccabaaa
adaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
Vector 19 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[20] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R0.xyz, vertex.normal, c[17].w;
DP3 R3.w, R0, c[6];
DP3 R2.w, R0, c[7];
DP3 R1.w, R0, c[5];
MOV R1.x, R3.w;
MOV R1.y, R2.w;
MOV R1.z, c[0].x;
MUL R0, R1.wxyy, R1.xyyw;
DP4 R2.z, R1.wxyz, c[12];
DP4 R2.y, R1.wxyz, c[11];
DP4 R2.x, R1.wxyz, c[10];
DP4 R1.z, R0, c[15];
DP4 R1.y, R0, c[14];
DP4 R1.x, R0, c[13];
MUL R3.x, R3.w, R3.w;
MAD R0.x, R1.w, R1.w, -R3;
ADD R3.xyz, R2, R1;
MUL R2.xyz, R0.x, c[16];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[3].xyz, R3, R2;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MOV result.texcoord[2].z, R2.w;
MOV result.texcoord[2].y, R3.w;
MOV result.texcoord[2].x, R1.w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
DP3 result.texcoord[1].z, vertex.normal, c[7];
DP3 result.texcoord[1].y, vertex.normal, c[6];
DP3 result.texcoord[1].x, vertex.normal, c[5];
END
# 36 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
Vector 19 [_MossTex_ST]
"vs_2_0
def c20, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1, c17.w
dp3 r3.w, r0, c5
dp3 r2.w, r0, c6
dp3 r1.w, r0, c4
mov r1.x, r3.w
mov r1.y, r2.w
mov r1.z, c20.x
mul r0, r1.wxyy, r1.xyyw
dp4 r2.z, r1.wxyz, c12
dp4 r2.y, r1.wxyz, c11
dp4 r2.x, r1.wxyz, c10
dp4 r1.z, r0, c15
dp4 r1.y, r0, c14
dp4 r1.x, r0, c13
mul r3.x, r3.w, r3.w
mad r0.x, r1.w, r1.w, -r3
add r3.xyz, r2, r1
mul r2.xyz, r0.x, c16
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c20.y
mul r1.y, r1, c8.x
add oT3.xyz, r3, r2
mad oT4.xy, r1.z, c9.zwzw, r1
mov oPos, r0
mov oT4.zw, r0
mov oT2.z, r2.w
mov oT2.y, r3.w
mov oT2.x, r1.w
mad oT0.zw, v2.xyxy, c19.xyxy, c19
mad oT0.xy, v2, c18, c18.zwzw
dp3 oT1.z, v1, c6
dp3 oT1.y, v1, c5
dp3 oT1.x, v1, c4
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Vector 144 [_MainTex_ST]
Vector 160 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
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
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedadegkdfnngceabdplokfbpekbgddiknaabaaaaaaiaagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcmmaeaaaaeaaaabaaddabaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaa
ogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaa
adaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaa
diaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaai
bcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaai
ccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaai
ecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaak
hccabaaaaeaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Vector 144 [_MainTex_ST]
Vector 160 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
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
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedgaicobkompimlphcggfdgacbfghhfiflabaaaaaahaajaaaaaeaaaaaa
daaaaaaabmadaaaapaahaaaaliaiaaaaebgpgodjoeacaaaaoeacaaaaaaacpopp
heacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaajaa
acaaabaaaaaaaaaaabaaafaaabaaadaaaaaaaaaaacaacgaaahaaaeaaaaaaaaaa
adaaaaaaaeaaalaaaaaaaaaaadaaamaaadaaapaaaaaaaaaaadaabeaaabaabcaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbdaaapkaaaaaiadpaaaaaadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaae
aaaaamoaadaaeejaacaaeekaacaaoekaafaaaaadaaaaahiaacaaffjabaaaoeka
aeaaaaaeaaaaahiaapaaoekaacaaaajaaaaaoeiaaeaaaaaeabaaahoabbaaoeka
acaakkjaaaaaoeiaafaaaaadaaaaahiaacaaoejabcaappkaafaaaaadabaaahia
aaaaffiabaaaoekaaeaaaaaeaaaaaliaapaakekaaaaaaaiaabaakeiaaeaaaaae
aaaaahiabbaaoekaaaaakkiaaaaapeiaabaaaaacaaaaaiiabdaaaakaajaaaaad
abaaabiaaeaaoekaaaaaoeiaajaaaaadabaaaciaafaaoekaaaaaoeiaajaaaaad
abaaaeiaagaaoekaaaaaoeiaafaaaaadacaaapiaaaaacjiaaaaakeiaajaaaaad
adaaabiaahaaoekaacaaoeiaajaaaaadadaaaciaaiaaoekaacaaoeiaajaaaaad
adaaaeiaajaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaad
aaaaaiiaaaaaffiaaaaaffiaaeaaaaaeaaaaaiiaaaaaaaiaaaaaaaiaaaaappib
abaaaaacacaaahoaaaaaoeiaaeaaaaaeadaaahoaakaaoekaaaaappiaabaaoeia
afaaaaadaaaaapiaaaaaffjaamaaoekaaeaaaaaeaaaaapiaalaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
aoaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaadaaaakaafaaaaad
abaaaiiaabaaaaiabdaaffkaafaaaaadabaaafiaaaaapeiabdaaffkaacaaaaad
aeaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacaeaaamoaaaaaoeiappppaaaafdeieefc
mmaeaaaaeaaaabaaddabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaac
afaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaa
aaaaaaaaakaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
abaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaa
egadbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaadgaaaaaf
icaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaa
acaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaa
acaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaa
acaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaa
abaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaa
cjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaa
ckaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaa
claaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaaeaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaa
abaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaiaebaaaaaaabaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaa
cmaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaafaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_LightmapST]
Vector 11 [_MainTex_ST]
Vector 12 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[13] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..12] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[12].xyxy, c[12];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[10], c[10].zwzw;
DP3 result.texcoord[1].z, vertex.normal, c[7];
DP3 result.texcoord[1].y, vertex.normal, c[6];
DP3 result.texcoord[1].x, vertex.normal, c[5];
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_LightmapST]
Vector 11 [_MainTex_ST]
Vector 12 [_MossTex_ST]
"vs_2_0
def c13, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c13.x
mul r1.y, r1, c8.x
mad oT3.xy, r1.z, c9.zwzw, r1
mov oPos, r0
mov oT3.zw, r0
mad oT0.zw, v2.xyxy, c12.xyxy, c12
mad oT0.xy, v2, c11, c11.zwzw
mad oT2.xy, v3, c10, c10.zwzw
dp3 oT1.z, v1, c6
dp3 oT1.y, v1, c5
dp3 oT1.x, v1, c4
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 192
Vector 144 [unity_LightmapST]
Vector 160 [_MainTex_ST]
Vector 176 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedblphgighgophhcpfllhjepaakiiakocpabaaaaaagiaeaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcmmacaaaaeaaaabaa
ldaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaa
aeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaa
akaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
alaaaaaakgiocaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
acaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaajaaaaaa
ogikcaaaaaaaaaaaajaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 192
Vector 144 [unity_LightmapST]
Vector 160 [_MainTex_ST]
Vector 176 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemkgboglefgofdghpikmbmlgbkpocnnabaaaaaaeiagaaaaaeaaaaaa
daaaaaaaamacaaaaoaaeaaaakiafaaaaebgpgodjneabaaaaneabaaaaaaacpopp
hmabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaajaa
adaaabaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaaacaaaaaaaeaaafaaaaaaaaaa
acaaamaaadaaajaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafamaaapkaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaae
aaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeejaadaaeeka
adaaoekaafaaaaadaaaaahiaacaaffjaakaaoekaaeaaaaaeaaaaahiaajaaoeka
acaaaajaaaaaoeiaaeaaaaaeabaaahoaalaaoekaacaakkjaaaaaoeiaaeaaaaae
acaaadoaaeaaoejaabaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaagaaoeka
aeaaaaaeaaaaapiaafaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaahaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaaeaaaakaafaaaaadabaaaiiaabaaaaiaamaaaakaafaaaaad
abaaafiaaaaapeiaamaaaakaacaaaaadadaaadoaabaakkiaabaaomiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
adaaamoaaaaaoeiappppaaaafdeieefcmmacaaaaeaaaabaaldaaaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaa
aaaaaaaaalaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaadcaaaaaldccabaaa
adaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaa
ajaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_LightmapST]
Vector 11 [_MainTex_ST]
Vector 12 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[13] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..12] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[12].xyxy, c[12];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[10], c[10].zwzw;
DP3 result.texcoord[1].z, vertex.normal, c[7];
DP3 result.texcoord[1].y, vertex.normal, c[6];
DP3 result.texcoord[1].x, vertex.normal, c[5];
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_LightmapST]
Vector 11 [_MainTex_ST]
Vector 12 [_MossTex_ST]
"vs_2_0
def c13, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c13.x
mul r1.y, r1, c8.x
mad oT3.xy, r1.z, c9.zwzw, r1
mov oPos, r0
mov oT3.zw, r0
mad oT0.zw, v2.xyxy, c12.xyxy, c12
mad oT0.xy, v2, c11, c11.zwzw
mad oT2.xy, v3, c10, c10.zwzw
dp3 oT1.z, v1, c6
dp3 oT1.y, v1, c5
dp3 oT1.x, v1, c4
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 192
Vector 144 [unity_LightmapST]
Vector 160 [_MainTex_ST]
Vector 176 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedblphgighgophhcpfllhjepaakiiakocpabaaaaaagiaeaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcmmacaaaaeaaaabaa
ldaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaa
aeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaa
akaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
alaaaaaakgiocaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
acaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaajaaaaaa
ogikcaaaaaaaaaaaajaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 192
Vector 144 [unity_LightmapST]
Vector 160 [_MainTex_ST]
Vector 176 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemkgboglefgofdghpikmbmlgbkpocnnabaaaaaaeiagaaaaaeaaaaaa
daaaaaaaamacaaaaoaaeaaaakiafaaaaebgpgodjneabaaaaneabaaaaaaacpopp
hmabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaajaa
adaaabaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaaacaaaaaaaeaaafaaaaaaaaaa
acaaamaaadaaajaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafamaaapkaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaae
aaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeejaadaaeeka
adaaoekaafaaaaadaaaaahiaacaaffjaakaaoekaaeaaaaaeaaaaahiaajaaoeka
acaaaajaaaaaoeiaaeaaaaaeabaaahoaalaaoekaacaakkjaaaaaoeiaaeaaaaae
acaaadoaaeaaoejaabaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaagaaoeka
aeaaaaaeaaaaapiaafaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaahaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaaeaaaakaafaaaaadabaaaiiaabaaaaiaamaaaakaafaaaaad
abaaafiaaaaapeiaamaaaakaacaaaaadadaaadoaabaakkiaabaaomiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
adaaamoaaaaaoeiappppaaaafdeieefcmmacaaaaeaaaabaaldaaaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaa
aaaaaaaaalaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaadcaaaaaldccabaaa
adaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaa
ajaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [unity_4LightPosX0]
Vector 10 [unity_4LightPosY0]
Vector 11 [unity_4LightPosZ0]
Vector 12 [unity_4LightAtten0]
Vector 13 [unity_LightColor0]
Vector 14 [unity_LightColor1]
Vector 15 [unity_LightColor2]
Vector 16 [unity_LightColor3]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Vector 24 [unity_Scale]
Vector 25 [_MainTex_ST]
Vector 26 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[27] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..26] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[24].w;
DP3 R4.x, R3, c[5];
DP3 R3.w, R3, c[6];
DP3 R3.x, R3, c[7];
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[10];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[9];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MOV R4.w, c[0].x;
MAD R2, R4.x, R0, R2;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[11];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[12];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
DP4 R2.z, R4, c[19];
DP4 R2.y, R4, c[18];
DP4 R2.x, R4, c[17];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[14];
MAD R1.xyz, R0.x, c[13], R1;
MAD R0.xyz, R0.z, c[15], R1;
MAD R1.xyz, R0.w, c[16], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R4.w, R0, c[22];
DP4 R4.z, R0, c[21];
DP4 R4.y, R0, c[20];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[23];
ADD R2.xyz, R2, R4.yzww;
ADD R0.xyz, R2, R0;
ADD result.texcoord[3].xyz, R0, R1;
MOV result.texcoord[2].z, R3.x;
MOV result.texcoord[2].y, R3.w;
MOV result.texcoord[2].x, R4;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[26].xyxy, c[26];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[25], c[25].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
DP3 result.texcoord[1].z, vertex.normal, c[7];
DP3 result.texcoord[1].y, vertex.normal, c[6];
DP3 result.texcoord[1].x, vertex.normal, c[5];
END
# 61 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_4LightPosX0]
Vector 9 [unity_4LightPosY0]
Vector 10 [unity_4LightPosZ0]
Vector 11 [unity_4LightAtten0]
Vector 12 [unity_LightColor0]
Vector 13 [unity_LightColor1]
Vector 14 [unity_LightColor2]
Vector 15 [unity_LightColor3]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [unity_Scale]
Vector 24 [_MainTex_ST]
Vector 25 [_MossTex_ST]
"vs_2_0
def c26, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r3.xyz, v1, c23.w
dp3 r4.x, r3, c4
dp3 r3.w, r3, c5
dp3 r3.x, r3, c6
dp4 r0.x, v0, c5
add r1, -r0.x, c9
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c8
mul r1, r1, r1
mov r4.z, r3.x
mov r4.w, c26.x
mad r2, r4.x, r0, r2
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c10
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c11
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c26.x
dp4 r2.z, r4, c18
dp4 r2.y, r4, c17
dp4 r2.x, r4, c16
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c26.y
mul r0, r0, r1
mul r1.xyz, r0.y, c13
mad r1.xyz, r0.x, c12, r1
mad r0.xyz, r0.z, c14, r1
mad r1.xyz, r0.w, c15, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r4.w, r0, c21
dp4 r4.z, r0, c20
dp4 r4.y, r0, c19
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c22
add r2.xyz, r2, r4.yzww
add r0.xyz, r2, r0
add oT3.xyz, r0, r1
mov oT2.z, r3.x
mov oT2.y, r3.w
mov oT2.x, r4
mad oT0.zw, v2.xyxy, c25.xyxy, c25
mad oT0.xy, v2, c24, c24.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
dp3 oT1.z, v1, c6
dp3 oT1.y, v1, c5
dp3 oT1.x, v1, c4
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 112
Vector 80 [_MainTex_ST]
Vector 96 [_MossTex_ST]
ConstBuffer "UnityLighting" 720
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
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedibjdfkmligkpkkhgnaopmdocfcbhpchkabaaaaaabaajaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcheahaaaaeaaaabaa
nnabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
cnaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacagaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
agaaaaaakgiocaaaaaaaaaaaagaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
acaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaa
aaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
abaaaaaaegiocaaaabaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaa
abaaaaaaegiocaaaabaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaa
abaaaaaaegiocaaaabaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaabaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaabaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaabaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaabaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaa
fgafbaiaebaaaaaaacaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaa
aeaaaaaafgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaia
ebaaaaaaacaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaa
kgakbaiaebaaaaaaacaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaa
aeaaaaaaegaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaaj
pcaabaaaaaaaaaaaegaobaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaa
adaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaan
pcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaabaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaajaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 112
Vector 80 [_MainTex_ST]
Vector 96 [_MossTex_ST]
ConstBuffer "UnityLighting" 720
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
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedocnkiipghoemamhijglgjmmfmafpiepgabaaaaaakmanaaaaaeaaaaaa
daaaaaaamiaeaaaaeeamaaaaamanaaaaebgpgodjjaaeaaaajaaeaaaaaaacpopp
caaeaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaafaa
acaaabaaaaaaaaaaabaaacaaaiaaadaaaaaaaaaaabaacgaaahaaalaaaaaaaaaa
acaaaaaaaeaabcaaaaaaaaaaacaaamaaaeaabgaaaaaaaaaaacaabeaaabaabkaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafblaaapkaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaae
aaaaamoaadaaeejaacaaeekaacaaoekaafaaaaadaaaaahiaacaaffjabhaaoeka
aeaaaaaeaaaaahiabgaaoekaacaaaajaaaaaoeiaaeaaaaaeabaaahoabiaaoeka
acaakkjaaaaaoeiaafaaaaadaaaaahiaaaaaffjabhaaoekaaeaaaaaeaaaaahia
bgaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabiaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaahiabjaaoekaaaaappjaaaaaoeiaacaaaaadabaaapiaaaaaffib
aeaaoekaafaaaaadacaaapiaabaaoeiaabaaoeiaacaaaaadadaaapiaaaaaaaib
adaaoekaacaaaaadaaaaapiaaaaakkibafaaoekaaeaaaaaeacaaapiaadaaoeia
adaaoeiaacaaoeiaaeaaaaaeacaaapiaaaaaoeiaaaaaoeiaacaaoeiaahaaaaac
aeaaabiaacaaaaiaahaaaaacaeaaaciaacaaffiaahaaaaacaeaaaeiaacaakkia
ahaaaaacaeaaaiiaacaappiaabaaaaacafaaabiablaaaakaaeaaaaaeacaaapia
acaaoeiaagaaoekaafaaaaiaafaaaaadafaaahiaacaaoejabkaappkaafaaaaad
agaaahiaafaaffiabhaaoekaaeaaaaaeafaaaliabgaakekaafaaaaiaagaakeia
aeaaaaaeafaaahiabiaaoekaafaakkiaafaapeiaafaaaaadabaaapiaabaaoeia
afaaffiaaeaaaaaeabaaapiaadaaoeiaafaaaaiaabaaoeiaaeaaaaaeaaaaapia
aaaaoeiaafaakkiaabaaoeiaafaaaaadaaaaapiaaeaaoeiaaaaaoeiaalaaaaad
aaaaapiaaaaaoeiablaaffkaagaaaaacabaaabiaacaaaaiaagaaaaacabaaacia
acaaffiaagaaaaacabaaaeiaacaakkiaagaaaaacabaaaiiaacaappiaafaaaaad
aaaaapiaaaaaoeiaabaaoeiaafaaaaadabaaahiaaaaaffiaaiaaoekaaeaaaaae
abaaahiaahaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaajaaoekaaaaakkia
abaaoeiaaeaaaaaeaaaaahiaakaaoekaaaaappiaaaaaoeiaabaaaaacafaaaiia
blaaaakaajaaaaadabaaabiaalaaoekaafaaoeiaajaaaaadabaaaciaamaaoeka
afaaoeiaajaaaaadabaaaeiaanaaoekaafaaoeiaafaaaaadacaaapiaafaacjia
afaakeiaajaaaaadadaaabiaaoaaoekaacaaoeiaajaaaaadadaaaciaapaaoeka
acaaoeiaajaaaaadadaaaeiabaaaoekaacaaoeiaacaaaaadabaaahiaabaaoeia
adaaoeiaafaaaaadaaaaaiiaafaaffiaafaaffiaaeaaaaaeaaaaaiiaafaaaaia
afaaaaiaaaaappibabaaaaacacaaahoaafaaoeiaaeaaaaaeabaaahiabbaaoeka
aaaappiaabaaoeiaacaaaaadadaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapia
aaaaffjabdaaoekaaeaaaaaeaaaaapiabcaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiabeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabfaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiappppaaaafdeieefcheahaaaaeaaaabaannabaaaafjaaaaaeegiocaaa
aaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaa
acaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaa
agaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
acaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaaaaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaabaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaabaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaabaaaaaa
ciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaa
egaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaacmaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaa
egiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaaaaaaaaa
egaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
adaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaacaaaaaaegiocaaa
abaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaakgakbaiaebaaaaaaacaaaaaa
egiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaa
agaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaa
egaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaeeaaaaaf
pcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaaegaobaaa
acaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
acaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaaaaaaaaa
egiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaa
agaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_4LightPosX0]
Vector 11 [unity_4LightPosY0]
Vector 12 [unity_4LightPosZ0]
Vector 13 [unity_4LightAtten0]
Vector 14 [unity_LightColor0]
Vector 15 [unity_LightColor1]
Vector 16 [unity_LightColor2]
Vector 17 [unity_LightColor3]
Vector 18 [unity_SHAr]
Vector 19 [unity_SHAg]
Vector 20 [unity_SHAb]
Vector 21 [unity_SHBr]
Vector 22 [unity_SHBg]
Vector 23 [unity_SHBb]
Vector 24 [unity_SHC]
Vector 25 [unity_Scale]
Vector 26 [_MainTex_ST]
Vector 27 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[28] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..27] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[25].w;
DP3 R4.x, R3, c[5];
DP3 R3.w, R3, c[6];
DP3 R3.x, R3, c[7];
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[11];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[10];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MOV R4.w, c[0].x;
MAD R2, R4.x, R0, R2;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[12];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[13];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
DP4 R2.z, R4, c[20];
DP4 R2.y, R4, c[19];
DP4 R2.x, R4, c[18];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[15];
MAD R1.xyz, R0.x, c[14], R1;
MAD R0.xyz, R0.z, c[16], R1;
MAD R1.xyz, R0.w, c[17], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R4.w, R0, c[23];
DP4 R4.z, R0, c[22];
DP4 R4.y, R0, c[21];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[24];
ADD R2.xyz, R2, R4.yzww;
ADD R4.yzw, R2.xxyz, R0.xxyz;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R2.xyz, R0.xyww, c[0].z;
ADD result.texcoord[3].xyz, R4.yzww, R1;
MOV R1.x, R2;
MUL R1.y, R2, c[9].x;
ADD result.texcoord[4].xy, R1, R2.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MOV result.texcoord[2].z, R3.x;
MOV result.texcoord[2].y, R3.w;
MOV result.texcoord[2].x, R4;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[27].xyxy, c[27];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[26], c[26].zwzw;
DP3 result.texcoord[1].z, vertex.normal, c[7];
DP3 result.texcoord[1].y, vertex.normal, c[6];
DP3 result.texcoord[1].x, vertex.normal, c[5];
END
# 67 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_4LightPosX0]
Vector 11 [unity_4LightPosY0]
Vector 12 [unity_4LightPosZ0]
Vector 13 [unity_4LightAtten0]
Vector 14 [unity_LightColor0]
Vector 15 [unity_LightColor1]
Vector 16 [unity_LightColor2]
Vector 17 [unity_LightColor3]
Vector 18 [unity_SHAr]
Vector 19 [unity_SHAg]
Vector 20 [unity_SHAb]
Vector 21 [unity_SHBr]
Vector 22 [unity_SHBg]
Vector 23 [unity_SHBb]
Vector 24 [unity_SHC]
Vector 25 [unity_Scale]
Vector 26 [_MainTex_ST]
Vector 27 [_MossTex_ST]
"vs_2_0
def c28, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r3.xyz, v1, c25.w
dp3 r4.x, r3, c4
dp3 r3.w, r3, c5
dp3 r3.x, r3, c6
dp4 r0.x, v0, c5
add r1, -r0.x, c11
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c10
mul r1, r1, r1
mov r4.z, r3.x
mov r4.w, c28.x
mad r2, r4.x, r0, r2
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c12
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c13
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c28.x
dp4 r2.z, r4, c20
dp4 r2.y, r4, c19
dp4 r2.x, r4, c18
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c28.y
mul r0, r0, r1
mul r1.xyz, r0.y, c15
mad r1.xyz, r0.x, c14, r1
mad r0.xyz, r0.z, c16, r1
mad r1.xyz, r0.w, c17, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r4.w, r0, c23
dp4 r4.z, r0, c22
dp4 r4.y, r0, c21
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c24
add r2.xyz, r2, r4.yzww
add r4.yzw, r2.xxyz, r0.xxyz
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c28.z
add oT3.xyz, r4.yzww, r1
mov r1.x, r2
mul r1.y, r2, c8.x
mad oT4.xy, r2.z, c9.zwzw, r1
mov oPos, r0
mov oT4.zw, r0
mov oT2.z, r3.x
mov oT2.y, r3.w
mov oT2.x, r4
mad oT0.zw, v2.xyxy, c27.xyxy, c27
mad oT0.xy, v2, c26, c26.zwzw
dp3 oT1.z, v1, c6
dp3 oT1.y, v1, c5
dp3 oT1.x, v1, c4
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Vector 144 [_MainTex_ST]
Vector 160 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
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
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedjoakhjjdkihomngfahmliggpjjnecmlaabaaaaaanaajaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcbmaiaaaaeaaaabaaahacaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagiaaaaacahaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaa
ogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaaihcaabaaa
abaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaa
adaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaa
diaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaai
bcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaai
ccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaai
ecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaaj
pcaabaaaaeaaaaaafgafbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaadaaaaaa
diaaaaahpcaabaaaafaaaaaafgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaah
pcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaa
agaaaaaaagaabaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaaj
pcaabaaaadaaaaaakgakbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaaeaaaaaa
dcaaaaajpcaabaaaafaaaaaaegaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaa
afaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaadaaaaaakgakbaaaabaaaaaa
egaobaaaafaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaa
agaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaadaaaaaa
egaobaaaadaaaaaaegaobaaaaeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaa
adaaaaaadcaaaaanpcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaaacaaaaaa
afaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaak
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaa
diaaaaaihcaabaaaadaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaa
kgakbaaaabaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaa
aeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaafaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Vector 144 [_MainTex_ST]
Vector 160 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
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
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecededhidddipphjlldljnabppdjooehjgdgabaaaaaameaoaaaaaeaaaaaa
daaaaaaacaafaaaaeeanaaaaamaoaaaaebgpgodjoiaeaaaaoiaeaaaaaaacpopp
gmaeaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaajaa
acaaabaaaaaaaaaaabaaafaaabaaadaaaaaaaaaaacaaacaaaiaaaeaaaaaaaaaa
acaacgaaahaaamaaaaaaaaaaadaaaaaaaeaabdaaaaaaaaaaadaaamaaaeaabhaa
aaaaaaaaadaabeaaabaablaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbmaaapka
aaaaiadpaaaaaaaaaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoeja
abaaoekaabaaookaaeaaaaaeaaaaamoaadaaeejaacaaeekaacaaoekaafaaaaad
aaaaahiaacaaffjabiaaoekaaeaaaaaeaaaaahiabhaaoekaacaaaajaaaaaoeia
aeaaaaaeabaaahoabjaaoekaacaakkjaaaaaoeiaafaaaaadaaaaahiaaaaaffja
biaaoekaaeaaaaaeaaaaahiabhaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahia
bjaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabkaaoekaaaaappjaaaaaoeia
acaaaaadabaaapiaaaaaffibafaaoekaafaaaaadacaaapiaabaaoeiaabaaoeia
acaaaaadadaaapiaaaaaaaibaeaaoekaacaaaaadaaaaapiaaaaakkibagaaoeka
aeaaaaaeacaaapiaadaaoeiaadaaoeiaacaaoeiaaeaaaaaeacaaapiaaaaaoeia
aaaaoeiaacaaoeiaahaaaaacaeaaabiaacaaaaiaahaaaaacaeaaaciaacaaffia
ahaaaaacaeaaaeiaacaakkiaahaaaaacaeaaaiiaacaappiaabaaaaacafaaabia
bmaaaakaaeaaaaaeacaaapiaacaaoeiaahaaoekaafaaaaiaafaaaaadafaaahia
acaaoejablaappkaafaaaaadagaaahiaafaaffiabiaaoekaaeaaaaaeafaaalia
bhaakekaafaaaaiaagaakeiaaeaaaaaeafaaahiabjaaoekaafaakkiaafaapeia
afaaaaadabaaapiaabaaoeiaafaaffiaaeaaaaaeabaaapiaadaaoeiaafaaaaia
abaaoeiaaeaaaaaeaaaaapiaaaaaoeiaafaakkiaabaaoeiaafaaaaadaaaaapia
aeaaoeiaaaaaoeiaalaaaaadaaaaapiaaaaaoeiabmaaffkaagaaaaacabaaabia
acaaaaiaagaaaaacabaaaciaacaaffiaagaaaaacabaaaeiaacaakkiaagaaaaac
abaaaiiaacaappiaafaaaaadaaaaapiaaaaaoeiaabaaoeiaafaaaaadabaaahia
aaaaffiaajaaoekaaeaaaaaeabaaahiaaiaaoekaaaaaaaiaabaaoeiaaeaaaaae
aaaaahiaakaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiaalaaoekaaaaappia
aaaaoeiaabaaaaacafaaaiiabmaaaakaajaaaaadabaaabiaamaaoekaafaaoeia
ajaaaaadabaaaciaanaaoekaafaaoeiaajaaaaadabaaaeiaaoaaoekaafaaoeia
afaaaaadacaaapiaafaacjiaafaakeiaajaaaaadadaaabiaapaaoekaacaaoeia
ajaaaaadadaaaciabaaaoekaacaaoeiaajaaaaadadaaaeiabbaaoekaacaaoeia
acaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaadaaaaaiiaafaaffiaafaaffia
aeaaaaaeaaaaaiiaafaaaaiaafaaaaiaaaaappibabaaaaacacaaahoaafaaoeia
aeaaaaaeabaaahiabcaaoekaaaaappiaabaaoeiaacaaaaadadaaahoaaaaaoeia
abaaoeiaafaaaaadaaaaapiaaaaaffjabeaaoekaaeaaaaaeaaaaapiabdaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiabfaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiabgaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaadaaaaka
afaaaaadabaaaiiaabaaaaiabmaakkkaafaaaaadabaaafiaaaaapeiabmaakkka
acaaaaadaeaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaeaaamoaaaaaoeiappppaaaa
fdeieefcbmaiaaaaeaaaabaaahacaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaa
fjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
giaaaaacahaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaa
kgiocaaaaaaaaaaaakaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaa
egiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
amaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaa
egiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
abaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaa
jgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaa
adaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaadaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaaaeaaaaaafgafbaia
ebaaaaaaadaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaafaaaaaa
fgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaa
aeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaaagaaaaaaagaabaiaebaaaaaa
adaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaakgakbaia
ebaaaaaaadaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaafaaaaaa
egaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaa
abaaaaaaegaobaaaadaaaaaakgakbaaaabaaaaaaegaobaaaafaaaaaadcaaaaaj
pcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaaagaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
aeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaaadaaaaaadcaaaaanpcaabaaa
adaaaaaaegaobaaaadaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaadaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaadiaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaadaaaaaa
fgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaadaaaaaa
egiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaaabaaaaaaegacbaaa
adaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaaeaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_Fading]
Float 3 [_Threshold]
Vector 4 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
"!!ARBfp1.0
PARAM c[6] = { program.local[0..4],
		{ 0, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[0].zwzw, texture[1], 2D;
DP3_SAT R2.y, R0, c[4];
MOV R2.x, c[2];
ADD R1, -R0, R1;
ADD R2.y, -R2, c[5];
MUL R2.x, R2, c[3];
MUL R2.x, R2, R2.y;
MAD_SAT R2.x, fragment.texcoord[1].y, c[2], -R2;
MAD R0, R2.x, R1, R0;
MUL R1.xyz, R0, fragment.texcoord[3];
DP3 R1.w, fragment.texcoord[2], c[0];
MUL R0.xyz, R0, c[1];
MAX R1.w, R1, c[5].x;
MUL R0.xyz, R1.w, R0;
MAD result.color.xyz, R0, c[5].z, R1;
MOV result.color.w, R0;
END
# 17 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_Fading]
Float 3 [_Threshold]
Vector 4 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c5, 0.00000000, 1.00000000, 2.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t3.xyz
texld r3, t0, s0
dp3_pp_sat r1.x, r3, c4
mov r0.y, t0.w
mov r0.x, t0.z
add_pp r1.x, -r1, c5.y
texld r2, r0, s1
mov r0.x, c3
mul r0.x, c2, r0
mul r0.x, r0, r1
add_pp r1, -r3, r2
mad_sat r0.x, t1.y, c2, -r0
mad_pp r1, r0.x, r1, r3
mul_pp r2.xyz, r1, t3
dp3_pp r0.x, t2, c0
mov_pp r0.w, r1
mul_pp r1.xyz, r1, c1
max_pp r0.x, r0, c5
mul_pp r0.xyz, r0.x, r1
mad_pp r0.xyz, r0, c5.z, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
ConstBuffer "$Globals" 112
Vector 16 [_LightColor0]
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedbnikcadpdckobbabnnfhklocbalpmkinabaaaaaaleadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefckmacaaaaeaaaaaaaklaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaabaaaaaaibcaabaaaaaaaaaaaegbcbaaaadaaaaaa
egiccaaaabaaaaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaajccaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaabkiacaaa
aaaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaabacaaaaiecaabaaaaaaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaaeaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaadccaaaalccaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaa
aaaaaaaaadaaaaaabkaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgafbaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaai
ocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegbcbaaaaeaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaaaaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
ConstBuffer "$Globals" 112
Vector 16 [_LightColor0]
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedcfheednllgjkpdocjheomoadaimgghokabaaaaaaiiafaaaaaeaaaaaa
daaaaaaaaaacaaaaleaeaaaafeafaaaaebgpgodjmiabaaaamiabaaaaaaacpppp
hiabaaaafaaaaaaaadaacmaaaaaafaaaaaaafaaaacaaceaaaaaafaaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaaaadaaacaaabaaaaaaaaaaabaaaaaa
abaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaahlabpaaaaac
aaaaaaiaacaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkaabaaaaacaaaaabiaaaaakklaabaaaaacaaaaacia
aaaapplaecaaaaadabaacpiaaaaaoelaaaaioekaecaaaaadaaaacpiaaaaaoeia
abaioekaaiaaaaadacaaciiaacaaoelaadaaoekaalaaaaadadaaciiaacaappia
aeaaffkaacaaaaadacaacbiaadaappiaadaappiaafaaaaadacaaaciaabaaaaka
abaaffkaaiaaaaadacaabeiaabaaoeiaacaaoekaacaaaaadacaaaeiaacaakkib
aeaaaakaafaaaaadacaaaciaacaakkiaacaaffiaaeaaaaaeacaadciaabaaffla
abaaaakaacaaffibbcaaaaaeadaacpiaacaaffiaaaaaoeiaabaaoeiaafaaaaad
aaaachiaadaaoeiaaaaaoekaafaaaaadabaachiaadaaoeiaadaaoelaaeaaaaae
adaachiaaaaaoeiaacaaaaiaabaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaa
fdeieefckmacaaaaeaaaaaaaklaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaabaaaaaaibcaabaaaaaaaaaaaegbcbaaaadaaaaaa
egiccaaaabaaaaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaajccaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaabkiacaaa
aaaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaabacaaaaiecaabaaaaaaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaaeaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaadccaaaalccaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaa
aaaaaaaaadaaaaaabkaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgafbaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaai
ocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegbcbaaaaeaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaaaaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahacaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[2], 2D;
TEX R1, fragment.texcoord[0].zwzw, texture[1], 2D;
DP3_SAT R3.y, R0, c[2];
MOV R3.x, c[0];
MUL R2.xyz, R2.w, R2;
ADD R1, -R0, R1;
ADD R3.y, -R3, c[3].x;
MUL R3.x, R3, c[1];
MUL R3.x, R3, R3.y;
MAD_SAT R2.w, fragment.texcoord[1].y, c[0].x, -R3.x;
MAD R0, R2.w, R1, R0;
MUL R0.xyz, R0, R2;
MOV result.color.w, R0;
MUL result.color.xyz, R0, c[3].y;
END
# 15 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 1.00000000, 8.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r2, t2, s2
texld r3, t0, s0
dp3_pp_sat r1.x, r3, c2
add_pp r1.x, -r1, c3
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s1
add_pp r4, -r3, r0
mov r0.x, c1
mul r0.x, c0, r0
mul r0.x, r0, r1
mad_sat r0.x, t1.y, c0, -r0
mad_pp r0, r0.x, r4, r3
mul_pp r1.xyz, r2.w, r2
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c3.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 128
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedaeaccfiioghdefbmcjhdokdmkadhmfplabaaaaaafmadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcgmacaaaaeaaaaaaajlaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaajbcaabaaaaaaaaaaa
akiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabacaaaai
ccaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaaeaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaalbcaabaaa
aaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 128
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedmclefmlhgckilmjndpabdihlmclbimgkabaaaaaapiaeaaaaaeaaaaaa
daaaaaaamiabaaaadmaeaaaameaeaaaaebgpgodjjaabaaaajaabaaaaaaacpppp
feabaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaaaaaaaaa
abababaaacacacaaaaaaadaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapka
aaaaiadpaaaaaaebaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaabaaaaacaaaaabia
aaaakklaabaaaaacaaaaaciaaaaapplaecaaaaadabaacpiaaaaaoelaaaaioeka
ecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaadacaacpiaacaaoelaacaioeka
afaaaaadadaaaiiaaaaaaakaaaaaffkaaiaaaaadadaabbiaabaaoeiaabaaoeka
acaaaaadadaaabiaadaaaaibacaaaakaafaaaaadadaaabiaadaaaaiaadaappia
aeaaaaaeadaadbiaabaafflaaaaaaakaadaaaaibbcaaaaaeaeaacpiaadaaaaia
aaaaoeiaabaaoeiaafaaaaadacaaciiaacaappiaacaaffkaafaaaaadaaaachia
acaaoeiaacaappiaafaaaaadaeaachiaaaaaoeiaaeaaoeiaabaaaaacaaaicpia
aeaaoeiappppaaaafdeieefcgmacaaaaeaaaaaaajlaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaajbcaabaaaaaaaaaaa
akiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabacaaaai
ccaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaaeaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaalbcaabaaa
aaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahacaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[2], 2D;
TEX R1, fragment.texcoord[0].zwzw, texture[1], 2D;
DP3_SAT R3.y, R0, c[2];
MOV R3.x, c[0];
MUL R2.xyz, R2.w, R2;
ADD R1, -R0, R1;
ADD R3.y, -R3, c[3].x;
MUL R3.x, R3, c[1];
MUL R3.x, R3, R3.y;
MAD_SAT R2.w, fragment.texcoord[1].y, c[0].x, -R3.x;
MAD R0, R2.w, R1, R0;
MUL R0.xyz, R0, R2;
MOV result.color.w, R0;
MUL result.color.xyz, R0, c[3].y;
END
# 15 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 1.00000000, 8.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r2, t2, s2
texld r3, t0, s0
dp3_pp_sat r1.x, r3, c2
add_pp r1.x, -r1, c3
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s1
add_pp r4, -r3, r0
mov r0.x, c1
mul r0.x, c0, r0
mul r0.x, r0, r1
mad_sat r0.x, t1.y, c0, -r0
mad_pp r0, r0.x, r4, r3
mul_pp r1.xyz, r2.w, r2
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c3.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 128
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedaeaccfiioghdefbmcjhdokdmkadhmfplabaaaaaafmadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcgmacaaaaeaaaaaaajlaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaajbcaabaaaaaaaaaaa
akiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabacaaaai
ccaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaaeaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaalbcaabaaa
aaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 128
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedmclefmlhgckilmjndpabdihlmclbimgkabaaaaaapiaeaaaaaeaaaaaa
daaaaaaamiabaaaadmaeaaaameaeaaaaebgpgodjjaabaaaajaabaaaaaaacpppp
feabaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaaaaaaaaa
abababaaacacacaaaaaaadaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapka
aaaaiadpaaaaaaebaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaabaaaaacaaaaabia
aaaakklaabaaaaacaaaaaciaaaaapplaecaaaaadabaacpiaaaaaoelaaaaioeka
ecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaadacaacpiaacaaoelaacaioeka
afaaaaadadaaaiiaaaaaaakaaaaaffkaaiaaaaadadaabbiaabaaoeiaabaaoeka
acaaaaadadaaabiaadaaaaibacaaaakaafaaaaadadaaabiaadaaaaiaadaappia
aeaaaaaeadaadbiaabaafflaaaaaaakaadaaaaibbcaaaaaeaeaacpiaadaaaaia
aaaaoeiaabaaoeiaafaaaaadacaaciiaacaappiaacaaffkaafaaaaadaaaachia
acaaoeiaacaappiaafaaaaadaeaachiaaaaaoeiaaeaaoeiaabaaaaacaaaicpia
aeaaoeiappppaaaafdeieefcgmacaaaaeaaaaaaajlaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaajbcaabaaaaaaaaaaa
akiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabacaaaai
ccaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaaeaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaalbcaabaaa
aaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahacaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_Fading]
Float 3 [_Threshold]
Vector 4 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"!!ARBfp1.0
PARAM c[6] = { program.local[0..4],
		{ 0, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[0].zwzw, texture[1], 2D;
TXP R2.x, fragment.texcoord[4], texture[2], 2D;
DP3_SAT R2.z, R0, c[4];
MOV R2.y, c[2].x;
ADD R1, -R0, R1;
ADD R2.z, -R2, c[5].y;
MUL R2.y, R2, c[3].x;
MUL R2.y, R2, R2.z;
MAD_SAT R2.y, fragment.texcoord[1], c[2].x, -R2;
MAD R0, R2.y, R1, R0;
MUL R1.xyz, R0, fragment.texcoord[3];
DP3 R1.w, fragment.texcoord[2], c[0];
MAX R1.w, R1, c[5].x;
MUL R0.xyz, R0, c[1];
MUL R1.w, R1, R2.x;
MUL R0.xyz, R1.w, R0;
MAD result.color.xyz, R0, c[5].z, R1;
MOV result.color.w, R0;
END
# 19 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_Fading]
Float 3 [_Threshold]
Vector 4 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c5, 0.00000000, 1.00000000, 2.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t3.xyz
dcl t4
texldp r4, t4, s2
texld r3, t0, s0
dp3_pp_sat r1.x, r3, c4
mov r0.y, t0.w
mov r0.x, t0.z
add_pp r1.x, -r1, c5.y
texld r2, r0, s1
mov r0.x, c3
mul r0.x, c2, r0
mul r0.x, r0, r1
add_pp r1, -r3, r2
mad_sat r0.x, t1.y, c2, -r0
mad_pp r0, r0.x, r1, r3
mul_pp r2.xyz, r0, t3
mul_pp r1.xyz, r0, c1
dp3_pp r0.x, t2, c0
max_pp r0.x, r0, c5
mul_pp r0.x, r0, r4
mul_pp r0.xyz, r0.x, r1
mad_pp r0.xyz, r0, c5.z, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_MossTex] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Float 112 [_Fading]
Float 116 [_Threshold]
Vector 128 [_FadeColor]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecededbeiohoikdmllcomhjjdjojpnkhdoahabaaaaaadeaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbeadaaaa
eaaaaaaamfaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaafaaaaaa
pgbpbaaaafaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
acaaaaaaaagabaaaaaaaaaaabaaaaaaiccaabaaaaaaaaaaaegbcbaaaadaaaaaa
egiccaaaabaaaaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaafgafbaaaaaaaaaaaagaabaaa
aaaaaaaadiaaaaajccaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaabkiacaaa
aaaaaaaaahaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaabacaaaaiecaabaaaaaaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaaiaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaadccaaaalccaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaa
aaaaaaaaahaaaaaabkaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaafgafbaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaai
ocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegbcbaaaaeaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaaaaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_MossTex] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Float 112 [_Fading]
Float 116 [_Threshold]
Vector 128 [_FadeColor]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedjmofenefbefagbcnajkehkmijbodjbfjabaaaaaageagaaaaaeaaaaaa
daaaaaaafmacaaaahiafaaaadaagaaaaebgpgodjceacaaaaceacaaaaaaacpppp
naabaaaafeaaaaaaadaadaaaaaaafeaaaaaafeaaadaaceaaaaaafeaaacaaaaaa
aaababaaabacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaahaaacaaabaaaaaaaaaa
abaaaaaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaahla
bpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaia
aeaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkaagaaaaacaaaaaiiaaeaapplaafaaaaadaaaaadiaaaaappia
aeaaoelaabaaaaacabaaabiaaaaakklaabaaaaacabaaaciaaaaapplaecaaaaad
aaaacpiaaaaaoeiaaaaioekaecaaaaadacaacpiaaaaaoelaabaioekaecaaaaad
abaacpiaabaaoeiaacaioekaaiaaaaadaaaacciaacaaoelaadaaoekaafaaaaad
aaaacbiaaaaaaaiaaaaaffiafiaaaaaeaaaacbiaaaaaffiaaaaaaaiaaeaaffka
acaaaaadaaaacbiaaaaaaaiaaaaaaaiaafaaaaadaaaaaciaabaaaakaabaaffka
aiaaaaadaaaabeiaacaaoeiaacaaoekaacaaaaadaaaaaeiaaaaakkibaeaaaaka
afaaaaadaaaaaciaaaaakkiaaaaaffiaaeaaaaaeaaaadciaabaafflaabaaaaka
aaaaffibbcaaaaaeadaacpiaaaaaffiaabaaoeiaacaaoeiaafaaaaadaaaacoia
adaabliaaaaablkaafaaaaadabaachiaadaaoeiaadaaoelaaeaaaaaeadaachia
aaaabliaaaaaaaiaabaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefc
beadaaaaeaaaaaaamfaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
afaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaabaaaaaaiccaabaaaaaaaaaaaegbcbaaa
adaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaafgafbaaaaaaaaaaa
agaabaaaaaaaaaaadiaaaaajccaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaa
bkiacaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaabacaaaaiecaabaaaaaaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaaiaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaadccaaaalccaabaaaaaaaaaaabkbabaaaacaaaaaa
akiacaaaaaaaaaaaahaaaaaabkaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaai
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaaj
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaa
diaaaaaiocaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbcbaaaaeaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaa
aaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahacaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaa
keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 1, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[2], texture[3], 2D;
TXP R3.x, fragment.texcoord[3], texture[2], 2D;
TEX R2, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R3.yzw, R1.xxyz, R3.x;
MUL R1.xyz, R1.w, R1;
DP3_SAT R1.w, R2, c[2];
MUL R1.xyz, R1, c[3].y;
MUL R3.yzw, R3, c[3].z;
MIN R3.yzw, R1.xxyz, R3;
MUL R1.xyz, R1, R3.x;
MOV R3.x, c[0];
ADD R0, -R2, R0;
ADD R1.w, -R1, c[3].x;
MUL R3.x, R3, c[1];
MUL R1.w, R3.x, R1;
MAD_SAT R1.w, fragment.texcoord[1].y, c[0].x, -R1;
MAD R0, R1.w, R0, R2;
MAX R1.xyz, R3.yzww, R1;
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 21 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 1.00000000, 8.00000000, 2.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xy
dcl t3
texld r2, t0, s0
texld r3, t2, s3
mul_pp r4.xyz, r3.w, r3
mul_pp r4.xyz, r4, c3.y
mov r0.y, t0.w
mov r0.x, t0.z
texld r1, r0, s1
texldp r0, t3, s2
mul_pp r3.xyz, r3, r0.x
mul_pp r3.xyz, r3, c3.z
mul_pp r0.xyz, r4, r0.x
min_pp r3.xyz, r4, r3
max_pp r4.xyz, r3, r0
dp3_pp_sat r3.x, r2, c2
mov r0.x, c1
add_pp r3.x, -r3, c3
mul r0.x, c0, r0
mul r0.x, r0, r3
add_pp r1, -r2, r1
mad_sat r0.x, t1.y, c0, -r0
mad_pp r0, r0.x, r1, r2
mul_pp r0.xyz, r0, r4
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_MossTex] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
SetTexture 3 [unity_Lightmap] 2D 3
ConstBuffer "$Globals" 192
Float 112 [_Fading]
Float 116 [_Threshold]
Vector 128 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecednkpblpoeggbcobnnaopdojlacfnigogoabaaaaaagiaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcgaadaaaaeaaaaaaaniaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
ccbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahocaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaaddaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
deaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaj
icaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaabacaaaaibcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
aiaaaaaaaaaaaaaibcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaa
dccaaaalicaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaa
dkaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaia
ebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaapgapbaaa
aaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_MossTex] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
SetTexture 3 [unity_Lightmap] 2D 3
ConstBuffer "$Globals" 192
Float 112 [_Fading]
Float 116 [_Threshold]
Vector 128 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecednpnaokceeglkgcflaefmpelgaggoccidabaaaaaajmagaaaaaeaaaaaa
daaaaaaagaacaaaamiafaaaagiagaaaaebgpgodjciacaaaaciacaaaaaaacpppp
oiabaaaaeaaaaaaaabaadeaaaaaaeaaaaaaaeaaaaeaaceaaaaaaeaaaacaaaaaa
aaababaaabacacaaadadadaaaaaaahaaacaaaaaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaiadpaaaaaaebaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaia
adaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaagaaaaacaaaaaiiaadaappla
afaaaaadaaaaadiaaaaappiaadaaoelaabaaaaacabaaabiaaaaakklaabaaaaac
abaaaciaaaaapplaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaadacaacpia
acaaoelaadaioekaecaaaaadadaacpiaaaaaoelaabaioekaecaaaaadabaacpia
abaaoeiaacaioekaacaaaaadaaaacciaaaaaaaiaaaaaaaiaafaaaaadaaaacoia
acaabliaaaaaffiaafaaaaadacaaciiaacaappiaacaaffkaafaaaaadacaachia
acaaoeiaacaappiaakaaaaadaeaachiaaaaabliaacaaoeiaafaaaaadaaaachia
aaaaaaiaacaaoeiaalaaaaadacaachiaaeaaoeiaaaaaoeiaafaaaaadacaaaiia
aaaaaakaaaaaffkaaiaaaaadaaaabbiaadaaoeiaabaaoekaacaaaaadaaaaabia
aaaaaaibacaaaakaafaaaaadacaaaiiaaaaaaaiaacaappiaaeaaaaaeacaadiia
abaafflaaaaaaakaacaappibbcaaaaaeaaaacpiaacaappiaabaaoeiaadaaoeia
afaaaaadaaaachiaacaaoeiaaaaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcgaadaaaaeaaaaaaaniaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
ccbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahocaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaaddaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
deaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaj
icaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaabacaaaaibcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
aiaaaaaaaaaaaaaibcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaa
dccaaaalicaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaa
dkaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaia
ebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaapgapbaaa
aaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahacaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 1, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[2], texture[3], 2D;
TXP R3.x, fragment.texcoord[3], texture[2], 2D;
TEX R2, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R3.yzw, R1.xxyz, R3.x;
MUL R1.xyz, R1.w, R1;
DP3_SAT R1.w, R2, c[2];
MUL R1.xyz, R1, c[3].y;
MUL R3.yzw, R3, c[3].z;
MIN R3.yzw, R1.xxyz, R3;
MUL R1.xyz, R1, R3.x;
MOV R3.x, c[0];
ADD R0, -R2, R0;
ADD R1.w, -R1, c[3].x;
MUL R3.x, R3, c[1];
MUL R1.w, R3.x, R1;
MAD_SAT R1.w, fragment.texcoord[1].y, c[0].x, -R1;
MAD R0, R1.w, R0, R2;
MAX R1.xyz, R3.yzww, R1;
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 21 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 1.00000000, 8.00000000, 2.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xy
dcl t3
texld r2, t0, s0
texld r3, t2, s3
mul_pp r4.xyz, r3.w, r3
mul_pp r4.xyz, r4, c3.y
mov r0.y, t0.w
mov r0.x, t0.z
texld r1, r0, s1
texldp r0, t3, s2
mul_pp r3.xyz, r3, r0.x
mul_pp r3.xyz, r3, c3.z
mul_pp r0.xyz, r4, r0.x
min_pp r3.xyz, r4, r3
max_pp r4.xyz, r3, r0
dp3_pp_sat r3.x, r2, c2
mov r0.x, c1
add_pp r3.x, -r3, c3
mul r0.x, c0, r0
mul r0.x, r0, r3
add_pp r1, -r2, r1
mad_sat r0.x, t1.y, c0, -r0
mad_pp r0, r0.x, r1, r2
mul_pp r0.xyz, r0, r4
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_MossTex] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
SetTexture 3 [unity_Lightmap] 2D 3
ConstBuffer "$Globals" 192
Float 112 [_Fading]
Float 116 [_Threshold]
Vector 128 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecednkpblpoeggbcobnnaopdojlacfnigogoabaaaaaagiaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcgaadaaaaeaaaaaaaniaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
ccbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahocaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaaddaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
deaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaj
icaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaabacaaaaibcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
aiaaaaaaaaaaaaaibcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaa
dccaaaalicaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaa
dkaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaia
ebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaapgapbaaa
aaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_MossTex] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
SetTexture 3 [unity_Lightmap] 2D 3
ConstBuffer "$Globals" 192
Float 112 [_Fading]
Float 116 [_Threshold]
Vector 128 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecednpnaokceeglkgcflaefmpelgaggoccidabaaaaaajmagaaaaaeaaaaaa
daaaaaaagaacaaaamiafaaaagiagaaaaebgpgodjciacaaaaciacaaaaaaacpppp
oiabaaaaeaaaaaaaabaadeaaaaaaeaaaaaaaeaaaaeaaceaaaaaaeaaaacaaaaaa
aaababaaabacacaaadadadaaaaaaahaaacaaaaaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaiadpaaaaaaebaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaia
adaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaagaaaaacaaaaaiiaadaappla
afaaaaadaaaaadiaaaaappiaadaaoelaabaaaaacabaaabiaaaaakklaabaaaaac
abaaaciaaaaapplaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaadacaacpia
acaaoelaadaioekaecaaaaadadaacpiaaaaaoelaabaioekaecaaaaadabaacpia
abaaoeiaacaioekaacaaaaadaaaacciaaaaaaaiaaaaaaaiaafaaaaadaaaacoia
acaabliaaaaaffiaafaaaaadacaaciiaacaappiaacaaffkaafaaaaadacaachia
acaaoeiaacaappiaakaaaaadaeaachiaaaaabliaacaaoeiaafaaaaadaaaachia
aaaaaaiaacaaoeiaalaaaaadacaachiaaeaaoeiaaaaaoeiaafaaaaadacaaaiia
aaaaaakaaaaaffkaaiaaaaadaaaabbiaadaaoeiaabaaoekaacaaaaadaaaaabia
aaaaaaibacaaaakaafaaaaadacaaaiiaaaaaaaiaacaappiaaeaaaaaeacaadiia
abaafflaaaaaaakaacaappibbcaaaaaeaaaacpiaacaappiaabaaoeiaadaaoeia
afaaaaadaaaachiaacaaoeiaaaaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcgaadaaaaeaaaaaaaniaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
ccbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahocaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaaddaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
deaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaj
icaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaabacaaaaibcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
aiaaaaaaaaaaaaaibcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaa
dccaaaalicaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaa
dkaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaia
ebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaapgapbaaa
aaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahacaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
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
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
Vector 15 [_MainTex_ST]
Vector 16 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[17] = { program.local[0],
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
ADD result.texcoord[3].xyz, -R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
DP3 result.texcoord[1].z, vertex.normal, c[7];
DP3 result.texcoord[1].y, vertex.normal, c[6];
DP3 result.texcoord[1].x, vertex.normal, c[5];
END
# 21 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
Vector 14 [_MainTex_ST]
Vector 15 [_MossTex_ST]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c13.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT4.z, r0, c10
dp4 oT4.y, r0, c9
dp4 oT4.x, r0, c8
dp3 oT2.z, r1, c6
dp3 oT2.y, r1, c5
dp3 oT2.x, r1, c4
add oT3.xyz, -r0, c12
mad oT0.zw, v2.xyxy, c15.xyxy, c15
mad oT0.xy, v2, c14, c14.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
dp3 oT1.z, v1, c6
dp3 oT1.y, v1, c5
dp3 oT1.x, v1, c4
"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_MossTex_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedipblibkdngkpedemgofcfofekbnpkihcabaaaaaaeeagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcjaaeaaaaeaaaabaaceabaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaa
aaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaaeaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_MossTex_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedoneencdekeaaaajhkgegaihajhijbabhabaaaaaapeaiaaaaaeaaaaaa
daaaaaaanmacaaaaheahaaaadmaiaaaaebgpgodjkeacaaaakeacaaaaaaacpopp
deacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
aeaaabaaaaaaaaaaaaaaajaaacaaafaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaa
acaaaaaaaeaaaiaaaaaaaaaaacaaamaaaeaaamaaaaaaaaaaacaabeaaabaabaaa
aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaafaaoeka
afaaookaaeaaaaaeaaaaamoaadaaeejaagaaeekaagaaoekaafaaaaadaaaaahia
acaaffjaanaaoekaaeaaaaaeaaaaahiaamaaoekaacaaaajaaaaaoeiaaeaaaaae
abaaahoaaoaaoekaacaakkjaaaaaoeiaafaaaaadaaaaahiaacaaoejabaaappka
afaaaaadabaaahiaaaaaffiaanaaoekaaeaaaaaeaaaaaliaamaakekaaaaaaaia
abaakeiaaeaaaaaeacaaahoaaoaaoekaaaaakkiaaaaapeiaafaaaaadaaaaahia
aaaaffjaanaaoekaaeaaaaaeaaaaahiaamaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaahiaaoaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiaapaaoekaaaaappja
aaaaoeiaacaaaaadadaaahoaaaaaoeibahaaoekaafaaaaadaaaaapiaaaaaffja
anaaoekaaeaaaaaeaaaaapiaamaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aoaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaappjaaaaaoeia
afaaaaadabaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoekaaaaaaaia
abaaoeiaaeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaaeaeaaahoa
aeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaajaaoekaaeaaaaae
aaaaapiaaiaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaakaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaalaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefc
jaaeaaaaeaaaabaaceabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaa
akaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
acaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hccabaaaaeaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_WorldSpaceLightPos0]
Vector 10 [unity_Scale]
Vector 11 [_MainTex_ST]
Vector 12 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[13] = { program.local[0],
		state.matrix.mvp,
		program.local[5..12] };
TEMP R0;
MUL R0.xyz, vertex.normal, c[10].w;
DP3 result.texcoord[2].z, R0, c[7];
DP3 result.texcoord[2].y, R0, c[6];
DP3 result.texcoord[2].x, R0, c[5];
MOV result.texcoord[3].xyz, c[9];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[12].xyxy, c[12];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
DP3 result.texcoord[1].z, vertex.normal, c[7];
DP3 result.texcoord[1].y, vertex.normal, c[6];
DP3 result.texcoord[1].x, vertex.normal, c[5];
END
# 14 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceLightPos0]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
Vector 11 [_MossTex_ST]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1, c9.w
dp3 oT2.z, r0, c6
dp3 oT2.y, r0, c5
dp3 oT2.x, r0, c4
mov oT3.xyz, c8
mad oT0.zw, v2.xyxy, c11.xyxy, c11
mad oT0.xy, v2, c10, c10.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
dp3 oT1.z, v1, c6
dp3 oT1.y, v1, c5
dp3 oT1.x, v1, c4
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 112
Vector 80 [_MainTex_ST]
Vector 96 [_MossTex_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedabdciojppbdnnnhbemiliipaganmjgpiabaaaaaaemaeaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefclaacaaaaeaaaabaa
kmaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
agaaaaaakgiocaaaaaaaaaaaagaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
acaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaa
abaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 112
Vector 80 [_MainTex_ST]
Vector 96 [_MossTex_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedjdjkhoplailefdcemahilphjkjgabeefabaaaaaaaiagaaaaaeaaaaaa
daaaaaaaoiabaaaakaaeaaaagiafaaaaebgpgodjlaabaaaalaabaaaaaaacpopp
emabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaafaa
acaaabaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaaacaaaaaaaeaaaeaaaaaaaaaa
acaaamaaadaaaiaaaaaaaaaaacaabeaaabaaalaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoa
adaaeejaacaaeekaacaaoekaafaaaaadaaaaahiaacaaffjaajaaoekaaeaaaaae
aaaaahiaaiaaoekaacaaaajaaaaaoeiaaeaaaaaeabaaahoaakaaoekaacaakkja
aaaaoeiaafaaaaadaaaaahiaacaaoejaalaappkaafaaaaadabaaahiaaaaaffia
ajaaoekaaeaaaaaeaaaaaliaaiaakekaaaaaaaiaabaakeiaaeaaaaaeacaaahoa
akaaoekaaaaakkiaaaaapeiaafaaaaadaaaaapiaaaaaffjaafaaoekaaeaaaaae
aaaaapiaaeaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacadaaahoa
adaaoekappppaaaafdeieefclaacaaaaeaaaabaakmaaaaaafjaaaaaeegiocaaa
aaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaa
acaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaa
agaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
acaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaaghccabaaaaeaaaaaaegiccaaaabaaaaaaaaaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
Vector 15 [_MainTex_ST]
Vector 16 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[17] = { program.local[0],
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[4].w, R0, c[12];
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
ADD result.texcoord[3].xyz, -R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
DP3 result.texcoord[1].z, vertex.normal, c[7];
DP3 result.texcoord[1].y, vertex.normal, c[6];
DP3 result.texcoord[1].x, vertex.normal, c[5];
END
# 22 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
Vector 14 [_MainTex_ST]
Vector 15 [_MossTex_ST]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c13.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT4.w, r0, c11
dp4 oT4.z, r0, c10
dp4 oT4.y, r0, c9
dp4 oT4.x, r0, c8
dp3 oT2.z, r1, c6
dp3 oT2.y, r1, c5
dp3 oT2.x, r1, c4
add oT3.xyz, -r0, c12
mad oT0.zw, v2.xyxy, c15.xyxy, c15
mad oT0.xy, v2, c14, c14.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
dp3 oT1.z, v1, c6
dp3 oT1.y, v1, c5
dp3 oT1.x, v1, c4
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_MossTex_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhgaafbhjilihojmkmgpboncmnmdnoegeabaaaaaaeeagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcjaaeaaaaeaaaabaaceabaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaa
aaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaaeaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
afaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_MossTex_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedkodgdfgcgmpkoampphonhoajnbjmloaiabaaaaaapeaiaaaaaeaaaaaa
daaaaaaanmacaaaaheahaaaadmaiaaaaebgpgodjkeacaaaakeacaaaaaaacpopp
deacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
aeaaabaaaaaaaaaaaaaaajaaacaaafaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaa
acaaaaaaaeaaaiaaaaaaaaaaacaaamaaaeaaamaaaaaaaaaaacaabeaaabaabaaa
aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaafaaoeka
afaaookaaeaaaaaeaaaaamoaadaaeejaagaaeekaagaaoekaafaaaaadaaaaahia
acaaffjaanaaoekaaeaaaaaeaaaaahiaamaaoekaacaaaajaaaaaoeiaaeaaaaae
abaaahoaaoaaoekaacaakkjaaaaaoeiaafaaaaadaaaaahiaacaaoejabaaappka
afaaaaadabaaahiaaaaaffiaanaaoekaaeaaaaaeaaaaaliaamaakekaaaaaaaia
abaakeiaaeaaaaaeacaaahoaaoaaoekaaaaakkiaaaaapeiaafaaaaadaaaaahia
aaaaffjaanaaoekaaeaaaaaeaaaaahiaamaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaahiaaoaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiaapaaoekaaaaappja
aaaaoeiaacaaaaadadaaahoaaaaaoeibahaaoekaafaaaaadaaaaapiaaaaaffja
anaaoekaaeaaaaaeaaaaapiaamaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aoaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaappjaaaaaoeia
afaaaaadabaaapiaaaaaffiaacaaoekaaeaaaaaeabaaapiaabaaoekaaaaaaaia
abaaoeiaaeaaaaaeabaaapiaadaaoekaaaaakkiaabaaoeiaaeaaaaaeaeaaapoa
aeaaoekaaaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffjaajaaoekaaeaaaaae
aaaaapiaaiaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaakaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaalaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefc
jaaeaaaaeaaaabaaceabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaa
akaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
acaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hccabaaaaeaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpccabaaaafaaaaaaegiocaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
Vector 15 [_MainTex_ST]
Vector 16 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[17] = { program.local[0],
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
ADD result.texcoord[3].xyz, -R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
DP3 result.texcoord[1].z, vertex.normal, c[7];
DP3 result.texcoord[1].y, vertex.normal, c[6];
DP3 result.texcoord[1].x, vertex.normal, c[5];
END
# 21 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
Vector 14 [_MainTex_ST]
Vector 15 [_MossTex_ST]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c13.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT4.z, r0, c10
dp4 oT4.y, r0, c9
dp4 oT4.x, r0, c8
dp3 oT2.z, r1, c6
dp3 oT2.y, r1, c5
dp3 oT2.x, r1, c4
add oT3.xyz, -r0, c12
mad oT0.zw, v2.xyxy, c15.xyxy, c15
mad oT0.xy, v2, c14, c14.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
dp3 oT1.z, v1, c6
dp3 oT1.y, v1, c5
dp3 oT1.x, v1, c4
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_MossTex_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedipblibkdngkpedemgofcfofekbnpkihcabaaaaaaeeagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcjaaeaaaaeaaaabaaceabaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaa
aaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaaeaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_MossTex_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedoneencdekeaaaajhkgegaihajhijbabhabaaaaaapeaiaaaaaeaaaaaa
daaaaaaanmacaaaaheahaaaadmaiaaaaebgpgodjkeacaaaakeacaaaaaaacpopp
deacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
aeaaabaaaaaaaaaaaaaaajaaacaaafaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaa
acaaaaaaaeaaaiaaaaaaaaaaacaaamaaaeaaamaaaaaaaaaaacaabeaaabaabaaa
aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaafaaoeka
afaaookaaeaaaaaeaaaaamoaadaaeejaagaaeekaagaaoekaafaaaaadaaaaahia
acaaffjaanaaoekaaeaaaaaeaaaaahiaamaaoekaacaaaajaaaaaoeiaaeaaaaae
abaaahoaaoaaoekaacaakkjaaaaaoeiaafaaaaadaaaaahiaacaaoejabaaappka
afaaaaadabaaahiaaaaaffiaanaaoekaaeaaaaaeaaaaaliaamaakekaaaaaaaia
abaakeiaaeaaaaaeacaaahoaaoaaoekaaaaakkiaaaaapeiaafaaaaadaaaaahia
aaaaffjaanaaoekaaeaaaaaeaaaaahiaamaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaahiaaoaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiaapaaoekaaaaappja
aaaaoeiaacaaaaadadaaahoaaaaaoeibahaaoekaafaaaaadaaaaapiaaaaaffja
anaaoekaaeaaaaaeaaaaapiaamaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aoaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaappjaaaaaoeia
afaaaaadabaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoekaaaaaaaia
abaaoeiaaeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaaeaeaaahoa
aeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaajaaoekaaeaaaaae
aaaaapiaaiaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaakaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaalaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefc
jaaeaaaaeaaaabaaceabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaa
akaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaacaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
acaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hccabaaaaeaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
Vector 15 [_MainTex_ST]
Vector 16 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[17] = { program.local[0],
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
MOV result.texcoord[3].xyz, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
DP3 result.texcoord[1].z, vertex.normal, c[7];
DP3 result.texcoord[1].y, vertex.normal, c[6];
DP3 result.texcoord[1].x, vertex.normal, c[5];
END
# 20 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
Vector 14 [_MainTex_ST]
Vector 15 [_MossTex_ST]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c13.w
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 oT4.y, r0, c9
dp4 oT4.x, r0, c8
dp3 oT2.z, r1, c6
dp3 oT2.y, r1, c5
dp3 oT2.x, r1, c4
mov oT3.xyz, c12
mad oT0.zw, v2.xyxy, c15.xyxy, c15
mad oT0.xy, v2, c14, c14.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
dp3 oT1.z, v1, c6
dp3 oT1.y, v1, c5
dp3 oT1.x, v1, c4
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_MossTex_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecednpofppbnlfmclpakbopklalkbhdkjphdabaaaaaakaafaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcomadaaaaeaaaabaaplaaaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaaddccabaaaafaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaa
aaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaa
egiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaa
aeaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaaagaabaaa
aaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaa
afaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakdccabaaaafaaaaaa
egiacaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_MossTex_ST]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedfececkphfjoidkgfifielcehjjonngmnabaaaaaaaaaiaaaaaeaaaaaa
daaaaaaaimacaaaaiaagaaaaeiahaaaaebgpgodjfeacaaaafeacaaaaaaacpopp
oeabaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
aeaaabaaaaaaaaaaaaaaajaaacaaafaaaaaaaaaaabaaaaaaabaaahaaaaaaaaaa
acaaaaaaaeaaaiaaaaaaaaaaacaaamaaaeaaamaaaaaaaaaaacaabeaaabaabaaa
aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaafaaoeka
afaaookaaeaaaaaeaaaaamoaadaaeejaagaaeekaagaaoekaafaaaaadaaaaahia
acaaffjaanaaoekaaeaaaaaeaaaaahiaamaaoekaacaaaajaaaaaoeiaaeaaaaae
abaaahoaaoaaoekaacaakkjaaaaaoeiaafaaaaadaaaaahiaacaaoejabaaappka
afaaaaadabaaahiaaaaaffiaanaaoekaaeaaaaaeaaaaaliaamaakekaaaaaaaia
abaakeiaaeaaaaaeacaaahoaaoaaoekaaaaakkiaaaaapeiaafaaaaadaaaaapia
aaaaffjaanaaoekaaeaaaaaeaaaaapiaamaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaaoaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaappja
aaaaoeiaafaaaaadabaaadiaaaaaffiaacaaoekaaeaaaaaeaaaaadiaabaaoeka
aaaaaaiaabaaoeiaaeaaaaaeaaaaadiaadaaoekaaaaakkiaaaaaoeiaaeaaaaae
aeaaadoaaeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaajaaoeka
aeaaaaaeaaaaapiaaiaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaakaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaalaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
adaaahoaahaaoekappppaaaafdeieefcomadaaaaeaaaabaaplaaaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaaddccabaaaafaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaa
aaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaacaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaghccabaaaaeaaaaaa
egiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaa
aeaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaaagaabaaa
aaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaa
afaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakdccabaaaafaaaaaa
egiacaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Float 1 [_Fading]
Float 2 [_Threshold]
Vector 3 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 0, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
DP3_SAT R1.w, R0, c[3];
ADD R2.x, -R1.w, c[4].y;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
DP3 R2.y, fragment.texcoord[3], fragment.texcoord[3];
MOV R1.w, c[1].x;
MUL R1.w, R1, c[2].x;
MUL R1.w, R1, R2.x;
RSQ R2.y, R2.y;
ADD R1.xyz, -R0, R1;
MAD_SAT R1.w, fragment.texcoord[1].y, c[1].x, -R1;
MAD R0.xyz, R1.w, R1, R0;
MUL R2.xyz, R2.y, fragment.texcoord[3];
DP3 R1.x, fragment.texcoord[2], R2;
MUL R0.xyz, R0, c[0];
MAX R1.x, R1, c[4];
MOV result.color.w, c[4].x;
TEX R0.w, R0.w, texture[2], 2D;
MUL R0.w, R1.x, R0;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[4].z;
END
# 22 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Float 1 [_Fading]
Float 2 [_Threshold]
Vector 3 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 1.00000000, 0.00000000, 2.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
texld r2, t0, s0
dp3 r0.x, t4, t4
mov r1.xy, r0.x
mov r0.y, t0.w
mov r0.x, t0.z
texld r4, r1, s2
texld r0, r0, s1
add_pp r3.xyz, -r2, r0
dp3_pp_sat r1.x, r2, c3
mov r0.x, c2
mul r0.x, c1, r0
add_pp r1.x, -r1, c4
mul r1.x, r0, r1
dp3_pp r0.x, t3, t3
mad_sat r1.x, t1.y, c1, -r1
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, t3
dp3_pp r0.x, t2, r0
mad_pp r1.xyz, r1.x, r3, r2
mul_pp r1.xyz, r1, c0
max_pp r0.x, r0, c4.y
mul_pp r0.x, r0, r4
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c4.z
mov_pp r0.w, c4.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_MossTex] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Float 112 [_Fading]
Float 116 [_Threshold]
Vector 128 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedeklknpgmajjcobhppiokdkbbhiccdaalabaaaaaaeiaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcciadaaaa
eaaaaaaamkaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadccbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
hcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaaj
bcaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaabacaaaaiccaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
aiaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dccaaaalbcaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaa
akaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaaiocaabaaaaaaaaaaaagajbaia
ebaaaaaaabaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaa
aaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaaeaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaa
agaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaapgapbaaaaaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_MossTex] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Float 112 [_Fading]
Float 116 [_Threshold]
Vector 128 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedmfhcpgdgnommmlleganoakhenifinedbabaaaaaahaagaaaaaeaaaaaa
daaaaaaafeacaaaaieafaaaadmagaaaaebgpgodjbmacaaaabmacaaaaaaacpppp
neabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaacaaaaaa
aaababaaabacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaahaaacaaabaaaaaaaaaa
aaacppppfbaaaaafadaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaachla
bpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaabaaaaac
aaaaabiaaaaakklaabaaaaacaaaaaciaaaaapplaaiaaaaadabaaaiiaaeaaoela
aeaaoelaabaaaaacabaaadiaabaappiaecaaaaadacaacpiaaaaaoelaabaioeka
ecaaaaadaaaacpiaaaaaoeiaacaioekaecaaaaadabaacpiaabaaoeiaaaaioeka
afaaaaadaaaaaiiaabaaaakaabaaffkaaiaaaaadacaabiiaacaaoeiaacaaoeka
acaaaaadacaaaiiaacaappibadaaaakaafaaaaadaaaaaiiaaaaappiaacaappia
aeaaaaaeaaaadiiaabaafflaabaaaakaaaaappibbcaaaaaeabaacoiaaaaappia
aaaabliaacaabliaafaaaaadaaaachiaabaabliaaaaaoekaceaaaaacacaachia
adaaoelaaiaaaaadaaaaciiaacaaoelaacaaoeiaafaaaaadabaacbiaabaaaaia
aaaappiafiaaaaaeaaaaciiaaaaappiaabaaaaiaadaaffkaacaaaaadaaaaciia
aaaappiaaaaappiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaaciia
adaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcciadaaaaeaaaaaaa
mkaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaajbcaabaaa
aaaaaaaaakiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
bacaaaaiccaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaaiaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaal
bcaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaaakaabaia
ebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaaaaaaaaaiocaabaaaaaaaaaaaagajbaiaebaaaaaa
abaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
pgapbaaaaaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahacaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Float 1 [_Fading]
Float 2 [_Threshold]
Vector 3 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
"!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 0, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
DP3_SAT R1.w, R0, c[3];
MOV R0.w, c[1].x;
ADD R1.xyz, -R0, R1;
ADD R1.w, -R1, c[4].y;
MUL R0.w, R0, c[2].x;
MUL R0.w, R0, R1;
MAD_SAT R0.w, fragment.texcoord[1].y, c[1].x, -R0;
MAD R0.xyz, R0.w, R1, R0;
MOV R2.xyz, fragment.texcoord[3];
DP3 R0.w, fragment.texcoord[2], R2;
MUL R0.xyz, R0, c[0];
MAX R0.w, R0, c[4].x;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[4].z;
MOV result.color.w, c[4].x;
END
# 17 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Float 1 [_Fading]
Float 2 [_Threshold]
Vector 3 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c4, 1.00000000, 0.00000000, 2.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t3.xyz
texld r2, t0, s0
dp3_pp_sat r1.x, r2, c3
mov r0.y, t0.w
mov r0.x, t0.z
add_pp r1.x, -r1, c4
mov_pp r0.w, c4.y
texld r3, r0, s1
mov r0.x, c2
mul r0.x, c1, r0
mul r0.x, r0, r1
add_pp r1.xyz, -r2, r3
mad_sat r0.x, t1.y, c1, -r0
mad_pp r1.xyz, r0.x, r1, r2
mov_pp r3.xyz, t3
dp3_pp r0.x, t2, r3
mul_pp r1.xyz, r1, c0
max_pp r0.x, r0, c4.y
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c4.z
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
ConstBuffer "$Globals" 112
Vector 16 [_LightColor0]
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedocfmcabpknnhipkbpbdgicjkolhnlnkfabaaaaaahmadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcheacaaaaeaaaaaaajnaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadccbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaaj
bcaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaabacaaaaiccaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
aeaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dccaaaalbcaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaadaaaaaa
akaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaiocaabaaaaaaaaaaaagajbaia
ebaaaaaaabaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaa
aaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaadaaaaaaegbcbaaaaeaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
ConstBuffer "$Globals" 112
Vector 16 [_LightColor0]
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedemcjgnpopkkffhadljmakkgdamehdangabaaaaaaeiafaaaaaeaaaaaa
daaaaaaapiabaaaaheaeaaaabeafaaaaebgpgodjmaabaaaamaabaaaaaaacpppp
hmabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaaaadaaacaaabaaaaaaaaaaaaacpppp
fbaaaaafadaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaachlabpaaaaac
aaaaaaiaadaachlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
abaaaaacaaaaabiaaaaakklaabaaaaacaaaaaciaaaaapplaecaaaaadabaacpia
aaaaoelaaaaioekaecaaaaadaaaacpiaaaaaoeiaabaioekaafaaaaadaaaaaiia
abaaaakaabaaffkaaiaaaaadabaabiiaabaaoeiaacaaoekaacaaaaadabaaaiia
abaappibadaaaakaafaaaaadaaaaaiiaaaaappiaabaappiaaeaaaaaeaaaadiia
abaafflaabaaaakaaaaappibbcaaaaaeacaachiaaaaappiaaaaaoeiaabaaoeia
afaaaaadaaaachiaacaaoeiaaaaaoekaabaaaaacabaaahiaacaaoelaaiaaaaad
aaaaciiaabaaoeiaadaaoelaalaaaaadabaacbiaaaaappiaadaaffkaacaaaaad
aaaaciiaabaaaaiaabaaaaiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaac
aaaaciiaadaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcheacaaaa
eaaaaaaajnaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
ccbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaajbcaabaaaaaaaaaaa
akiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabacaaaai
ccaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaaeaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaalbcaabaaa
aaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaadaaaaaaakaabaiaebaaaaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaiocaabaaaaaaaaaaaagajbaiaebaaaaaaabaaaaaa
agajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaa
egbcbaaaaeaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahacaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Float 1 [_Fading]
Float 2 [_Threshold]
Vector 3 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
"!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 0, 1, 0.5, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
RCP R0.x, fragment.texcoord[4].w;
MAD R2.xy, fragment.texcoord[4], R0.x, c[4].z;
DP3 R1.w, fragment.texcoord[4], fragment.texcoord[4];
DP3 R2.z, fragment.texcoord[3], fragment.texcoord[3];
MOV result.color.w, c[4].x;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R0.w, R2, texture[2], 2D;
TEX R1.w, R1.w, texture[3], 2D;
DP3_SAT R2.y, R0, c[3];
MOV R2.x, c[1];
ADD R1.xyz, -R0, R1;
ADD R2.y, -R2, c[4];
MUL R2.x, R2, c[2];
MUL R2.x, R2, R2.y;
MAD_SAT R2.y, fragment.texcoord[1], c[1].x, -R2.x;
MAD R0.xyz, R2.y, R1, R0;
RSQ R2.x, R2.z;
MUL R1.xyz, R2.x, fragment.texcoord[3];
DP3 R1.x, fragment.texcoord[2], R1;
SLT R1.y, c[4].x, fragment.texcoord[4].z;
MUL R0.w, R1.y, R0;
MUL R1.y, R0.w, R1.w;
MAX R0.w, R1.x, c[4].x;
MUL R0.xyz, R0, c[0];
MUL R0.w, R0, R1.y;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[4].w;
END
# 28 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Float 1 [_Fading]
Float 2 [_Threshold]
Vector 3 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c4, 1.00000000, 0.50000000, 0.00000000, 2.00000000
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t3.xyz
dcl t4
texld r3, t0, s0
dp3 r2.x, t4, t4
mov r2.xy, r2.x
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.xy, r0
rcp r0.x, t4.w
mad r0.xy, t4, r0.x, c4.y
texld r4, r2, s3
texld r2, r1, s1
texld r0, r0, s2
dp3_pp_sat r1.x, r3, c3
mov r0.x, c2
add_pp r1.x, -r1, c4
mul r0.x, c1, r0
mul r0.x, r0, r1
add_pp r1.xyz, -r3, r2
mad_sat r0.x, t1.y, c1, -r0
mad_pp r0.xyz, r0.x, r1, r3
mul_pp r2.xyz, r0, c0
dp3_pp r0.x, t3, t3
rsq_pp r1.x, r0.x
cmp r0.x, -t4.z, c4.z, c4
mul_pp r0.x, r0, r0.w
mul_pp r1.xyz, r1.x, t3
dp3_pp r1.x, t2, r1
mul_pp r0.x, r0, r4
max_pp r1.x, r1, c4.z
mul_pp r0.x, r1, r0
mul_pp r0.xyz, r0.x, r2
mul_pp r0.xyz, r0, c4.w
mov_pp r0.w, c4.z
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_MossTex] 2D 3
SetTexture 2 [_LightTexture0] 2D 0
SetTexture 3 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Float 112 [_Fading]
Float 116 [_Threshold]
Vector 128 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedcgidpahjkekaocoljiniemgmgbmnfeegabaaaaaadmafaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmaeaaaa
eaaaaaaaahabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadpcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaa
dbaaaaahbcaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaafaaaaaaabaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaa
aaaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagbjbaaaaeaaaaaabaaaaaah
ccaabaaaaaaaaaaaegbcbaaaadaaaaaajgahbaaaaaaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagaabaaaaaaaaaaadiaaaaajccaabaaaaaaaaaaaakiacaaa
aaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaabacaaaaiecaabaaa
aaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaaiaaaaaaaaaaaaaiecaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadccaaaalccaabaaaaaaaaaaa
bkbabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaabkaabaiaebaaaaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaa
acaaaaaadcaaaaajocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaaacaaaaaa
agajbaaaabaaaaaadiaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaaagijcaaa
aaaaaaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_MossTex] 2D 3
SetTexture 2 [_LightTexture0] 2D 0
SetTexture 3 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Float 112 [_Fading]
Float 116 [_Threshold]
Vector 128 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedmmmmbjdneffjabpljafldhfnackeaogfabaaaaaameahaaaaaeaaaaaa
daaaaaaaleacaaaaniagaaaajaahaaaaebgpgodjhmacaaaahmacaaaaaaacpppp
daacaaaaemaaaaaaacaadeaaaaaaemaaaaaaemaaaeaaceaaaaaaemaaacaaaaaa
adababaaaaacacaaabadadaaaaaaabaaabaaaaaaaaaaaaaaaaaaahaaacaaabaa
aaaaaaaaaaacppppfbaaaaafadaaapkaaaaaiadpaaaaaadpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaia
acaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapka
bpaaaaacaaaaaajaadaiapkaagaaaaacaaaaaiiaaeaapplaaeaaaaaeaaaaadia
aeaaoelaaaaappiaadaaffkaaiaaaaadabaaaiiaaeaaoelaaeaaoelaabaaaaac
abaaadiaabaappiaabaaaaacacaaabiaaaaakklaabaaaaacacaaaciaaaaappla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaadabaacpiaabaaoeiaabaioeka
ecaaaaadadaacpiaaaaaoelaacaioekaecaaaaadacaacpiaacaaoeiaadaioeka
afaaaaadacaaciiaaaaappiaabaaaaiafiaaaaaeacaaciiaaeaakklbadaakkka
acaappiaceaaaaacaaaachiaadaaoelaaiaaaaadadaaciiaacaaoelaaaaaoeia
alaaaaadaaaacbiaadaappiaadaakkkaafaaaaadacaaciiaacaappiaaaaaaaia
acaaaaadacaaciiaacaappiaacaappiaafaaaaadadaaaiiaabaaaakaabaaffka
aiaaaaadaaaabbiaadaaoeiaacaaoekaacaaaaadaaaaabiaaaaaaaibadaaaaka
afaaaaadadaaaiiaaaaaaaiaadaappiaaeaaaaaeadaadiiaabaafflaabaaaaka
adaappibbcaaaaaeaaaachiaadaappiaacaaoeiaadaaoeiaafaaaaadaaaachia
aaaaoeiaaaaaoekaafaaaaadaaaachiaacaappiaaaaaoeiaabaaaaacaaaaaiia
adaakkkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcbmaeaaaaeaaaaaaa
ahabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
adaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaafaaaaaapgbpbaaaafaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadbaaaaah
bcaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaafaaaaaaabaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaa
eghobaaaadaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaaeaaaaaa
egbcbaaaaeaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
ocaabaaaaaaaaaaafgafbaaaaaaaaaaaagbjbaaaaeaaaaaabaaaaaahccaabaaa
aaaaaaaaegbcbaaaadaaaaaajgahbaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaafgafbaaa
aaaaaaaaagaabaaaaaaaaaaadiaaaaajccaabaaaaaaaaaaaakiacaaaaaaaaaaa
ahaaaaaabkiacaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaabacaaaaiecaabaaaaaaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaaiaaaaaaaaaaaaaiecaabaaaaaaaaaaa
ckaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaaaaaaaaadccaaaalccaabaaaaaaaaaaabkbabaaa
acaaaaaaakiacaaaaaaaaaaaahaaaaaabkaabaiaebaaaaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
aaaaaaaihcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaajocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaaacaaaaaaagajbaaa
abaaaaaadiaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaaagijcaaaaaaaaaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahacaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaa
keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Fading]
Float 2 [_Threshold]
Vector 3 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
SetTexture 3 [_LightTexture0] CUBE 3
"!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 0, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R1.w, fragment.texcoord[4], texture[3], CUBE;
DP3_SAT R2.y, R0, c[3];
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
MOV R2.x, c[1];
ADD R1.xyz, -R0, R1;
ADD R2.y, -R2, c[4];
MUL R2.x, R2, c[2];
MUL R2.x, R2, R2.y;
MAD_SAT R2.y, fragment.texcoord[1], c[1].x, -R2.x;
MAD R0.xyz, R2.y, R1, R0;
DP3 R2.z, fragment.texcoord[3], fragment.texcoord[3];
RSQ R2.x, R2.z;
MUL R1.xyz, R2.x, fragment.texcoord[3];
DP3 R1.x, fragment.texcoord[2], R1;
MUL R0.xyz, R0, c[0];
MOV result.color.w, c[4].x;
TEX R0.w, R0.w, texture[2], 2D;
MUL R1.y, R0.w, R1.w;
MAX R0.w, R1.x, c[4].x;
MUL R0.w, R0, R1.y;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[4].z;
END
# 24 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Fading]
Float 2 [_Threshold]
Vector 3 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
SetTexture 3 [_LightTexture0] CUBE 3
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c4, 1.00000000, 0.00000000, 2.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
texld r3, t0, s0
dp3 r0.x, t4, t4
mov r2.xy, r0.x
mov r1.y, t0.w
mov r1.x, t0.z
texld r4, r2, s2
texld r2, r1, s1
texld r0, t4, s3
dp3_pp_sat r1.x, r3, c3
mov r0.x, c2
add_pp r1.x, -r1, c4
mul r0.x, c1, r0
mul r0.x, r0, r1
add_pp r1.xyz, -r3, r2
mad_sat r0.x, t1.y, c1, -r0
mad_pp r1.xyz, r0.x, r1, r3
dp3_pp r0.x, t3, t3
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, t3
dp3_pp r0.x, t2, r0
mul r2.x, r4, r0.w
max_pp r0.x, r0, c4.y
mul_pp r1.xyz, r1, c0
mul_pp r0.x, r0, r2
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c4.z
mov_pp r0.w, c4.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_MossTex] 2D 3
SetTexture 2 [_LightTextureB0] 2D 1
SetTexture 3 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Float 112 [_Fading]
Float 116 [_Threshold]
Vector 128 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkajlcmjaeecnogligbbkjcimjpcbjdhnabaaaaaakeaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcieadaaaa
eaaaaaaaobaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafidaaaaeaahabaaa
adaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaajbcaabaaa
aaaaaaaaakiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
bacaaaaiccaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaaiaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaal
bcaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaaakaabaia
ebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaaaaaaaaaiocaabaaaaaaaaaaaagajbaiaebaaaaaa
abaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbcbaaaafaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaadkaabaaaacaaaaaaapaaaaahicaabaaaaaaaaaaa
pgapbaaaaaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_MossTex] 2D 3
SetTexture 2 [_LightTextureB0] 2D 1
SetTexture 3 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Float 112 [_Fading]
Float 116 [_Threshold]
Vector 128 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedelpojhbnadoepocimopnnhkcddigaeebabaaaaaapiagaaaaaeaaaaaa
daaaaaaaiaacaaaaamagaaaameagaaaaebgpgodjeiacaaaaeiacaaaaaaacpppp
pmabaaaaemaaaaaaacaadeaaaaaaemaaaaaaemaaaeaaceaaaaaaemaaadaaaaaa
acababaaaaacacaaabadadaaaaaaabaaabaaaaaaaaaaaaaaaaaaahaaacaaabaa
aaaaaaaaaaacppppfbaaaaafadaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaia
acaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaaahlabpaaaaac
aaaaaajiaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapka
bpaaaaacaaaaaajaadaiapkaabaaaaacaaaaabiaaaaakklaabaaaaacaaaaacia
aaaapplaaiaaaaadabaaaiiaaeaaoelaaeaaoelaabaaaaacabaaadiaabaappia
ecaaaaadacaacpiaaaaaoelaacaioekaecaaaaadaaaacpiaaaaaoeiaadaioeka
ecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadadaaapiaaeaaoelaaaaioeka
afaaaaadaaaaaiiaabaaaakaabaaffkaaiaaaaadacaabiiaacaaoeiaacaaoeka
acaaaaadacaaaiiaacaappibadaaaakaafaaaaadaaaaaiiaaaaappiaacaappia
aeaaaaaeaaaadiiaabaafflaabaaaakaaaaappibbcaaaaaeabaacoiaaaaappia
aaaabliaacaabliaafaaaaadaaaachiaabaabliaaaaaoekaafaaaaadaaaaciia
abaaaaiaadaappiaceaaaaacabaachiaadaaoelaaiaaaaadabaacbiaacaaoela
abaaoeiaalaaaaadacaacbiaabaaaaiaadaaffkaafaaaaadaaaaciiaaaaappia
acaaaaiaacaaaaadaaaaciiaaaaappiaaaaappiaafaaaaadaaaachiaaaaappia
aaaaoeiaabaaaaacaaaaciiaadaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcieadaaaaeaaaaaaaobaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fidaaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
ccbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
diaaaaajbcaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaa
ahaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaabacaaaaiccaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaaiaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadccaaaalbcaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaa
ahaaaaaaakaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaaaaaaaaiocaabaaaaaaaaaaa
agajbaiaebaaaaaaabaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaa
aeaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaefaaaaajpcaabaaa
abaaaaaaagaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbcbaaaafaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaacaaaaaaapaaaaah
icaabaaaaaaaaaaapgapbaaaaaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Fading]
Float 2 [_Threshold]
Vector 3 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 0, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R0.w, fragment.texcoord[4], texture[2], 2D;
DP3_SAT R2.x, R0, c[3];
MOV R1.w, c[1].x;
ADD R1.xyz, -R0, R1;
ADD R2.x, -R2, c[4].y;
MUL R1.w, R1, c[2].x;
MUL R1.w, R1, R2.x;
MAD_SAT R1.w, fragment.texcoord[1].y, c[1].x, -R1;
MAD R0.xyz, R1.w, R1, R0;
MOV R2.xyz, fragment.texcoord[3];
DP3 R1.x, fragment.texcoord[2], R2;
MAX R1.x, R1, c[4];
MUL R0.xyz, R0, c[0];
MUL R0.w, R1.x, R0;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[4].z;
MOV result.color.w, c[4].x;
END
# 19 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Fading]
Float 2 [_Threshold]
Vector 3 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 1.00000000, 0.00000000, 2.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t3.xyz
dcl t4.xy
texld r3, t0, s0
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.xy, r0
texld r2, r1, s1
texld r0, t4, s2
dp3_pp_sat r1.x, r3, c3
mov r0.x, c2
add_pp r1.x, -r1, c4
mul r0.x, c1, r0
mul r0.x, r0, r1
mad_sat r0.x, t1.y, c1, -r0
add_pp r1.xyz, -r3, r2
mad_pp r1.xyz, r0.x, r1, r3
mov_pp r0.xyz, t3
dp3_pp r0.x, t2, r0
max_pp r0.x, r0, c4.y
mul_pp r0.x, r0, r0.w
mul_pp r1.xyz, r1, c0
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c4.z
mov_pp r0.w, c4.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_MossTex] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Float 112 [_Fading]
Float 116 [_Threshold]
Vector 128 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0
eefieceddlcepjibbhoolcikmpacadmlnoghnbjbabaaaaaaoaadaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmaacaaaa
eaaaaaaalaaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadccbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
dcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaaj
bcaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaabacaaaaiccaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
aiaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dccaaaalbcaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaa
akaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaaiocaabaaaaaaaaaaaagajbaia
ebaaaaaaabaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaa
aaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaadaaaaaaegbcbaaaaeaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaafaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaa
aaaaaaaapgapbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_MossTex] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Float 112 [_Fading]
Float 116 [_Threshold]
Vector 128 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedehbmicflnjlknflaclgjiamoblfckjgdabaaaaaaomafaaaaaeaaaaaa
daaaaaaadiacaaaaaaafaaaaliafaaaaebgpgodjaaacaaaaaaacaaaaaaacpppp
liabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaacaaaaaa
aaababaaabacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaahaaacaaabaaaaaaaaaa
aaacppppfbaaaaafadaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaachla
bpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaaadlabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaabaaaaac
aaaaabiaaaaakklaabaaaaacaaaaaciaaaaapplaecaaaaadabaacpiaaaaaoela
abaioekaecaaaaadaaaacpiaaaaaoeiaacaioekaecaaaaadacaacpiaaeaaoela
aaaioekaafaaaaadaaaaaiiaabaaaakaabaaffkaaiaaaaadabaabiiaabaaoeia
acaaoekaacaaaaadabaaaiiaabaappibadaaaakaafaaaaadaaaaaiiaaaaappia
abaappiaaeaaaaaeaaaadiiaabaafflaabaaaakaaaaappibbcaaaaaeacaachia
aaaappiaaaaaoeiaabaaoeiaafaaaaadaaaachiaacaaoeiaaaaaoekaabaaaaac
abaaahiaacaaoelaaiaaaaadaaaaciiaabaaoeiaadaaoelaafaaaaadabaacbia
acaappiaaaaappiafiaaaaaeaaaaciiaaaaappiaabaaaaiaadaaffkaacaaaaad
aaaaciiaaaaappiaaaaappiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaac
aaaaciiaadaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcmaacaaaa
eaaaaaaalaaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadccbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
dcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaaj
bcaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaabacaaaaiccaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
aiaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dccaaaalbcaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaa
akaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaaiocaabaaaaaaaaaaaagajbaia
ebaaaaaaabaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaa
aaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaadaaaaaaegbcbaaaaeaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaafaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaa
aaaaaaaapgapbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
ejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahacaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadadaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
"!!ARBvp1.0
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
MUL R0.xyz, vertex.normal, c[9].w;
DP3 result.texcoord[0].z, R0, c[7];
DP3 result.texcoord[0].y, R0, c[6];
DP3 result.texcoord[0].x, R0, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
mul r0.xyz, v1, c8.w
dp3 oT0.z, r0, c6
dp3 oT0.y, r0, c5
dp3 oT0.x, r0, c4
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefieceddgoflhcgfinoonoplgmdiabihpafgdafabaaaaaaneacaaaaadaaaaaa
cmaaaaaapeaaaaaaemabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaae
egiocaaaaaaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
aaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaaaaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaaaaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "UnityPerDraw" 0
"vs_4_0_level_9_1
eefiecedfpmclfcoogjdlpcnlpgnljpcdonknacmabaaaaaaaaaeaaaaaeaaaaaa
daaaaaaafiabaaaaoaacaaaakiadaaaaebgpgodjcaabaaaacaabaaaaaaacpopp
neaaaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaamaaadaaafaaaaaaaaaaaaaabeaaabaaaiaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaahiaacaaoejaaiaappkaafaaaaadabaaahiaaaaaffiaagaaoeka
aeaaaaaeaaaaaliaafaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahoaahaaoeka
aaaakkiaaaaapeiaafaaaaadaaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapia
abaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaeaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaa
pgipcaaaaaaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaaaaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaabaaaaaa
egiccaaaaaaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!ARBfp1.0
PARAM c[1] = { { 0, 0.5 } };
MAD result.color.xyz, fragment.texcoord[0], c[0].y, c[0].y;
MOV result.color.w, c[0].x;
END
# 2 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
"ps_2_0
def c0, 0.50000000, 0.00000000, 0, 0
dcl t0.xyz
mad_pp r0.xyz, t0, c0.x, c0.x
mov_pp r0.w, c0.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
"ps_4_0
eefiecedhbdiiogganilkmhhpogjlnaalcliljppabaaaaaadeabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcheaaaaaa
eaaaaaaabnaaaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
dcaaaaaphccabaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
"ps_4_0_level_9_1
eefiecedbcfagkfmhchaonghfjackccpkbjompokabaaaaaalmabaaaaaeaaaaaa
daaaaaaaleaaaaaadaabaaaaiiabaaaaebgpgodjhmaaaaaahmaaaaaaaaacpppp
fiaaaaaaceaaaaaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaacpppp
fbaaaaafaaaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaachlaaeaaaaaeaaaachiaaaaaoelaaaaaaakaaaaaaakaabaaaaacaaaaciia
aaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcheaaaaaaeaaaaaaa
bnaaaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaadcaaaaap
hccabaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "RenderType"="Opaque" }
  ZWrite Off
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
Vector 19 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[20] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.w, c[0].y;
DP3 R1.z, vertex.normal, c[7];
DP3 R1.x, vertex.normal, c[5];
DP3 R1.y, vertex.normal, c[6];
MUL R0.xyz, R1, c[17].w;
MUL R1.w, R0.y, R0.y;
MUL R2, R0.xyzz, R0.yzzx;
DP4 R3.z, R0, c[12];
DP4 R3.y, R0, c[11];
DP4 R3.x, R0, c[10];
MAD R1.w, R0.x, R0.x, -R1;
DP4 R0.z, R2, c[15];
DP4 R0.x, R2, c[13];
DP4 R0.y, R2, c[14];
ADD R4.xyz, R3, R0;
MUL R3.xyz, R1.w, c[16];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R2.xyz, R0.xyww, c[0].x;
MUL R2.y, R2, c[9].x;
ADD result.texcoord[3].xyz, R4, R3;
ADD result.texcoord[2].xy, R2, R2.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MOV result.texcoord[1].xyz, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
END
# 29 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
Vector 19 [_MossTex_ST]
"vs_2_0
def c20, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mov r0.w, c20.y
dp3 r1.z, v1, c6
dp3 r1.x, v1, c4
dp3 r1.y, v1, c5
mul r0.xyz, r1, c17.w
mul r1.w, r0.y, r0.y
mul r2, r0.xyzz, r0.yzzx
dp4 r3.z, r0, c12
dp4 r3.y, r0, c11
dp4 r3.x, r0, c10
mad r1.w, r0.x, r0.x, -r1
dp4 r0.z, r2, c15
dp4 r0.x, r2, c13
dp4 r0.y, r2, c14
add r4.xyz, r3, r0
mul r3.xyz, r1.w, c16
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c20.x
mul r2.y, r2, c8.x
add oT3.xyz, r4, r3
mad oT2.xy, r2.z, c9.zwzw, r2
mov oPos, r0
mov oT2.zw, r0
mov oT1.xyz, r1
mad oT0.zw, v2.xyxy, c19.xyxy, c19
mad oT0.xy, v2, c18, c18.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 80 [_MainTex_ST]
Vector 96 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
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
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecednbgomhdllodnhfgmfompdkeeiacicliaabaaaaaaomafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcfaaeaaaaeaaaabaa
beabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
aaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
acaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
kgakbaaaacaaaaaamgaabaaaacaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaaaaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaa
abaaaaaabbaaaaaiccaabaaaaaaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaa
abaaaaaabbaaaaaiecaabaaaaaaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaa
bbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaadiaaaaah
icaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaa
dcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 80 [_MainTex_ST]
Vector 96 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
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
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedfmjhipojnjmciodahlfkeemeblflcmckabaaaaaakeaiaaaaaeaaaaaa
daaaaaaaoeacaaaadmahaaaaaeaiaaaaebgpgodjkmacaaaakmacaaaaaaacpopp
dmacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaafaa
acaaabaaaaaaaaaaabaaafaaabaaadaaaaaaaaaaacaacgaaahaaaeaaaaaaaaaa
adaaaaaaaeaaalaaaaaaaaaaadaaamaaadaaapaaaaaaaaaaadaabeaaabaabcaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbdaaapkaaaaaaadpaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaae
aaaaamoaadaaeejaacaaeekaacaaoekaafaaaaadaaaaapiaaaaaffjaamaaoeka
aeaaaaaeaaaaapiaalaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaanaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaoaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaadaaaakaafaaaaadabaaaiiaabaaaaiabdaaaakaafaaaaad
abaaafiaaaaapeiabdaaaakaacaaaaadacaaadoaabaakkiaabaaomiaafaaaaad
abaaahiaacaaffjabaaaoekaaeaaaaaeabaaahiaapaaoekaacaaaajaabaaoeia
aeaaaaaeabaaahiabbaaoekaacaakkjaabaaoeiaafaaaaadacaaahiaabaaoeia
bcaappkaabaaaaacabaaahoaabaaoeiaabaaaaacacaaaiiabdaaffkaajaaaaad
abaaabiaaeaaoekaacaaoeiaajaaaaadabaaaciaafaaoekaacaaoeiaajaaaaad
abaaaeiaagaaoekaacaaoeiaafaaaaadadaaapiaacaacjiaacaakeiaajaaaaad
aeaaabiaahaaoekaadaaoeiaajaaaaadaeaaaciaaiaaoekaadaaoeiaajaaaaad
aeaaaeiaajaaoekaadaaoeiaacaaaaadabaaahiaabaaoeiaaeaaoeiaafaaaaad
abaaaiiaacaaffiaacaaffiaaeaaaaaeabaaaiiaacaaaaiaacaaaaiaabaappib
aeaaaaaeadaaahoaakaaoekaabaappiaabaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaamoaaaaaoeia
ppppaaaafdeieefcfaaeaaaaeaaaabaabeabaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacaeaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaa
agaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
acaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaacaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaacaaaaaamgaabaaaacaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaaaaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaaaaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaaaaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaa
acaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_ProjectionParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
Vector 17 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[18] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..17] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[2].zw, R0;
MUL result.texcoord[4].xyz, R1, c[14].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[4].w, -R0.x, R0.y;
DP3 result.texcoord[1].z, vertex.normal, c[11];
DP3 result.texcoord[1].y, vertex.normal, c[10];
DP3 result.texcoord[1].x, vertex.normal, c[9];
END
# 24 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
Vector 17 [_MossTex_ST]
"vs_2_0
def c18, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c18.x
mul r1.y, r1, c12.x
mad oT2.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov r0.x, c14.w
add r0.y, c18, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov oT2.zw, r0
mul oT4.xyz, r1, c14.w
mad oT0.zw, v2.xyxy, c17.xyxy, c17
mad oT0.xy, v2, c16, c16.zwzw
mad oT3.xy, v3, c15, c15.zwzw
mul oT4.w, -r0.x, r0.y
dp3 oT1.z, v1, c10
dp3 oT1.y, v1, c9
dp3 oT1.x, v1, c8
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 400 [unity_ShadowFadeCenterAndType]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedidapigkmbihoollpickibnbomkppglpeabaaaaaafeagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefckaaeaaaaeaaaabaaciabaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaaddccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaa
ahaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
acaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaaeaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaaafaaaaaa
egacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaa
acaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaafaaaaaabkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 400 [unity_ShadowFadeCenterAndType]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedmbjoalojemaeieiiofciohjahglfmcgmabaaaaaaceajaaaaaeaaaaaa
daaaaaaapmacaaaakeahaaaagmaiaaaaebgpgodjmeacaaaameacaaaaaaacpopp
gaacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaafaa
adaaabaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaaacaabjaaabaaafaaaaaaaaaa
adaaaaaaaiaaagaaaaaaaaaaadaaamaaaeaaaoaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbcaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaaeiaaeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaae
aaaaamoaadaaeejaadaaeekaadaaoekaafaaaaadaaaaahiaacaaffjaapaaoeka
aeaaaaaeaaaaahiaaoaaoekaacaaaajaaaaaoeiaaeaaaaaeabaaahoabaaaoeka
acaakkjaaaaaoeiaafaaaaadaaaaapiaaaaaffjaahaaoekaaeaaaaaeaaaaapia
agaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffia
aeaaaakaafaaaaadabaaaiiaabaaaaiabcaaaakaafaaaaadabaaafiaaaaapeia
bcaaaakaacaaaaadacaaadoaabaakkiaabaaomiaaeaaaaaeadaaadoaaeaaoeja
abaaoekaabaaookaafaaaaadabaaahiaaaaaffjaapaaoekaaeaaaaaeabaaahia
aoaaoekaaaaaaajaabaaoeiaaeaaaaaeabaaahiabaaaoekaaaaakkjaabaaoeia
aeaaaaaeabaaahiabbaaoekaaaaappjaabaaoeiaacaaaaadabaaahiaabaaoeia
afaaoekbafaaaaadaeaaahoaabaaoeiaafaappkaafaaaaadabaaabiaaaaaffja
alaakkkaaeaaaaaeabaaabiaakaakkkaaaaaaajaabaaaaiaaeaaaaaeabaaabia
amaakkkaaaaakkjaabaaaaiaaeaaaaaeabaaabiaanaakkkaaaaappjaabaaaaia
abaaaaacabaaaiiaafaappkaacaaaaadabaaaciaabaappibbcaaffkaafaaaaad
aeaaaioaabaaffiaabaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacacaaamoaaaaaoeiappppaaaafdeieefc
kaaeaaaaeaaaabaaciabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaae
egiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaa
aaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaal
dccabaaaaeaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
aaaaaaaaafaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
bjaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaa
bjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaj
ccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadp
diaaaaaiiccabaaaafaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_LightmapST]
Vector 11 [_MainTex_ST]
Vector 12 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[13] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..12] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[12].xyxy, c[12];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[10], c[10].zwzw;
DP3 result.texcoord[1].z, vertex.normal, c[7];
DP3 result.texcoord[1].y, vertex.normal, c[6];
DP3 result.texcoord[1].x, vertex.normal, c[5];
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_LightmapST]
Vector 11 [_MainTex_ST]
Vector 12 [_MossTex_ST]
"vs_2_0
def c13, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c13.x
mul r1.y, r1, c8.x
mad oT2.xy, r1.z, c9.zwzw, r1
mov oPos, r0
mov oT2.zw, r0
mad oT0.zw, v2.xyxy, c12.xyxy, c12
mad oT0.xy, v2, c11, c11.zwzw
mad oT3.xy, v3, c10, c10.zwzw
dp3 oT1.z, v1, c6
dp3 oT1.y, v1, c5
dp3 oT1.x, v1, c4
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedkohljckdfaofbhbcbofgkmkpjpfkonlpabaaaaaagiaeaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcmmacaaaaeaaaabaa
ldaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaa
aeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaaddccabaaa
aeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaa
agaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
ahaaaaaakgiocaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
acaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaa
aeaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedahiancgeaeeaalhfphlbahbpmeaefnhjabaaaaaaeiagaaaaaeaaaaaa
daaaaaaaamacaaaaoaaeaaaakiafaaaaebgpgodjneabaaaaneabaaaaaaacpopp
hmabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaafaa
adaaabaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaaacaaaaaaaeaaafaaaaaaaaaa
acaaamaaadaaajaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafamaaapkaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaae
aaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeejaadaaeeka
adaaoekaafaaaaadaaaaahiaacaaffjaakaaoekaaeaaaaaeaaaaahiaajaaoeka
acaaaajaaaaaoeiaaeaaaaaeabaaahoaalaaoekaacaakkjaaaaaoeiaafaaaaad
aaaaapiaaaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaiaaoeka
aaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaaeaaaakaafaaaaadabaaaiia
abaaaaiaamaaaakaafaaaaadabaaafiaaaaapeiaamaaaakaacaaaaadacaaadoa
abaakkiaabaaomiaaeaaaaaeadaaadoaaeaaoejaabaaoekaabaaookaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaamoaaaaaoeiappppaaaafdeieefcmmacaaaaeaaaabaaldaaaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaa
aaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaaeaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
Vector 19 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[20] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.w, c[0].y;
DP3 R1.z, vertex.normal, c[7];
DP3 R1.x, vertex.normal, c[5];
DP3 R1.y, vertex.normal, c[6];
MUL R0.xyz, R1, c[17].w;
MUL R1.w, R0.y, R0.y;
MUL R2, R0.xyzz, R0.yzzx;
DP4 R3.z, R0, c[12];
DP4 R3.y, R0, c[11];
DP4 R3.x, R0, c[10];
MAD R1.w, R0.x, R0.x, -R1;
DP4 R0.z, R2, c[15];
DP4 R0.x, R2, c[13];
DP4 R0.y, R2, c[14];
ADD R4.xyz, R3, R0;
MUL R3.xyz, R1.w, c[16];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R2.xyz, R0.xyww, c[0].x;
MUL R2.y, R2, c[9].x;
ADD result.texcoord[3].xyz, R4, R3;
ADD result.texcoord[2].xy, R2, R2.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MOV result.texcoord[1].xyz, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
END
# 29 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
Vector 19 [_MossTex_ST]
"vs_2_0
def c20, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mov r0.w, c20.y
dp3 r1.z, v1, c6
dp3 r1.x, v1, c4
dp3 r1.y, v1, c5
mul r0.xyz, r1, c17.w
mul r1.w, r0.y, r0.y
mul r2, r0.xyzz, r0.yzzx
dp4 r3.z, r0, c12
dp4 r3.y, r0, c11
dp4 r3.x, r0, c10
mad r1.w, r0.x, r0.x, -r1
dp4 r0.z, r2, c15
dp4 r0.x, r2, c13
dp4 r0.y, r2, c14
add r4.xyz, r3, r0
mul r3.xyz, r1.w, c16
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c20.x
mul r2.y, r2, c8.x
add oT3.xyz, r4, r3
mad oT2.xy, r2.z, c9.zwzw, r2
mov oPos, r0
mov oT2.zw, r0
mov oT1.xyz, r1
mad oT0.zw, v2.xyxy, c19.xyxy, c19
mad oT0.xy, v2, c18, c18.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 80 [_MainTex_ST]
Vector 96 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
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
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecednbgomhdllodnhfgmfompdkeeiacicliaabaaaaaaomafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcfaaeaaaaeaaaabaa
beabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
aaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
abaaaaaadgaaaaafhccabaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
acaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
kgakbaaaacaaaaaamgaabaaaacaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaaaaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaa
abaaaaaabbaaaaaiccaabaaaaaaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaa
abaaaaaabbaaaaaiecaabaaaaaaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaa
abaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaa
bbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaadiaaaaah
icaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaa
dcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 80 [_MainTex_ST]
Vector 96 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
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
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedfmjhipojnjmciodahlfkeemeblflcmckabaaaaaakeaiaaaaaeaaaaaa
daaaaaaaoeacaaaadmahaaaaaeaiaaaaebgpgodjkmacaaaakmacaaaaaaacpopp
dmacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaafaa
acaaabaaaaaaaaaaabaaafaaabaaadaaaaaaaaaaacaacgaaahaaaeaaaaaaaaaa
adaaaaaaaeaaalaaaaaaaaaaadaaamaaadaaapaaaaaaaaaaadaabeaaabaabcaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbdaaapkaaaaaaadpaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaae
aaaaamoaadaaeejaacaaeekaacaaoekaafaaaaadaaaaapiaaaaaffjaamaaoeka
aeaaaaaeaaaaapiaalaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaanaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaoaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaadaaaakaafaaaaadabaaaiiaabaaaaiabdaaaakaafaaaaad
abaaafiaaaaapeiabdaaaakaacaaaaadacaaadoaabaakkiaabaaomiaafaaaaad
abaaahiaacaaffjabaaaoekaaeaaaaaeabaaahiaapaaoekaacaaaajaabaaoeia
aeaaaaaeabaaahiabbaaoekaacaakkjaabaaoeiaafaaaaadacaaahiaabaaoeia
bcaappkaabaaaaacabaaahoaabaaoeiaabaaaaacacaaaiiabdaaffkaajaaaaad
abaaabiaaeaaoekaacaaoeiaajaaaaadabaaaciaafaaoekaacaaoeiaajaaaaad
abaaaeiaagaaoekaacaaoeiaafaaaaadadaaapiaacaacjiaacaakeiaajaaaaad
aeaaabiaahaaoekaadaaoeiaajaaaaadaeaaaciaaiaaoekaadaaoeiaajaaaaad
aeaaaeiaajaaoekaadaaoeiaacaaaaadabaaahiaabaaoeiaaeaaoeiaafaaaaad
abaaaiiaacaaffiaacaaffiaaeaaaaaeabaaaiiaacaaaaiaacaaaaiaabaappib
aeaaaaaeadaaahoaakaaoekaabaappiaabaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaamoaaaaaoeia
ppppaaaafdeieefcfaaeaaaaeaaaabaabeabaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacaeaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaa
agaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
acaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaacaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaacaaaaaamgaabaaaacaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaaaaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaaaaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaaaaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaa
acaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_ProjectionParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
Vector 17 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[18] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..17] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[2].zw, R0;
MUL result.texcoord[4].xyz, R1, c[14].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[4].w, -R0.x, R0.y;
DP3 result.texcoord[1].z, vertex.normal, c[11];
DP3 result.texcoord[1].y, vertex.normal, c[10];
DP3 result.texcoord[1].x, vertex.normal, c[9];
END
# 24 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
Vector 17 [_MossTex_ST]
"vs_2_0
def c18, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c18.x
mul r1.y, r1, c12.x
mad oT2.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov r0.x, c14.w
add r0.y, c18, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov oT2.zw, r0
mul oT4.xyz, r1, c14.w
mad oT0.zw, v2.xyxy, c17.xyxy, c17
mad oT0.xy, v2, c16, c16.zwzw
mad oT3.xy, v3, c15, c15.zwzw
mul oT4.w, -r0.x, r0.y
dp3 oT1.z, v1, c10
dp3 oT1.y, v1, c9
dp3 oT1.x, v1, c8
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 400 [unity_ShadowFadeCenterAndType]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedidapigkmbihoollpickibnbomkppglpeabaaaaaafeagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefckaaeaaaaeaaaabaaciabaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
gfaaaaaddccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaa
ahaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
acaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaaeaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaaafaaaaaa
egacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaa
acaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaafaaaaaabkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 400 [unity_ShadowFadeCenterAndType]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedmbjoalojemaeieiiofciohjahglfmcgmabaaaaaaceajaaaaaeaaaaaa
daaaaaaapmacaaaakeahaaaagmaiaaaaebgpgodjmeacaaaameacaaaaaaacpopp
gaacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaafaa
adaaabaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaaacaabjaaabaaafaaaaaaaaaa
adaaaaaaaiaaagaaaaaaaaaaadaaamaaaeaaaoaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbcaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaaeiaaeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaae
aaaaamoaadaaeejaadaaeekaadaaoekaafaaaaadaaaaahiaacaaffjaapaaoeka
aeaaaaaeaaaaahiaaoaaoekaacaaaajaaaaaoeiaaeaaaaaeabaaahoabaaaoeka
acaakkjaaaaaoeiaafaaaaadaaaaapiaaaaaffjaahaaoekaaeaaaaaeaaaaapia
agaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffia
aeaaaakaafaaaaadabaaaiiaabaaaaiabcaaaakaafaaaaadabaaafiaaaaapeia
bcaaaakaacaaaaadacaaadoaabaakkiaabaaomiaaeaaaaaeadaaadoaaeaaoeja
abaaoekaabaaookaafaaaaadabaaahiaaaaaffjaapaaoekaaeaaaaaeabaaahia
aoaaoekaaaaaaajaabaaoeiaaeaaaaaeabaaahiabaaaoekaaaaakkjaabaaoeia
aeaaaaaeabaaahiabbaaoekaaaaappjaabaaoeiaacaaaaadabaaahiaabaaoeia
afaaoekbafaaaaadaeaaahoaabaaoeiaafaappkaafaaaaadabaaabiaaaaaffja
alaakkkaaeaaaaaeabaaabiaakaakkkaaaaaaajaabaaaaiaaeaaaaaeabaaabia
amaakkkaaaaakkjaabaaaaiaaeaaaaaeabaaabiaanaakkkaaaaappjaabaaaaia
abaaaaacabaaaiiaafaappkaacaaaaadabaaaciaabaappibbcaaffkaafaaaaad
aeaaaioaabaaffiaabaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacacaaamoaaaaaoeiappppaaaafdeieefc
kaaeaaaaeaaaabaaciabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaae
egiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaad
pccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaa
aaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaal
dccabaaaaeaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
aaaaaaaaafaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaa
bjaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaa
bjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaa
afaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
agaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaaj
ccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadp
diaaaaaiiccabaaaafaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_LightmapST]
Vector 11 [_MainTex_ST]
Vector 12 [_MossTex_ST]
"!!ARBvp1.0
PARAM c[13] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..12] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[12].xyxy, c[12];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[10], c[10].zwzw;
DP3 result.texcoord[1].z, vertex.normal, c[7];
DP3 result.texcoord[1].y, vertex.normal, c[6];
DP3 result.texcoord[1].x, vertex.normal, c[5];
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_LightmapST]
Vector 11 [_MainTex_ST]
Vector 12 [_MossTex_ST]
"vs_2_0
def c13, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c13.x
mul r1.y, r1, c8.x
mad oT2.xy, r1.z, c9.zwzw, r1
mov oPos, r0
mov oT2.zw, r0
mad oT0.zw, v2.xyxy, c12.xyxy, c12
mad oT0.xy, v2, c11, c11.zwzw
mad oT3.xy, v3, c10, c10.zwzw
dp3 oT1.z, v1, c6
dp3 oT1.y, v1, c5
dp3 oT1.x, v1, c4
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedkohljckdfaofbhbcbofgkmkpjpfkonlpabaaaaaagiaeaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcmmacaaaaeaaaabaa
ldaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaa
aeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaaddccabaaa
aeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaa
agaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
ahaaaaaakgiocaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaa
acaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaamaaaaaaagbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaa
aeaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_MossTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedahiancgeaeeaalhfphlbahbpmeaefnhjabaaaaaaeiagaaaaaeaaaaaa
daaaaaaaamacaaaaoaaeaaaakiafaaaaebgpgodjneabaaaaneabaaaaaaacpopp
hmabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaafaa
adaaabaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaaacaaaaaaaeaaafaaaaaaaaaa
acaaamaaadaaajaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafamaaapkaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaae
aaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeejaadaaeeka
adaaoekaafaaaaadaaaaahiaacaaffjaakaaoekaaeaaaaaeaaaaahiaajaaoeka
acaaaajaaaaaoeiaaeaaaaaeabaaahoaalaaoekaacaakkjaaaaaoeiaafaaaaad
aaaaapiaaaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaiaaoeka
aaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaaeaaaakaafaaaaadabaaaiia
abaaaaiaamaaaakaafaaaaadabaaafiaaaaapeiaamaaaakaacaaaaadacaaadoa
abaakkiaabaaomiaaeaaaaaeadaaadoaaeaaoejaabaaoekaabaaookaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaamoaaaaaoeiappppaaaafdeieefcmmacaaaaeaaaabaaldaaaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaapaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaa
aaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaafgbfbaaaacaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaacaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaaeaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
"!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[0].zwzw, texture[1], 2D;
TXP R2.xyz, fragment.texcoord[2], texture[2], 2D;
DP3_SAT R3.x, R0, c[2];
MOV R2.w, c[0].x;
ADD R1, -R0, R1;
ADD R3.x, -R3, c[3];
MUL R2.w, R2, c[1].x;
MUL R2.w, R2, R3.x;
MAD_SAT R2.w, fragment.texcoord[1].y, c[0].x, -R2;
MAD R0, R2.w, R1, R0;
LG2 R1.x, R2.x;
LG2 R1.z, R2.z;
LG2 R1.y, R2.y;
ADD R1.xyz, -R1, fragment.texcoord[3];
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 1.00000000, 0, 0, 0
dcl t0
dcl t1.xy
dcl t2
dcl t3.xyz
texldp r4, t2, s2
texld r2, t0, s0
dp3_pp_sat r1.x, r2, c2
add_pp r1.x, -r1, c3
mov r0.y, t0.w
mov r0.x, t0.z
log_pp r1.z, r4.z
log_pp r1.y, r4.y
texld r0, r0, s1
add_pp r3, -r2, r0
mov r0.x, c1
mul r0.x, c0, r0
mul r0.x, r0, r1
log_pp r1.x, r4.x
mad_sat r0.x, t1.y, c0, -r0
mad_pp r0, r0.x, r3, r2
add_pp r1.xyz, -r1, t3
mul_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 128
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjhcbogkodjopffodkjgbkkdpacboniiaabaaaaaajiadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcjaacaaaaeaaaaaaakeaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadccbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaajbcaabaaa
aaaaaaaaakiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
bacaaaaiccaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaaeaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaal
bcaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaadaaaaaaakaabaia
ebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaa
abaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaa
aeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 128
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedlbejkooeljapnjaapeenmopfgodghdfjabaaaaaahaafaaaaaeaaaaaa
daaaaaaaaeacaaaajmaeaaaadmafaaaaebgpgodjmmabaaaammabaaaaaaacpppp
jaabaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaaaaaaaaa
abababaaacacacaaaaaaadaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapka
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaiaadaaahla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkaagaaaaacaaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoela
abaaaaacabaaabiaaaaakklaabaaaaacabaaaciaaaaapplaecaaaaadaaaacpia
aaaaoeiaacaioekaecaaaaadacaacpiaaaaaoelaaaaioekaecaaaaadabaacpia
abaaoeiaabaioekaapaaaaacadaacbiaaaaaaaiaapaaaaacadaacciaaaaaffia
apaaaaacadaaceiaaaaakkiaacaaaaadaaaachiaadaaoeibadaaoelaafaaaaad
aaaaaiiaaaaaaakaaaaaffkaaiaaaaadadaabbiaacaaoeiaabaaoekaacaaaaad
adaaabiaadaaaaibacaaaakaafaaaaadaaaaaiiaaaaappiaadaaaaiaaeaaaaae
aaaadiiaabaafflaaaaaaakaaaaappibbcaaaaaeadaacpiaaaaappiaabaaoeia
acaaoeiaafaaaaadadaachiaaaaaoeiaadaaoeiaabaaaaacaaaicpiaadaaoeia
ppppaaaafdeieefcjaacaaaaeaaaaaaakeaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadccbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaaj
bcaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaabacaaaaiccaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
aeaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dccaaaalbcaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaadaaaaaa
akaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaia
ebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafhcaabaaaabaaaaaa
egacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egbcbaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahacaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapalaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R2, fragment.texcoord[3], texture[3], 2D;
TEX R3, fragment.texcoord[3], texture[4], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[0].zwzw, texture[1], 2D;
TXP R4.xyz, fragment.texcoord[2], texture[2], 2D;
MUL R2.xyz, R2.w, R2;
DP4 R2.w, fragment.texcoord[4], fragment.texcoord[4];
MUL R3.xyz, R3.w, R3;
MUL R3.xyz, R3, c[4].y;
RSQ R2.w, R2.w;
RCP R2.w, R2.w;
MAD R2.xyz, R2, c[4].y, -R3;
MAD_SAT R2.w, R2, c[3].z, c[3];
MAD R2.xyz, R2.w, R2, R3;
MOV R2.w, c[0].x;
LG2 R3.x, R4.x;
LG2 R3.y, R4.y;
LG2 R3.z, R4.z;
ADD R2.xyz, -R3, R2;
DP3_SAT R3.x, R0, c[2];
ADD R3.x, -R3, c[4];
MUL R2.w, R2, c[1].x;
MUL R2.w, R2, R3.x;
ADD R1, -R0, R1;
MAD_SAT R2.w, fragment.texcoord[1].y, c[0].x, -R2;
MAD R0, R2.w, R1, R0;
MUL result.color.xyz, R0, R2;
MOV result.color.w, R0;
END
# 28 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c4, 1.00000000, 8.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2
dcl t3.xy
dcl t4
texld r2, t0, s0
texldp r3, t2, s2
texld r4, t3, s3
mov r0.y, t0.w
mov r0.x, t0.z
log_pp r3.x, r3.x
mul_pp r4.xyz, r4.w, r4
log_pp r3.y, r3.y
log_pp r3.z, r3.z
texld r1, r0, s1
texld r0, t3, s4
mul_pp r5.xyz, r0.w, r0
mul_pp r5.xyz, r5, c4.y
dp4 r0.x, t4, t4
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r4.xyz, r4, c4.y, -r5
mad_sat r0.x, r0, c3.z, c3.w
mad_pp r0.xyz, r0.x, r4, r5
add_pp r4.xyz, -r3, r0
dp3_pp_sat r3.x, r2, c2
mov r0.x, c1
add_pp r3.x, -r3, c4
mul r0.x, c0, r0
mul r0.x, r0, r3
add_pp r1, -r2, r1
mad_sat r0.x, t1.y, c0, -r0
mad_pp r0, r0.x, r1, r2
mul_pp r0.xyz, r0, r4
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 160
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
Vector 128 [unity_LightmapFade]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmkapohfjhlakkonkgnniaapmkobpdnbkabaaaaaadiafaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbiaeaaaa
eaaaaaaaagabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaagcbaaaad
lcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabbaaaaahbcaabaaaaaaaaaaa
egbobaaaafaaaaaaegbobaaaafaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadccaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaa
aiaaaaaadkiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
aeaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaa
abaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaajgahbaiaebaaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafhcaabaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaadiaaaaajicaabaaaaaaaaaaaakiacaaaaaaaaaaa
adaaaaaabkiacaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabacaaaaibcaabaaaacaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaaeaaaaaaaaaaaaaibcaabaaaacaaaaaa
akaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaacaaaaaadccaaaalicaabaaaaaaaaaaabkbabaaa
acaaaaaaakiacaaaaaaaaaaaadaaaaaadkaabaiaebaaaaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 160
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
Vector 128 [unity_LightmapFade]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecediembfckjlbidajhggifnhfjbhhfpkejhabaaaaaapmahaaaaaeaaaaaa
daaaaaaapaacaaaabaahaaaamiahaaaaebgpgodjliacaaaaliacaaaaaaacpppp
giacaaaafaaaaaaaacaadiaaaaaafaaaaaaafaaaafaaceaaaaaafaaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaaaaaadaaacaaaaaaaaaaaaaaaaaaaiaa
abaaacaaaaaaaaaaaaacppppfbaaaaafadaaapkaaaaaiadpaaaaaaebaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaahlabpaaaaac
aaaaaaiaacaaaplabpaaaaacaaaaaaiaadaaadlabpaaaaacaaaaaaiaaeaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaabaaaaacabaaabia
aaaakklaabaaaaacabaaaciaaaaapplaecaaaaadacaacpiaadaaoelaaeaioeka
ecaaaaadadaacpiaadaaoelaadaioekaecaaaaadaaaacpiaaaaaoeiaacaioeka
ecaaaaadaeaacpiaaaaaoelaaaaioekaecaaaaadabaacpiaabaaoeiaabaioeka
ajaaaaadaaaaaiiaaeaaoelaaeaaoelaahaaaaacaaaaaiiaaaaappiaagaaaaac
aaaaaiiaaaaappiaaeaaaaaeaaaadiiaaaaappiaacaakkkaacaappkaafaaaaad
acaaciiaacaappiaadaaffkaafaaaaadacaachiaacaaoeiaacaappiaafaaaaad
acaaciiaadaappiaadaaffkaaeaaaaaeadaachiaacaappiaadaaoeiaacaaoeib
aeaaaaaeacaachiaaaaappiaadaaoeiaacaaoeiaapaaaaacadaacbiaaaaaaaia
apaaaaacadaacciaaaaaffiaapaaaaacadaaceiaaaaakkiaacaaaaadaaaachia
acaaoeiaadaaoeibafaaaaadaaaaaiiaaaaaaakaaaaaffkaaiaaaaadacaabbia
aeaaoeiaabaaoekaacaaaaadacaaabiaacaaaaibadaaaakaafaaaaadaaaaaiia
aaaappiaacaaaaiaaeaaaaaeaaaadiiaabaafflaaaaaaakaaaaappibbcaaaaae
acaacpiaaaaappiaabaaoeiaaeaaoeiaafaaaaadacaachiaaaaaoeiaacaaoeia
abaaaaacaaaicpiaacaaoeiappppaaaafdeieefcbiaeaaaaeaaaaaaaagabaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaabbaaaaahbcaabaaaaaaaaaaaegbobaaaafaaaaaa
egbobaaaafaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaal
bcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaaiaaaaaadkiacaaa
aaaaaaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdcaaaaakhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
jgahbaiaebaaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaadiaaaaajicaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaabkiacaaa
aaaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaabacaaaaibcaabaaaacaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaaeaaaaaaaaaaaaaibcaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaacaaaaaadccaaaalicaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaa
aaaaaaaaadaaaaaadkaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaa
acaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaapgapbaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahacaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaa
keaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TXP R3.xyz, fragment.texcoord[2], texture[2], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[3], texture[3], 2D;
TEX R1, fragment.texcoord[0].zwzw, texture[1], 2D;
DP3_SAT R4.x, R0, c[2];
MOV R3.w, c[0].x;
MUL R2.xyz, R2.w, R2;
ADD R1, -R0, R1;
ADD R4.x, -R4, c[3];
MUL R3.w, R3, c[1].x;
MUL R3.w, R3, R4.x;
MAD_SAT R2.w, fragment.texcoord[1].y, c[0].x, -R3;
MAD R0, R2.w, R1, R0;
LG2 R3.x, R3.x;
LG2 R3.z, R3.z;
LG2 R3.y, R3.y;
MAD R2.xyz, R2, c[3].y, -R3;
MUL result.color.xyz, R0, R2;
MOV result.color.w, R0;
END
# 19 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 1.00000000, 8.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2
dcl t3.xy
texldp r5, t2, s2
texld r2, t3, s3
texld r3, t0, s0
dp3_pp_sat r1.x, r3, c2
add_pp r1.x, -r1, c3
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s1
add_pp r4, -r3, r0
mov r0.x, c1
mul r0.x, c0, r0
mul r0.x, r0, r1
mul_pp r1.xyz, r2.w, r2
mad_sat r0.x, t1.y, c0, -r0
mad_pp r0, r0.x, r4, r3
log_pp r2.x, r5.x
log_pp r2.z, r5.z
log_pp r2.y, r5.y
mad_pp r1.xyz, r1, c3.y, -r2
mul_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
ConstBuffer "$Globals" 160
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedoflbflgjeakbjkkgjjlbflcbmfgadifiabaaaaaapmadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpeacaaaaeaaaaaaalnaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
ccbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdcaaaaakhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaajicaabaaaaaaaaaaaakiacaaa
aaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabacaaaaibcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaaeaaaaaaaaaaaaaibcaabaaa
acaaaaaaakaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadccaaaalicaabaaaaaaaaaaa
bkbabaaaacaaaaaaakiacaaaaaaaaaaaadaaaaaadkaabaiaebaaaaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaa
acaaaaaadcaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
ConstBuffer "$Globals" 160
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedihhhbbociabpikgkbagfcgahjbndhmalabaaaaaaaiagaaaaaeaaaaaa
daaaaaaadiacaaaadeafaaaaneafaaaaebgpgodjaaacaaaaaaacaaaaaaacpppp
maabaaaaeaaaaaaaabaadeaaaaaaeaaaaaaaeaaaaeaaceaaaaaaeaaaaaaaaaaa
abababaaacacacaaadadadaaaaaaadaaacaaaaaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaiadpaaaaaaebaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaia
adaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaagaaaaacaaaaaiiaacaappla
afaaaaadaaaaadiaaaaappiaacaaoelaabaaaaacabaaabiaaaaakklaabaaaaac
abaaaciaaaaapplaecaaaaadaaaacpiaaaaaoeiaacaioekaecaaaaadacaacpia
adaaoelaadaioekaecaaaaadadaacpiaaaaaoelaaaaioekaecaaaaadabaacpia
abaaoeiaabaioekaapaaaaacaeaacbiaaaaaaaiaapaaaaacaeaacciaaaaaffia
apaaaaacaeaaceiaaaaakkiaafaaaaadacaaciiaacaappiaacaaffkaaeaaaaae
aaaachiaacaappiaacaaoeiaaeaaoeibafaaaaadaaaaaiiaaaaaaakaaaaaffka
aiaaaaadacaabbiaadaaoeiaabaaoekaacaaaaadacaaabiaacaaaaibacaaaaka
afaaaaadaaaaaiiaaaaappiaacaaaaiaaeaaaaaeaaaadiiaabaafflaaaaaaaka
aaaappibbcaaaaaeacaacpiaaaaappiaabaaoeiaadaaoeiaafaaaaadacaachia
aaaaoeiaacaaoeiaabaaaaacaaaicpiaacaaoeiappppaaaafdeieefcpeacaaaa
eaaaaaaalnaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaacpaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaeb
dcaaaaakhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaegacbaia
ebaaaaaaaaaaaaaadiaaaaajicaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaa
bkiacaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaabacaaaaibcaabaaaacaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaaeaaaaaaaaaaaaaibcaabaaaacaaaaaaakaabaia
ebaaaaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaacaaaaaadccaaaalicaabaaaaaaaaaaabkbabaaaacaaaaaa
akiacaaaaaaaaaaaadaaaaaadkaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaai
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaaj
pcaabaaaabaaaaaapgapbaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahacaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apalaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
"!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[0].zwzw, texture[1], 2D;
TXP R2.xyz, fragment.texcoord[2], texture[2], 2D;
DP3_SAT R3.x, R0, c[2];
MOV R2.w, c[0].x;
ADD R1, -R0, R1;
ADD R3.x, -R3, c[3];
MUL R2.w, R2, c[1].x;
MUL R2.w, R2, R3.x;
MAD_SAT R2.w, fragment.texcoord[1].y, c[0].x, -R2;
MAD R0, R2.w, R1, R0;
ADD R1.xyz, R2, fragment.texcoord[3];
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 14 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 1.00000000, 0, 0, 0
dcl t0
dcl t1.xy
dcl t2
dcl t3.xyz
texldp r4, t2, s2
texld r2, t0, s0
dp3_pp_sat r1.x, r2, c2
add_pp r1.x, -r1, c3
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s1
add_pp r3, -r2, r0
mov r0.x, c1
mul r0.x, c0, r0
mul r0.x, r0, r1
mad_sat r0.x, t1.y, c0, -r0
mad_pp r0, r0.x, r3, r2
add_pp r1.xyz, r4, t3
mul_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 128
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedejjafoihnchbpoljbldiondaoieagkdjabaaaaaaiaadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefchiacaaaaeaaaaaaajoaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadccbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaajbcaabaaa
aaaaaaaaakiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
bacaaaaiccaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaaeaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaal
bcaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaadaaaaaaakaabaia
ebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaa
abaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegbcbaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 128
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedmalffohnbgjdjjcmdhophaehnkgfebemabaaaaaadeafaaaaaeaaaaaa
daaaaaaaoaabaaaagaaeaaaaaaafaaaaebgpgodjkiabaaaakiabaaaaaaacpppp
gmabaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaaaaaaaaa
abababaaacacacaaaaaaadaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapka
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaiaadaaahla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkaabaaaaacaaaaabiaaaaakklaabaaaaacaaaaaciaaaaapplaagaaaaac
aaaaaeiaacaapplaafaaaaadabaaadiaaaaakkiaacaaoelaecaaaaadacaacpia
aaaaoelaaaaioekaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaadabaacpia
abaaoeiaacaioekaafaaaaadabaaaiiaaaaaaakaaaaaffkaaiaaaaadadaabiia
acaaoeiaabaaoekaacaaaaadadaaabiaadaappibacaaaakaafaaaaadabaaaiia
abaappiaadaaaaiaaeaaaaaeabaadiiaabaafflaaaaaaakaabaappibbcaaaaae
adaacpiaabaappiaaaaaoeiaacaaoeiaacaaaaadaaaachiaabaaoeiaadaaoela
afaaaaadadaachiaaaaaoeiaadaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaa
fdeieefchiacaaaaeaaaaaaajoaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadccbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaadiaaaaajbcaabaaa
aaaaaaaaakiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
bacaaaaiccaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaaeaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaal
bcaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaadaaaaaaakaabaia
ebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaa
abaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegbcbaaaaeaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
ejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahacaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapalaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R2, fragment.texcoord[3], texture[3], 2D;
TEX R3, fragment.texcoord[3], texture[4], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[0].zwzw, texture[1], 2D;
TXP R4.xyz, fragment.texcoord[2], texture[2], 2D;
MUL R2.xyz, R2.w, R2;
DP4 R2.w, fragment.texcoord[4], fragment.texcoord[4];
MUL R3.xyz, R3.w, R3;
MUL R3.xyz, R3, c[4].y;
RSQ R2.w, R2.w;
RCP R2.w, R2.w;
MAD R2.xyz, R2, c[4].y, -R3;
MAD_SAT R2.w, R2, c[3].z, c[3];
MAD R2.xyz, R2.w, R2, R3;
DP3_SAT R3.x, R0, c[2];
MOV R2.w, c[0].x;
ADD R1, -R0, R1;
ADD R3.x, -R3, c[4];
MUL R2.w, R2, c[1].x;
MUL R2.w, R2, R3.x;
MAD_SAT R2.w, fragment.texcoord[1].y, c[0].x, -R2;
MAD R0, R2.w, R1, R0;
ADD R2.xyz, R4, R2;
MUL result.color.xyz, R0, R2;
MOV result.color.w, R0;
END
# 25 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c4, 1.00000000, 8.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2
dcl t3.xy
dcl t4
texldp r4, t2, s2
texld r3, t3, s4
texld r1, t0, s0
mul_pp r3.xyz, r3.w, r3
mul_pp r3.xyz, r3, c4.y
mov r0.y, t0.w
mov r0.x, t0.z
mov r2.xy, r0
texld r0, t3, s3
texld r2, r2, s1
mul_pp r5.xyz, r0.w, r0
dp4 r0.x, t4, t4
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r5.xyz, r5, c4.y, -r3
mad_sat r0.x, r0, c3.z, c3.w
mad_pp r5.xyz, r0.x, r5, r3
dp3_pp_sat r3.x, r1, c2
mov r0.x, c1
add_pp r3.x, -r3, c4
mul r0.x, c0, r0
mul r0.x, r0, r3
add_pp r2, -r1, r2
mad_sat r0.x, t1.y, c0, -r0
mad_pp r0, r0.x, r2, r1
add_pp r3.xyz, r4, r5
mul_pp r0.xyz, r0, r3
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 160
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
Vector 128 [unity_LightmapFade]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkemccnphfnjkamoenhkichfobmkiijnjabaaaaaacaafaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaaaeaaaa
eaaaaaaaaaabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaagcbaaaad
lcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabbaaaaahbcaabaaaaaaaaaaa
egbobaaaafaaaaaaegbobaaaafaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadccaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaa
aiaaaaaadkiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
aeaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaa
abaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaajgahbaiaebaaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaajicaabaaaaaaaaaaa
akiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabacaaaai
bcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaaeaaaaaaaaaaaaai
bcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadccaaaalicaabaaa
aaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaadaaaaaadkaabaiaebaaaaaa
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaa
egaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaaegaobaaa
acaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 160
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
Vector 128 [unity_LightmapFade]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedahakkacbdpbmeppekpfdikhkhjcanhhgabaaaaaamaahaaaaaeaaaaaa
daaaaaaammacaaaaneagaaaaimahaaaaebgpgodjjeacaaaajeacaaaaaaacpppp
eeacaaaafaaaaaaaacaadiaaaaaafaaaaaaafaaaafaaceaaaaaafaaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaaaaaadaaacaaaaaaaaaaaaaaaaaaaiaa
abaaacaaaaaaaaaaaaacppppfbaaaaafadaaapkaaaaaiadpaaaaaaebaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaahlabpaaaaac
aaaaaaiaacaaaplabpaaaaacaaaaaaiaadaaadlabpaaaaacaaaaaaiaaeaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaabaaaaacabaaabia
aaaakklaabaaaaacabaaaciaaaaapplaecaaaaadacaacpiaadaaoelaaeaioeka
ecaaaaadadaacpiaadaaoelaadaioekaecaaaaadaaaacpiaaaaaoeiaacaioeka
ecaaaaadaeaacpiaaaaaoelaaaaioekaecaaaaadabaacpiaabaaoeiaabaioeka
ajaaaaadaaaaaiiaaeaaoelaaeaaoelaahaaaaacaaaaaiiaaaaappiaagaaaaac
aaaaaiiaaaaappiaaeaaaaaeaaaadiiaaaaappiaacaakkkaacaappkaafaaaaad
acaaciiaacaappiaadaaffkaafaaaaadacaachiaacaaoeiaacaappiaafaaaaad
acaaciiaadaappiaadaaffkaaeaaaaaeadaachiaacaappiaadaaoeiaacaaoeib
aeaaaaaeacaachiaaaaappiaadaaoeiaacaaoeiaacaaaaadaaaachiaaaaaoeia
acaaoeiaafaaaaadaaaaaiiaaaaaaakaaaaaffkaaiaaaaadacaabbiaaeaaoeia
abaaoekaacaaaaadacaaabiaacaaaaibadaaaakaafaaaaadaaaaaiiaaaaappia
acaaaaiaaeaaaaaeaaaadiiaabaafflaaaaaaakaaaaappibbcaaaaaeacaacpia
aaaappiaabaaoeiaaeaaoeiaafaaaaadacaachiaaaaaoeiaacaaoeiaabaaaaac
aaaicpiaacaaoeiappppaaaafdeieefcaaaeaaaaeaaaaaaaaaabaaaafjaaaaae
egiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaad
aagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadccbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaad
dcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaabbaaaaahbcaabaaaaaaaaaaaegbobaaaafaaaaaaegbobaaa
afaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaalbcaabaaa
aaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaaiaaaaaadkiacaaaaaaaaaaa
aiaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaeb
dcaaaaakhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaajgahbaia
ebaaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaajicaabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaa
bkiacaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaabacaaaaibcaabaaaacaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaaeaaaaaaaaaaaaaibcaabaaaacaaaaaaakaabaia
ebaaaaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaacaaaaaadccaaaalicaabaaaaaaaaaaabkbabaaaacaaaaaa
akiacaaaaaaaaaaaadaaaaaadkaabaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaai
pcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadcaaaaaj
pcaabaaaabaaaaaapgapbaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahacaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apalaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R2, fragment.texcoord[3], texture[3], 2D;
TXP R3.xyz, fragment.texcoord[2], texture[2], 2D;
DP3_SAT R4.x, R0, c[2];
MOV R3.w, c[0].x;
ADD R1, -R0, R1;
ADD R4.x, -R4, c[3];
MUL R3.w, R3, c[1].x;
MUL R3.w, R3, R4.x;
MAD_SAT R3.w, fragment.texcoord[1].y, c[0].x, -R3;
MAD R0, R3.w, R1, R0;
MUL R1.xyz, R2.w, R2;
MAD R1.xyz, R1, c[3].y, R3;
MOV result.color.w, R0;
MUL result.color.xyz, R0, R1;
END
# 16 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_Fading]
Float 1 [_Threshold]
Vector 2 [_FadeColor]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 1.00000000, 8.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2
dcl t3.xy
texldp r5, t2, s2
texld r2, t3, s3
texld r3, t0, s0
dp3_pp_sat r1.x, r3, c2
add_pp r1.x, -r1, c3
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s1
add_pp r4, -r3, r0
mov r0.x, c1
mul r0.x, c0, r0
mul r0.x, r0, r1
mul_pp r1.xyz, r2.w, r2
mad_sat r0.x, t1.y, c0, -r0
mad_pp r0, r0.x, r4, r3
mad_pp r1.xyz, r1, c3.y, r5
mul_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
ConstBuffer "$Globals" 160
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedeopcjaboamionjpjhjifocjanbmjgidgabaaaaaaoeadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahacaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcnmacaaaaeaaaaaaalhaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
ccbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaaeaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdcaaaaajhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaajicaabaaa
aaaaaaaaakiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
bacaaaaibcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaaeaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadp
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadccaaaal
icaabaaaaaaaaaaabkbabaaaacaaaaaaakiacaaaaaaaaaaaadaaaaaadkaabaia
ebaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaa
abaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MossTex] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
ConstBuffer "$Globals" 160
Float 48 [_Fading]
Float 52 [_Threshold]
Vector 64 [_FadeColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedcohkjkmodebcfhcgddnppbjppdoaipnoabaaaaaammafaaaaaeaaaaaa
daaaaaaabeacaaaapiaeaaaajiafaaaaebgpgodjnmabaaaanmabaaaaaaacpppp
jmabaaaaeaaaaaaaabaadeaaaaaaeaaaaaaaeaaaaeaaceaaaaaaeaaaaaaaaaaa
abababaaacacacaaadadadaaaaaaadaaacaaaaaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaiadpaaaaaaebaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaia
adaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaagaaaaacaaaaaiiaacaappla
afaaaaadaaaaadiaaaaappiaacaaoelaabaaaaacabaaabiaaaaakklaabaaaaac
abaaaciaaaaapplaecaaaaadaaaacpiaaaaaoeiaacaioekaecaaaaadacaacpia
adaaoelaadaioekaecaaaaadadaacpiaaaaaoelaaaaioekaecaaaaadabaacpia
abaaoeiaabaioekaafaaaaadaaaaciiaacaappiaacaaffkaaeaaaaaeaaaachia
aaaappiaacaaoeiaaaaaoeiaafaaaaadaaaaaiiaaaaaaakaaaaaffkaaiaaaaad
acaabbiaadaaoeiaabaaoekaacaaaaadacaaabiaacaaaaibacaaaakaafaaaaad
aaaaaiiaaaaappiaacaaaaiaaeaaaaaeaaaadiiaabaafflaaaaaaakaaaaappib
bcaaaaaeacaacpiaaaaappiaabaaoeiaadaaoeiaafaaaaadacaachiaaaaaoeia
acaaoeiaabaaaaacaaaicpiaacaaoeiappppaaaafdeieefcnmacaaaaeaaaaaaa
lhaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
adaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadccbabaaaacaaaaaagcbaaaad
lcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaa
adaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadiaaaaajicaabaaaaaaaaaaaakiacaaaaaaaaaaa
adaaaaaabkiacaaaaaaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabacaaaaibcaabaaaacaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaaeaaaaaaaaaaaaaibcaabaaaacaaaaaa
akaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaacaaaaaadccaaaalicaabaaaaaaaaaaabkbabaaa
acaaaaaaakiacaaaaaaaaaaaadaaaaaadkaabaiaebaaaaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
dcaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaaegaobaaaacaaaaaaegaobaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaabejfdeheojiaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahacaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapalaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
SubShader { 
 LOD 150
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
Program "vp" {
}
Program "fp" {
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
}
Program "fp" {
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "RenderType"="Opaque" }
  ZWrite Off
Program "vp" {
}
Program "fp" {
}
 }
}
Fallback "VertexLit"
}