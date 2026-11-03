Shader "Bumped Specular" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.03,1)) = 0.078125
 _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
 _BumpMap ("Normalmap", 2D) = "bump" {}
}
SubShader { 
 LOD 400
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
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[25] = { { 1 },
		state.matrix.mvp,
		program.local[5..24] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MOV R0.w, c[0].x;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[20];
DP4 R0.y, R1, c[19];
DP4 R0.x, R1, c[18];
ADD R0.xyz, R2, R0;
MUL R1.xyz, R0.w, c[21];
ADD result.texcoord[2].xyz, R0, R1;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[22].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[14];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 44 instructions, 4 R-regs
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
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
"vs_2_0
def c24, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c21.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mov r0.w, c24.x
mul r1, r0.xyzz, r0.yzzx
dp4 r2.z, r0, c16
dp4 r2.y, r0, c15
dp4 r2.x, r0, c14
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c19
dp4 r0.y, r1, c18
dp4 r0.x, r1, c17
mul r1.xyz, r0.w, c20
add r0.xyz, r2, r0
add oT2.xyz, r0, r1
mov r0.w, c24.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c21.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
mov r1, c8
dp4 r4.y, c13, r0
dp4 r4.x, c13, r1
dp3 oT1.y, r4, r2
dp3 oT3.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
mad oT0.zw, v3.xyxy, c23.xyxy, c23
mad oT0.xy, v3, c22, c22.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 112
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
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
eefiecedgmjnmjnjgliikefmppilhbhglmholnhdabaaaaaanaahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdeagaaaaeaaaabaa
inabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacafaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaa
kgiocaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaa
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
aeaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadkaabaia
ebaaaaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaa
pgapbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
aeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 112
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
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
"vs_4_0_level_9_1
eefiecedcohmimfmemepegbafcmchmpnmhadhipeabaaaaaakialaaaaaeaaaaaa
daaaaaaaaeaeaaaaeaakaaaaaialaaaaebgpgodjmmadaaaammadaaaaaaacpopp
faadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaafaa
acaaabaaaaaaaaaaabaaaeaaabaaadaaaaaaaaaaacaaaaaaabaaaeaaaaaaaaaa
acaacgaaahaaafaaaaaaaaaaadaaaaaaaeaaamaaaaaaaaaaadaaamaaadaabaaa
aaaaaaaaadaabaaaafaabdaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbiaaapka
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
aeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaadaaeeja
acaaeekaacaaoekaabaaaaacaaaaapiaaeaaoekaafaaaaadabaaahiaaaaaffia
beaaoekaaeaaaaaeabaaahiabdaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahia
bfaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiabgaaoekaaaaappiaaaaaoeia
aiaaaaadabaaaboaabaaoejaaaaaoeiaabaaaaacabaaahiaacaaoejaafaaaaad
acaaahiaabaanciaabaamjjaaeaaaaaeabaaahiaabaamjiaabaancjaacaaoeib
afaaaaadabaaahiaabaaoeiaabaappjaaiaaaaadabaaacoaabaaoeiaaaaaoeia
aiaaaaadabaaaeoaacaaoejaaaaaoeiaabaaaaacaaaaahiaadaaoekaafaaaaad
acaaahiaaaaaffiabeaaoekaaeaaaaaeaaaaaliabdaakekaaaaaaaiaacaakeia
aeaaaaaeaaaaahiabfaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeia
bgaaoekaaeaaaaaeaaaaahiaaaaaoeiabhaappkaaaaaoejbaiaaaaadadaaaboa
abaaoejaaaaaoeiaaiaaaaadadaaacoaabaaoeiaaaaaoeiaaiaaaaadadaaaeoa
acaaoejaaaaaoeiaafaaaaadaaaaahiaacaaoejabhaappkaafaaaaadabaaahia
aaaaffiabbaaoekaaeaaaaaeaaaaaliabaaakekaaaaaaaiaabaakeiaaeaaaaae
aaaaahiabcaaoekaaaaakkiaaaaapeiaabaaaaacaaaaaiiabiaaaakaajaaaaad
abaaabiaafaaoekaaaaaoeiaajaaaaadabaaaciaagaaoekaaaaaoeiaajaaaaad
abaaaeiaahaaoekaaaaaoeiaafaaaaadacaaapiaaaaacjiaaaaakeiaajaaaaad
adaaabiaaiaaoekaacaaoeiaajaaaaadadaaaciaajaaoekaacaaoeiaajaaaaad
adaaaeiaakaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaad
aaaaaciaaaaaffiaaaaaffiaaeaaaaaeaaaaabiaaaaaaaiaaaaaaaiaaaaaffib
aeaaaaaeacaaahoaalaaoekaaaaaaaiaabaaoeiaafaaaaadaaaaapiaaaaaffja
anaaoekaaeaaaaaeaaaaapiaamaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aoaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
ppppaaaafdeieefcdeagaaaaeaaaabaainabaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
afaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadiaaaaah
hcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
eccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
abaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaa
egadbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaai
ecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaah
pcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaa
aeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaa
aeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaa
aeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaa
bkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
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
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[17] = { program.local[0],
		state.matrix.mvp,
		program.local[5..16] };
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[14], c[14].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 7 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
mad oT0.zw, v3.xyxy, c14.xyxy, c14
mad oT0.xy, v3, c13, c13.zwzw
mad oT1.xy, v4, c12, c12.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 128
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_BumpMap_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedfijeamgbongkagahoocpfcccbjhnkgioabaaaaaaaiadaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcjmabaaaaeaaaabaaghaaaaaafjaaaaaeegiocaaaaaaaaaaa
aiaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaa
ogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 128
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_BumpMap_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedkiijcljoblcabbedpjhdbhidfgcobpeoabaaaaaaciaeaaaaaeaaaaaa
daaaaaaaemabaaaapaacaaaaliadaaaaebgpgodjbeabaaaabeabaaaaaaacpopp
neaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaafaa
adaaabaaaaaaaaaaabaaaaaaaeaaaeaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapja
aeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeeja
adaaeekaadaaoekaaeaaaaaeabaaadoaaeaaoejaabaaoekaabaaookaafaaaaad
aaaaapiaaaaaffjaafaaoekaaeaaaaaeaaaaapiaaeaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaagaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaahaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiappppaaaafdeieefcjmabaaaaeaaaabaaghaaaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaafaaaaaa
ogikcaaaaaaaaaaaafaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[19] = { { 1 },
		state.matrix.mvp,
		program.local[5..18] };
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
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 20 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
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
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
"vs_2_0
def c17, 1.00000000, 0, 0, 0
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
mov r0.w, c17.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c13.w, -v0
dp3 oT2.y, r0, r1
dp3 oT2.z, v2, r0
dp3 oT2.x, r0, v1
mad oT0.zw, v3.xyxy, c16.xyxy, c16
mad oT0.xy, v3, c15, c15.zwzw
mad oT1.xy, v4, c14, c14.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 128
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_BumpMap_ST]
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
eefiecednlhbhlmbjbpijcaejkckhjodfickmkndabaaaaaanaaeaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
emadaaaaeaaaabaandaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaa
ahaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
afaaaaaaogikcaaaaaaaaaaaafaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
adaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 128
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedagacnnhbpnkifahjaaanamindgooonkbabaaaaaapiagaaaaaeaaaaaa
daaaaaaafeacaaaakiafaaaahaagaaaaebgpgodjbmacaaaabmacaaaaaaacpopp
meabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaafaa
adaaabaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaaacaaaaaaaeaaafaaaaaaaaaa
acaabaaaafaaajaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoeka
acaaookaaeaaaaaeaaaaamoaadaaeejaadaaeekaadaaoekaaeaaaaaeabaaadoa
aeaaoejaabaaoekaabaaookaabaaaaacaaaaahiaaeaaoekaafaaaaadabaaahia
aaaaffiaakaaoekaaeaaaaaeaaaaaliaajaakekaaaaaaaiaabaakeiaaeaaaaae
aaaaahiaalaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeiaamaaoeka
aeaaaaaeaaaaahiaaaaaoeiaanaappkaaaaaoejbaiaaaaadacaaaboaabaaoeja
aaaaoeiaabaaaaacabaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancja
aeaaaaaeabaaahiaacaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeia
abaappjaaiaaaaadacaaacoaabaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoeja
aaaaoeiaafaaaaadaaaaapiaaaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaaiaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcemadaaaaeaaaabaa
ndaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
agaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadcaaaaal
dccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
aaaaaaaaafaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaa
bdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[26] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..25] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[23].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MOV R0.w, c[0].x;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R2.z, R0, c[18];
DP4 R2.y, R0, c[17];
DP4 R2.x, R0, c[16];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[21];
DP4 R0.y, R1, c[20];
DP4 R0.x, R1, c[19];
ADD R0.xyz, R2, R0;
MUL R1.xyz, R0.w, c[22];
ADD result.texcoord[2].xyz, R0, R1;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[23].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[15];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[3].y, R1, R2;
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
END
# 49 instructions, 4 R-regs
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
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
"vs_2_0
def c26, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c23.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mov r0.w, c26.x
mul r1, r0.xyzz, r0.yzzx
dp4 r2.z, r0, c18
dp4 r2.y, r0, c17
dp4 r2.x, r0, c16
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c21
dp4 r0.y, r1, c20
dp4 r0.x, r1, c19
mul r1.xyz, r0.w, c22
add r0.xyz, r2, r0
add oT2.xyz, r0, r1
mov r0.w, c26.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c23.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mov r1, c8
dp4 r4.x, c15, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c26.y
mul r1.y, r1, c13.x
dp3 oT1.y, r4, r2
dp3 oT3.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
mad oT4.xy, r1.z, c14.zwzw, r1
mov oPos, r0
mov oT4.zw, r0
mad oT0.zw, v3.xyxy, c25.xyxy, c25
mad oT0.xy, v3, c24, c24.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
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
eefiecedaljepedldaoholngknaepappjbhlimgbabaaaaaaiaaiaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcmmagaaaaeaaaabaaldabaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacagaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaa
akaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaa
diaaaaaihcaabaaaacaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
diaaaaaihcaabaaaadaaaaaafgafbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaaklcaabaaaacaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaacaaaaaa
egaibaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgakbaaaacaaaaaaegadbaaaacaaaaaadgaaaaaficaabaaaacaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaa
acaaaaaadiaaaaahpcaabaaaaeaaaaaajgacbaaaacaaaaaaegakbaaaacaaaaaa
bbaaaaaibcaabaaaafaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaaeaaaaaa
bbaaaaaiccaabaaaafaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaaeaaaaaa
bbaaaaaiecaabaaaafaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaaeaaaaaa
aaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaafaaaaaadiaaaaah
icaabaaaabaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaa
abaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaabaaaaaa
egacbaaaadaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaa
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
aaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
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
"vs_4_0_level_9_1
eefieceddagkjngmoolbjmcgomfedfnlfladfkimabaaaaaakeamaaaaaeaaaaaa
daaaaaaafaaeaaaacealaaaaomalaaaaebgpgodjbiaeaaaabiaeaaaaaaacpopp
jmadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaajaa
acaaabaaaaaaaaaaabaaaeaaacaaadaaaaaaaaaaacaaaaaaabaaafaaaaaaaaaa
acaacgaaahaaagaaaaaaaaaaadaaaaaaaeaaanaaaaaaaaaaadaaamaaadaabbaa
aaaaaaaaadaabaaaafaabeaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbjaaapka
aaaaiadpaaaaaadpaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
aeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaadaaeeja
acaaeekaacaaoekaabaaaaacaaaaapiaafaaoekaafaaaaadabaaahiaaaaaffia
bfaaoekaaeaaaaaeabaaahiabeaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahia
bgaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiabhaaoekaaaaappiaaaaaoeia
aiaaaaadabaaaboaabaaoejaaaaaoeiaabaaaaacabaaahiaacaaoejaafaaaaad
acaaahiaabaanciaabaamjjaaeaaaaaeabaaahiaabaamjiaabaancjaacaaoeib
afaaaaadabaaahiaabaaoeiaabaappjaaiaaaaadabaaacoaabaaoeiaaaaaoeia
aiaaaaadabaaaeoaacaaoejaaaaaoeiaabaaaaacaaaaahiaadaaoekaafaaaaad
acaaahiaaaaaffiabfaaoekaaeaaaaaeaaaaaliabeaakekaaaaaaaiaacaakeia
aeaaaaaeaaaaahiabgaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeia
bhaaoekaaeaaaaaeaaaaahiaaaaaoeiabiaappkaaaaaoejbaiaaaaadadaaaboa
abaaoejaaaaaoeiaaiaaaaadadaaacoaabaaoeiaaaaaoeiaaiaaaaadadaaaeoa
acaaoejaaaaaoeiaafaaaaadaaaaahiaacaaoejabiaappkaafaaaaadabaaahia
aaaaffiabcaaoekaaeaaaaaeaaaaaliabbaakekaaaaaaaiaabaakeiaaeaaaaae
aaaaahiabdaaoekaaaaakkiaaaaapeiaabaaaaacaaaaaiiabjaaaakaajaaaaad
abaaabiaagaaoekaaaaaoeiaajaaaaadabaaaciaahaaoekaaaaaoeiaajaaaaad
abaaaeiaaiaaoekaaaaaoeiaafaaaaadacaaapiaaaaacjiaaaaakeiaajaaaaad
adaaabiaajaaoekaacaaoeiaajaaaaadadaaaciaakaaoekaacaaoeiaajaaaaad
adaaaeiaalaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaad
aaaaaciaaaaaffiaaaaaffiaaeaaaaaeaaaaabiaaaaaaaiaaaaaaaiaaaaaffib
aeaaaaaeacaaahoaamaaoekaaaaaaaiaabaaoeiaafaaaaadaaaaapiaaaaaffja
aoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
apaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaappjaaaaaoeia
afaaaaadabaaabiaaaaaffiaaeaaaakaafaaaaadabaaaiiaabaaaaiabjaaffka
afaaaaadabaaafiaaaaapeiabjaaffkaacaaaaadaeaaadoaabaakkiaabaaomia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacaeaaamoaaaaaoeiappppaaaafdeieefcmmagaaaaeaaaabaaldabaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaac
agaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaa
aaaaaaaaakaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
acaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaacaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
acaaaaaaegaibaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaadgaaaaaficaabaaaacaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacgaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaachaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaciaaaaaa
egaobaaaacaaaaaadiaaaaahpcaabaaaaeaaaaaajgacbaaaacaaaaaaegakbaaa
acaaaaaabbaaaaaibcaabaaaafaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaa
aeaaaaaabbaaaaaiccaabaaaafaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaa
aeaaaaaabbaaaaaiecaabaaaafaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaa
aeaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaafaaaaaa
diaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaak
icaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadkaabaiaebaaaaaa
abaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaa
abaaaaaaegacbaaaadaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaa
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
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
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
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_ProjectionParams]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
Vector 17 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[18] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[15], c[15].zwzw;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
"vs_2_0
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c17.x
mul r1.y, r1, c12.x
mad oT2.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov oT2.zw, r0
mad oT0.zw, v3.xyxy, c16.xyxy, c16
mad oT0.xy, v3, c15, c15.zwzw
mad oT1.xy, v4, c14, c14.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 192
Vector 144 [unity_LightmapST]
Vector 160 [_MainTex_ST]
Vector 176 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhcecebjiincpgloaiemogobajakhhbnnabaaaaaamiadaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
eeacaaaaeaaaabaajbaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaaaaaaaaaaalaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaajaaaaaa
ogikcaaaaaaaaaaaajaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 192
Vector 144 [unity_LightmapST]
Vector 160 [_MainTex_ST]
Vector 176 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedicogdkecglmkcghlghkojjbnfbonbbahabaaaaaafiafaaaaaeaaaaaa
daaaaaaalmabaaaaaiaeaaaanaaeaaaaebgpgodjieabaaaaieabaaaaaaacpopp
diabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaajaa
adaaabaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaaacaaaaaaaeaaafaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafajaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeia
aeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoa
adaaeejaadaaeekaadaaoekaaeaaaaaeabaaadoaaeaaoejaabaaoekaabaaooka
afaaaaadaaaaapiaaaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
aiaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaaeaaaakaafaaaaad
abaaaiiaabaaaaiaajaaaakaafaaaaadabaaafiaaaaapeiaajaaaakaacaaaaad
acaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacacaaamoaaaaaoeiappppaaaafdeieefc
eeacaaaaeaaaabaajbaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaaaaaaaaaaalaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaajaaaaaa
ogikcaaaaaaaaaaaajaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
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
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[20] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..19] };
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
DP3 result.texcoord[2].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, R2, vertex.attrib[14];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 25 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
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
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"vs_2_0
def c19, 1.00000000, 0.50000000, 0, 0
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
mov r1.w, c19.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
dp3 oT2.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c19.y
mul r1.y, r1, c13.x
dp3 oT2.z, v2, r2
dp3 oT2.x, r2, v1
mad oT3.xy, r1.z, c14.zwzw, r1
mov oPos, r0
mov oT3.zw, r0
mad oT0.zw, v3.xyxy, c18.xyxy, c18
mad oT0.xy, v3, c17, c17.zwzw
mad oT1.xy, v4, c16, c16.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Vector 144 [unity_LightmapST]
Vector 160 [_MainTex_ST]
Vector 176 [_BumpMap_ST]
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
eefiecedoaonjikeoiamplaoogifafigiokfjichabaaaaaaiaafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeadaaaaeaaaabaa
pjaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
akaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaaaaaaaaaaalaaaaaadcaaaaal
dccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaa
aaaaaaaaajaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
acaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaacaaaaaa
bdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Vector 144 [unity_LightmapST]
Vector 160 [_MainTex_ST]
Vector 176 [_BumpMap_ST]
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
"vs_4_0_level_9_1
eefiecedhlbkbdghijgllplpehdnjhnknmnjlngiabaaaaaaamaiaaaaaeaaaaaa
daaaaaaaliacaaaakeagaaaagmahaaaaebgpgodjiaacaaaaiaacaaaaaaacpopp
ciacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaajaa
adaaabaaaaaaaaaaabaaaeaaacaaaeaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaabaaaafaaakaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafapaaapkaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaaeiaaeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaae
aaaaamoaadaaeejaadaaeekaadaaoekaaeaaaaaeabaaadoaaeaaoejaabaaoeka
abaaookaabaaaaacaaaaahiaaeaaoekaafaaaaadabaaahiaaaaaffiaalaaoeka
aeaaaaaeaaaaaliaakaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahiaamaaoeka
aaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeiaanaaoekaaeaaaaaeaaaaahia
aaaaoeiaaoaappkaaaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaabaaaaac
abaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaaeabaaahia
acaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappjaaiaaaaad
acaaacoaabaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaafaaaaad
aaaaapiaaaaaffjaahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoeka
aaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaafaaaakaafaaaaadabaaaiia
abaaaaiaapaaaakaafaaaaadabaaafiaaaaapeiaapaaaakaacaaaaadadaaadoa
abaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacadaaamoaaaaaoeiappppaaaafdeieefcoeadaaaa
eaaaabaapjaaaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaaaaaaaaaaalaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaajaaaaaa
ogikcaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
acaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaa
egacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adamaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
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
Vector 31 [_MainTex_ST]
Vector 32 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[33] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..32] };
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
MUL R1.w, R3, R3;
DP4 R3.z, R0, c[28];
DP4 R3.y, R0, c[27];
DP4 R3.x, R0, c[26];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[29];
MOV R1.w, c[0].x;
DP4 R2.z, R4, c[25];
DP4 R2.y, R4, c[24];
DP4 R2.x, R4, c[23];
ADD R2.xyz, R2, R3;
ADD R0.xyz, R2, R0;
ADD result.texcoord[2].xyz, R0, R1;
MOV R1.xyz, c[13];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[30].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1, c[14];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
DP3 result.texcoord[1].y, R3, R0;
DP3 result.texcoord[3].y, R0, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[32].xyxy, c[32];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[31], c[31].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 75 instructions, 5 R-regs
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
Vector 30 [_MainTex_ST]
Vector 31 [_BumpMap_ST]
"vs_2_0
def c32, 1.00000000, 0.00000000, 0, 0
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
mov r4.w, c32.x
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
add r1, r2, c32.x
dp4 r2.z, r4, c24
dp4 r2.y, r4, c23
dp4 r2.x, r4, c22
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c32.y
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
add r0.xyz, r2, r0
add oT2.xyz, r0, r1
mov r1.w, c32.x
mov r1.xyz, c12
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
mad r3.xyz, r0, c29.w, -v0
mov r1.xyz, v1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r1, c9
mov r0, c8
dp4 r4.y, c13, r1
dp4 r4.x, c13, r0
dp3 oT1.y, r4, r2
dp3 oT3.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
mad oT0.zw, v3.xyxy, c31.xyxy, c31
mad oT0.xy, v3, c30, c30.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 112
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
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
eefiecedmookmmbhgaijfnpgbgjbakokndpnaholabaaaaaacaalaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcieajaaaaeaaaabaa
gbacaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaa
kgiocaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaai
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
aeaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadkaabaia
ebaaaaaaaaaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaacmaaaaaa
pgapbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaa
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
abaaaaaaaaaaaaahhccabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 112
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
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
"vs_4_0_level_9_1
eefiecedgjkloljgpeppemaaciimkejhbfhgaaahabaaaaaapabaaaaaaeaaaaaa
daaaaaaapmafaaaaiiapaaaafabaaaaaebgpgodjmeafaaaameafaaaaaaacpopp
eiafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaafaa
acaaabaaaaaaaaaaabaaaeaaabaaadaaaaaaaaaaacaaaaaaabaaaeaaaaaaaaaa
acaaacaaaiaaafaaaaaaaaaaacaacgaaahaaanaaaaaaaaaaadaaaaaaaeaabeaa
aaaaaaaaadaaamaaajaabiaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafcbaaapka
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
aeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaadaaeeja
acaaeekaacaaoekaabaaaaacaaaaapiaaeaaoekaafaaaaadabaaahiaaaaaffia
bnaaoekaaeaaaaaeabaaahiabmaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahia
boaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiabpaaoekaaaaappiaaaaaoeia
aiaaaaadabaaaboaabaaoejaaaaaoeiaabaaaaacabaaahiaacaaoejaafaaaaad
acaaahiaabaanciaabaamjjaaeaaaaaeabaaahiaabaamjiaabaancjaacaaoeib
afaaaaadabaaahiaabaaoeiaabaappjaaiaaaaadabaaacoaabaaoeiaaaaaoeia
aiaaaaadabaaaeoaacaaoejaaaaaoeiaabaaaaacaaaaahiaadaaoekaafaaaaad
acaaahiaaaaaffiabnaaoekaaeaaaaaeaaaaaliabmaakekaaaaaaaiaacaakeia
aeaaaaaeaaaaahiaboaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeia
bpaaoekaaeaaaaaeaaaaahiaaaaaoeiacaaappkaaaaaoejbaiaaaaadadaaaboa
abaaoejaaaaaoeiaaiaaaaadadaaacoaabaaoeiaaaaaoeiaaiaaaaadadaaaeoa
acaaoejaaaaaoeiaafaaaaadaaaaahiaaaaaffjabjaaoekaaeaaaaaeaaaaahia
biaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabkaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaahiablaaoekaaaaappjaaaaaoeiaacaaaaadabaaapiaaaaakkib
ahaaoekaacaaaaadacaaapiaaaaaaaibafaaoekaacaaaaadaaaaapiaaaaaffib
agaaoekaafaaaaadadaaahiaacaaoejacaaappkaafaaaaadaeaaahiaadaaffia
bjaaoekaaeaaaaaeadaaaliabiaakekaadaaaaiaaeaakeiaaeaaaaaeadaaahia
bkaaoekaadaakkiaadaapeiaafaaaaadaeaaapiaaaaaoeiaadaaffiaafaaaaad
aaaaapiaaaaaoeiaaaaaoeiaaeaaaaaeaaaaapiaacaaoeiaacaaoeiaaaaaoeia
aeaaaaaeacaaapiaacaaoeiaadaaaaiaaeaaoeiaaeaaaaaeacaaapiaabaaoeia
adaakkiaacaaoeiaaeaaaaaeaaaaapiaabaaoeiaabaaoeiaaaaaoeiaahaaaaac
abaaabiaaaaaaaiaahaaaaacabaaaciaaaaaffiaahaaaaacabaaaeiaaaaakkia
ahaaaaacabaaaiiaaaaappiaabaaaaacaeaaabiacbaaaakaaeaaaaaeaaaaapia
aaaaoeiaaiaaoekaaeaaaaiaafaaaaadabaaapiaabaaoeiaacaaoeiaalaaaaad
abaaapiaabaaoeiacbaaffkaagaaaaacacaaabiaaaaaaaiaagaaaaacacaaacia
aaaaffiaagaaaaacacaaaeiaaaaakkiaagaaaaacacaaaiiaaaaappiaafaaaaad
aaaaapiaabaaoeiaacaaoeiaafaaaaadabaaahiaaaaaffiaakaaoekaaeaaaaae
abaaahiaajaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaalaaoekaaaaakkia
abaaoeiaaeaaaaaeaaaaahiaamaaoekaaaaappiaaaaaoeiaabaaaaacadaaaiia
cbaaaakaajaaaaadabaaabiaanaaoekaadaaoeiaajaaaaadabaaaciaaoaaoeka
adaaoeiaajaaaaadabaaaeiaapaaoekaadaaoeiaafaaaaadacaaapiaadaacjia
adaakeiaajaaaaadaeaaabiabaaaoekaacaaoeiaajaaaaadaeaaaciabbaaoeka
acaaoeiaajaaaaadaeaaaeiabcaaoekaacaaoeiaacaaaaadabaaahiaabaaoeia
aeaaoeiaafaaaaadaaaaaiiaadaaffiaadaaffiaaeaaaaaeaaaaaiiaadaaaaia
adaaaaiaaaaappibaeaaaaaeabaaahiabdaaoekaaaaappiaabaaoeiaacaaaaad
acaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapiaaaaaffjabfaaoekaaeaaaaae
aaaaapiabeaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabgaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabhaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefc
ieajaaaaeaaaabaagbacaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaac
ahaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
aaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
aaaaiadpdiaaaaaihcaabaaaacaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaacaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
acaaaaaaegaibaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaabbaaaaaibcaabaaaacaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaa
jgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaa
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
abaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaadaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaa
imaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
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
Vector 32 [_MainTex_ST]
Vector 33 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[34] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..33] };
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
MUL R1.w, R3, R3;
DP4 R3.z, R0, c[29];
DP4 R3.y, R0, c[28];
DP4 R3.x, R0, c[27];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[30];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R4, c[26];
DP4 R2.y, R4, c[25];
DP4 R2.x, R4, c[24];
ADD R2.xyz, R2, R3;
ADD R0.xyz, R2, R0;
ADD result.texcoord[2].xyz, R0, R1;
MOV R1.xyz, c[13];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[31].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1, c[15];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
DP3 result.texcoord[1].y, R3, R0;
DP3 result.texcoord[3].y, R0, R2;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[33].xyxy, c[33];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[32], c[32].zwzw;
END
# 80 instructions, 5 R-regs
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
Vector 32 [_MainTex_ST]
Vector 33 [_BumpMap_ST]
"vs_2_0
def c34, 1.00000000, 0.00000000, 0.50000000, 0
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
mov r4.w, c34.x
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
add r1, r2, c34.x
dp4 r2.z, r4, c26
dp4 r2.y, r4, c25
dp4 r2.x, r4, c24
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c34.y
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
add r0.xyz, r2, r0
add oT2.xyz, r0, r1
mov r1.w, c34.x
mov r1.xyz, c12
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
mad r3.xyz, r0, c31.w, -v0
mov r1.xyz, v1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c8
dp4 r4.x, c15, r0
mov r1, c9
dp4 r4.y, c15, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c34.z
mul r1.y, r1, c13.x
dp3 oT1.y, r4, r2
dp3 oT3.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
mad oT4.xy, r1.z, c14.zwzw, r1
mov oPos, r0
mov oT4.zw, r0
mad oT0.zw, v3.xyxy, c33.xyxy, c33
mad oT0.xy, v3, c32, c32.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
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
eefiecedfenjoboioodacodolnmcfhljllgoofohabaaaaaanaalaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcbmakaaaaeaaaabaaihacaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacaiaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaa
akaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaa
dgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaaadaaaaaa
egbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaaeaaaaaa
fgafbaaaadaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaadaaaaaa
egiicaaaadaaaaaaamaaaaaaagaabaaaadaaaaaaegaibaaaaeaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaadaaaaaaegadbaaa
adaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaa
acaaaaaadiaaaaahpcaabaaaaeaaaaaajgacbaaaacaaaaaaegakbaaaacaaaaaa
bbaaaaaibcaabaaaafaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaaeaaaaaa
bbaaaaaiccaabaaaafaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaaeaaaaaa
bbaaaaaiecaabaaaafaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaaeaaaaaa
aaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaafaaaaaadiaaaaah
icaabaaaabaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaa
abaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaabaaaaaa
egacbaaaadaaaaaadiaaaaaihcaabaaaaeaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaa
aeaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaeaaaaaa
aaaaaaajpcaabaaaafaaaaaafgafbaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaa
adaaaaaadiaaaaahpcaabaaaagaaaaaafgafbaaaacaaaaaaegaobaaaafaaaaaa
diaaaaahpcaabaaaafaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaaaaaaaaj
pcaabaaaahaaaaaaagaabaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaaacaaaaaa
aaaaaaajpcaabaaaaeaaaaaakgakbaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaa
aeaaaaaadcaaaaajpcaabaaaagaaaaaaegaobaaaahaaaaaaagaabaaaacaaaaaa
egaobaaaagaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaaeaaaaaakgakbaaa
acaaaaaaegaobaaaagaaaaaadcaaaaajpcaabaaaafaaaaaaegaobaaaahaaaaaa
egaobaaaahaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaa
aeaaaaaaegaobaaaaeaaaaaaegaobaaaafaaaaaaeeaaaaafpcaabaaaafaaaaaa
egaobaaaaeaaaaaadcaaaaanpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegiocaaa
acaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaak
pcaabaaaaeaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaa
aeaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaafaaaaaa
deaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaaeaaaaaaegaobaaa
acaaaaaadiaaaaaihcaabaaaaeaaaaaafgafbaaaacaaaaaaegiccaaaacaaaaaa
ahaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaa
acaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
aiaaaaaakgakbaaaacaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaacaaaaaaajaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaah
hccabaaaadaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaajhcaabaaa
acaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaa
egacbaaaacaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaa
egacbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
bccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaa
aeaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
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
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
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
"vs_4_0_level_9_1
eefiecedhkfadeikmflhanbkobdnmbmbmihpmilpabaaaaaaombbaaaaaeaaaaaa
daaaaaaaeiagaaaagmbaaaaadebbaaaaebgpgodjbaagaaaabaagaaaaaaacpopp
jeafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaajaa
acaaabaaaaaaaaaaabaaaeaaacaaadaaaaaaaaaaacaaaaaaabaaafaaaaaaaaaa
acaaacaaaiaaagaaaaaaaaaaacaacgaaahaaaoaaaaaaaaaaadaaaaaaaeaabfaa
aaaaaaaaadaaamaaajaabjaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafccaaapka
aaaaiadpaaaaaaaaaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
aeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaadaaeeja
acaaeekaacaaoekaabaaaaacaaaaapiaafaaoekaafaaaaadabaaahiaaaaaffia
boaaoekaaeaaaaaeabaaahiabnaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahia
bpaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiacaaaoekaaaaappiaaaaaoeia
aiaaaaadabaaaboaabaaoejaaaaaoeiaabaaaaacabaaahiaacaaoejaafaaaaad
acaaahiaabaanciaabaamjjaaeaaaaaeabaaahiaabaamjiaabaancjaacaaoeib
afaaaaadabaaahiaabaaoeiaabaappjaaiaaaaadabaaacoaabaaoeiaaaaaoeia
aiaaaaadabaaaeoaacaaoejaaaaaoeiaabaaaaacaaaaahiaadaaoekaafaaaaad
acaaahiaaaaaffiaboaaoekaaeaaaaaeaaaaaliabnaakekaaaaaaaiaacaakeia
aeaaaaaeaaaaahiabpaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeia
caaaoekaaeaaaaaeaaaaahiaaaaaoeiacbaappkaaaaaoejbaiaaaaadadaaaboa
abaaoejaaaaaoeiaaiaaaaadadaaacoaabaaoeiaaaaaoeiaaiaaaaadadaaaeoa
acaaoejaaaaaoeiaafaaaaadaaaaahiaaaaaffjabkaaoekaaeaaaaaeaaaaahia
bjaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiablaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaahiabmaaoekaaaaappjaaaaaoeiaacaaaaadabaaapiaaaaakkib
aiaaoekaacaaaaadacaaapiaaaaaaaibagaaoekaacaaaaadaaaaapiaaaaaffib
ahaaoekaafaaaaadadaaahiaacaaoejacbaappkaafaaaaadaeaaahiaadaaffia
bkaaoekaaeaaaaaeadaaaliabjaakekaadaaaaiaaeaakeiaaeaaaaaeadaaahia
blaaoekaadaakkiaadaapeiaafaaaaadaeaaapiaaaaaoeiaadaaffiaafaaaaad
aaaaapiaaaaaoeiaaaaaoeiaaeaaaaaeaaaaapiaacaaoeiaacaaoeiaaaaaoeia
aeaaaaaeacaaapiaacaaoeiaadaaaaiaaeaaoeiaaeaaaaaeacaaapiaabaaoeia
adaakkiaacaaoeiaaeaaaaaeaaaaapiaabaaoeiaabaaoeiaaaaaoeiaahaaaaac
abaaabiaaaaaaaiaahaaaaacabaaaciaaaaaffiaahaaaaacabaaaeiaaaaakkia
ahaaaaacabaaaiiaaaaappiaabaaaaacaeaaabiaccaaaakaaeaaaaaeaaaaapia
aaaaoeiaajaaoekaaeaaaaiaafaaaaadabaaapiaabaaoeiaacaaoeiaalaaaaad
abaaapiaabaaoeiaccaaffkaagaaaaacacaaabiaaaaaaaiaagaaaaacacaaacia
aaaaffiaagaaaaacacaaaeiaaaaakkiaagaaaaacacaaaiiaaaaappiaafaaaaad
aaaaapiaabaaoeiaacaaoeiaafaaaaadabaaahiaaaaaffiaalaaoekaaeaaaaae
abaaahiaakaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaamaaoekaaaaakkia
abaaoeiaaeaaaaaeaaaaahiaanaaoekaaaaappiaaaaaoeiaabaaaaacadaaaiia
ccaaaakaajaaaaadabaaabiaaoaaoekaadaaoeiaajaaaaadabaaaciaapaaoeka
adaaoeiaajaaaaadabaaaeiabaaaoekaadaaoeiaafaaaaadacaaapiaadaacjia
adaakeiaajaaaaadaeaaabiabbaaoekaacaaoeiaajaaaaadaeaaaciabcaaoeka
acaaoeiaajaaaaadaeaaaeiabdaaoekaacaaoeiaacaaaaadabaaahiaabaaoeia
aeaaoeiaafaaaaadaaaaaiiaadaaffiaadaaffiaaeaaaaaeaaaaaiiaadaaaaia
adaaaaiaaaaappibaeaaaaaeabaaahiabeaaoekaaaaappiaabaaoeiaacaaaaad
acaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapiaaaaaffjabgaaoekaaeaaaaae
aaaaapiabfaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabhaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabiaaoekaaaaappjaaaaaoeiaafaaaaadabaaabia
aaaaffiaaeaaaakaafaaaaadabaaaiiaabaaaaiaccaakkkaafaaaaadabaaafia
aaaapeiaccaakkkaacaaaaadaeaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaeaaamoa
aaaaoeiappppaaaafdeieefcbmakaaaaeaaaabaaihacaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacaiaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaa
diaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaa
diaaaaajhcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
acaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaa
egacbaaaacaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadgaaaaaf
icaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaaadaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaaeaaaaaafgafbaaa
adaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaadaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaadaaaaaaegaibaaaaeaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaadaaaaaaegadbaaaadaaaaaa
bbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaacaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaacaaaaaa
diaaaaahpcaabaaaaeaaaaaajgacbaaaacaaaaaaegakbaaaacaaaaaabbaaaaai
bcaabaaaafaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaaeaaaaaabbaaaaai
ccaabaaaafaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaaeaaaaaabbaaaaai
ecaabaaaafaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaaeaaaaaaaaaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaafaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaaabaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaak
hcaabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaaihcaabaaaaeaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaaeaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaeaaaaaaaaaaaaaj
pcaabaaaafaaaaaafgafbaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaaadaaaaaa
diaaaaahpcaabaaaagaaaaaafgafbaaaacaaaaaaegaobaaaafaaaaaadiaaaaah
pcaabaaaafaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaaaaaaaajpcaabaaa
ahaaaaaaagaabaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaaj
pcaabaaaaeaaaaaakgakbaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaaaeaaaaaa
dcaaaaajpcaabaaaagaaaaaaegaobaaaahaaaaaaagaabaaaacaaaaaaegaobaaa
agaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaaeaaaaaakgakbaaaacaaaaaa
egaobaaaagaaaaaadcaaaaajpcaabaaaafaaaaaaegaobaaaahaaaaaaegaobaaa
ahaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaaeaaaaaa
egaobaaaaeaaaaaaegaobaaaafaaaaaaeeaaaaafpcaabaaaafaaaaaaegaobaaa
aeaaaaaadcaaaaanpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegiocaaaacaaaaaa
afaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaa
aeaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaaeaaaaaa
diaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaafaaaaaadeaaaaak
pcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaa
diaaaaaihcaabaaaaeaaaaaafgafbaaaacaaaaaaegiccaaaacaaaaaaahaaaaaa
dcaaaaakhcaabaaaaeaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaacaaaaaa
egacbaaaaeaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaaiaaaaaa
kgakbaaaacaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaaajaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaahhccabaaa
adaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaajhcaabaaaacaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
acaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaa
acaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaa
aeaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaaeaaaaaa
egbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
afaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
"!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 2, 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R2.xy, R2.wyzw, c[4].x, -c[4].y;
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
MUL R2.zw, R2.xyxy, R2.xyxy;
MUL R0.xyz, R0, c[2];
RSQ R1.w, R1.w;
MOV R1.xyz, fragment.texcoord[1];
MAD R1.xyz, R1.w, fragment.texcoord[3], R1;
ADD_SAT R1.w, R2.z, R2;
DP3 R2.z, R1, R1;
RSQ R2.z, R2.z;
ADD R1.w, -R1, c[4].y;
MUL R1.xyz, R2.z, R1;
RSQ R1.w, R1.w;
RCP R2.z, R1.w;
DP3 R1.x, R2, R1;
MOV R1.w, c[4];
DP3 R2.x, R2, fragment.texcoord[1];
MAX R3.x, R2, c[4].z;
MUL R2.xyz, R0, c[0];
MUL R1.y, R1.w, c[3].x;
MAX R1.x, R1, c[4].z;
POW R1.x, R1.x, R1.y;
MUL R2.w, R0, R1.x;
MOV R1, c[1];
MUL R2.xyz, R2, R3.x;
MUL R1.xyz, R1, c[0];
MAD R1.xyz, R1, R2.w, R2;
MUL R1.xyz, R1, c[4].x;
MAD result.color.xyz, R0, fragment.texcoord[2], R1;
MUL R0.y, R0.w, c[2].w;
MUL R0.x, R1.w, c[0].w;
MAD result.color.w, R2, R0.x, R0.y;
END
# 34 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c5, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r2, t0, s0
dp3_pp r1.x, t3, t3
rsq_pp r1.x, r1.x
mov_pp r3.xyz, t1
mad_pp r3.xyz, r1.x, t3, r3
mul_pp r2.xyz, r2, c2
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s1
mov r0.x, r0.w
mad_pp r4.xy, r0, c4.x, c4.y
mul_pp r0.xy, r4, r4
add_pp_sat r0.x, r0, r0.y
add_pp r1.x, -r0, c4.z
dp3_pp r0.x, r3, r3
rsq_pp r1.x, r1.x
rcp_pp r4.z, r1.x
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r3
dp3_pp r1.x, r4, r1
mov_pp r0.x, c3
mul_pp r0.x, c5, r0
max_pp r1.x, r1, c4.w
pow r3.w, r1.x, r0.x
dp3_pp r1.x, r4, t1
mov r0.x, r3.w
mov_pp r3.xyz, c0
mul r0.x, r2.w, r0
mul_pp r4.xyz, r2, c0
max_pp r1.x, r1, c4.w
mul_pp r1.xyz, r4, r1.x
mul_pp r3.xyz, c1, r3
mad r1.xyz, r3, r0.x, r1
mul r4.xyz, r1, c4.x
mov_pp r0.w, c0
mul_pp r1.x, r2.w, c2.w
mul_pp r3.x, c1.w, r0.w
mad r0.w, r0.x, r3.x, r1.x
mad_pp r0.xyz, r2, t2, r4
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
ConstBuffer "$Globals" 112
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0
eefiecedfeikaflchgeicafonfflolhjblhcoeegabaaaaaabmafaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcbeaeaaaaeaaaaaaaafabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaaeaaaaaa
agaabaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaa
dkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaacaaaaaa
deaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
ecaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkaabaaaabaaaaaadiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahpcaabaaaacaaaaaaagaabaaa
aaaaaaaaegaobaaaacaaaaaadiaaaaaincaabaaaaaaaaaaaagajbaaaabaaaaaa
agijcaaaaaaaaaaaadaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaadaaaaaadkaabaaaacaaaaaadiaaaaaihcaabaaaabaaaaaa
igadbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaabaaaaaafgafbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaa
igadbaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
ConstBuffer "$Globals" 112
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecednfegkoibpkkabcniilpkgpgnbhgcgpopabaaaaaaaeaiaaaaaeaaaaaa
daaaaaaabeadaaaadaahaaaanaahaaaaebgpgodjnmacaaaanmacaaaaaaacpppp
keacaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaaeaaaaaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaea
aaaaialpaaaaaaaaaaaaiadpfbaaaaafafaaapkaaaaaaaedaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaac
aaaaaaiaacaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkaabaaaaacaaaaabiaaaaakklaabaaaaacaaaaacia
aaaapplaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaadabaacpiaaaaaoela
aaaioekaaeaaaaaeacaacbiaaaaappiaaeaaaakaaeaaffkaaeaaaaaeacaaccia
aaaaffiaaeaaaakaaeaaffkafkaaaaaeacaadiiaacaaoeiaacaaoeiaaeaakkka
acaaaaadacaaciiaacaappibaeaappkaahaaaaacacaaciiaacaappiaagaaaaac
acaaceiaacaappiaaiaaaaadacaaciiaacaaoeiaabaaoelaalaaaaadaaaacbia
acaappiaaeaakkkaaiaaaaadacaaciiaadaaoelaadaaoelaahaaaaacacaaciia
acaappiaabaaaaacadaaahiaadaaoelaaeaaaaaeadaachiaadaaoeiaacaappia
abaaoelaceaaaaacaeaachiaadaaoeiaaiaaaaadaaaacciaacaaoeiaaeaaoeia
alaaaaadacaaabiaaaaaffiaaeaakkkaabaaaaacadaaabiaadaaaakaafaaaaad
aaaaaciaadaaaaiaafaaaakacaaaaaadadaaabiaacaaaaiaaaaaffiaafaaaaad
aaaaaciaabaappiaadaaaaiaabaaaaacacaaapiaaaaaoekaafaaaaadacaaahia
acaaoeiaabaaoekaafaaaaadacaaahiaaaaaffiaacaaoeiaafaaaaadabaachia
abaaoeiaacaaoekaafaaaaadadaachiaabaaoeiaaaaaoekaaeaaaaaeacaaahia
adaaoeiaaaaaaaiaacaaoeiaacaaaaadacaachiaacaaoeiaacaaoeiaaeaaaaae
adaachiaabaaoeiaacaaoelaacaaoeiaafaaaaadaaaaabiaacaappiaabaappka
afaaaaadaaaaabiaaaaaffiaaaaaaaiaaeaaaaaeadaaciiaabaappiaacaappka
aaaaaaiaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefcbeaeaaaaeaaaaaaa
afabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegbcbaaaaeaaaaaaagaabaaaaaaaaaaaegbcbaaa
acaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaabaaaaaa
hgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaa
abaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaadkaabaaaaaaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaabaaaaaaegbcbaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaaakiacaaa
aaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaaegiocaaaaaaaaaaa
acaaaaaadiaaaaahpcaabaaaacaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaa
diaaaaaincaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaadaaaaaa
dcaaaaakiccabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaadaaaaaa
dkaabaaaacaaaaaadiaaaaaihcaabaaaabaaaaaaigadbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaafgafbaaa
aaaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaaigadbaaaaaaaaaaaegbcbaaa
adaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaa
imaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 8 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[2], 2D;
MUL R0, R0, c[0];
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, c[1].x;
MOV result.color.w, R0;
END
# 7 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s2
def c1, 8.00000000, 0, 0, 0
dcl t0.xy
dcl t1.xy
texld r1, t0, s0
texld r0, t1, s2
mul_pp r1, r1, c0
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c1.x
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 128
Vector 48 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedeofcialfdghdigdbmfmigakgflliolgkabaaaaaadeacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfmabaaaaeaaaaaaafhaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaaiiccabaaaaaaaaaaa
dkaabaaaabaaaaaadkiacaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 128
Vector 48 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedmbjhohjbogchecbahfggkflifkoobfjhabaaaaaaeeadaaaaaeaaaaaa
daaaaaaadmabaaaakaacaaaabaadaaaaebgpgodjaeabaaaaaeabaaaaaaacpppp
mmaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaadaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaeb
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaacpiaabaaoelaabaioekaecaaaaadabaacpiaaaaaoelaaaaioekaafaaaaad
aaaaciiaaaaappiaabaaaakaafaaaaadaaaachiaaaaaoeiaaaaappiaafaaaaad
abaachiaabaaoeiaaaaaoekaafaaaaadacaaciiaabaappiaaaaappkaafaaaaad
acaachiaaaaaoeiaabaaoeiaabaaaaacaaaicpiaacaaoeiappppaaaafdeieefc
fmabaaaaeaaaaaaafhaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaeb
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
diaaaaaiiccabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaadaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapadaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
"!!ARBfp1.0
PARAM c[7] = { program.local[0..2],
		{ 2, 1, 8, 0 },
		{ -0.40824828, -0.70710677, 0.57735026, 128 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1, fragment.texcoord[1], texture[2], 2D;
TEX R2, fragment.texcoord[1], texture[3], 2D;
TEX R3.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MAD R3.xy, R3.wyzw, c[3].x, -c[3].y;
MUL R2.xyz, R2.w, R2;
MUL R2.xyz, R2, c[3].z;
MUL R4.xyz, R2.y, c[5];
MAD R4.xyz, R2.x, c[6], R4;
MAD R4.xyz, R2.z, c[4], R4;
DP3 R2.w, R4, R4;
RSQ R2.w, R2.w;
MUL R4.xyz, R2.w, R4;
MUL R3.zw, R3.xyxy, R3.xyxy;
ADD_SAT R3.z, R3, R3.w;
MUL R1.xyz, R1.w, R1;
DP3 R2.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R2.w, R2.w;
MAD R4.xyz, R2.w, fragment.texcoord[2], R4;
MOV R1.w, c[4];
DP3 R2.w, R4, R4;
ADD R3.w, -R3.z, c[3].y;
RSQ R3.z, R2.w;
MUL R4.xyz, R3.z, R4;
RSQ R2.w, R3.w;
RCP R3.z, R2.w;
DP3 R2.w, R3, R4;
MAX R2.w, R2, c[3];
MUL R1.w, R1, c[2].x;
DP3_SAT R4.z, R3, c[4];
DP3_SAT R4.x, R3, c[6];
DP3_SAT R4.y, R3, c[5];
DP3 R2.x, R4, R2;
MUL R1.xyz, R1, R2.x;
MUL R1.xyz, R1, c[3].z;
MUL R2.xyz, R1, c[0];
MUL R2.xyz, R0.w, R2;
MUL R0, R0, c[1];
POW R1.w, R2.w, R1.w;
MUL R2.xyz, R2, R1.w;
MAD result.color.xyz, R0, R1, R2;
MOV result.color.w, R0;
END
# 42 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c3, 2.00000000, -1.00000000, 1.00000000, 8.00000000
def c4, -0.40824828, -0.70710677, 0.57735026, 0.00000000
def c5, -0.40824831, 0.70710677, 0.57735026, 128.00000000
def c6, 0.81649655, 0.00000000, 0.57735026, 0
dcl t0
dcl t1.xy
dcl t2.xyz
texld r1, t0, s0
texld r2, t1, s2
texld r3, t1, s3
mul_pp r3.xyz, r3.w, r3
mul_pp r3.xyz, r3, c3.w
mul r4.xyz, r3.y, c5
mad r4.xyz, r3.x, c6, r4
mul_pp r2.xyz, r2.w, r2
mad r4.xyz, r3.z, c4, r4
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s1
dp3 r0.x, r4, r4
rsq r0.x, r0.x
mul r4.xyz, r0.x, r4
mov r0.x, r0.w
mad_pp r6.xy, r0, c3.x, c3.y
dp3_pp r0.x, t2, t2
rsq_pp r0.x, r0.x
mad_pp r0.xyz, r0.x, t2, r4
mul_pp r5.xy, r6, r6
add_pp_sat r4.x, r5, r5.y
dp3_pp r5.x, r0, r0
rsq_pp r5.x, r5.x
add_pp r4.x, -r4, c3.z
rsq_pp r4.x, r4.x
rcp_pp r6.z, r4.x
mul_pp r0.xyz, r5.x, r0
dp3_pp r0.x, r6, r0
mov_pp r4.x, c2
max_pp r0.x, r0, c4.w
mul_pp r4.x, c5.w, r4
pow r5.x, r0.x, r4.x
dp3_pp_sat r0.z, r6, c4
dp3_pp_sat r0.y, r6, c5
dp3_pp_sat r0.x, r6, c6
dp3_pp r0.x, r0, r3
mul_pp r0.xyz, r2, r0.x
mul_pp r0.xyz, r0, c3.w
mul_pp r3.xyz, r0, c0
mul_pp r3.xyz, r1.w, r3
mul_pp r1, r1, c1
mov r2.x, r5.x
mul r2.xyz, r3, r2.x
mad_pp r0.xyz, r1, r0, r2
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 128
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0
eefiecedaonafhfdpcejahkemiincifjhfelamolabaaaaaaniagaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcoiafaaaaeaaaaaaahkabaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaakhcaabaaa
acaaaaaafgafbaaaabaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaa
dcaaaaamhcaabaaaacaaaaaaagaabaaaabaaaaaaaceaaaaaolaffbdpaaaaaaaa
dkmnbddpaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaacaaaaaakgakbaaa
abaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaapcaaaakbcaabaaaadaaaaaaaceaaaaaolaffbdpdkmnbddp
aaaaaaaaaaaaaaaaigaabaaaacaaaaaabacaaaakccaabaaaadaaaaaaaceaaaaa
omafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaacaaaaaabacaaaakecaabaaa
adaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
diaaaaahecaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaadiaaaaahocaabaaa
aaaaaaaafgafbaaaaaaaaaaaagajbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
jgahbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaa
egacbaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaadiaaaaaiiccabaaaaaaaaaaa
dkaabaaaacaaaaaadkiacaaaaaaaaaaaadaaaaaadiaaaaahocaabaaaaaaaaaaa
fgaobaaaaaaaaaaaagajbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 128
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedlpimopblfneheehginfliemjjbdhfcbnabaaaaaagiakaaaaaeaaaaaa
daaaaaaalmadaaaakmajaaaadeakaaaaebgpgodjieadaaaaieadaaaaaaacpppp
eeadaaaaeaaaaaaaabaadeaaaaaaeaaaaaaaeaaaaeaaceaaaaaaeaaaaaaaaaaa
abababaaacacacaaadadadaaaaaaacaaadaaaaaaaaaaaaaaaaacppppfbaaaaaf
adaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafaeaaapkaomafnblo
pdaedfdpdkmnbddpaaaaaaedfbaaaaafafaaapkaolafnblopdaedflpdkmnbddp
aaaaaaaafbaaaaafagaaapkaaaaaaaebdkmnbddpaaaaaaaaolaffbdpbpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaachla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkaabaaaaacaaaaabiaaaaakklaabaaaaac
aaaaaciaaaaapplaecaaaaadabaacpiaabaaoelaadaioekaecaaaaadaaaacpia
aaaaoeiaabaioekaecaaaaadacaacpiaabaaoelaacaioekaecaaaaadadaacpia
aaaaoelaaaaioekaafaaaaadabaaciiaabaappiaagaaaakaafaaaaadabaachia
abaaoeiaabaappiaafaaaaadaeaaahiaabaaffiaaeaaoekaaeaaaaaeaeaaahia
abaaaaiaagaablkaaeaaoeiaaeaaaaaeaeaaahiaabaakkiaafaaoekaaeaaoeia
aiaaaaadabaaaiiaaeaaoeiaaeaaoeiaahaaaaacabaaaiiaabaappiaceaaaaac
afaachiaacaaoelaaeaaaaaeaeaachiaaeaaoeiaabaappiaafaaoeiaceaaaaac
afaachiaaeaaoeiaaeaaaaaeaeaacbiaaaaappiaadaaaakaadaaffkaaeaaaaae
aeaacciaaaaaffiaadaaaakaadaaffkafkaaaaaeabaadiiaaeaaoeiaaeaaoeia
adaakkkaacaaaaadabaaciiaabaappibadaappkaahaaaaacabaaciiaabaappia
agaaaaacaeaaceiaabaappiaaiaaaaadabaaciiaaeaaoeiaafaaoeiaalaaaaad
aeaaaiiaabaappiaadaakkkaabaaaaacabaaaiiaaeaappkaafaaaaadabaaaiia
abaappiaacaaaakacaaaaaadaaaacbiaaeaappiaabaappiaaiaaaaadafaadbia
agaablkaaeaaoeiaaiaaaaadafaadciaaeaaoekaaeaaoeiaaiaaaaadafaadeia
afaaoekaaeaaoeiaaiaaaaadaaaacciaafaaoeiaabaaoeiaafaaaaadacaaciia
acaappiaagaaaakaafaaaaadabaachiaacaaoeiaacaappiaafaaaaadaaaacoia
aaaaffiaabaabliaafaaaaadabaachiaaaaabliaaaaaoekaafaaaaadabaaahia
adaappiaabaaoeiaafaaaaadacaachiaadaaoeiaabaaoekaafaaaaadadaaciia
adaappiaabaappkaafaaaaadaaaacoiaaaaaoeiaacaabliaaeaaaaaeadaachia
abaaoeiaaaaaaaiaaaaabliaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefc
oiafaaaaeaaaaaaahkabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaadiaaaaakhcaabaaaacaaaaaafgafbaaaabaaaaaa
aceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaadcaaaaamhcaabaaaacaaaaaa
agaabaaaabaaaaaaaceaaaaaolaffbdpaaaaaaaadkmnbddpaaaaaaaaegacbaaa
acaaaaaadcaaaaamhcaabaaaacaaaaaakgakbaaaabaaaaaaaceaaaaaolafnblo
pdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
acaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaaakiacaaaaaaaaaaa
aeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaapcaaaak
bcaabaaaadaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaa
acaaaaaabacaaaakccaabaaaadaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddp
aaaaaaaaegacbaaaacaaaaaabacaaaakecaabaaaadaaaaaaaceaaaaaolafnblo
pdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaakgakbaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaa
agajbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaajgahbaaaaaaaaaaaegiccaaa
aaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
aaaaaaaaadaaaaaadiaaaaaiiccabaaaaaaaaaaadkaabaaaacaaaaaadkiacaaa
aaaaaaaaadaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
acaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 2, 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TXP R3.x, fragment.texcoord[4], texture[2], 2D;
MAD R2.xy, R2.wyzw, c[4].x, -c[4].y;
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
MUL R2.zw, R2.xyxy, R2.xyxy;
MUL R0.xyz, R0, c[2];
RSQ R1.w, R1.w;
MOV R1.xyz, fragment.texcoord[1];
MAD R1.xyz, R1.w, fragment.texcoord[3], R1;
ADD_SAT R1.w, R2.z, R2;
DP3 R2.z, R1, R1;
RSQ R2.z, R2.z;
ADD R1.w, -R1, c[4].y;
MUL R1.xyz, R2.z, R1;
RSQ R1.w, R1.w;
RCP R2.z, R1.w;
DP3 R1.x, R2, R1;
MOV R1.w, c[4];
DP3 R2.x, R2, fragment.texcoord[1];
MAX R3.y, R2.x, c[4].z;
MUL R2.xyz, R0, c[0];
MUL R2.xyz, R2, R3.y;
MUL R1.y, R1.w, c[3].x;
MAX R1.x, R1, c[4].z;
POW R1.x, R1.x, R1.y;
MUL R2.w, R0, R1.x;
MOV R1, c[1];
MUL R1.xyz, R1, c[0];
MUL R3.y, R3.x, c[4].x;
MAD R1.xyz, R1, R2.w, R2;
MUL R1.xyz, R1, R3.y;
MAD result.color.xyz, R0, fragment.texcoord[2], R1;
MUL R0.x, R1.w, c[0].w;
MUL R0.y, R0.w, c[2].w;
MUL R0.x, R2.w, R0;
MAD result.color.w, R3.x, R0.x, R0.y;
END
# 37 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c5, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4
texldp r5, t4, s2
texld r2, t0, s0
dp3_pp r1.x, t3, t3
rsq_pp r1.x, r1.x
mov_pp r4.xyz, t1
mad_pp r4.xyz, r1.x, t3, r4
dp3_pp r1.x, r4, r4
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, r4
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s1
mov r0.x, r0.w
mad_pp r3.xy, r0, c4.x, c4.y
mul_pp r0.xy, r3, r3
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c4.z
rsq_pp r0.x, r0.x
rcp_pp r3.z, r0.x
dp3_pp r1.x, r3, r1
mov_pp r0.x, c3
mul_pp r0.x, c5, r0
max_pp r1.x, r1, c4.w
pow r4.w, r1.x, r0.x
dp3_pp r1.x, r3, t1
mul_pp r3.xyz, r2, c2
mov r0.x, r4.w
mul r0.x, r2.w, r0
max_pp r1.x, r1, c4.w
mul_pp r2.xyz, r3, c0
mul_pp r2.xyz, r2, r1.x
mov_pp r1.xyz, c0
mul_pp r1.xyz, c1, r1
mad r2.xyz, r1, r0.x, r2
mul_pp r1.x, r5, c4
mul r4.xyz, r2, r1.x
mov_pp r0.w, c0
mul_pp r1.x, c1.w, r0.w
mul r0.x, r0, r1
mul_pp r2.x, r2.w, c2.w
mad r0.w, r5.x, r0.x, r2.x
mad_pp r0.xyz, r3, t2, r4
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlhiflenhlibeoedggdnfimpkejacfnjiabaaaaaaleafaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjeaeaaaa
eaaaaaaacfabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
lcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaaeaaaaaa
agaabaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
dcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaa
dkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaacaaaaaa
deaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
ecaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkaabaaaabaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egiocaaaaaaaaaaaahaaaaaadiaaaaajpcaabaaaacaaaaaaegiocaaaaaaaaaaa
abaaaaaaegiocaaaaaaaaaaaacaaaaaadiaaaaahpcaabaaaacaaaaaaagaabaaa
aaaaaaaaegaobaaaacaaaaaadiaaaaaincaabaaaaaaaaaaaagajbaaaabaaaaaa
agijcaaaaaaaaaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaigadbaaaaaaaaaaa
fgafbaaaaaaaaaaaegacbaaaacaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaa
afaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaa
adaaaaaaakaabaaaadaaaaaadcaaaaajiccabaaaaaaaaaaadkaabaaaacaaaaaa
akaabaaaadaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegbcbaaaadaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedfclkoloeaibblpelikacdgjngcgmildjabaaaaaabaajaaaaaeaaaaaa
daaaaaaaiiadaaaaceaiaaaanmaiaaaaebgpgodjfaadaaaafaadaaaaaaacpppp
aiadaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaacaaaaaa
aaababaaabacacaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaacaaacaaaaaaaaaa
aaacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaaf
afaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaia
adaachlabpaaaaacaaaaaaiaaeaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaabaaaaacaaaaabiaaaaakkla
abaaaaacaaaaaciaaaaapplaagaaaaacaaaaaeiaaeaapplaafaaaaadabaaadia
aaaakkiaaeaaoelaecaaaaadaaaacpiaaaaaoeiaacaioekaecaaaaadacaacpia
aaaaoelaabaioekaecaaaaadabaacpiaabaaoeiaaaaioekaaeaaaaaeadaacbia
aaaappiaaeaaaakaaeaaffkaaeaaaaaeadaacciaaaaaffiaaeaaaakaaeaaffka
fkaaaaaeadaadiiaadaaoeiaadaaoeiaaeaakkkaacaaaaadadaaciiaadaappib
aeaappkaahaaaaacadaaciiaadaappiaagaaaaacadaaceiaadaappiaaiaaaaad
adaaciiaadaaoeiaabaaoelaalaaaaadaaaacbiaadaappiaaeaakkkaaiaaaaad
adaaciiaadaaoelaadaaoelaahaaaaacadaaciiaadaappiaabaaaaacaeaaahia
adaaoelaaeaaaaaeaeaachiaaeaaoeiaadaappiaabaaoelaceaaaaacafaachia
aeaaoeiaaiaaaaadaaaacciaadaaoeiaafaaoeiaalaaaaadabaaaciaaaaaffia
aeaakkkaabaaaaacadaaabiaadaaaakaafaaaaadaaaaaciaadaaaaiaafaaaaka
caaaaaadadaaabiaabaaffiaaaaaffiaafaaaaadaaaaaciaacaappiaadaaaaia
abaaaaacadaaapiaaaaaoekaafaaaaadabaaaoiaadaabliaabaablkaafaaaaad
abaaaoiaaaaaffiaabaaoeiaafaaaaadacaachiaacaaoeiaacaaoekaafaaaaad
adaachiaacaaoeiaaaaaoekaafaaaaadacaachiaacaaoeiaacaaoelaaeaaaaae
abaaaoiaadaabliaaaaaaaiaabaaoeiaacaaaaadaaaaabiaabaaaaiaabaaaaia
aeaaaaaeaeaachiaabaabliaaaaaaaiaacaaoeiaafaaaaadaaaaabiaadaappia
abaappkaafaaaaadaaaaabiaaaaaffiaaaaaaaiaafaaaaadaaaaabiaabaaaaia
aaaaaaiaaeaaaaaeaeaaciiaacaappiaacaappkaaaaaaaiaabaaaaacaaaicpia
aeaaoeiappppaaaafdeieefcjeaeaaaaeaaaaaaacfabaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaeaaaaaa
egbcbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegbcbaaaaeaaaaaaagaabaaaaaaaaaaaegbcbaaaacaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaabaaaaaahgapbaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaa
egaabaaaabaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaabaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaa
egacbaaaabaaaaaaegbcbaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaahaaaaaadiaaaaaj
pcaabaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaaegiocaaaaaaaaaaaacaaaaaa
diaaaaahpcaabaaaacaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaadiaaaaai
ncaabaaaaaaaaaaaagajbaaaabaaaaaaagijcaaaaaaaaaaaabaaaaaadcaaaaaj
hcaabaaaaaaaaaaaigadbaaaaaaaaaaafgafbaaaaaaaaaaaegacbaaaacaaaaaa
aoaaaaahdcaabaaaacaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaa
aaaaaaahicaabaaaaaaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaaj
iccabaaaaaaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegbcbaaaadaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
doaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2, fragment.texcoord[1], texture[3], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TXP R3.x, fragment.texcoord[2], texture[2], 2D;
MUL R1.xyz, R2.w, R2;
MUL R2.xyz, R2, R3.x;
MUL R1.xyz, R1, c[1].x;
MUL R0, R0, c[0];
MUL R3.xyz, R1, R3.x;
MUL R2.xyz, R2, c[1].y;
MIN R1.xyz, R1, R2;
MAX R1.xyz, R1, R3;
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 13 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"ps_2_0
dcl_2d s0
dcl_2d s2
dcl_2d s3
def c1, 8.00000000, 2.00000000, 0, 0
dcl t0.xy
dcl t1.xy
dcl t2
texld r1, t0, s0
texldp r3, t2, s2
texld r0, t1, s3
mul_pp r2.xyz, r0, r3.x
mul_pp r0.xyz, r0.w, r0
mul_pp r1, r1, c0
mul_pp r0.xyz, r0, c1.x
mul_pp r2.xyz, r2, c1.y
min_pp r2.xyz, r0, r2
mul_pp r0.xyz, r0, r3.x
max_pp r0.xyz, r2, r0
mul_pp r0.xyz, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 192
Vector 112 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkhbpnikkpabbbamfgjcflplcnmllhhicabaaaaaaeaadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfaacaaaaeaaaaaaajeaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahocaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaaddaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
deaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaahaaaaaa
diaaaaaiiccabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaahaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 192
Vector 112 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefieceddjekcmlngichokcdidhlgpgfiimjklndabaaaaaaoiaeaaaaaeaaaaaa
daaaaaaaneabaaaacmaeaaaaleaeaaaaebgpgodjjmabaaaajmabaaaaaaacpppp
gaabaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaabaaaaaa
aaababaaacacacaaaaaaahaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapka
aaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaadlabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaagaaaaacaaaaaiia
acaapplaafaaaaadaaaaadiaaaaappiaacaaoelaecaaaaadaaaacpiaaaaaoeia
aaaioekaecaaaaadabaacpiaabaaoelaacaioekaecaaaaadacaacpiaaaaaoela
abaioekaacaaaaadaaaacciaaaaaaaiaaaaaaaiaafaaaaadaaaacoiaabaablia
aaaaffiaafaaaaadabaaciiaabaappiaabaaaakaafaaaaadabaachiaabaaoeia
abaappiaakaaaaadadaachiaaaaabliaabaaoeiaafaaaaadaaaachiaaaaaaaia
abaaoeiaalaaaaadabaachiaadaaoeiaaaaaoeiaafaaaaadaaaachiaacaaoeia
aaaaoekaafaaaaadacaaciiaacaappiaaaaappkaafaaaaadacaachiaabaaoeia
aaaaoeiaabaaaaacaaaicpiaacaaoeiappppaaaafdeieefcfaacaaaaeaaaaaaa
jeaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
aaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
diaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaaabaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaddaaaaahocaabaaaaaaaaaaa
fgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadeaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaahaaaaaadiaaaaaiiccabaaaaaaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaahaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"!!ARBfp1.0
PARAM c[7] = { program.local[0..2],
		{ 2, 1, 8, 0 },
		{ -0.40824828, -0.70710677, 0.57735026, 128 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R3, fragment.texcoord[1], texture[4], 2D;
TEX R1, fragment.texcoord[1], texture[3], 2D;
TXP R5.x, fragment.texcoord[3], texture[2], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R3.xyz, R3.w, R3;
MUL R3.xyz, R3, c[3].z;
MUL R4.xyz, R3.y, c[5];
MAD R4.xyz, R3.x, c[6], R4;
MAD R4.xyz, R3.z, c[4], R4;
DP3 R2.x, R4, R4;
RSQ R2.z, R2.x;
MAD R2.xy, R2.wyzw, c[3].x, -c[3].y;
MUL R4.xyz, R2.z, R4;
MUL R2.zw, R2.xyxy, R2.xyxy;
ADD_SAT R2.w, R2.z, R2;
DP3 R3.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R2.z, R3.w;
MAD R4.xyz, R2.z, fragment.texcoord[2], R4;
ADD R2.w, -R2, c[3].y;
DP3 R2.z, R4, R4;
RSQ R3.w, R2.w;
RSQ R2.w, R2.z;
RCP R2.z, R3.w;
DP3_SAT R5.w, R2, c[4];
DP3_SAT R5.y, R2, c[6];
DP3_SAT R5.z, R2, c[5];
MUL R4.xyz, R2.w, R4;
DP3 R2.w, R5.yzww, R3;
MUL R3.xyz, R1.w, R1;
MUL R1.xyz, R1, R5.x;
DP3 R1.w, R2, R4;
MUL R3.xyz, R3, R2.w;
MUL R3.xyz, R3, c[3].z;
MUL R5.yzw, R1.xxyz, c[3].x;
MUL R1.xyz, R3, R5.x;
MIN R5.xyz, R3, R5.yzww;
MOV R2.x, c[4].w;
MAX R2.w, R1, c[3];
MUL R1.w, R2.x, c[2].x;
MUL R2.xyz, R3, c[0];
MUL R2.xyz, R0.w, R2;
MUL R0, R0, c[1];
POW R1.w, R2.w, R1.w;
MAX R1.xyz, R5, R1;
MUL R2.xyz, R2, R1.w;
MAD result.color.xyz, R0, R1, R2;
MOV result.color.w, R0;
END
# 48 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c3, 2.00000000, -1.00000000, 1.00000000, 8.00000000
def c4, -0.40824828, -0.70710677, 0.57735026, 0.00000000
def c5, -0.40824831, 0.70710677, 0.57735026, 128.00000000
def c6, 0.81649655, 0.00000000, 0.57735026, 0
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t3
texldp r2, t3, s2
texld r1, t0, s0
texld r3, t1, s3
texld r4, t1, s4
mul_pp r4.xyz, r4.w, r4
mul_pp r4.xyz, r4, c3.w
mul r5.xyz, r4.y, c5
mad r5.xyz, r4.x, c6, r5
mad r5.xyz, r4.z, c4, r5
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s1
dp3 r0.x, r5, r5
rsq r0.x, r0.x
mul r5.xyz, r0.x, r5
mov r0.x, r0.w
mad_pp r7.xy, r0, c3.x, c3.y
dp3_pp r0.x, t2, t2
rsq_pp r0.x, r0.x
mad_pp r0.xyz, r0.x, t2, r5
mul_pp r6.xy, r7, r7
add_pp_sat r5.x, r6, r6.y
dp3_pp r6.x, r0, r0
rsq_pp r6.x, r6.x
add_pp r5.x, -r5, c3.z
rsq_pp r5.x, r5.x
rcp_pp r7.z, r5.x
mul_pp r0.xyz, r6.x, r0
dp3_pp r0.x, r7, r0
mov_pp r5.x, c2
max_pp r0.x, r0, c4.w
mul_pp r5.x, c5.w, r5
pow r6.x, r0.x, r5.x
dp3_pp_sat r0.z, r7, c4
dp3_pp_sat r0.y, r7, c5
dp3_pp_sat r0.x, r7, c6
dp3_pp r0.x, r0, r4
mul_pp r4.xyz, r3.w, r3
mul_pp r3.xyz, r3, r2.x
mul_pp r0.xyz, r4, r0.x
mul_pp r0.xyz, r0, c3.w
mul_pp r3.xyz, r3, c3.x
min_pp r3.xyz, r0, r3
mul_pp r2.xyz, r0, r2.x
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r1.w, r0
mul_pp r1, r1, c1
max_pp r2.xyz, r3, r2
mov r3.x, r6.x
mul r0.xyz, r0, r3.x
mad_pp r0.xyz, r1, r2, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 192
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0
eefieceddiailhnfhfcbcobhdpapfdfokidphabfabaaaaaaoeahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcnmagaaaaeaaaaaaalhabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaakhcaabaaa
acaaaaaafgafbaaaabaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaa
dcaaaaamhcaabaaaacaaaaaaagaabaaaabaaaaaaaceaaaaaolaffbdpaaaaaaaa
dkmnbddpaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaacaaaaaakgakbaaa
abaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaapcaaaakbcaabaaaadaaaaaaaceaaaaaolaffbdpdkmnbddp
aaaaaaaaaaaaaaaaigaabaaaacaaaaaabacaaaakccaabaaaadaaaaaaaceaaaaa
omafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaacaaaaaabacaaaakecaabaaa
adaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaa
diaaaaahecaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaacaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaadiaaaaahocaabaaa
aaaaaaaafgafbaaaaaaaaaaaagajbaaaacaaaaaaaoaaaaahdcaabaaaacaaaaaa
egbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaabaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaajgahbaaa
aaaaaaaaagaabaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaaddaaaaahhcaabaaaabaaaaaajgahbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaaagijcaaaaaaaaaaa
acaaaaaadeaaaaahhcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
ahaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaapgapbaaaacaaaaaadiaaaaai
iccabaaaaaaaaaaadkaabaaaacaaaaaadkiacaaaaaaaaaaaahaaaaaadcaaaaaj
hccabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 192
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedflplafcaaghjfpdkdlddphjmnoonooihabaaaaaabiamaaaaaeaaaaaa
daaaaaaagaaeaaaaeealaaaaoealaaaaebgpgodjciaeaaaaciaeaaaaaaacpppp
niadaaaafaaaaaaaacaadiaaaaaafaaaaaaafaaaafaaceaaaaaafaaaacaaaaaa
aaababaaabacacaaadadadaaaeaeaeaaaaaaacaaabaaaaaaaaaaaaaaaaaaahaa
acaaabaaaaaaaaaaaaacppppfbaaaaafadaaapkaaaaaaaeaaaaaialpaaaaaaaa
aaaaiadpfbaaaaafaeaaapkaaaaaaaebdkmnbddpaaaaaaaaolaffbdpfbaaaaaf
afaaapkaomafnblopdaedfdpdkmnbddpaaaaaaedfbaaaaafagaaapkaolafnblo
pdaedflpdkmnbddpaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaaadlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapka
bpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkaabaaaaacaaaaabia
aaaakklaabaaaaacaaaaaciaaaaapplaagaaaaacaaaaaeiaadaapplaafaaaaad
abaaadiaaaaakkiaadaaoelaecaaaaadaaaacpiaaaaaoeiaacaioekaecaaaaad
acaacpiaabaaoelaaeaioekaecaaaaadadaacpiaabaaoelaadaioekaecaaaaad
abaacpiaabaaoeiaaaaioekaecaaaaadaeaacpiaaaaaoelaabaioekaaeaaaaae
afaacbiaaaaappiaadaaaakaadaaffkaaeaaaaaeafaacciaaaaaffiaadaaaaka
adaaffkafkaaaaaeafaadiiaafaaoeiaafaaoeiaadaakkkaacaaaaadafaaciia
afaappibadaappkaahaaaaacafaaciiaafaappiaagaaaaacafaaceiaafaappia
aiaaaaadaaaadbiaaeaablkaafaaoeiaaiaaaaadaaaadciaafaaoekaafaaoeia
aiaaaaadaaaadeiaagaaoekaafaaoeiaafaaaaadaaaaciiaacaappiaaeaaaaka
afaaaaadacaachiaacaaoeiaaaaappiaaiaaaaadacaaciiaaaaaoeiaacaaoeia
afaaaaadadaaciiaadaappiaaeaaaakaafaaaaadaaaachiaadaaoeiaadaappia
afaaaaadaaaachiaacaappiaaaaaoeiaacaaaaadaaaaciiaabaaaaiaabaaaaia
afaaaaadabaachiaabaaaaiaaaaaoeiaafaaaaadadaachiaadaaoeiaaaaappia
akaaaaadagaachiaadaaoeiaaaaaoeiaafaaaaadaaaachiaaaaaoeiaaaaaoeka
alaaaaadadaachiaagaaoeiaabaaoeiaafaaaaadabaachiaaeaaoeiaabaaoeka
afaaaaadabaachiaadaaoeiaabaaoeiaafaaaaadadaaahiaacaaffiaafaaoeka
aeaaaaaeadaaahiaacaaaaiaaeaablkaadaaoeiaaeaaaaaeacaaahiaacaakkia
agaaoekaadaaoeiaaiaaaaadaaaaaiiaacaaoeiaacaaoeiaahaaaaacaaaaaiia
aaaappiaceaaaaacadaachiaacaaoelaaeaaaaaeacaachiaacaaoeiaaaaappia
adaaoeiaceaaaaacadaachiaacaaoeiaaiaaaaadaaaaciiaafaaoeiaadaaoeia
alaaaaadabaaaiiaaaaappiaadaakkkaabaaaaacaaaaaiiaafaappkaafaaaaad
aaaaaiiaaaaappiaacaaaakacaaaaaadacaacbiaabaappiaaaaappiaafaaaaad
aaaaahiaaeaappiaaaaaoeiaafaaaaadadaaciiaaeaappiaabaappkaaeaaaaae
adaachiaaaaaoeiaacaaaaiaabaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaa
fdeieefcnmagaaaaeaaaaaaalhabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaakhcaabaaa
acaaaaaafgafbaaaabaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaa
dcaaaaamhcaabaaaacaaaaaaagaabaaaabaaaaaaaceaaaaaolaffbdpaaaaaaaa
dkmnbddpaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaacaaaaaakgakbaaa
abaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaapcaaaakbcaabaaaadaaaaaaaceaaaaaolaffbdpdkmnbddp
aaaaaaaaaaaaaaaaigaabaaaacaaaaaabacaaaakccaabaaaadaaaaaaaceaaaaa
omafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaacaaaaaabacaaaakecaabaaa
adaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaa
diaaaaahecaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaacaaaaaaegacbaaaabaaaaaakgakbaaaaaaaaaaadiaaaaahocaabaaa
aaaaaaaafgafbaaaaaaaaaaaagajbaaaacaaaaaaaoaaaaahdcaabaaaacaaaaaa
egbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaabaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaajgahbaaa
aaaaaaaaagaabaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaaddaaaaahhcaabaaaabaaaaaajgahbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaaagijcaaaaaaaaaaa
acaaaaaadeaaaaahhcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaa
ahaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaapgapbaaaacaaaaaadiaaaaai
iccabaaaaaaaaaaadkaabaaaacaaaaaadkiacaaaaaaaaaaaahaaaaaadcaaaaaj
hccabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
doaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
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
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
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
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 34 instructions, 4 R-regs
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
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_2_0
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
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
dp3 oT1.y, r0, r2
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT2.y, r2, r3
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mad oT0.zw, v3.xyxy, c20.xyxy, c20
mad oT0.xy, v3, c19, c19.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
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
eefiecedccfkfopdfpaobpeododkohcedchnnokcabaaaaaaceahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiafaaaaeaaaabaa
gcabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaa
kgiocaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
acaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
adaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
aeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
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
"vs_4_0_level_9_1
eefiecedglfmblgekmphjihfmafddmepplhjlfkdabaaaaaahiakaaaaaeaaaaaa
daaaaaaaiaadaaaabaajaaaaniajaaaaebgpgodjeiadaaaaeiadaaaaaaacpopp
niacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
aeaaabaaaaaaaaaaaaaaajaaacaaafaaaaaaaaaaabaaaeaaabaaahaaaaaaaaaa
acaaaaaaabaaaiaaaaaaaaaaadaaaaaaaeaaajaaaaaaaaaaadaaamaaajaaanaa
aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoaadaaeejaagaaeeka
agaaoekaabaaaaacaaaaapiaaiaaoekaafaaaaadabaaahiaaaaaffiabcaaoeka
aeaaaaaeabaaahiabbaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabdaaoeka
aaaakkiaabaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaappiaaaaaoeiaaeaaaaae
aaaaahiaaaaaoeiabfaappkaaaaaoejbaiaaaaadabaaaboaabaaoejaaaaaoeia
abaaaaacabaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaae
abaaahiaacaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappja
aiaaaaadabaaacoaabaaoeiaaaaaoeiaaiaaaaadabaaaeoaacaaoejaaaaaoeia
abaaaaacaaaaahiaahaaoekaafaaaaadacaaahiaaaaaffiabcaaoekaaeaaaaae
aaaaaliabbaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiabdaaoekaaaaakkia
aaaapeiaacaaaaadaaaaahiaaaaaoeiabeaaoekaaeaaaaaeaaaaahiaaaaaoeia
bfaappkaaaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaaiaaaaadacaaacoa
abaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapia
aaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaappja
aaaaoeiaafaaaaadabaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoeka
aaaaaaiaabaaoeiaaeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaae
adaaahoaaeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaakaaoeka
aeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefciiafaaaaeaaaabaagcabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaa
ogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
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
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Vector 11 [unity_Scale]
Vector 12 [_MainTex_ST]
Vector 13 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[14] = { { 1 },
		state.matrix.mvp,
		program.local[5..13] };
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
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[13].xyxy, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[12], c[12].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 26 instructions, 4 R-regs
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
Vector 11 [_MainTex_ST]
Vector 12 [_BumpMap_ST]
"vs_2_0
def c13, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c13.x
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
dp3 oT1.y, r4, r2
dp3 oT2.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
mad oT0.zw, v3.xyxy, c12.xyxy, c12
mad oT0.xy, v3, c11, c11.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 112
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
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
eefiecedilmfnpikeflakedanncpadbknlhigcmiabaaaaaakeafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
caaeaaaaeaaaabaaaiabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaa
aaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 112
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
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
"vs_4_0_level_9_1
eefiecedjpofmdlndpbdaoofdgcolcjdbclelkafabaaaaaaeaaiaaaaaeaaaaaa
daaaaaaamiacaaaapaagaaaaliahaaaaebgpgodjjaacaaaajaacaaaaaaacpopp
cmacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaafaa
acaaabaaaaaaaaaaabaaaeaaabaaadaaaaaaaaaaacaaaaaaabaaaeaaaaaaaaaa
adaaaaaaaeaaafaaaaaaaaaaadaabaaaafaaajaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoeka
abaaookaaeaaaaaeaaaaamoaadaaeejaacaaeekaacaaoekaabaaaaacaaaaapia
aeaaoekaafaaaaadabaaahiaaaaaffiaakaaoekaaeaaaaaeabaaahiaajaaoeka
aaaaaaiaabaaoeiaaeaaaaaeaaaaahiaalaaoekaaaaakkiaabaaoeiaaeaaaaae
aaaaahiaamaaoekaaaaappiaaaaaoeiaaiaaaaadabaaaboaabaaoejaaaaaoeia
abaaaaacabaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaae
abaaahiaacaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappja
aiaaaaadabaaacoaabaaoeiaaaaaoeiaaiaaaaadabaaaeoaacaaoejaaaaaoeia
abaaaaacaaaaahiaadaaoekaafaaaaadacaaahiaaaaaffiaakaaoekaaeaaaaae
aaaaaliaajaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiaalaaoekaaaaakkia
aaaapeiaacaaaaadaaaaahiaaaaaoeiaamaaoekaaeaaaaaeaaaaahiaaaaaoeia
anaappkaaaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaaiaaaaadacaaacoa
abaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapia
aaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiappppaaaafdeieefccaaeaaaaeaaaabaaaiabaaaafjaaaaaeegiocaaa
aaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
aaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
adaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
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
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
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
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].w, R0, c[16];
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
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
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_2_0
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
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
dp3 oT1.y, r0, r2
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT2.y, r2, r3
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
dp4 oT3.w, r0, c15
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mad oT0.zw, v3.xyxy, c20.xyxy, c20
mad oT0.xy, v3, c19, c19.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
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
eefiecedpcdamidoddoccgdgmmpngiplnmipkbeiabaaaaaaceahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiafaaaaeaaaabaa
gcabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaa
kgiocaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
acaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
adaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
aeaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
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
"vs_4_0_level_9_1
eefiecedpmfjemkficildkgcfaicadpplelkgmedabaaaaaahiakaaaaaeaaaaaa
daaaaaaaiaadaaaabaajaaaaniajaaaaebgpgodjeiadaaaaeiadaaaaaaacpopp
niacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
aeaaabaaaaaaaaaaaaaaajaaacaaafaaaaaaaaaaabaaaeaaabaaahaaaaaaaaaa
acaaaaaaabaaaiaaaaaaaaaaadaaaaaaaeaaajaaaaaaaaaaadaaamaaajaaanaa
aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoaadaaeejaagaaeeka
agaaoekaabaaaaacaaaaapiaaiaaoekaafaaaaadabaaahiaaaaaffiabcaaoeka
aeaaaaaeabaaahiabbaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabdaaoeka
aaaakkiaabaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaappiaaaaaoeiaaeaaaaae
aaaaahiaaaaaoeiabfaappkaaaaaoejbaiaaaaadabaaaboaabaaoejaaaaaoeia
abaaaaacabaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaae
abaaahiaacaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappja
aiaaaaadabaaacoaabaaoeiaaaaaoeiaaiaaaaadabaaaeoaacaaoejaaaaaoeia
abaaaaacaaaaahiaahaaoekaafaaaaadacaaahiaaaaaffiabcaaoekaaeaaaaae
aaaaaliabbaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiabdaaoekaaaaakkia
aaaapeiaacaaaaadaaaaahiaaaaaoeiabeaaoekaaeaaaaaeaaaaahiaaaaaoeia
bfaappkaaaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaaiaaaaadacaaacoa
abaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapia
aaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaappja
aaaaoeiaafaaaaadabaaapiaaaaaffiaacaaoekaaeaaaaaeabaaapiaabaaoeka
aaaaaaiaabaaoeiaaeaaaaaeabaaapiaadaaoekaaaaakkiaabaaoeiaaeaaaaae
adaaapoaaeaaoekaaaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffjaakaaoeka
aeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefciiafaaaaeaaaabaagcabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaa
ogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaaeaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
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
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 34 instructions, 4 R-regs
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
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_2_0
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
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
dp3 oT1.y, r0, r2
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT2.y, r2, r3
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mad oT0.zw, v3.xyxy, c20.xyxy, c20
mad oT0.xy, v3, c19, c19.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
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
eefiecedccfkfopdfpaobpeododkohcedchnnokcabaaaaaaceahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiafaaaaeaaaabaa
gcabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaa
kgiocaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
acaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
adaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
aeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
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
"vs_4_0_level_9_1
eefiecedglfmblgekmphjihfmafddmepplhjlfkdabaaaaaahiakaaaaaeaaaaaa
daaaaaaaiaadaaaabaajaaaaniajaaaaebgpgodjeiadaaaaeiadaaaaaaacpopp
niacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
aeaaabaaaaaaaaaaaaaaajaaacaaafaaaaaaaaaaabaaaeaaabaaahaaaaaaaaaa
acaaaaaaabaaaiaaaaaaaaaaadaaaaaaaeaaajaaaaaaaaaaadaaamaaajaaanaa
aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoaadaaeejaagaaeeka
agaaoekaabaaaaacaaaaapiaaiaaoekaafaaaaadabaaahiaaaaaffiabcaaoeka
aeaaaaaeabaaahiabbaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabdaaoeka
aaaakkiaabaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaappiaaaaaoeiaaeaaaaae
aaaaahiaaaaaoeiabfaappkaaaaaoejbaiaaaaadabaaaboaabaaoejaaaaaoeia
abaaaaacabaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaae
abaaahiaacaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappja
aiaaaaadabaaacoaabaaoeiaaaaaoeiaaiaaaaadabaaaeoaacaaoejaaaaaoeia
abaaaaacaaaaahiaahaaoekaafaaaaadacaaahiaaaaaffiabcaaoekaaeaaaaae
aaaaaliabbaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiabdaaoekaaaaakkia
aaaapeiaacaaaaadaaaaahiaaaaaoeiabeaaoekaaeaaaaaeaaaaahiaaaaaoeia
bfaappkaaaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaaiaaaaadacaaacoa
abaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapia
aaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaappja
aaaaoeiaafaaaaadabaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoeka
aaaaaaiaabaaoeiaaeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaae
adaaahoaaeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaakaaoeka
aeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefciiafaaaaeaaaabaagcabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaa
ogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
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
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
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
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 32 instructions, 4 R-regs
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
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_2_0
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
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
dp3 oT1.y, r4, r2
dp3 oT2.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mad oT0.zw, v3.xyxy, c20.xyxy, c20
mad oT0.xy, v3, c19, c19.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
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
eefiecedekokaocinpphacablapoaibkilcpahegabaaaaaapiagaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcfmafaaaaeaaaabaa
fhabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaa
kgiocaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
dcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegaabaaaaaaaaaaadcaaaaakdccabaaaaeaaaaaaegiacaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
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
"vs_4_0_level_9_1
eefiecedgkkoopmggkilchbfdomlfbickfoppfndabaaaaaadiakaaaaaeaaaaaa
daaaaaaagmadaaaanaaiaaaajiajaaaaebgpgodjdeadaaaadeadaaaaaaacpopp
meacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
aeaaabaaaaaaaaaaaaaaajaaacaaafaaaaaaaaaaabaaaeaaabaaahaaaaaaaaaa
acaaaaaaabaaaiaaaaaaaaaaadaaaaaaaeaaajaaaaaaaaaaadaaamaaajaaanaa
aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoaadaaeejaagaaeeka
agaaoekaabaaaaacaaaaapiaaiaaoekaafaaaaadabaaahiaaaaaffiabcaaoeka
aeaaaaaeabaaahiabbaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabdaaoeka
aaaakkiaabaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaappiaaaaaoeiaaiaaaaad
abaaaboaabaaoejaaaaaoeiaabaaaaacabaaahiaabaaoejaafaaaaadacaaahia
abaamjiaacaancjaaeaaaaaeabaaahiaacaamjjaabaanciaacaaoeibafaaaaad
abaaahiaabaaoeiaabaappjaaiaaaaadabaaacoaabaaoeiaaaaaoeiaaiaaaaad
abaaaeoaacaaoejaaaaaoeiaabaaaaacaaaaahiaahaaoekaafaaaaadacaaahia
aaaaffiabcaaoekaaeaaaaaeaaaaaliabbaakekaaaaaaaiaacaakeiaaeaaaaae
aaaaahiabdaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeiabeaaoeka
aeaaaaaeaaaaahiaaaaaoeiabfaappkaaaaaoejbaiaaaaadacaaaboaabaaoeja
aaaaoeiaaiaaaaadacaaacoaabaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoeja
aaaaoeiaafaaaaadaaaaapiaaaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiabaaaoekaaaaappjaaaaaoeiaafaaaaadabaaadiaaaaaffiaacaaoeka
aeaaaaaeaaaaadiaabaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaadiaadaaoeka
aaaakkiaaaaaoeiaaeaaaaaeadaaadoaaeaaoekaaaaappiaaaaaoeiaafaaaaad
aaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiappppaaaafdeieefcfmafaaaaeaaaabaafhabaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaaddccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaa
akaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaabaaa
aaaaaaaadcaaaaakdccabaaaaeaaaaaaegiacaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 0, 2, 1, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
DP3 R1.x, fragment.texcoord[3], fragment.texcoord[3];
DP3 R3.x, fragment.texcoord[2], fragment.texcoord[2];
MUL R0.xyz, R0, c[2];
RSQ R3.x, R3.x;
MOV result.color.w, c[4].x;
TEX R2.w, R1.x, texture[2], 2D;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R1.x, R1.x;
MUL R2.xyz, R1.x, fragment.texcoord[1];
MAD R1.xy, R1.wyzw, c[4].y, -c[4].z;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R1.z, R1, R1.w;
MAD R3.xyz, R3.x, fragment.texcoord[2], R2;
DP3 R1.w, R3, R3;
RSQ R1.w, R1.w;
MUL R3.xyz, R1.w, R3;
ADD R1.z, -R1, c[4];
RSQ R1.z, R1.z;
RCP R1.z, R1.z;
DP3 R3.x, R1, R3;
MOV R1.w, c[4];
MUL R3.y, R1.w, c[3].x;
MAX R1.w, R3.x, c[4].x;
POW R1.w, R1.w, R3.y;
MUL R0.w, R1, R0;
DP3 R1.x, R1, R2;
MAX R1.w, R1.x, c[4].x;
MUL R1.xyz, R0, c[0];
MUL R1.xyz, R1, R1.w;
MOV R0.xyz, c[1];
MUL R0.xyz, R0, c[0];
MUL R1.w, R2, c[4].y;
MAD R0.xyz, R0, R0.w, R1;
MUL result.color.xyz, R0, R1.w;
END
# 36 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c5, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r2, t0, s0
dp3 r0.x, t3, t3
mov r1.xy, r0.x
mul_pp r2.xyz, r2, c2
mul_pp r2.xyz, r2, c0
mov r0.y, t0.w
mov r0.x, t0.z
texld r6, r1, s2
texld r0, r0, s1
mov r0.x, r0.w
mad_pp r4.xy, r0, c4.x, c4.y
mul_pp r0.xy, r4, r4
add_pp_sat r0.x, r0, r0.y
dp3_pp r1.x, t1, t1
rsq_pp r3.x, r1.x
dp3_pp r1.x, t2, t2
add_pp r0.x, -r0, c4.z
rsq_pp r0.x, r0.x
rcp_pp r4.z, r0.x
mov_pp r0.x, c3
mul_pp r3.xyz, r3.x, t1
rsq_pp r1.x, r1.x
mad_pp r5.xyz, r1.x, t2, r3
dp3_pp r1.x, r5, r5
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, r5
dp3_pp r1.x, r4, r1
mul_pp r0.x, c5, r0
max_pp r1.x, r1, c4.w
pow r5.x, r1.x, r0.x
dp3_pp r1.x, r4, r3
max_pp r1.x, r1, c4.w
mul_pp r3.xyz, r2, r1.x
mov r0.x, r5.x
mov_pp r2.xyz, c0
mul r0.x, r0, r2.w
mul_pp r2.xyz, c1, r2
mul_pp r1.x, r6, c4
mad r0.xyz, r2, r0.x, r3
mul r0.xyz, r0, r1.x
mov_pp r0.w, c4
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0
eefiecedeacmdcfdhmhkgcmhcbnnljcpahiejinnabaaaaaakiafaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefckaaeaaaaeaaaaaaaciabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
acaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahocaabaaa
aaaaaaaafgafbaaaaaaaaaaaagbjbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaa
egbcbaaaadaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaapaaaaahbcaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaa
ddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaai
bcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaacaaaaaaakaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaa
jgahbaaaaaaaaaaadeaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaaiecaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaa
aaaaaaeddiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaa
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaajhcaabaaaacaaaaaa
egiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaa
aaaaaaaaagaabaaaaaaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaabaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
pgapbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecediaanhjdpncekepahkaidddlmbohgnkgcabaaaaaakmaiaaaaaeaaaaaa
daaaaaaadaadaaaaniahaaaahiaiaaaaebgpgodjpiacaaaapiacaaaaaaacpppp
laacaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaacaaaaaa
aaababaaabacacaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaacaaacaaaaaaaaaa
aaacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaaf
afaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaia
adaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkaaiaaaaadaaaaciiaacaaoelaacaaoelaahaaaaacaaaacbia
aaaappiaceaaaaacabaachiaabaaoelaaeaaaaaeaaaachiaacaaoelaaaaaaaia
abaaoeiaceaaaaacacaachiaaaaaoeiaabaaaaacaaaaabiaaaaakklaabaaaaac
aaaaaciaaaaapplaaiaaaaadabaaaiiaadaaoelaadaaoelaabaaaaacadaaadia
abaappiaecaaaaadaaaacpiaaaaaoeiaacaioekaecaaaaadaeaacpiaaaaaoela
abaioekaecaaaaadadaacpiaadaaoeiaaaaioekaaeaaaaaeafaacbiaaaaappia
aeaaaakaaeaaffkaaeaaaaaeafaacciaaaaaffiaaeaaaakaaeaaffkafkaaaaae
abaadiiaafaaoeiaafaaoeiaaeaakkkaacaaaaadabaaciiaabaappibaeaappka
ahaaaaacabaaciiaabaappiaagaaaaacafaaceiaabaappiaaiaaaaadabaaciia
afaaoeiaacaaoeiaaiaaaaadaaaacbiaafaaoeiaabaaoeiaalaaaaadabaacbia
aaaaaaiaaeaakkkaalaaaaadaaaaabiaabaappiaaeaakkkaabaaaaacacaaabia
adaaaakaafaaaaadaaaaaciaacaaaaiaafaaaakacaaaaaadabaaaciaaaaaaaia
aaaaffiaafaaaaadaeaaaiiaaeaappiaabaaffiaafaaaaadaaaachiaaeaaoeia
acaaoekaafaaaaadaaaachiaaaaaoeiaaaaaoekaabaaaaacacaaahiaaaaaoeka
afaaaaadabaaaoiaacaabliaabaablkaafaaaaadabaaaoiaaeaappiaabaaoeia
aeaaaaaeaaaaahiaaaaaoeiaabaaaaiaabaabliaacaaaaadaaaaaiiaadaaaaia
adaaaaiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaaaiiaaeaakkka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefckaaeaaaaeaaaaaaaciabaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagbjbaaa
acaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaadaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
acaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaa
egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaaakaabaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaacaaaaaajgahbaaaaaaaaaaadeaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
ahaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
abaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaa
aaaaaaaaacaaaaaadiaaaaahncaabaaaaaaaaaaaagaabaaaaaaaaaaaagajbaaa
acaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgafbaaaaaaaaaaa
igadbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaa
aeaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheojiaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahahaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
"!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 0, 2, 1, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R1.wyzw, c[4].y, -c[4].z;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R1.z, R1, R1.w;
DP3 R2.w, fragment.texcoord[2], fragment.texcoord[2];
ADD R1.z, -R1, c[4];
RSQ R1.z, R1.z;
RCP R1.z, R1.z;
MUL R0.xyz, R0, c[2];
MOV R2.xyz, fragment.texcoord[1];
RSQ R2.w, R2.w;
MAD R2.xyz, R2.w, fragment.texcoord[2], R2;
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, R2;
DP3 R2.x, R1, R2;
MOV R1.w, c[4];
MUL R2.y, R1.w, c[3].x;
MAX R1.w, R2.x, c[4].x;
POW R1.w, R1.w, R2.y;
MUL R0.w, R1, R0;
DP3 R1.w, R1, fragment.texcoord[1];
MUL R1.xyz, R0, c[0];
MAX R1.w, R1, c[4].x;
MOV R0.xyz, c[1];
MUL R1.xyz, R1, R1.w;
MUL R0.xyz, R0, c[0];
MAD R0.xyz, R0, R0.w, R1;
MUL result.color.xyz, R0, c[4].y;
MOV result.color.w, c[4].x;
END
# 31 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c5, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
texld r2, t0, s0
dp3_pp r1.x, t2, t2
rsq_pp r1.x, r1.x
mov_pp r3.xyz, t1
mad_pp r3.xyz, r1.x, t2, r3
mul_pp r2.xyz, r2, c2
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s1
mov r0.x, r0.w
mad_pp r4.xy, r0, c4.x, c4.y
mul_pp r0.xy, r4, r4
add_pp_sat r0.x, r0, r0.y
add_pp r1.x, -r0, c4.z
dp3_pp r0.x, r3, r3
rsq_pp r1.x, r1.x
rcp_pp r4.z, r1.x
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r3
dp3_pp r1.x, r4, r1
mov_pp r0.x, c3
mul_pp r0.x, c5, r0
max_pp r1.x, r1, c4.w
pow r3.w, r1.x, r0.x
mov r0.x, r3.w
mul_pp r3.xyz, r2, c0
dp3_pp r1.x, r4, t1
max_pp r1.x, r1, c4.w
mov_pp r2.xyz, c0
mul r0.x, r0, r2.w
mul_pp r1.xyz, r3, r1.x
mul_pp r2.xyz, c1, r2
mad r0.xyz, r2, r0.x, r1
mul r0.xyz, r0, c4.x
mov_pp r0.w, c4
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
ConstBuffer "$Globals" 112
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmmjhbpfcgbnnfmmmjomjhmimkhpgnpnlabaaaaaamaaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcnaadaaaaeaaaaaaapeaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaadaaaaaaagaabaaa
aaaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaacaaaaaadeaaaaak
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaa
aaaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaabaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaa
egiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaaaaaaaaaagaabaaaaaaaaaaa
agajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgafbaaa
aaaaaaaaigadbaaaaaaaaaaaaaaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
ConstBuffer "$Globals" 112
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedbhilbifapcgdbfehhmnjabocjhmkoekmabaaaaaagaahaaaaaeaaaaaa
daaaaaaammacaaaakeagaaaacmahaaaaebgpgodjjeacaaaajeacaaaaaaacpppp
fmacaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaaeaaaaaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaea
aaaaialpaaaaaaaaaaaaiadpfbaaaaafafaaapkaaaaaaaedaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaac
aaaaaaiaacaachlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
aiaaaaadaaaaciiaacaaoelaacaaoelaahaaaaacaaaacbiaaaaappiaabaaaaac
abaaahiaacaaoelaaeaaaaaeaaaachiaabaaoeiaaaaaaaiaabaaoelaceaaaaac
abaachiaaaaaoeiaabaaaaacaaaaabiaaaaakklaabaaaaacaaaaaciaaaaappla
ecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaadacaacpiaaaaaoelaaaaioeka
aeaaaaaeadaacbiaaaaappiaaeaaaakaaeaaffkaaeaaaaaeadaacciaaaaaffia
aeaaaakaaeaaffkafkaaaaaeabaadiiaadaaoeiaadaaoeiaaeaakkkaacaaaaad
abaaciiaabaappibaeaappkaahaaaaacabaaciiaabaappiaagaaaaacadaaceia
abaappiaaiaaaaadadaaciiaadaaoeiaabaaoeiaaiaaaaadaaaacbiaadaaoeia
abaaoelaalaaaaadabaacbiaaaaaaaiaaeaakkkaalaaaaadaaaaabiaadaappia
aeaakkkaabaaaaacadaaabiaadaaaakaafaaaaadaaaaaciaadaaaaiaafaaaaka
caaaaaadabaaaciaaaaaaaiaaaaaffiaafaaaaadacaaaiiaacaappiaabaaffia
afaaaaadaaaachiaacaaoeiaacaaoekaafaaaaadaaaachiaaaaaoeiaaaaaoeka
abaaaaacacaaahiaaaaaoekaafaaaaadabaaaoiaacaabliaabaablkaafaaaaad
abaaaoiaacaappiaabaaoeiaaeaaaaaeaaaaahiaaaaaoeiaabaaaaiaabaablia
acaaaaadaaaachiaaaaaoeiaaaaaoeiaabaaaaacaaaaciiaaeaakkkaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcnaadaaaaeaaaaaaapeaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaadaaaaaa
agaabaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaa
dkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaacaaaaaa
deaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
ecaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaabaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaa
abaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaaaaaaaaaagaabaaa
aaaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaa
fgafbaaaaaaaaaaaigadbaaaaaaaaaaaaaaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
"!!ARBfp1.0
PARAM c[6] = { program.local[0..3],
		{ 0, 2, 1, 128 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R3.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R2, fragment.texcoord[0], texture[0], 2D;
MAD R3.xy, R3.wyzw, c[4].y, -c[4].z;
DP3 R0.z, fragment.texcoord[3], fragment.texcoord[3];
MUL R3.zw, R3.xyxy, R3.xyxy;
ADD_SAT R3.z, R3, R3.w;
RCP R0.x, fragment.texcoord[3].w;
MAD R0.xy, fragment.texcoord[3], R0.x, c[5].x;
DP3 R1.x, fragment.texcoord[2], fragment.texcoord[2];
ADD R3.z, -R3, c[4];
RSQ R3.z, R3.z;
RCP R3.z, R3.z;
RSQ R1.x, R1.x;
MOV result.color.w, c[4].x;
TEX R0.w, R0, texture[2], 2D;
TEX R1.w, R0.z, texture[3], 2D;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[1];
MAD R1.xyz, R1.x, fragment.texcoord[2], R0;
DP3 R3.w, R1, R1;
RSQ R3.w, R3.w;
MUL R1.xyz, R3.w, R1;
DP3 R1.x, R3, R1;
MOV R3.w, c[4];
MUL R1.y, R3.w, c[3].x;
MAX R1.x, R1, c[4];
POW R1.x, R1.x, R1.y;
MUL R2.w, R1.x, R2;
DP3 R1.x, R3, R0;
MUL R0.xyz, R2, c[2];
SLT R2.x, c[4], fragment.texcoord[3].z;
MUL R0.w, R2.x, R0;
MUL R0.w, R0, R1;
MUL R0.xyz, R0, c[0];
MAX R1.x, R1, c[4];
MUL R1.xyz, R0, R1.x;
MOV R0.xyz, c[1];
MUL R0.xyz, R0, c[0];
MUL R0.w, R0, c[4].y;
MAD R0.xyz, R0, R2.w, R1;
MUL result.color.xyz, R0, R0.w;
END
# 42 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c5, 128.00000000, 0.50000000, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3
rcp r2.x, t3.w
mad r3.xy, t3, r2.x, c5.y
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.xy, r0
dp3 r0.x, t3, t3
mov r2.xy, r0.x
texld r6, r2, s3
texld r1, r1, s1
texld r2, t0, s0
texld r0, r3, s2
dp3_pp r1.x, t1, t1
rsq_pp r3.x, r1.x
dp3_pp r1.x, t2, t2
mul_pp r2.xyz, r2, c2
mov r0.y, r1
mov r0.x, r1.w
mad_pp r4.xy, r0, c4.x, c4.y
mul_pp r0.xy, r4, r4
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c4.z
rsq_pp r0.x, r0.x
rcp_pp r4.z, r0.x
mov_pp r0.x, c3
mul_pp r3.xyz, r3.x, t1
rsq_pp r1.x, r1.x
mad_pp r5.xyz, r1.x, t2, r3
dp3_pp r1.x, r5, r5
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, r5
dp3_pp r1.x, r4, r1
mul_pp r0.x, c5, r0
max_pp r1.x, r1, c4.w
pow r5.x, r1.x, r0.x
dp3_pp r1.x, r4, r3
mov r0.x, r5.x
mul r0.x, r0, r2.w
mov_pp r3.xyz, c0
max_pp r1.x, r1, c4.w
mul_pp r2.xyz, r2, c0
mul_pp r2.xyz, r2, r1.x
cmp r1.x, -t3.z, c4.w, c4.z
mul_pp r1.x, r1, r0.w
mul_pp r1.x, r1, r6
mul_pp r3.xyz, c1, r3
mul_pp r1.x, r1, c4
mad r0.xyz, r3, r0.x, r2
mul r0.xyz, r0, r1.x
mov_pp r0.w, c4
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_LightTexture0] 2D 0
SetTexture 3 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0
eefieceddaljplfnmgmpajjbhgmlegcjfgjndpplabaaaaaaiaagaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefchiafaaaaeaaaaaaafoabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagbjbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaa
adaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahbcaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaaakaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaajgahbaaa
aaaaaaaadeaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaiecaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaed
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaa
aaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaaaaaaaaa
agaabaaaaaaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
abaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaaeaaaaaapgbpbaaaaeaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaa
abaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaaeaaaaaaabaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaa
eghobaaaadaaaaaaaagabaaaabaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_LightTexture0] 2D 0
SetTexture 3 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedadnnnlpibaedimljingadbgiginedjcgabaaaaaaoiajaaaaaeaaaaaa
daaaaaaajeadaaaabeajaaaaleajaaaaebgpgodjfmadaaaafmadaaaaaaacpppp
baadaaaaemaaaaaaacaadeaaaaaaemaaaaaaemaaaeaaceaaaaaaemaaacaaaaaa
adababaaaaacacaaabadadaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaacaaacaa
aaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadp
fbaaaaafafaaapkaaaaaaadpaaaaaaedaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaac
aaaaaaiaadaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaaiaaaaadaaaaciia
acaaoelaacaaoelaahaaaaacaaaacbiaaaaappiaceaaaaacabaachiaabaaoela
aeaaaaaeaaaachiaacaaoelaaaaaaaiaabaaoeiaceaaaaacacaachiaaaaaoeia
abaaaaacaaaaabiaaaaakklaabaaaaacaaaaaciaaaaapplaagaaaaacabaaaiia
adaapplaaeaaaaaeadaaadiaadaaoelaabaappiaafaaaakaaiaaaaadabaaaiia
adaaoelaadaaoelaabaaaaacaeaaadiaabaappiaecaaaaadaaaacpiaaaaaoeia
adaioekaecaaaaadafaacpiaaaaaoelaacaioekaecaaaaadadaacpiaadaaoeia
aaaioekaecaaaaadaeaacpiaaeaaoeiaabaioekaaeaaaaaeadaacbiaaaaappia
aeaaaakaaeaaffkaaeaaaaaeadaacciaaaaaffiaaeaaaakaaeaaffkafkaaaaae
abaadiiaadaaoeiaadaaoeiaaeaakkkaacaaaaadabaaciiaabaappibaeaappka
ahaaaaacabaaciiaabaappiaagaaaaacadaaceiaabaappiaaiaaaaadabaaciia
adaaoeiaacaaoeiaaiaaaaadaaaacbiaadaaoeiaabaaoeiaalaaaaadabaacbia
aaaaaaiaaeaakkkaalaaaaadaaaaabiaabaappiaaeaakkkaabaaaaacaaaaacia
afaaffkaafaaaaadaaaaaciaaaaaffiaadaaaakacaaaaaadabaaaciaaaaaaaia
aaaaffiaafaaaaadafaaaiiaafaappiaabaaffiaafaaaaadaaaachiaafaaoeia
acaaoekaafaaaaadaaaachiaaaaaoeiaaaaaoekaabaaaaacacaaahiaaaaaoeka
afaaaaadabaaaoiaacaabliaabaablkaafaaaaadabaaaoiaafaappiaabaaoeia
aeaaaaaeaaaaahiaaaaaoeiaabaaaaiaabaabliaafaaaaadaaaaciiaadaappia
aeaaaaiafiaaaaaeaaaaciiaadaakklbaeaakkkaaaaappiaacaaaaadaaaaaiia
aaaappiaaaaappiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaaciia
aeaakkkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefchiafaaaaeaaaaaaa
foabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
adaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagbjbaaa
acaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaadaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaa
acaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaa
egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaaakaabaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaacaaaaaajgahbaaaaaaaaaaadeaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
ahaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
abaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaa
aaaaaaaaacaaaaaadiaaaaahncaabaaaaaaaaaaaagaabaaaaaaaaaaaagajbaaa
acaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgafbaaaaaaaaaaa
igadbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaaeaaaaaapgbpbaaa
aeaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaa
aaaaaaaackbabaaaaeaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaa
abaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaaaaaaaaaaagaabaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
SetTexture 3 [_LightTexture0] CUBE 3
"!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 0, 2, 1, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R3.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R2, fragment.texcoord[0], texture[0], 2D;
TEX R1.w, fragment.texcoord[3], texture[3], CUBE;
MAD R3.xy, R3.wyzw, c[4].y, -c[4].z;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
MUL R3.zw, R3.xyxy, R3.xyxy;
ADD_SAT R3.z, R3, R3.w;
DP3 R1.x, fragment.texcoord[2], fragment.texcoord[2];
ADD R3.z, -R3, c[4];
RSQ R3.z, R3.z;
RCP R3.z, R3.z;
RSQ R1.x, R1.x;
MOV result.color.w, c[4].x;
TEX R0.w, R0.x, texture[2], 2D;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[1];
MAD R1.xyz, R1.x, fragment.texcoord[2], R0;
DP3 R3.w, R1, R1;
RSQ R3.w, R3.w;
MUL R1.xyz, R3.w, R1;
DP3 R1.x, R3, R1;
MOV R3.w, c[4];
MUL R0.w, R0, R1;
MUL R1.y, R3.w, c[3].x;
MAX R1.x, R1, c[4];
POW R1.x, R1.x, R1.y;
MUL R2.w, R1.x, R2;
DP3 R1.x, R3, R0;
MUL R0.xyz, R2, c[2];
MUL R0.xyz, R0, c[0];
MAX R1.x, R1, c[4];
MUL R1.xyz, R0, R1.x;
MOV R0.xyz, c[1];
MUL R0.xyz, R0, c[0];
MUL R0.w, R0, c[4].y;
MAD R0.xyz, R0, R2.w, R1;
MUL result.color.xyz, R0, R0.w;
END
# 38 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
SetTexture 3 [_LightTexture0] CUBE 3
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c5, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r2, t0, s0
dp3 r0.x, t3, t3
mov r0.xy, r0.x
mul_pp r2.xyz, r2, c2
mov r1.y, t0.w
mov r1.x, t0.z
mul_pp r2.xyz, r2, c0
texld r6, r0, s2
texld r1, r1, s1
texld r0, t3, s3
dp3_pp r1.x, t1, t1
rsq_pp r3.x, r1.x
dp3_pp r1.x, t2, t2
mov r0.y, r1
mov r0.x, r1.w
mad_pp r4.xy, r0, c4.x, c4.y
mul_pp r0.xy, r4, r4
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c4.z
rsq_pp r0.x, r0.x
rcp_pp r4.z, r0.x
mov_pp r0.x, c3
mul_pp r3.xyz, r3.x, t1
rsq_pp r1.x, r1.x
mad_pp r5.xyz, r1.x, t2, r3
dp3_pp r1.x, r5, r5
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, r5
dp3_pp r1.x, r4, r1
mul_pp r0.x, c5, r0
max_pp r1.x, r1, c4.w
pow r5.x, r1.x, r0.x
dp3_pp r1.x, r4, r3
max_pp r1.x, r1, c4.w
mov r0.x, r5.x
mul r0.x, r0, r2.w
mov_pp r3.xyz, c0
mul_pp r2.xyz, r2, r1.x
mul r1.x, r6, r0.w
mul_pp r3.xyz, c1, r3
mul_pp r1.x, r1, c4
mad r0.xyz, r3, r0.x, r2
mul r0.xyz, r0, r1.x
mov_pp r0.w, c4
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_LightTextureB0] 2D 1
SetTexture 3 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0
eefiecedpbnlkiggofkhahabphhkpkdpjefojjacabaaaaaaoiafaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoaaeaaaaeaaaaaaadiabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fidaaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagbjbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaa
adaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahbcaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaaakaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaajgahbaaa
aaaaaaaadeaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaiecaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaed
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaa
aaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaaaaaaaaa
agaabaaaaaaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
abaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaa
aaaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbcbaaaaeaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaagaabaaaabaaaaaapgapbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_LightTextureB0] 2D 1
SetTexture 3 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedaklmlmaendpfbnkcnejcjbeojkgihcpdabaaaaaabmajaaaaaeaaaaaa
daaaaaaagaadaaaaeiaiaaaaoiaiaaaaebgpgodjciadaaaaciadaaaaaaacpppp
nmacaaaaemaaaaaaacaadeaaaaaaemaaaaaaemaaaeaaceaaaaaaemaaadaaaaaa
acababaaaaacacaaabadadaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaacaaacaa
aaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadp
fbaaaaafafaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaac
aaaaaaiaadaaahlabpaaaaacaaaaaajiaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaaiaaaaadaaaaciia
acaaoelaacaaoelaahaaaaacaaaacbiaaaaappiaceaaaaacabaachiaabaaoela
aeaaaaaeaaaachiaacaaoelaaaaaaaiaabaaoeiaceaaaaacacaachiaaaaaoeia
abaaaaacaaaaabiaaaaakklaabaaaaacaaaaaciaaaaapplaaiaaaaadabaaaiia
adaaoelaadaaoelaabaaaaacadaaadiaabaappiaecaaaaadaaaacpiaaaaaoeia
adaioekaecaaaaadaeaacpiaaaaaoelaacaioekaecaaaaadadaaapiaadaaoeia
abaioekaecaaaaadafaaapiaadaaoelaaaaioekaaeaaaaaeafaacbiaaaaappia
aeaaaakaaeaaffkaaeaaaaaeafaacciaaaaaffiaaeaaaakaaeaaffkafkaaaaae
abaadiiaafaaoeiaafaaoeiaaeaakkkaacaaaaadabaaciiaabaappibaeaappka
ahaaaaacabaaciiaabaappiaagaaaaacafaaceiaabaappiaaiaaaaadabaaciia
afaaoeiaacaaoeiaaiaaaaadaaaacbiaafaaoeiaabaaoeiaalaaaaadabaacbia
aaaaaaiaaeaakkkaalaaaaadaaaaabiaabaappiaaeaakkkaabaaaaacacaaabia
adaaaakaafaaaaadaaaaaciaacaaaaiaafaaaakacaaaaaadabaaaciaaaaaaaia
aaaaffiaafaaaaadaeaaaiiaaeaappiaabaaffiaafaaaaadaaaachiaaeaaoeia
acaaoekaafaaaaadaaaachiaaaaaoeiaaaaaoekaabaaaaacacaaahiaaaaaoeka
afaaaaadabaaaoiaacaabliaabaablkaafaaaaadabaaaoiaaeaappiaabaaoeia
aeaaaaaeaaaaahiaaaaaoeiaabaaaaiaabaabliaafaaaaadaaaaciiaadaaaaia
afaappiaacaaaaadaaaaaiiaaaaappiaaaaappiaafaaaaadaaaachiaaaaappia
aaaaoeiaabaaaaacaaaaaiiaaeaakkkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcoaaeaaaaeaaaaaaadiabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fidaaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagbjbaaaacaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaa
adaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahbcaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaaakaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaacaaaaaajgahbaaa
aaaaaaaadeaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaiecaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaed
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaa
aaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaaaaaaaaa
agaabaaaaaaaaaaaagajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
abaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaa
aaaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbcbaaaaeaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaagaabaaaabaaaaaapgapbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 0, 2, 1, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R2.w, fragment.texcoord[3], texture[2], 2D;
MAD R1.xy, R1.wyzw, c[4].y, -c[4].z;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R1.z, R1, R1.w;
DP3 R3.x, fragment.texcoord[2], fragment.texcoord[2];
ADD R1.z, -R1, c[4];
RSQ R1.z, R1.z;
RCP R1.z, R1.z;
MUL R0.xyz, R0, c[2];
MOV R2.xyz, fragment.texcoord[1];
RSQ R3.x, R3.x;
MAD R2.xyz, R3.x, fragment.texcoord[2], R2;
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, R2;
DP3 R2.x, R1, R2;
MOV R1.w, c[4];
MUL R2.y, R1.w, c[3].x;
MAX R1.w, R2.x, c[4].x;
POW R1.w, R1.w, R2.y;
MUL R0.w, R1, R0;
DP3 R1.w, R1, fragment.texcoord[1];
MUL R1.xyz, R0, c[0];
MAX R1.w, R1, c[4].x;
MUL R1.xyz, R1, R1.w;
MOV R0.xyz, c[1];
MUL R0.xyz, R0, c[0];
MUL R1.w, R2, c[4].y;
MAD R0.xyz, R0, R0.w, R1;
MUL result.color.xyz, R0, R1.w;
MOV result.color.w, c[4].x;
END
# 33 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c5, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3.xy
texld r2, t0, s0
mul_pp r2.xyz, r2, c2
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.xy, r0
mul_pp r2.xyz, r2, c0
mov_pp r4.xyz, t1
texld r1, r1, s1
texld r0, t3, s2
dp3_pp r1.x, t2, t2
rsq_pp r1.x, r1.x
mad_pp r4.xyz, r1.x, t2, r4
dp3_pp r1.x, r4, r4
mov r0.y, r1
mov r0.x, r1.w
mad_pp r3.xy, r0, c4.x, c4.y
mul_pp r0.xy, r3, r3
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c4.z
rsq_pp r0.x, r0.x
rcp_pp r3.z, r0.x
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, r4
dp3_pp r1.x, r3, r1
mov_pp r0.x, c3
mul_pp r0.x, c5, r0
max_pp r1.x, r1, c4.w
pow r4.x, r1.x, r0.x
dp3_pp r1.x, r3, t1
max_pp r1.x, r1, c4.w
mul_pp r3.xyz, r2, r1.x
mov r0.x, r4.x
mul r0.x, r0, r2.w
mul_pp r1.x, r0.w, c4
mov_pp r2.xyz, c0
mul_pp r2.xyz, c1, r2
mad r0.xyz, r2, r0.x, r3
mul r0.xyz, r0, r1.x
mov_pp r0.w, c4
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0
eefiecedciolmapjmenaabahokkendfjndfbncbfabaaaaaaeaafaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcdiaeaaaaeaaaaaaaaoabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaaddcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegbcbaaaadaaaaaaagaabaaa
aaaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaap
dcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaabaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaacaaaaaadeaaaaak
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaa
aaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaabaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaa
egiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaaaaaaaaaagaabaaaaaaaaaaa
agajbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaafgafbaaa
aaaaaaaaigadbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecediicmkphflinocmekjajjeijmbjgdkchdabaaaaaaciaiaaaaaeaaaaaa
daaaaaaabeadaaaafeahaaaapeahaaaaebgpgodjnmacaaaanmacaaaaaaacpppp
jeacaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaacaaaaaa
aaababaaabacacaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaacaaacaaaaaaaaaa
aaacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaaf
afaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaia
adaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkaaiaaaaadaaaaciiaacaaoelaacaaoelaahaaaaacaaaacbia
aaaappiaabaaaaacabaaahiaacaaoelaaeaaaaaeaaaachiaabaaoeiaaaaaaaia
abaaoelaceaaaaacabaachiaaaaaoeiaabaaaaacaaaaabiaaaaakklaabaaaaac
aaaaaciaaaaapplaecaaaaadaaaacpiaaaaaoeiaacaioekaecaaaaadacaacpia
aaaaoelaabaioekaecaaaaadadaacpiaadaaoelaaaaioekaaeaaaaaeadaacbia
aaaappiaaeaaaakaaeaaffkaaeaaaaaeadaacciaaaaaffiaaeaaaakaaeaaffka
fkaaaaaeabaadiiaadaaoeiaadaaoeiaaeaakkkaacaaaaadabaaciiaabaappib
aeaappkaahaaaaacabaaciiaabaappiaagaaaaacadaaceiaabaappiaaiaaaaad
aaaacbiaadaaoeiaabaaoeiaaiaaaaadaaaacciaadaaoeiaabaaoelaalaaaaad
abaacbiaaaaaffiaaeaakkkaalaaaaadabaaaciaaaaaaaiaaeaakkkaabaaaaac
aaaaabiaadaaaakaafaaaaadaaaaabiaaaaaaaiaafaaaakacaaaaaadadaaabia
abaaffiaaaaaaaiaafaaaaadacaaaiiaacaappiaadaaaaiaafaaaaadaaaachia
acaaoeiaacaaoekaafaaaaadaaaachiaaaaaoeiaaaaaoekaabaaaaacacaaahia
aaaaoekaafaaaaadabaaaoiaacaabliaabaablkaafaaaaadabaaaoiaacaappia
abaaoeiaaeaaaaaeaaaaahiaaaaaoeiaabaaaaiaabaabliaacaaaaadaaaaaiia
adaappiaadaappiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaaaiia
aeaakkkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcdiaeaaaaeaaaaaaa
aoabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaadaaaaaa
egbcbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegbcbaaaadaaaaaaagaabaaaaaaaaaaaegbcbaaaacaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaabaaaaaahgapbaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaabaaaaaa
egaabaaaabaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaabaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaa
egacbaaaabaaaaaaegbcbaaaacaaaaaadeaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaaiecaabaaaaaaaaaaaakiacaaaaaaaaaaa
aiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaaaaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaahaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaaj
hcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaa
diaaaaahncaabaaaaaaaaaaaagaabaaaaaaaaaaaagajbaaaacaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaafgafbaaaaaaaaaaaigadbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
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
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
Vector 10 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[11] = { program.local[0],
		state.matrix.mvp,
		program.local[5..10] };
TEMP R0;
TEMP R1;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
DP3 R0.y, R1, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[1].xyz, R0, c[9].w;
DP3 R0.y, R1, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[2].xyz, R0, c[9].w;
DP3 R0.y, R1, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[3].xyz, R0, c[9].w;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 21 instructions, 2 R-regs
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
Vector 9 [_BumpMap_ST]
"vs_2_0
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
mul oT1.xyz, r0, c8.w
dp3 r0.y, r1, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul oT2.xyz, r0, c8.w
dp3 r0.y, r1, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul oT3.xyz, r0, c8.w
mad oT0.xy, v3, c9, c9.zwzw
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
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 96
Vector 80 [_BumpMap_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefieceddofdaliokfballcidnldemeeghikookjabaaaaaajiafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcpmadaaaaeaaaabaa
ppaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
dgaaaaagbcaabaaaabaaaaaaakiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaa
abaaaaaaakiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaaakiacaaa
abaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
hccabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadgaaaaag
bcaabaaaabaaaaaabkiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaa
bkiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaabkiacaaaabaaaaaa
aoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
ecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihccabaaa
adaaaaaaegacbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadgaaaaagbcaabaaa
abaaaaaackiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaackiacaaa
abaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaabaaaaaaaoaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaa
aaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihccabaaaaeaaaaaa
egacbaaaaaaaaaaapgipcaaaabaaaaaabeaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 96
Vector 80 [_BumpMap_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedklopoeegfccblenojjggckhogjkcdgdkabaaaaaacaaiaaaaaeaaaaaa
daaaaaaaleacaaaaliagaaaaiaahaaaaebgpgodjhmacaaaahmacaaaaaaacpopp
ceacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaafaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaadaaagaaaaaaaaaa
abaabeaaabaaajaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaabaaaaacaaaaahia
abaaoejaafaaaaadabaaahiaaaaamjiaacaancjaaeaaaaaeaaaaahiaacaamjja
aaaanciaabaaoeibafaaaaadaaaaahiaaaaaoeiaabaappjaabaaaaacabaaabia
agaaaakaabaaaaacabaaaciaahaaaakaabaaaaacabaaaeiaaiaaaakaaiaaaaad
acaaaciaaaaaoeiaabaaoeiaaiaaaaadacaaabiaabaaoejaabaaoeiaaiaaaaad
acaaaeiaacaaoejaabaaoeiaafaaaaadabaaahoaacaaoeiaajaappkaabaaaaac
abaaabiaagaaffkaabaaaaacabaaaciaahaaffkaabaaaaacabaaaeiaaiaaffka
aiaaaaadacaaaciaaaaaoeiaabaaoeiaaiaaaaadacaaabiaabaaoejaabaaoeia
aiaaaaadacaaaeiaacaaoejaabaaoeiaafaaaaadacaaahoaacaaoeiaajaappka
abaaaaacabaaabiaagaakkkaabaaaaacabaaaciaahaakkkaabaaaaacabaaaeia
aiaakkkaaiaaaaadaaaaaciaaaaaoeiaabaaoeiaaiaaaaadaaaaabiaabaaoeja
abaaoeiaaiaaaaadaaaaaeiaacaaoejaabaaoeiaafaaaaadadaaahoaaaaaoeia
ajaappkaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcpmadaaaaeaaaabaa
ppaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
dgaaaaagbcaabaaaabaaaaaaakiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaa
abaaaaaaakiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaaakiacaaa
abaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
hccabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadgaaaaag
bcaabaaaabaaaaaabkiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaa
bkiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaabkiacaaaabaaaaaa
aoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
ecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihccabaaa
adaaaaaaegacbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadgaaaaagbcaabaaa
abaaaaaackiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaackiacaaa
abaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaabaaaaaaaoaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaa
aaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihccabaaaaeaaaaaa
egacbaaaaaaaaaaapgipcaaaabaaaaaabeaaaaaadoaaaaabejfdeheomaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Shininess]
SetTexture 0 [_BumpMap] 2D 0
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 2, 1, 0.5 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[0], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[1].x, -c[1].y;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[1].y;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R1.z, fragment.texcoord[3], R0;
DP3 R1.x, R0, fragment.texcoord[1];
DP3 R1.y, R0, fragment.texcoord[2];
MAD result.color.xyz, R1, c[1].z, c[1].z;
MOV result.color.w, c[0].x;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Shininess]
SetTexture 0 [_BumpMap] 2D 0
"ps_2_0
dcl_2d s0
def c1, 2.00000000, -1.00000000, 1.00000000, 0.50000000
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r0, t0, s0
mov r0.x, r0.w
mad_pp r1.xy, r0, c1.x, c1.y
mul_pp r0.xy, r1, r1
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c1.z
rsq_pp r0.x, r0.x
rcp_pp r1.z, r0.x
dp3 r0.z, t3, r1
dp3 r0.x, r1, t1
dp3 r0.y, r1, t2
mad_pp r0.xyz, r0, c1.w, c1.w
mov_pp r0.w, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_BumpMap] 2D 0
ConstBuffer "$Globals" 96
Float 64 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0
eefiecedpaddkbhnomdjlgchoachihcllgnienmiabaaaaaapiacaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpaabaaaaeaaaaaaahmaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
aaaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaacaaaaaa
egacbaaaaaaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaa
aaaaaaaabaaaaaahecaabaaaabaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaa
dcaaaaaphccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaag
iccabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_BumpMap] 2D 0
ConstBuffer "$Globals" 96
Float 64 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedcglaohkhlkedplgppohnoijoaloplcolabaaaaaahmaeaaaaaeaaaaaa
daaaaaaalaabaaaakiadaaaaeiaeaaaaebgpgodjhiabaaaahiabaaaaaaacpppp
eeabaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaaeaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaeaaaaaialp
aaaaaaaaaaaaiadpfbaaaaafacaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaia
acaaahlabpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaajaaaaiapkaecaaaaad
aaaacpiaaaaaoelaaaaioekaaeaaaaaeabaacbiaaaaappiaabaaaakaabaaffka
aeaaaaaeabaacciaaaaaffiaabaaaakaabaaffkafkaaaaaeabaadiiaabaaoeia
abaaoeiaabaakkkaacaaaaadabaaciiaabaappibabaappkaahaaaaacabaaciia
abaappiaagaaaaacabaaceiaabaappiaaiaaaaadaaaacbiaabaaoelaabaaoeia
aiaaaaadaaaacciaacaaoelaabaaoeiaaiaaaaadaaaaceiaadaaoelaabaaoeia
aeaaaaaeaaaachiaaaaaoeiaacaaaakaacaaaakaabaaaaacaaaaciiaaaaaaaka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaaaaahmaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaapdcaabaaaaaaaaaaa
hgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaa
aaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaahccaabaaa
abaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahecaabaaaabaaaaaa
egbcbaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaaphccabaaaaaaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaadgaaaaagiccabaaaaaaaaaaaakiacaaaaaaaaaaa
aeaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
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
Vector 19 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[20] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[17].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[12];
DP4 R2.y, R0, c[11];
DP4 R2.x, R0, c[10];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[15];
DP4 R3.y, R1, c[14];
DP4 R3.x, R1, c[13];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MAD R0.x, R0, R0, -R0.y;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[16];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[9].x;
ADD result.texcoord[2].xyz, R3, R2;
ADD result.texcoord[1].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[1].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
END
# 29 instructions, 4 R-regs
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
Vector 19 [_BumpMap_ST]
"vs_2_0
def c20, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c17.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c20.y
dp4 r2.z, r0, c12
dp4 r2.y, r0, c11
dp4 r2.x, r0, c10
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c15
dp4 r3.y, r1, c14
dp4 r3.x, r1, c13
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
mad r0.x, r0, r0, -r0.y
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c16
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r0.xyz, r1.xyww, c20.x
mul r0.y, r0, c8.x
add oT2.xyz, r3, r2
mad oT1.xy, r0.z, c9.zwzw, r0
mov oPos, r1
mov oT1.zw, r1
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
Vector 96 [_BumpMap_ST]
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
eefiecedhjghebkfbgcccccjamagfmenclmebepgabaaaaaaleafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
daaeaaaaeaaaabaaamabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
agaaaaaakgiocaaaaaaaaaaaagaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
acaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
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
eefiecedmfhnbbmnekcnkhfgoklgkpfgfbknlhbfabaaaaaagaaiaaaaaeaaaaaa
daaaaaaaniacaaaabaahaaaaniahaaaaebgpgodjkaacaaaakaacaaaaaaacpopp
daacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaafaa
acaaabaaaaaaaaaaabaaafaaabaaadaaaaaaaaaaacaacgaaahaaaeaaaaaaaaaa
adaaaaaaaeaaalaaaaaaaaaaadaaamaaadaaapaaaaaaaaaaadaabeaaabaabcaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbdaaapkaaaaaaadpaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaae
aaaaamoaadaaeejaacaaeekaacaaoekaafaaaaadaaaaapiaaaaaffjaamaaoeka
aeaaaaaeaaaaapiaalaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaanaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaoaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaadaaaakaafaaaaadabaaaiiaabaaaaiabdaaaakaafaaaaad
abaaafiaaaaapeiabdaaaakaacaaaaadabaaadoaabaakkiaabaaomiaafaaaaad
abaaahiaacaaoejabcaappkaafaaaaadacaaahiaabaaffiabaaaoekaaeaaaaae
abaaaliaapaakekaabaaaaiaacaakeiaaeaaaaaeabaaahiabbaaoekaabaakkia
abaapeiaabaaaaacabaaaiiabdaaffkaajaaaaadacaaabiaaeaaoekaabaaoeia
ajaaaaadacaaaciaafaaoekaabaaoeiaajaaaaadacaaaeiaagaaoekaabaaoeia
afaaaaadadaaapiaabaacjiaabaakeiaajaaaaadaeaaabiaahaaoekaadaaoeia
ajaaaaadaeaaaciaaiaaoekaadaaoeiaajaaaaadaeaaaeiaajaaoekaadaaoeia
acaaaaadacaaahiaacaaoeiaaeaaoeiaafaaaaadabaaaciaabaaffiaabaaffia
aeaaaaaeabaaabiaabaaaaiaabaaaaiaabaaffibaeaaaaaeacaaahoaakaaoeka
abaaaaiaacaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacabaaamoaaaaaoeiappppaaaafdeieefcdaaeaaaa
eaaaabaaamabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaa
adaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaa
kgiocaaaaaaaaaaaagaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaa
egaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaa
egaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaa
acaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_ProjectionParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
Vector 17 [_BumpMap_ST]
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
ADD result.texcoord[1].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[1].zw, R0;
MUL result.texcoord[3].xyz, R1, c[14].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[3].w, -R0.x, R0.y;
END
# 21 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
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
Vector 17 [_BumpMap_ST]
"vs_2_0
def c18, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c18.x
mul r1.y, r1, c12.x
mad oT1.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov r0.x, c14.w
add r0.y, c18, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov oT1.zw, r0
mul oT3.xyz, r1, c14.w
mad oT0.zw, v1.xyxy, c17.xyxy, c17
mad oT0.xy, v1, c16, c16.zwzw
mad oT2.xy, v2, c15, c15.zwzw
mul oT3.w, -r0.x, r0.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_BumpMap_ST]
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
eefiecedckkkiaoccchdeafmfemkokgafbnhibfpabaaaaaaleafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcbiaeaaaaeaaaabaa
agabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaa
aaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaaaeaaaaaa
egacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaa
acaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaaeaaaaaabkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_BumpMap_ST]
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
eefiecedejofjfbmanenbednagpooiikppfgomkkabaaaaaaeaaiaaaaaeaaaaaa
daaaaaaaliacaaaaniagaaaakaahaaaaebgpgodjiaacaaaaiaacaaaaaaacpopp
bmacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaafaa
adaaabaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaaacaabjaaabaaafaaaaaaaaaa
adaaaaaaaiaaagaaaaaaaaaaadaaamaaaeaaaoaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbcaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaae
aaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeejaadaaeeka
adaaoekaafaaaaadaaaaapiaaaaaffjaahaaoekaaeaaaaaeaaaaapiaagaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaajaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaaeaaaaka
afaaaaadabaaaiiaabaaaaiabcaaaakaafaaaaadabaaafiaaaaapeiabcaaaaka
acaaaaadabaaadoaabaakkiaabaaomiaaeaaaaaeacaaadoaaeaaoejaabaaoeka
abaaookaafaaaaadabaaahiaaaaaffjaapaaoekaaeaaaaaeabaaahiaaoaaoeka
aaaaaajaabaaoeiaaeaaaaaeabaaahiabaaaoekaaaaakkjaabaaoeiaaeaaaaae
abaaahiabbaaoekaaaaappjaabaaoeiaacaaaaadabaaahiaabaaoeiaafaaoekb
afaaaaadadaaahoaabaaoeiaafaappkaafaaaaadabaaabiaaaaaffjaalaakkka
aeaaaaaeabaaabiaakaakkkaaaaaaajaabaaaaiaaeaaaaaeabaaabiaamaakkka
aaaakkjaabaaaaiaaeaaaaaeabaaabiaanaakkkaaaaappjaabaaaaiaabaaaaac
abaaaiiaafaappkaacaaaaadabaaaciaabaappibbcaaffkaafaaaaadadaaaioa
abaaffiaabaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacabaaamoaaaaaoeiappppaaaafdeieefcbiaeaaaa
eaaaabaaagabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaa
ogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaa
aeaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaia
ebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaaeaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaabejfdeheomaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaa
ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ProjectionParams]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[15] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R3.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[9];
MOV R1.w, c[0].y;
DP4 R2.z, R1, c[7];
DP4 R2.x, R1, c[5];
DP4 R2.y, R1, c[6];
MAD R1.xyz, R2, c[11].w, -vertex.position;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R2.xyz, R0.xyww, c[0].x;
MUL R2.y, R2, c[10].x;
DP3 result.texcoord[3].y, R1, R3;
ADD result.texcoord[1].xy, R2, R2.z;
DP3 result.texcoord[3].z, vertex.normal, R1;
DP3 result.texcoord[3].x, R1, vertex.attrib[14];
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[12], c[12].zwzw;
END
# 25 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"vs_2_0
def c15, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r1.xyz, c8
mov r1.w, c15.y
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
mad r1.xyz, r2, c11.w, -v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c15.x
mul r2.y, r2, c9.x
dp3 oT3.y, r1, r3
mad oT1.xy, r2.z, c10.zwzw, r2
dp3 oT3.z, v2, r1
dp3 oT3.x, r1, v1
mov oPos, r0
mov oT1.zw, r0
mad oT0.zw, v3.xyxy, c14.xyxy, c14
mad oT0.xy, v3, c13, c13.zwzw
mad oT2.xy, v4, c12, c12.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 160
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_BumpMap_ST]
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
eefiecedghblbhnndcpccfeielhpcpjhcnlefpbmabaaaaaaiaafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeadaaaaeaaaabaa
pjaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
agaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
acaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaadaaaaaa
egbabaaaaeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
acaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 160
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_BumpMap_ST]
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
"vs_4_0_level_9_1
eefiecedjcipmffbodbigpkhgdjnoohfggcjlfklabaaaaaaamaiaaaaaeaaaaaa
daaaaaaaliacaaaakeagaaaagmahaaaaebgpgodjiaacaaaaiaacaaaaaaacpopp
ciacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaafaa
adaaabaaaaaaaaaaabaaaeaaacaaaeaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaabaaaafaaakaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafapaaapkaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaaeiaaeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaae
aaaaamoaadaaeejaadaaeekaadaaoekaafaaaaadaaaaapiaaaaaffjaahaaoeka
aeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaiaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaafaaaakaafaaaaadabaaaiiaabaaaaiaapaaaakaafaaaaad
abaaafiaaaaapeiaapaaaakaacaaaaadabaaadoaabaakkiaabaaomiaaeaaaaae
acaaadoaaeaaoejaabaaoekaabaaookaabaaaaacabaaahiaaeaaoekaafaaaaad
acaaahiaabaaffiaalaaoekaaeaaaaaeabaaaliaakaakekaabaaaaiaacaakeia
aeaaaaaeabaaahiaamaaoekaabaakkiaabaapeiaacaaaaadabaaahiaabaaoeia
anaaoekaaeaaaaaeabaaahiaabaaoeiaaoaappkaaaaaoejbaiaaaaadadaaaboa
abaaoejaabaaoeiaabaaaaacacaaahiaabaaoejaafaaaaadadaaahiaacaamjia
acaancjaaeaaaaaeacaaahiaacaamjjaacaanciaadaaoeibafaaaaadacaaahia
acaaoeiaabaappjaaiaaaaadadaaacoaacaaoeiaabaaoeiaaiaaaaadadaaaeoa
acaaoejaabaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacabaaamoaaaaaoeiappppaaaafdeieefcoeadaaaa
eaaaabaapjaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaa
adaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
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
Vector 19 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[20] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[17].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[12];
DP4 R2.y, R0, c[11];
DP4 R2.x, R0, c[10];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[15];
DP4 R3.y, R1, c[14];
DP4 R3.x, R1, c[13];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MAD R0.x, R0, R0, -R0.y;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[16];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[9].x;
ADD result.texcoord[2].xyz, R3, R2;
ADD result.texcoord[1].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[1].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
END
# 29 instructions, 4 R-regs
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
Vector 19 [_BumpMap_ST]
"vs_2_0
def c20, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c17.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c20.y
dp4 r2.z, r0, c12
dp4 r2.y, r0, c11
dp4 r2.x, r0, c10
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c15
dp4 r3.y, r1, c14
dp4 r3.x, r1, c13
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
mad r0.x, r0, r0, -r0.y
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c16
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r0.xyz, r1.xyww, c20.x
mul r0.y, r0, c8.x
add oT2.xyz, r3, r2
mad oT1.xy, r0.z, c9.zwzw, r0
mov oPos, r1
mov oT1.zw, r1
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
Vector 96 [_BumpMap_ST]
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
eefiecedhjghebkfbgcccccjamagfmenclmebepgabaaaaaaleafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
daaeaaaaeaaaabaaamabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
agaaaaaakgiocaaaaaaaaaaaagaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
acaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
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
eefiecedmfhnbbmnekcnkhfgoklgkpfgfbknlhbfabaaaaaagaaiaaaaaeaaaaaa
daaaaaaaniacaaaabaahaaaaniahaaaaebgpgodjkaacaaaakaacaaaaaaacpopp
daacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaafaa
acaaabaaaaaaaaaaabaaafaaabaaadaaaaaaaaaaacaacgaaahaaaeaaaaaaaaaa
adaaaaaaaeaaalaaaaaaaaaaadaaamaaadaaapaaaaaaaaaaadaabeaaabaabcaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbdaaapkaaaaaaadpaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaae
aaaaamoaadaaeejaacaaeekaacaaoekaafaaaaadaaaaapiaaaaaffjaamaaoeka
aeaaaaaeaaaaapiaalaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaanaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaoaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaadaaaakaafaaaaadabaaaiiaabaaaaiabdaaaakaafaaaaad
abaaafiaaaaapeiabdaaaakaacaaaaadabaaadoaabaakkiaabaaomiaafaaaaad
abaaahiaacaaoejabcaappkaafaaaaadacaaahiaabaaffiabaaaoekaaeaaaaae
abaaaliaapaakekaabaaaaiaacaakeiaaeaaaaaeabaaahiabbaaoekaabaakkia
abaapeiaabaaaaacabaaaiiabdaaffkaajaaaaadacaaabiaaeaaoekaabaaoeia
ajaaaaadacaaaciaafaaoekaabaaoeiaajaaaaadacaaaeiaagaaoekaabaaoeia
afaaaaadadaaapiaabaacjiaabaakeiaajaaaaadaeaaabiaahaaoekaadaaoeia
ajaaaaadaeaaaciaaiaaoekaadaaoeiaajaaaaadaeaaaeiaajaaoekaadaaoeia
acaaaaadacaaahiaacaaoeiaaeaaoeiaafaaaaadabaaaciaabaaffiaabaaffia
aeaaaaaeabaaabiaabaaaaiaabaaaaiaabaaffibaeaaaaaeacaaahoaakaaoeka
abaaaaiaacaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacabaaamoaaaaaoeiappppaaaafdeieefcdaaeaaaa
eaaaabaaamabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaa
adaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaa
kgiocaaaaaaaaaaaagaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaa
egaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaa
egaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaa
acaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_ProjectionParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
Vector 17 [_BumpMap_ST]
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
ADD result.texcoord[1].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[1].zw, R0;
MUL result.texcoord[3].xyz, R1, c[14].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[3].w, -R0.x, R0.y;
END
# 21 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
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
Vector 17 [_BumpMap_ST]
"vs_2_0
def c18, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c18.x
mul r1.y, r1, c12.x
mad oT1.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov r0.x, c14.w
add r0.y, c18, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov oT1.zw, r0
mul oT3.xyz, r1, c14.w
mad oT0.zw, v1.xyxy, c17.xyxy, c17
mad oT0.xy, v1, c16, c16.zwzw
mad oT2.xy, v2, c15, c15.zwzw
mul oT3.w, -r0.x, r0.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_BumpMap_ST]
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
eefiecedckkkiaoccchdeafmfemkokgafbnhibfpabaaaaaaleafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcbiaeaaaaeaaaabaa
agabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaa
aaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaaaeaaaaaa
egacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaa
acaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaaeaaaaaabkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_BumpMap_ST]
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
eefiecedejofjfbmanenbednagpooiikppfgomkkabaaaaaaeaaiaaaaaeaaaaaa
daaaaaaaliacaaaaniagaaaakaahaaaaebgpgodjiaacaaaaiaacaaaaaaacpopp
bmacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaafaa
adaaabaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaaacaabjaaabaaafaaaaaaaaaa
adaaaaaaaiaaagaaaaaaaaaaadaaamaaaeaaaoaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbcaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaae
aaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeejaadaaeeka
adaaoekaafaaaaadaaaaapiaaaaaffjaahaaoekaaeaaaaaeaaaaapiaagaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaajaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaaeaaaaka
afaaaaadabaaaiiaabaaaaiabcaaaakaafaaaaadabaaafiaaaaapeiabcaaaaka
acaaaaadabaaadoaabaakkiaabaaomiaaeaaaaaeacaaadoaaeaaoejaabaaoeka
abaaookaafaaaaadabaaahiaaaaaffjaapaaoekaaeaaaaaeabaaahiaaoaaoeka
aaaaaajaabaaoeiaaeaaaaaeabaaahiabaaaoekaaaaakkjaabaaoeiaaeaaaaae
abaaahiabbaaoekaaaaappjaabaaoeiaacaaaaadabaaahiaabaaoeiaafaaoekb
afaaaaadadaaahoaabaaoeiaafaappkaafaaaaadabaaabiaaaaaffjaalaakkka
aeaaaaaeabaaabiaakaakkkaaaaaaajaabaaaaiaaeaaaaaeabaaabiaamaakkka
aaaakkjaabaaaaiaaeaaaaaeabaaabiaanaakkkaaaaappjaabaaaaiaabaaaaac
abaaaiiaafaappkaacaaaaadabaaaciaabaappibbcaaffkaafaaaaadadaaaioa
abaaffiaabaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacabaaamoaaaaaoeiappppaaaafdeieefcbiaeaaaa
eaaaabaaagabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaa
ogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaa
aeaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaia
ebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaaeaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaabejfdeheomaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaa
ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ProjectionParams]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[15] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R3.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[9];
MOV R1.w, c[0].y;
DP4 R2.z, R1, c[7];
DP4 R2.x, R1, c[5];
DP4 R2.y, R1, c[6];
MAD R1.xyz, R2, c[11].w, -vertex.position;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R2.xyz, R0.xyww, c[0].x;
MUL R2.y, R2, c[10].x;
DP3 result.texcoord[3].y, R1, R3;
ADD result.texcoord[1].xy, R2, R2.z;
DP3 result.texcoord[3].z, vertex.normal, R1;
DP3 result.texcoord[3].x, R1, vertex.attrib[14];
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[12], c[12].zwzw;
END
# 25 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"vs_2_0
def c15, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r1.xyz, c8
mov r1.w, c15.y
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
mad r1.xyz, r2, c11.w, -v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c15.x
mul r2.y, r2, c9.x
dp3 oT3.y, r1, r3
mad oT1.xy, r2.z, c10.zwzw, r2
dp3 oT3.z, v2, r1
dp3 oT3.x, r1, v1
mov oPos, r0
mov oT1.zw, r0
mad oT0.zw, v3.xyxy, c14.xyxy, c14
mad oT0.xy, v3, c13, c13.zwzw
mad oT2.xy, v4, c12, c12.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 160
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_BumpMap_ST]
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
eefiecedghblbhnndcpccfeielhpcpjhcnlefpbmabaaaaaaiaafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeadaaaaeaaaabaa
pjaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
agaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
acaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaadaaaaaa
egbabaaaaeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
acaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 160
Vector 80 [unity_LightmapST]
Vector 96 [_MainTex_ST]
Vector 112 [_BumpMap_ST]
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
"vs_4_0_level_9_1
eefiecedjcipmffbodbigpkhgdjnoohfggcjlfklabaaaaaaamaiaaaaaeaaaaaa
daaaaaaaliacaaaakeagaaaagmahaaaaebgpgodjiaacaaaaiaacaaaaaaacpopp
ciacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaafaa
adaaabaaaaaaaaaaabaaaeaaacaaaeaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaabaaaafaaakaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafapaaapkaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaaeiaaeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaae
aaaaamoaadaaeejaadaaeekaadaaoekaafaaaaadaaaaapiaaaaaffjaahaaoeka
aeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaiaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaafaaaakaafaaaaadabaaaiiaabaaaaiaapaaaakaafaaaaad
abaaafiaaaaapeiaapaaaakaacaaaaadabaaadoaabaakkiaabaaomiaaeaaaaae
acaaadoaaeaaoejaabaaoekaabaaookaabaaaaacabaaahiaaeaaoekaafaaaaad
acaaahiaabaaffiaalaaoekaaeaaaaaeabaaaliaakaakekaabaaaaiaacaakeia
aeaaaaaeabaaahiaamaaoekaabaakkiaabaapeiaacaaaaadabaaahiaabaaoeia
anaaoekaaeaaaaaeabaaahiaabaaoeiaaoaappkaaaaaoejbaiaaaaadadaaaboa
abaaoejaabaaoeiaabaaaaacacaaahiaabaaoejaafaaaaadadaaahiaacaamjia
acaancjaaeaaaaaeacaaahiaacaamjjaacaanciaadaaoeibafaaaaadacaaahia
acaaoeiaabaappjaaiaaaaadadaaacoaacaaoeiaabaaoeiaaiaaaaadadaaaeoa
acaaoejaabaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacabaaamoaaaaaoeiappppaaaafdeieefcoeadaaaa
eaaaabaapjaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaa
adaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
"!!ARBfp1.0
PARAM c[2] = { program.local[0..1] };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R1, fragment.texcoord[1], texture[2], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
LG2 R1.w, R1.w;
MUL R1.w, R0, -R1;
LG2 R1.x, R1.x;
LG2 R1.z, R1.z;
LG2 R1.y, R1.y;
ADD R1.xyz, -R1, fragment.texcoord[2];
MUL R2.xyz, R1, c[0];
MUL R2.xyz, R1.w, R2;
MUL R1.w, R1, c[0];
MUL R0.xyz, R0, c[1];
MAD result.color.xyz, R0, R1, R2;
MAD result.color.w, R0, c[1], R1;
END
# 14 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s2
dcl t0.xy
dcl t1
dcl t2.xyz
texldp r0, t1, s2
texld r1, t0, s0
log_pp r0.x, r0.x
log_pp r0.z, r0.z
log_pp r0.y, r0.y
add_pp r2.xyz, -r0, t2
log_pp r0.x, r0.w
mul_pp r0.x, r1.w, -r0
mul_pp r3.xyz, r2, c0
mul_pp r3.xyz, r0.x, r3
mul_pp r0.x, r0, c0.w
mul_pp r1.xyz, r1, c1
mad_pp r1.xyz, r1, r2, r3
mad_pp r1.w, r1, c1, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 128
Vector 32 [_SpecColor]
Vector 48 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbdjodkhkmdkmgjmdjmgjlibnckmkicpdabaaaaaanmacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcomabaaaaeaaaaaaahlaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaafpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegbcbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaacaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaacaaaaaadkaabaaaacaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 128
Vector 32 [_SpecColor]
Vector 48 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefieceddobgoamoiaeplodpcoodeapolikaeianabaaaaaageaeaaaaaeaaaaaa
daaaaaaaleabaaaakiadaaaadaaeaaaaebgpgodjhmabaaaahmabaaaaaaacpppp
eeabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaacaaacaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaacaaaaaiiaabaapplaafaaaaad
aaaaadiaaaaappiaabaaoelaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaacpiaaaaaoelaaaaioekaapaaaaacacaacbiaaaaaaaiaapaaaaacacaaccia
aaaaffiaapaaaaacacaaceiaaaaakkiaapaaaaacacaaciiaaaaappiaacaaaaad
aaaachiaacaaoeibacaaoelaafaaaaadacaachiaaaaaoeiaaaaaoekaafaaaaad
aaaaciiaabaappiaacaappibafaaaaadacaachiaaaaappiaacaaoeiaafaaaaad
aaaaciiaaaaappiaaaaappkaaeaaaaaeadaaciiaabaappiaabaappkaaaaappia
afaaaaadabaachiaabaaoeiaabaaoekaaeaaaaaeadaachiaabaaoeiaaaaaoeia
acaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefcomabaaaaeaaaaaaa
hlaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaacpaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaegbcbaaaadaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaacaaaaaadiaaaaai
pcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakiccabaaa
aaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaadkaabaaaacaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaa
heaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TXP R1, fragment.texcoord[1], texture[2], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R3, fragment.texcoord[2], texture[3], 2D;
TEX R2, fragment.texcoord[2], texture[4], 2D;
MUL R3.xyz, R3.w, R3;
MUL R2.xyz, R2.w, R2;
MUL R2.xyz, R2, c[3].x;
DP4 R3.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R2.w, R3.w;
RCP R2.w, R2.w;
LG2 R1.w, R1.w;
MUL R1.w, R0, -R1;
MAD R3.xyz, R3, c[3].x, -R2;
MAD_SAT R2.w, R2, c[2].z, c[2];
MAD R2.xyz, R2.w, R3, R2;
LG2 R1.x, R1.x;
LG2 R1.y, R1.y;
LG2 R1.z, R1.z;
ADD R1.xyz, -R1, R2;
MUL R2.xyz, R1, c[0];
MUL R2.xyz, R1.w, R2;
MUL R1.w, R1, c[0];
MUL R0.xyz, R0, c[1];
MAD result.color.xyz, R0, R1, R2;
MAD result.color.w, R0, c[1], R1;
END
# 25 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"ps_2_0
dcl_2d s0
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c3, 8.00000000, 0, 0, 0
dcl t0.xy
dcl t1
dcl t2.xy
dcl t3
texld r2, t0, s0
texldp r1, t1, s2
texld r0, t2, s3
texld r3, t2, s4
mul_pp r4.xyz, r0.w, r0
mul_pp r3.xyz, r3.w, r3
mul_pp r3.xyz, r3, c3.x
dp4 r0.x, t3, t3
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r4.xyz, r4, c3.x, -r3
mad_sat r0.x, r0, c2.z, c2.w
mad_pp r0.xyz, r0.x, r4, r3
log_pp r1.x, r1.x
log_pp r1.y, r1.y
log_pp r1.z, r1.z
add_pp r1.xyz, -r1, r0
log_pp r0.x, r1.w
mul_pp r3.xyz, r1, c0
mul_pp r0.x, r2.w, -r0
mul_pp r3.xyz, r0.x, r3
mul_pp r0.x, r0, c0.w
mul_pp r2.xyz, r2, c1
mad_pp r1.xyz, r2, r1, r3
mad_pp r1.w, r2, c1, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 160
Vector 32 [_SpecColor]
Vector 48 [_Color]
Vector 128 [unity_LightmapFade]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkpaeacknogadcbnihgbafcdlenebhkihabaaaaaahmaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcheadaaaaeaaaaaaannaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
lcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabbaaaaahbcaabaaaaaaaaaaa
egbobaaaaeaaaaaaegbobaaaaeaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadccaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaa
aiaaaaaadkiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaa
abaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaajgahbaiaebaaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaafpcaabaaa
abaaaaaaegaobaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaabaaaaaadkaabaaaacaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaacaaaaaadkaabaaaacaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 160
Vector 32 [_SpecColor]
Vector 48 [_Color]
Vector 128 [unity_LightmapFade]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedkieglgbjnndkfamimojcigojoekpcnkfabaaaaaaaiahaaaaaeaaaaaa
daaaaaaaliacaaaadeagaaaaneagaaaaebgpgodjiaacaaaaiaacaaaaaaacpppp
deacaaaaemaaaaaaacaadeaaaaaaemaaaaaaemaaaeaaceaaaaaaemaaaaaaaaaa
abababaaacacacaaadadadaaaaaaacaaacaaaaaaaaaaaaaaaaaaaiaaabaaacaa
aaaaaaaaaaacppppfbaaaaafadaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaia
acaaadlabpaaaaacaaaaaaiaadaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapka
agaaaaacaaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaecaaaaad
abaacpiaacaaoelaadaioekaecaaaaadacaacpiaacaaoelaacaioekaecaaaaad
aaaacpiaaaaaoeiaabaioekaecaaaaadadaacpiaaaaaoelaaaaioekaajaaaaad
aeaaaiiaadaaoelaadaaoelaahaaaaacaeaaabiaaeaappiaagaaaaacaeaaabia
aeaaaaiaaeaaaaaeaeaadbiaaeaaaaiaacaakkkaacaappkaafaaaaadabaaciia
abaappiaadaaaakaafaaaaadabaachiaabaaoeiaabaappiaafaaaaadabaaciia
acaappiaadaaaakaaeaaaaaeacaachiaabaappiaacaaoeiaabaaoeibaeaaaaae
abaachiaaeaaaaiaacaaoeiaabaaoeiaapaaaaacacaacbiaaaaaaaiaapaaaaac
acaacciaaaaaffiaapaaaaacacaaceiaaaaakkiaapaaaaacabaaciiaaaaappia
acaaaaadaaaachiaabaaoeiaacaaoeibafaaaaadabaachiaaaaaoeiaaaaaoeka
afaaaaadaaaaciiaadaappiaabaappibafaaaaadabaachiaaaaappiaabaaoeia
afaaaaadaaaaciiaaaaappiaaaaappkaaeaaaaaeacaaciiaadaappiaabaappka
aaaappiaafaaaaadadaachiaadaaoeiaabaaoekaaeaaaaaeacaachiaadaaoeia
aaaaoeiaabaaoeiaabaaaaacaaaicpiaacaaoeiappppaaaafdeieefcheadaaaa
eaaaaaaannaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaabbaaaaahbcaabaaaaaaaaaaaegbobaaaaeaaaaaa
egbobaaaaeaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaal
bcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaaiaaaaaadkiacaaa
aaaaaaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdcaaaaakhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
jgahbaiaebaaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
acaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaafpcaabaaaabaaaaaaegaobaaa
abaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaa
dkaabaaaacaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaa
aaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
acaaaaaadkaabaaaacaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapadaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapalaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"!!ARBfp1.0
PARAM c[7] = { program.local[0..2],
		{ 2, 1, 8, 0 },
		{ -0.40824828, -0.70710677, 0.57735026, 128 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TXP R1, fragment.texcoord[1], texture[2], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[3], 2D;
TEX R3, fragment.texcoord[2], texture[4], 2D;
TEX R4.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R4.xy, R4.wyzw, c[3].x, -c[3].y;
MUL R3.xyz, R3.w, R3;
MUL R3.xyz, R3, c[3].z;
MUL R5.xyz, R3.y, c[5];
MAD R5.xyz, R3.x, c[6], R5;
MAD R5.xyz, R3.z, c[4], R5;
DP3 R3.w, R5, R5;
RSQ R3.w, R3.w;
MUL R5.xyz, R3.w, R5;
MUL R4.zw, R4.xyxy, R4.xyxy;
ADD_SAT R4.z, R4, R4.w;
DP3 R3.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R3.w, R3.w;
MAD R5.xyz, R3.w, fragment.texcoord[3], R5;
DP3 R3.w, R5, R5;
ADD R4.w, -R4.z, c[3].y;
RSQ R4.z, R3.w;
MUL R5.xyz, R4.z, R5;
RSQ R3.w, R4.w;
RCP R4.z, R3.w;
DP3 R3.w, R4, R5;
MUL R2.xyz, R2.w, R2;
MAX R3.w, R3, c[3];
DP3_SAT R5.z, R4, c[4];
DP3_SAT R5.x, R4, c[6];
DP3_SAT R5.y, R4, c[5];
DP3 R3.x, R5, R3;
MOV R3.y, c[4].w;
MUL R2.w, R3.y, c[2].x;
MUL R2.xyz, R2, R3.x;
MUL R2.xyz, R2, c[3].z;
POW R2.w, R3.w, R2.w;
LG2 R1.x, R1.x;
LG2 R1.y, R1.y;
LG2 R1.z, R1.z;
LG2 R1.w, R1.w;
ADD R1, -R1, R2;
MUL R1.w, R0, R1;
MUL R2.xyz, R1, c[0];
MUL R2.xyz, R1.w, R2;
MUL R1.w, R1, c[0];
MUL R0.xyz, R0, c[1];
MAD result.color.xyz, R1, R0, R2;
MAD result.color.w, R0, c[1], R1;
END
# 49 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c3, 2.00000000, -1.00000000, 1.00000000, 8.00000000
def c4, -0.40824828, -0.70710677, 0.57735026, 0.00000000
def c5, -0.40824831, 0.70710677, 0.57735026, 128.00000000
def c6, 0.81649655, 0.00000000, 0.57735026, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3.xyz
texld r1, t0, s0
texldp r2, t1, s2
texld r3, t2, s3
texld r4, t2, s4
mul_pp r4.xyz, r4.w, r4
mul_pp r4.xyz, r4, c3.w
mul r5.xyz, r4.y, c5
mad r5.xyz, r4.x, c6, r5
mad r5.xyz, r4.z, c4, r5
mul_pp r3.xyz, r3.w, r3
log_pp r2.x, r2.x
log_pp r2.y, r2.y
log_pp r2.z, r2.z
mov r0.y, t0.w
mov r0.x, t0.z
log_pp r2.w, r2.w
mul_pp r1.xyz, r1, c1
texld r0, r0, s1
dp3 r0.x, r5, r5
rsq r0.x, r0.x
mul r5.xyz, r0.x, r5
mov r0.x, r0.w
mad_pp r7.xy, r0, c3.x, c3.y
dp3_pp r0.x, t3, t3
rsq_pp r0.x, r0.x
mad_pp r0.xyz, r0.x, t3, r5
mul_pp r6.xy, r7, r7
add_pp_sat r5.x, r6, r6.y
dp3_pp r6.x, r0, r0
rsq_pp r6.x, r6.x
add_pp r5.x, -r5, c3.z
rsq_pp r5.x, r5.x
rcp_pp r7.z, r5.x
mul_pp r0.xyz, r6.x, r0
dp3_pp r0.x, r7, r0
mov_pp r5.x, c2
max_pp r0.x, r0, c4.w
mul_pp r5.x, c5.w, r5
pow r6.x, r0.x, r5.x
dp3_pp_sat r0.z, r7, c4
dp3_pp_sat r0.y, r7, c5
dp3_pp_sat r0.x, r7, c6
dp3_pp r0.x, r0, r4
mul_pp r0.xyz, r3, r0.x
mov r0.w, r6.x
mul_pp r0.xyz, r0, c3.w
add_pp r0, -r2, r0
mul_pp r3.x, r1.w, r0.w
mul_pp r2.xyz, r0, c0
mul_pp r2.xyz, r3.x, r2
mul_pp r3.x, r3, c0.w
mad_pp r0.xyz, r0, r1, r2
mad_pp r0.w, r1, c1, r3.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 160
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgoaaeckhfmddbljakmjjmnkjeilfcjkpabaaaaaajeahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcimagaaaaeaaaaaaakdabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadlcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
acaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafpcaabaaaaaaaaaaaegaobaaa
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaa
eeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaabaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
adaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaapgapbaaaabaaaaaadiaaaaakhcaabaaaadaaaaaafgafbaaaacaaaaaa
aceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaadcaaaaamhcaabaaaadaaaaaa
agaabaaaacaaaaaaaceaaaaaolaffbdpaaaaaaaadkmnbddpaaaaaaaaegacbaaa
adaaaaaadcaaaaamhcaabaaaadaaaaaakgakbaaaacaaaaaaaceaaaaaolafnblo
pdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
adaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaa
egaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaadeaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaaakiacaaaaaaaaaaa
aeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaabjaaaaaficaabaaaabaaaaaaakaabaaaabaaaaaaapcaaaak
bcaabaaaaeaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaa
adaaaaaabacaaaakccaabaaaaeaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddp
aaaaaaaaegacbaaaadaaaaaabacaaaakecaabaaaaeaaaaaaaceaaaaaolafnblo
pdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaacaaaaaa
egacbaaaaeaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaa
adaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahccaabaaaacaaaaaa
dkaabaaaadaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaacaaaaaaagajbaaa
adaaaaaafgafbaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaacaaaaaa
jgahbaaaacaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaiaebaaaaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaacaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaa
aaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
acaaaaaadkaabaaaacaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 160
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedliabcdkmpechkldfgiocfcelhpllibopabaaaaaamaalaaaaaeaaaaaa
daaaaaaafiaeaaaaomakaaaaimalaaaaebgpgodjcaaeaaaacaaeaaaaaaacpppp
nmadaaaaeeaaaaaaabaadiaaaaaaeeaaaaaaeeaaafaaceaaaaaaeeaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaaaaaacaaadaaaaaaaaaaaaaaaaacpppp
fbaaaaafadaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafaeaaapka
omafnblopdaedfdpdkmnbddpaaaaaaedfbaaaaafafaaapkaolafnblopdaedflp
dkmnbddpaaaaaaaafbaaaaafagaaapkaaaaaaaebdkmnbddpaaaaaaaaolaffbdp
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaia
acaaadlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapka
bpaaaaacaaaaaajaaeaiapkaabaaaaacaaaaabiaaaaakklaabaaaaacaaaaacia
aaaapplaagaaaaacaaaaaeiaabaapplaafaaaaadabaaadiaaaaakkiaabaaoela
ecaaaaadacaacpiaacaaoelaadaioekaecaaaaadaaaacpiaaaaaoeiaabaioeka
ecaaaaadadaacpiaacaaoelaaeaioekaecaaaaadabaacpiaabaaoeiaacaioeka
ecaaaaadaeaacpiaaaaaoelaaaaioekaafaaaaadacaaciiaacaappiaagaaaaka
afaaaaadacaachiaacaaoeiaacaappiaaeaaaaaeafaacbiaaaaappiaadaaaaka
adaaffkaaeaaaaaeafaacciaaaaaffiaadaaaakaadaaffkafkaaaaaeacaadiia
afaaoeiaafaaoeiaadaakkkaacaaaaadacaaciiaacaappibadaappkaahaaaaac
acaaciiaacaappiaagaaaaacafaaceiaacaappiaaiaaaaadaaaadbiaagaablka
afaaoeiaaiaaaaadaaaadciaaeaaoekaafaaoeiaaiaaaaadaaaadeiaafaaoeka
afaaoeiaafaaaaadaaaaciiaadaappiaagaaaakaafaaaaadadaachiaadaaoeia
aaaappiaaiaaaaadacaaciiaaaaaoeiaadaaoeiaafaaaaadaaaachiaacaappia
acaaoeiaafaaaaadacaaahiaadaaffiaaeaaoekaaeaaaaaeacaaahiaadaaaaia
agaablkaacaaoeiaaeaaaaaeacaaahiaadaakkiaafaaoekaacaaoeiaaiaaaaad
acaaaiiaacaaoeiaacaaoeiaahaaaaacacaaaiiaacaappiaceaaaaacadaachia
adaaoelaaeaaaaaeacaachiaacaaoeiaacaappiaadaaoeiaceaaaaacadaachia
acaaoeiaaiaaaaadacaacbiaafaaoeiaadaaoeiaalaaaaadadaaabiaacaaaaia
adaakkkaabaaaaacacaaaiiaaeaappkaafaaaaadacaaabiaacaappiaacaaaaka
caaaaaadaaaaciiaadaaaaiaacaaaaiaapaaaaacacaacbiaabaaaaiaapaaaaac
acaacciaabaaffiaapaaaaacacaaceiaabaakkiaapaaaaacacaaciiaabaappia
acaaaaadaaaacpiaaaaaoeiaacaaoeibafaaaaadabaachiaaaaaoeiaaaaaoeka
afaaaaadaaaaciiaaeaappiaaaaappiaafaaaaadabaachiaaaaappiaabaaoeia
afaaaaadaaaaciiaaaaappiaaaaappkaaeaaaaaeacaaciiaaeaappiaabaappka
aaaappiaafaaaaadadaachiaaeaaoeiaabaaoekaaeaaaaaeacaachiaadaaoeia
aaaaoeiaabaaoeiaabaaaaacaaaicpiaacaaoeiappppaaaafdeieefcimagaaaa
eaaaaaaakdabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaad
dcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacafaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaacpaaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaa
egbcbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaa
abaaaaaadiaaaaakhcaabaaaadaaaaaafgafbaaaacaaaaaaaceaaaaaomafnblo
pdaedfdpdkmnbddpaaaaaaaadcaaaaamhcaabaaaadaaaaaaagaabaaaacaaaaaa
aceaaaaaolaffbdpaaaaaaaadkmnbddpaaaaaaaaegacbaaaadaaaaaadcaaaaam
hcaabaaaadaaaaaakgakbaaaacaaaaaaaceaaaaaolafnblopdaedflpdkmnbddp
aaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaa
adaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaaadaaaaaa
egaabaaaadaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaabaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaaiccaabaaaabaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaa
aaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
bjaaaaaficaabaaaabaaaaaaakaabaaaabaaaaaaapcaaaakbcaabaaaaeaaaaaa
aceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaaadaaaaaabacaaaak
ccaabaaaaeaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaa
adaaaaaabacaaaakecaabaaaaeaaaaaaaceaaaaaolafnblopdaedflpdkmnbddp
aaaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaaeaaaaaa
egacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaadaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadiaaaaahccaabaaaacaaaaaadkaabaaaadaaaaaa
abeaaaaaaaaaaaebdiaaaaahocaabaaaacaaaaaaagajbaaaadaaaaaafgafbaaa
acaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaacaaaaaajgahbaaaacaaaaaa
aaaaaaaipcaabaaaaaaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaacaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaadaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
iccabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaadkaabaaa
acaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
"!!ARBfp1.0
PARAM c[2] = { program.local[0..1] };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R1, fragment.texcoord[1], texture[2], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2.w, R0, R1;
ADD R1.xyz, R1, fragment.texcoord[2];
MUL R2.xyz, R1, c[0];
MUL R1.w, R2, c[0];
MUL R2.xyz, R2.w, R2;
MUL R0.xyz, R0, c[1];
MAD result.color.xyz, R0, R1, R2;
MAD result.color.w, R0, c[1], R1;
END
# 10 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s2
dcl t0.xy
dcl t1
dcl t2.xyz
texldp r0, t1, s2
texld r2, t0, s0
add_pp r3.xyz, r0, t2
mul_pp r1.x, r2.w, r0.w
mul_pp r0.x, r1, c0.w
mul_pp r4.xyz, r3, c0
mul_pp r1.xyz, r1.x, r4
mul_pp r2.xyz, r2, c1
mad_pp r1.xyz, r2, r3, r1
mad_pp r1.w, r2, c1, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 128
Vector 32 [_SpecColor]
Vector 48 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmpjmgpphdgdimobdblligmbofffbejlbabaaaaaamaacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcnaabaaaaeaaaaaaaheaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaaipcaabaaaacaaaaaa
egaobaaaacaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaacaaaaaadkaabaaaacaaaaaadcaaaaajhccabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 128
Vector 32 [_SpecColor]
Vector 48 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedpnolkiajklfpomoeelgfcaefnamceefeabaaaaaabiaeaaaaaeaaaaaa
daaaaaaaieabaaaafmadaaaaoeadaaaaebgpgodjemabaaaaemabaaaaaaacpppp
beabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaacaaacaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaacaaaaaiiaabaapplaafaaaaad
aaaaadiaaaaappiaabaaoelaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaacpiaaaaaoelaaaaioekaacaaaaadaaaachiaaaaaoeiaacaaoelaafaaaaad
acaachiaaaaaoeiaaaaaoekaafaaaaadaaaaciiaaaaappiaabaappiaafaaaaad
acaachiaaaaappiaacaaoeiaafaaaaadaaaaciiaaaaappiaaaaappkaaeaaaaae
adaaciiaabaappiaabaappkaaaaappiaafaaaaadabaachiaabaaoeiaabaaoeka
aeaaaaaeadaachiaabaaoeiaaaaaoeiaacaaoeiaabaaaaacaaaicpiaadaaoeia
ppppaaaafdeieefcnaabaaaaeaaaaaaaheaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaacaaaaaadkaabaaaacaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapadaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TXP R1, fragment.texcoord[1], texture[2], 2D;
TEX R3, fragment.texcoord[2], texture[3], 2D;
TEX R2, fragment.texcoord[2], texture[4], 2D;
MUL R3.xyz, R3.w, R3;
MUL R2.xyz, R2.w, R2;
MUL R2.xyz, R2, c[3].x;
DP4 R3.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R2.w, R3.w;
RCP R2.w, R2.w;
MUL R1.w, R0, R1;
MAD R3.xyz, R3, c[3].x, -R2;
MAD_SAT R2.w, R2, c[2].z, c[2];
MAD R2.xyz, R2.w, R3, R2;
ADD R1.xyz, R1, R2;
MUL R2.xyz, R1, c[0];
MUL R2.xyz, R1.w, R2;
MUL R1.w, R1, c[0];
MUL R0.xyz, R0, c[1];
MAD result.color.xyz, R0, R1, R2;
MAD result.color.w, R0, c[1], R1;
END
# 21 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"ps_2_0
dcl_2d s0
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c3, 8.00000000, 0, 0, 0
dcl t0.xy
dcl t1
dcl t2.xy
dcl t3
texld r2, t0, s0
texldp r1, t1, s2
texld r0, t2, s3
texld r3, t2, s4
mul_pp r4.xyz, r0.w, r0
dp4 r0.x, t3, t3
mul_pp r3.xyz, r3.w, r3
mul_pp r3.xyz, r3, c3.x
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r4.xyz, r4, c3.x, -r3
mad_sat r0.x, r0, c2.z, c2.w
mad_pp r0.xyz, r0.x, r4, r3
add_pp r1.xyz, r1, r0
mul_pp r0.x, r2.w, r1.w
mul_pp r3.xyz, r1, c0
mul_pp r3.xyz, r0.x, r3
mul_pp r0.x, r0, c0.w
mul_pp r2.xyz, r2, c1
mad_pp r1.xyz, r2, r1, r3
mad_pp r1.w, r2, c1, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 160
Vector 32 [_SpecColor]
Vector 48 [_Color]
Vector 128 [unity_LightmapFade]
BindCB  "$Globals" 0
"ps_4_0
eefiecedccebbcfohikjhlgcjdnciiobfbpoppkeabaaaaaagaaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcfiadaaaaeaaaaaaangaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
lcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabbaaaaahbcaabaaaaaaaaaaa
egbobaaaaeaaaaaaegbobaaaaeaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadccaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaa
aiaaaaaadkiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaa
abaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaajgahbaiaebaaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaadiaaaaaipcaabaaaacaaaaaa
egaobaaaacaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaacaaaaaadkaabaaaacaaaaaadcaaaaajhccabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 160
Vector 32 [_SpecColor]
Vector 48 [_Color]
Vector 128 [unity_LightmapFade]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedkmjgkhmjndcdfmhfikimmfdidgmkdpnbabaaaaaalmagaaaaaeaaaaaa
daaaaaaaiiacaaaaoiafaaaaiiagaaaaebgpgodjfaacaaaafaacaaaaaaacpppp
aeacaaaaemaaaaaaacaadeaaaaaaemaaaaaaemaaaeaaceaaaaaaemaaaaaaaaaa
abababaaacacacaaadadadaaaaaaacaaacaaaaaaaaaaaaaaaaaaaiaaabaaacaa
aaaaaaaaaaacppppfbaaaaafadaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaia
acaaadlabpaaaaacaaaaaaiaadaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapka
agaaaaacaaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaecaaaaad
abaacpiaacaaoelaadaioekaecaaaaadacaacpiaacaaoelaacaioekaecaaaaad
aaaacpiaaaaaoeiaabaioekaecaaaaadadaacpiaaaaaoelaaaaioekaajaaaaad
aeaaaiiaadaaoelaadaaoelaahaaaaacaeaaabiaaeaappiaagaaaaacaeaaabia
aeaaaaiaaeaaaaaeaeaadbiaaeaaaaiaacaakkkaacaappkaafaaaaadabaaciia
abaappiaadaaaakaafaaaaadabaachiaabaaoeiaabaappiaafaaaaadabaaciia
acaappiaadaaaakaaeaaaaaeacaachiaabaappiaacaaoeiaabaaoeibaeaaaaae
abaachiaaeaaaaiaacaaoeiaabaaoeiaacaaaaadaaaachiaaaaaoeiaabaaoeia
afaaaaadabaachiaaaaaoeiaaaaaoekaafaaaaadaaaaciiaaaaappiaadaappia
afaaaaadabaachiaaaaappiaabaaoeiaafaaaaadaaaaciiaaaaappiaaaaappka
aeaaaaaeacaaciiaadaappiaabaappkaaaaappiaafaaaaadadaachiaadaaoeia
abaaoekaaeaaaaaeacaachiaadaaoeiaaaaaoeiaabaaoeiaabaaaaacaaaicpia
acaaoeiappppaaaafdeieefcfiadaaaaeaaaaaaangaaaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabbaaaaah
bcaabaaaaaaaaaaaegbobaaaaeaaaaaaegbobaaaaeaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadccaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckiacaaaaaaaaaaaaiaaaaaadkiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaadaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaah
ccaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaa
aaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaadaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaajgahbaiaebaaaaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaadiaaaaai
pcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakiccabaaa
aaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaadkaabaaaacaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"!!ARBfp1.0
PARAM c[7] = { program.local[0..2],
		{ 2, 1, 8, 0 },
		{ -0.40824828, -0.70710677, 0.57735026, 128 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[3], 2D;
TEX R3, fragment.texcoord[2], texture[4], 2D;
TEX R4.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TXP R1, fragment.texcoord[1], texture[2], 2D;
MAD R4.xy, R4.wyzw, c[3].x, -c[3].y;
MUL R3.xyz, R3.w, R3;
MUL R3.xyz, R3, c[3].z;
MUL R5.xyz, R3.y, c[5];
MAD R5.xyz, R3.x, c[6], R5;
MAD R5.xyz, R3.z, c[4], R5;
DP3 R3.w, R5, R5;
RSQ R3.w, R3.w;
MUL R5.xyz, R3.w, R5;
MUL R4.zw, R4.xyxy, R4.xyxy;
ADD_SAT R4.z, R4, R4.w;
DP3 R3.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R3.w, R3.w;
MAD R5.xyz, R3.w, fragment.texcoord[3], R5;
DP3 R3.w, R5, R5;
ADD R4.w, -R4.z, c[3].y;
RSQ R4.z, R3.w;
MUL R5.xyz, R4.z, R5;
RSQ R3.w, R4.w;
RCP R4.z, R3.w;
DP3 R3.w, R4, R5;
MUL R2.xyz, R2.w, R2;
MAX R3.w, R3, c[3];
DP3_SAT R5.z, R4, c[4];
DP3_SAT R5.x, R4, c[6];
DP3_SAT R5.y, R4, c[5];
DP3 R3.x, R5, R3;
MOV R3.y, c[4].w;
MUL R2.w, R3.y, c[2].x;
MUL R2.xyz, R2, R3.x;
MUL R2.xyz, R2, c[3].z;
POW R2.w, R3.w, R2.w;
ADD R1, R1, R2;
MUL R1.w, R0, R1;
MUL R2.xyz, R1, c[0];
MUL R2.xyz, R1.w, R2;
MUL R1.w, R1, c[0];
MUL R0.xyz, R0, c[1];
MAD result.color.xyz, R1, R0, R2;
MAD result.color.w, R0, c[1], R1;
END
# 45 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Shininess]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c3, 2.00000000, -1.00000000, 1.00000000, 8.00000000
def c4, -0.40824828, -0.70710677, 0.57735026, 0.00000000
def c5, -0.40824831, 0.70710677, 0.57735026, 128.00000000
def c6, 0.81649655, 0.00000000, 0.57735026, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3.xyz
texld r1, t0, s0
texldp r2, t1, s2
texld r3, t2, s3
texld r4, t2, s4
mul_pp r4.xyz, r4.w, r4
mul_pp r4.xyz, r4, c3.w
mul r5.xyz, r4.y, c5
mad r5.xyz, r4.x, c6, r5
mad r5.xyz, r4.z, c4, r5
mul_pp r3.xyz, r3.w, r3
mov r0.y, t0.w
mov r0.x, t0.z
mul_pp r1.xyz, r1, c1
texld r0, r0, s1
dp3 r0.x, r5, r5
rsq r0.x, r0.x
mul r5.xyz, r0.x, r5
mov r0.x, r0.w
mad_pp r7.xy, r0, c3.x, c3.y
dp3_pp r0.x, t3, t3
rsq_pp r0.x, r0.x
mad_pp r0.xyz, r0.x, t3, r5
mul_pp r6.xy, r7, r7
add_pp_sat r5.x, r6, r6.y
dp3_pp r6.x, r0, r0
rsq_pp r6.x, r6.x
add_pp r5.x, -r5, c3.z
rsq_pp r5.x, r5.x
rcp_pp r7.z, r5.x
mul_pp r0.xyz, r6.x, r0
dp3_pp r0.x, r7, r0
mov_pp r5.x, c2
max_pp r0.x, r0, c4.w
mul_pp r5.x, c5.w, r5
pow r6.x, r0.x, r5.x
dp3_pp_sat r0.z, r7, c4
dp3_pp_sat r0.y, r7, c5
dp3_pp_sat r0.x, r7, c6
dp3_pp r0.x, r0, r4
mul_pp r0.xyz, r3, r0.x
mov r0.w, r6.x
mul_pp r0.xyz, r0, c3.w
add_pp r0, r2, r0
mul_pp r3.x, r1.w, r0.w
mul_pp r2.xyz, r0, c0
mul_pp r2.xyz, r3.x, r2
mul_pp r3.x, r3, c0.w
mad_pp r0.xyz, r0, r1, r2
mad_pp r0.w, r1, c1, r3.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 160
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbdnfjhpplccgbckkppkpjaijeolbpnpiabaaaaaahmahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcheagaaaaeaaaaaaajnabaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadlcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
aeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaaaeaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaakhcaabaaa
acaaaaaafgafbaaaabaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaa
dcaaaaamhcaabaaaacaaaaaaagaabaaaabaaaaaaaceaaaaaolaffbdpaaaaaaaa
dkmnbddpaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaacaaaaaakgakbaaa
abaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaaficaabaaaaaaaaaaa
akaabaaaaaaaaaaaaoaaaaahdcaabaaaadaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaapcaaaakbcaabaaaaeaaaaaaaceaaaaaolaffbdpdkmnbddp
aaaaaaaaaaaaaaaaigaabaaaacaaaaaabacaaaakccaabaaaaeaaaaaaaceaaaaa
omafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaacaaaaaabacaaaakecaabaaa
aeaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaa
diaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaah
ocaabaaaabaaaaaaagajbaaaacaaaaaafgafbaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaaaaaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaa
acaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaacaaaaaadkaabaaaacaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 160
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedghmfomgeboonjfnlahcldhbigkmooldhabaaaaaahialaaaaaeaaaaaa
daaaaaaaciaeaaaakeakaaaaeealaaaaebgpgodjpaadaaaapaadaaaaaaacpppp
kmadaaaaeeaaaaaaabaadiaaaaaaeeaaaaaaeeaaafaaceaaaaaaeeaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaaaaaacaaadaaaaaaaaaaaaaaaaacpppp
fbaaaaafadaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafaeaaapka
omafnblopdaedfdpdkmnbddpaaaaaaedfbaaaaafafaaapkaolafnblopdaedflp
dkmnbddpaaaaaaaafbaaaaafagaaapkaaaaaaaebdkmnbddpaaaaaaaaolaffbdp
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaia
acaaadlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapka
bpaaaaacaaaaaajaaeaiapkaagaaaaacaaaaaiiaabaapplaafaaaaadaaaaadia
aaaappiaabaaoelaabaaaaacabaaabiaaaaakklaabaaaaacabaaaciaaaaappla
ecaaaaadaaaacpiaaaaaoeiaacaioekaecaaaaadacaacpiaacaaoelaadaioeka
ecaaaaadabaacpiaabaaoeiaabaioekaecaaaaadadaacpiaacaaoelaaeaioeka
ecaaaaadaeaacpiaaaaaoelaaaaioekaafaaaaadacaaciiaacaappiaagaaaaka
afaaaaadacaachiaacaaoeiaacaappiaaeaaaaaeafaacbiaabaappiaadaaaaka
adaaffkaaeaaaaaeafaacciaabaaffiaadaaaakaadaaffkafkaaaaaeacaadiia
afaaoeiaafaaoeiaadaakkkaacaaaaadacaaciiaacaappibadaappkaahaaaaac
acaaciiaacaappiaagaaaaacafaaceiaacaappiaaiaaaaadabaadbiaagaablka
afaaoeiaaiaaaaadabaadciaaeaaoekaafaaoeiaaiaaaaadabaadeiaafaaoeka
afaaoeiaafaaaaadabaaciiaadaappiaagaaaakaafaaaaadadaachiaadaaoeia
abaappiaaiaaaaadacaaciiaabaaoeiaadaaoeiaafaaaaadabaachiaacaappia
acaaoeiaafaaaaadacaaahiaadaaffiaaeaaoekaaeaaaaaeacaaahiaadaaaaia
agaablkaacaaoeiaaeaaaaaeacaaahiaadaakkiaafaaoekaacaaoeiaaiaaaaad
acaaaiiaacaaoeiaacaaoeiaahaaaaacacaaaiiaacaappiaceaaaaacadaachia
adaaoelaaeaaaaaeacaachiaacaaoeiaacaappiaadaaoeiaceaaaaacadaachia
acaaoeiaaiaaaaadacaacbiaafaaoeiaadaaoeiaalaaaaadadaaabiaacaaaaia
adaakkkaabaaaaacacaaaiiaaeaappkaafaaaaadacaaabiaacaappiaacaaaaka
caaaaaadabaaciiaadaaaaiaacaaaaiaacaaaaadaaaacpiaaaaaoeiaabaaoeia
afaaaaadabaachiaaaaaoeiaaaaaoekaafaaaaadaaaaciiaaeaappiaaaaappia
afaaaaadabaachiaaaaappiaabaaoeiaafaaaaadaaaaciiaaaaappiaaaaappka
aeaaaaaeacaaciiaaeaappiaabaappkaaaaappiaafaaaaadadaachiaaeaaoeia
abaaoekaaeaaaaaeacaachiaadaaoeiaaaaaoeiaabaaoeiaabaaaaacaaaicpia
acaaoeiappppaaaafdeieefcheagaaaaeaaaaaaajnabaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadlcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
aeaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
diaaaaakhcaabaaaacaaaaaafgafbaaaabaaaaaaaceaaaaaomafnblopdaedfdp
dkmnbddpaaaaaaaadcaaaaamhcaabaaaacaaaaaaagaabaaaabaaaaaaaceaaaaa
olaffbdpaaaaaaaadkmnbddpaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaa
acaaaaaakgakbaaaabaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaa
egacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaaacaaaaaaegaabaaa
acaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaacaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaiccaabaaaaaaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaed
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabjaaaaaf
icaabaaaaaaaaaaaakaabaaaaaaaaaaaaoaaaaahdcaabaaaadaaaaaaegbabaaa
acaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaapcaaaakbcaabaaaaeaaaaaaaceaaaaa
olaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaaacaaaaaabacaaaakccaabaaa
aeaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaacaaaaaa
bacaaaakecaabaaaaeaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaa
egacbaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdiaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaafgafbaaaabaaaaaa
diaaaaahhcaabaaaaaaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaaaaaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaadiaaaaaihcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaaipcaabaaa
acaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakiccabaaaaaaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaacaaaaaadkaabaaaacaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
doaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "Specular"
}