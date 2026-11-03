Shader "Transparent/Cutout/Bumped Specular" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,0)
 _Shininess ("Shininess", Range(0.01,1)) = 0.078125
 _MainTex ("Base (RGB) TransGloss (A)", 2D) = "white" {}
 _BumpMap ("Normalmap", 2D) = "bump" {}
 _Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
}
SubShader { 
 LOD 400
 Tags { "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  ColorMask RGB
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
ConstBuffer "$Globals" 128
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
ConstBuffer "$Globals" 128
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
ConstBuffer "$Globals" 144
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
ConstBuffer "$Globals" 144
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
ConstBuffer "$Globals" 144
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
ConstBuffer "$Globals" 144
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
ConstBuffer "$Globals" 192
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
ConstBuffer "$Globals" 192
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
ConstBuffer "$Globals" 208
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
ConstBuffer "$Globals" 208
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
ConstBuffer "$Globals" 208
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
ConstBuffer "$Globals" 208
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
ConstBuffer "$Globals" 128
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
ConstBuffer "$Globals" 128
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
ConstBuffer "$Globals" 192
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
ConstBuffer "$Globals" 192
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
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
"!!ARBfp1.0
PARAM c[6] = { program.local[0..4],
		{ 2, 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R2.w, R0, c[2];
SLT R1.x, R2.w, c[4];
DP3 R3.x, fragment.texcoord[3], fragment.texcoord[3];
MUL R0.xyz, R0, c[2];
MOV R2.xyz, fragment.texcoord[1];
RSQ R3.x, R3.x;
MAD R2.xyz, R3.x, fragment.texcoord[3], R2;
MOV result.color.w, R2;
KIL -R1.x;
MAD R1.xy, R1.wyzw, c[5].x, -c[5].y;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R1.z, R1, R1.w;
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, R2;
ADD R1.z, -R1, c[5].y;
RSQ R1.z, R1.z;
RCP R1.z, R1.z;
DP3 R2.x, R1, R2;
MOV R1.w, c[5];
MUL R2.y, R1.w, c[3].x;
MAX R1.w, R2.x, c[5].z;
POW R1.w, R1.w, R2.y;
MUL R0.w, R0, R1;
DP3 R1.x, R1, fragment.texcoord[1];
MAX R1.w, R1.x, c[5].z;
MUL R2.xyz, R0, c[0];
MOV R1.xyz, c[1];
MUL R2.xyz, R2, R1.w;
MUL R1.xyz, R1, c[0];
MAD R1.xyz, R1, R0.w, R2;
MUL R1.xyz, R1, c[5].x;
MAD result.color.xyz, R0, fragment.texcoord[2], R1;
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c5, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c6, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r3, t0, s0
mul_pp r0.x, r3.w, c2.w
add_pp r1.x, r0, -c4
cmp r1.x, r1, c5, c5.y
mov r2.y, t0.w
mov r2.x, t0.z
mov r4.xy, r2
mov_pp r2, -r1.x
mul_pp r3.xyz, r3, c2
texld r1, r4, s1
texkill r2.xyzw
mov r1.x, r1.w
mad_pp r5.xy, r1, c5.z, c5.w
mul_pp r1.xy, r5, r5
dp3_pp r2.x, t3, t3
add_pp_sat r1.x, r1, r1.y
rsq_pp r2.x, r2.x
mov_pp r4.xyz, t1
mad_pp r4.xyz, r2.x, t3, r4
add_pp r2.x, -r1, c5.y
dp3_pp r1.x, r4, r4
rsq_pp r2.x, r2.x
rcp_pp r5.z, r2.x
rsq_pp r1.x, r1.x
mul_pp r2.xyz, r1.x, r4
dp3_pp r2.x, r5, r2
mov_pp r1.x, c3
mul_pp r1.x, c6, r1
max_pp r2.x, r2, c5
pow r4.w, r2.x, r1.x
dp3_pp r2.x, r5, t1
mov r1.x, r4.w
mov_pp r4.xyz, c0
mul r1.x, r3.w, r1
max_pp r2.x, r2, c5
mul_pp r5.xyz, r3, c0
mul_pp r2.xyz, r5, r2.x
mul_pp r4.xyz, c1, r4
mad r1.xyz, r4, r1.x, r2
mul r1.xyz, r1, c5.z
mad_pp r1.xyz, r3, t2, r1
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
Float 112 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmfjknkbieoanbmnmiddigjccpdahfclfabaaaaaagaafaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcfiaeaaaaeaaaaaaabgabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaa
akiacaiaebaaaaaaaaaaaaaaahaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaaeaaaaaaagaabaaa
abaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
abaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaa
abaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahccaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaacaaaaaadeaaaaak
dcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiecaabaaa
abaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
adaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaa
aaaaaaaaacaaaaaadiaaaaahncaabaaaabaaaaaaagaabaaaabaaaaaaagajbaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaafgafbaaaabaaaaaa
igadbaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
Float 112 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedlmpnkcloplplnenfkhlcbhknldiojicpabaaaaaafiaiaaaaaeaaaaaa
daaaaaaaceadaaaaieahaaaaceaiaaaaebgpgodjomacaaaaomacaaaaaaacpppp
kiacaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaabaaaeaaaaaaaaaaaaaaaaaaahaaabaaaeaaaaaaaaaaaaacpppp
fbaaaaafafaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafagaaapka
aaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaachla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaadaaaacpia
aaaaoelaaaaioekaabaaaaacabaaaiiaacaappkaaeaaaaaeabaacpiaaaaappia
abaappiaaeaaaakbabaaaaacacaaabiaaaaakklaabaaaaacacaaaciaaaaappla
ebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaabaioekaaiaaaaadabaacbia
adaaoelaadaaoelaahaaaaacabaacbiaabaaaaiaabaaaaacacaaahiaadaaoela
aeaaaaaeacaachiaacaaoeiaabaaaaiaabaaoelaceaaaaacadaachiaacaaoeia
aeaaaaaeacaacbiaabaappiaafaaaakaafaaffkaaeaaaaaeacaacciaabaaffia
afaaaakaafaaffkafkaaaaaeacaadiiaacaaoeiaacaaoeiaafaakkkaacaaaaad
acaaciiaacaappibafaappkaahaaaaacacaaciiaacaappiaagaaaaacacaaceia
acaappiaaiaaaaadacaaciiaacaaoeiaadaaoeiaaiaaaaadabaacbiaacaaoeia
abaaoelaalaaaaadacaacbiaabaaaaiaafaakkkaalaaaaadabaaabiaacaappia
afaakkkaabaaaaacadaaabiaadaaaakaafaaaaadabaaaciaadaaaaiaagaaaaka
caaaaaadacaaaciaabaaaaiaabaaffiaafaaaaadabaaabiaaaaappiaacaaffia
abaaaaacadaaahiaaaaaoekaafaaaaadabaaaoiaadaabliaabaablkaafaaaaad
abaaahiaabaaaaiaabaabliaafaaaaadaaaachiaaaaaoeiaacaaoekaafaaaaad
adaaciiaaaaappiaacaappkaafaaaaadacaacoiaaaaabliaaaaablkaaeaaaaae
abaaahiaacaabliaacaaaaiaabaaoeiaacaaaaadabaachiaabaaoeiaabaaoeia
aeaaaaaeadaachiaaaaaoeiaacaaoelaabaaoeiaabaaaaacaaaicpiaadaaoeia
ppppaaaafdeieefcfiaeaaaaeaaaaaaabgabaaaafjaaaaaeegiocaaaaaaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
adaaaaaaakiacaiaebaaaaaaaaaaaaaaahaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaaeaaaaaa
agaabaaaabaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaabaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaa
dkaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaacaaaaaa
deaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
ecaabaaaabaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaa
egiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaabaaaaaaagaabaaaabaaaaaa
agajbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaafgafbaaa
abaaaaaaigadbaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaa
adaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
"!!ARBfp1.0
PARAM c[3] = { program.local[0..1],
		{ 8 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.w, R0, c[0];
SLT R1.x, R0.w, c[1];
MUL R0.xyz, R0, c[0];
MOV result.color.w, R0;
KIL -R1.x;
TEX R1, fragment.texcoord[1], texture[2], 2D;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, c[2].x;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s2
def c2, 0.00000000, 1.00000000, 8.00000000, 0
dcl t0.xy
dcl t1.xy
texld r3, t0, s0
mul_pp r0.x, r3.w, c0.w
add_pp r1.x, r0, -c1
cmp r1.x, r1, c2, c2.y
mov_pp r2, -r1.x
texld r1, t1, s2
texkill r2.xyzw
mul_pp r1.xyz, r1.w, r1
mul_pp r2.xyz, r3, c0
mul_pp r1.xyz, r1, r2
mul_pp r1.xyz, r1, c2.z
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 144
Vector 48 [_Color]
Float 128 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecednofjggokjjfoknmnpkmccafgbfeiceaoabaaaaaaiaacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckiabaaaaeaaaaaaagkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaa
aaaaaaaaaiaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 144
Vector 48 [_Color]
Float 128 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedcdojcgejehkdddljghekhlppmjhnddinabaaaaaameadaaaaaeaaaaaa
daaaaaaahaabaaaacaadaaaajaadaaaaebgpgodjdiabaaaadiabaaaaaaacpppp
peaaaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaadaaabaaaaaaaaaaaaaaaaaaaiaaabaaabaaaaaaaaaaaaacpppp
fbaaaaafacaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaabaaaaacabaaaiia
aaaappkaaeaaaaaeabaacpiaaaaappiaabaappiaabaaaakbebaaaaababaaapia
ecaaaaadabaacpiaabaaoelaabaioekaafaaaaadabaaciiaabaappiaacaaaaka
afaaaaadabaachiaabaaoeiaabaappiaafaaaaadaaaachiaaaaaoeiaaaaaoeka
afaaaaadacaaciiaaaaappiaaaaappkaafaaaaadacaachiaabaaoeiaaaaaoeia
abaaaaacaaaicpiaacaaoeiappppaaaafdeieefckiabaaaaeaaaaaaagkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaa
aaaaaaaaaiaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
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
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
"!!ARBfp1.0
PARAM c[8] = { program.local[0..3],
		{ 2, 1, 8, 0 },
		{ -0.40824828, -0.70710677, 0.57735026, 128 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R4, fragment.texcoord[1], texture[3], 2D;
TEX R3.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R2.xyz, R4.w, R4;
MUL R2.w, R0, c[1];
MUL R2.xyz, R2, c[4].z;
SLT R1.x, R2.w, c[3];
MUL R4.xyz, R2.y, c[6];
MAD R4.xyz, R2.x, c[7], R4;
MAD R4.xyz, R2.z, c[5], R4;
DP3 R3.x, R4, R4;
RSQ R3.x, R3.x;
MUL R4.xyz, R3.x, R4;
MAD R3.xy, R3.wyzw, c[4].x, -c[4].y;
MUL R3.zw, R3.xyxy, R3.xyxy;
DP3 R4.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R4.w, R4.w;
MAD R4.xyz, R4.w, fragment.texcoord[2], R4;
ADD_SAT R3.w, R3.z, R3;
DP3 R3.z, R4, R4;
ADD R4.w, -R3, c[4].y;
RSQ R3.w, R3.z;
RSQ R3.z, R4.w;
MUL R4.xyz, R3.w, R4;
RCP R3.z, R3.z;
DP3 R3.w, R3, R4;
MAX R3.w, R3, c[4];
DP3_SAT R4.z, R3, c[5];
DP3_SAT R4.x, R3, c[7];
DP3_SAT R4.y, R3, c[6];
DP3 R2.x, R4, R2;
MUL R0.xyz, R0, c[1];
MOV result.color.w, R2;
KIL -R1.x;
TEX R1, fragment.texcoord[1], texture[2], 2D;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, R2.x;
MUL R1.xyz, R1, c[4].z;
MOV R1.w, c[5];
MUL R1.w, R1, c[2].x;
MUL R2.xyz, R1, c[0];
POW R1.w, R3.w, R1.w;
MUL R2.xyz, R0.w, R2;
MUL R2.xyz, R2, R1.w;
MAD result.color.xyz, R0, R1, R2;
END
# 45 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Shininess]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c4, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c5, -0.40824828, -0.70710677, 0.57735026, 8.00000000
def c6, -0.40824831, 0.70710677, 0.57735026, 128.00000000
def c7, 0.81649655, 0.00000000, 0.57735026, 0
dcl t0
dcl t1.xy
dcl t2.xyz
texld r0, t0, s0
texld r4, t1, s3
mul_pp r1.x, r0.w, c1.w
mul_pp r4.xyz, r4.w, r4
mul_pp r4.xyz, r4, c5.w
mul r5.xyz, r4.y, c6
mad r5.xyz, r4.x, c7, r5
add_pp r2.x, r1, -c3
cmp r2.x, r2, c4, c4.y
mov_pp r2, -r2.x
mad r5.xyz, r4.z, c5, r5
mov r3.y, t0.w
mov r3.x, t0.z
mul_pp r0.xyz, r0, c1
texld r3, r3, s1
texkill r2.xyzw
texld r2, t1, s2
dp3 r3.x, r5, r5
rsq r3.x, r3.x
mul r5.xyz, r3.x, r5
mov r3.x, r3.w
mad_pp r7.xy, r3, c4.z, c4.w
dp3_pp r3.x, t2, t2
rsq_pp r3.x, r3.x
mad_pp r3.xyz, r3.x, t2, r5
mul_pp r6.xy, r7, r7
add_pp_sat r5.x, r6, r6.y
dp3_pp r6.x, r3, r3
add_pp r5.x, -r5, c4.y
rsq_pp r5.x, r5.x
rcp_pp r7.z, r5.x
rsq_pp r6.x, r6.x
mul_pp r3.xyz, r6.x, r3
dp3_pp r3.x, r7, r3
max_pp r3.x, r3, c4
dp3_pp_sat r5.x, r7, c7
dp3_pp_sat r5.z, r7, c5
dp3_pp_sat r5.y, r7, c6
dp3_pp r4.x, r5, r4
mov_pp r5.x, c2
mul_pp r2.xyz, r2.w, r2
mul_pp r2.xyz, r2, r4.x
mul_pp r5.x, c6.w, r5
pow r4.x, r3.x, r5.x
mul_pp r2.xyz, r2, c5.w
mul_pp r3.xyz, r2, c0
mul_pp r3.xyz, r0.w, r3
mul r3.xyz, r3, r4.x
mad_pp r0.xyz, r0, r2, r3
mov_pp r0.w, r1.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 144
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
Float 128 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedplagghjaenlhkgbefjdfkjonkfnjnckaabaaaaaaceahaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdeagaaaaeaaaaaaainabaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaaaaaaaaaa
aiaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaa
egbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgapbaaaabaaaaaadiaaaaakhcaabaaaadaaaaaa
fgafbaaaacaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaadcaaaaam
hcaabaaaadaaaaaaagaabaaaacaaaaaaaceaaaaaolaffbdpaaaaaaaadkmnbddp
aaaaaaaaegacbaaaadaaaaaadcaaaaamhcaabaaaadaaaaaakgakbaaaacaaaaaa
aceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaadaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaa
dkaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
abaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaa
akiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaaapcaaaakbcaabaaaaeaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaa
aaaaaaaaigaabaaaadaaaaaabacaaaakccaabaaaaeaaaaaaaceaaaaaomafnblo
pdaedfdpdkmnbddpaaaaaaaaegacbaaaadaaaaaabacaaaakecaabaaaaeaaaaaa
aceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaah
ccaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaah
ecaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaakgakbaaaabaaaaaadiaaaaahocaabaaaabaaaaaa
fgafbaaaabaaaaaaagajbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaajgahbaaa
abaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaaaaaaaaajgahbaaaabaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaacaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 144
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
Float 128 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedpmcekjmkkigafikcbcbffjappfgpbhloabaaaaaaoiakaaaaaeaaaaaa
daaaaaaapaadaaaacmakaaaaleakaaaaebgpgodjliadaaaaliadaaaaaaacpppp
gmadaaaaemaaaaaaacaadeaaaaaaemaaaaaaemaaaeaaceaaaaaaemaaaaaaaaaa
abababaaacacacaaadadadaaaaaaacaaadaaaaaaaaaaaaaaaaaaaiaaabaaadaa
aaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadp
fbaaaaafafaaapkaomafnblopdaedfdpdkmnbddpaaaaaaedfbaaaaafagaaapka
olafnblopdaedflpdkmnbddpaaaaaaaafbaaaaafahaaapkaaaaaaaebdkmnbddp
aaaaaaaaolaffbdpbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaadla
bpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkaecaaaaad
aaaacpiaaaaaoelaaaaioekaabaaaaacabaaaiiaabaappkaaeaaaaaeabaacpia
aaaappiaabaappiaadaaaakbabaaaaacacaaabiaaaaakklaabaaaaacacaaacia
aaaapplaebaaaaababaaapiaecaaaaadabaacpiaabaaoelaadaioekaecaaaaad
acaacpiaacaaoeiaabaioekaecaaaaadadaacpiaabaaoelaacaioekaafaaaaad
abaaciiaabaappiaahaaaakaafaaaaadabaachiaabaaoeiaabaappiaafaaaaad
aeaaahiaabaaffiaafaaoekaaeaaaaaeaeaaahiaabaaaaiaahaablkaaeaaoeia
aeaaaaaeaeaaahiaabaakkiaagaaoekaaeaaoeiaaiaaaaadabaaaiiaaeaaoeia
aeaaoeiaahaaaaacabaaaiiaabaappiaceaaaaacafaachiaacaaoelaaeaaaaae
aeaachiaaeaaoeiaabaappiaafaaoeiaceaaaaacafaachiaaeaaoeiaaeaaaaae
aeaacbiaacaappiaaeaaaakaaeaaffkaaeaaaaaeaeaacciaacaaffiaaeaaaaka
aeaaffkafkaaaaaeabaadiiaaeaaoeiaaeaaoeiaaeaakkkaacaaaaadabaaciia
abaappibaeaappkaahaaaaacabaaciiaabaappiaagaaaaacaeaaceiaabaappia
aiaaaaadabaaciiaaeaaoeiaafaaoeiaalaaaaadaeaaaiiaabaappiaaeaakkka
abaaaaacabaaaiiaafaappkaafaaaaadabaaaiiaabaappiaacaaaakacaaaaaad
acaacbiaaeaappiaabaappiaaiaaaaadafaadbiaahaablkaaeaaoeiaaiaaaaad
afaadciaafaaoekaaeaaoeiaaiaaaaadafaadeiaagaaoekaaeaaoeiaaiaaaaad
abaacbiaafaaoeiaabaaoeiaafaaaaadadaaciiaadaappiaahaaaakaafaaaaad
abaacoiaadaabliaadaappiaafaaaaadabaachiaabaaaaiaabaabliaafaaaaad
acaacoiaabaabliaaaaablkaafaaaaadacaaaoiaaaaappiaacaaoeiaafaaaaad
aaaachiaaaaaoeiaabaaoekaafaaaaadadaaciiaaaaappiaabaappkaafaaaaad
aaaachiaabaaoeiaaaaaoeiaaeaaaaaeadaachiaacaabliaacaaaaiaaaaaoeia
abaaaaacaaaicpiaadaaoeiappppaaaafdeieefcdeagaaaaeaaaaaaainabaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaia
ebaaaaaaaaaaaaaaaiaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaadaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaeb
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaabaaaaaadiaaaaak
hcaabaaaadaaaaaafgafbaaaacaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddp
aaaaaaaadcaaaaamhcaabaaaadaaaaaaagaabaaaacaaaaaaaceaaaaaolaffbdp
aaaaaaaadkmnbddpaaaaaaaaegacbaaaadaaaaaadcaaaaamhcaabaaaadaaaaaa
kgakbaaaacaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaa
adaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaadaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaa
ddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaai
icaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaadaaaaaadkaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
adaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
ccaabaaaabaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaaapcaaaakbcaabaaaaeaaaaaaaceaaaaaolaffbdp
dkmnbddpaaaaaaaaaaaaaaaaigaabaaaadaaaaaabacaaaakccaabaaaaeaaaaaa
aceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaadaaaaaabacaaaak
ecaabaaaaeaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaa
adaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaahecaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaeb
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaakgakbaaaabaaaaaadiaaaaah
ocaabaaaabaaaaaafgafbaaaabaaaaaaagajbaaaacaaaaaadiaaaaaihcaabaaa
acaaaaaajgahbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaaaaaaaaa
jgahbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaaagaabaaaabaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
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
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"!!ARBfp1.0
PARAM c[6] = { program.local[0..4],
		{ 2, 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TXP R3.x, fragment.texcoord[4], texture[2], 2D;
MUL R2.w, R0, c[2];
SLT R1.x, R2.w, c[4];
DP3 R3.y, fragment.texcoord[3], fragment.texcoord[3];
MUL R0.xyz, R0, c[2];
MOV R2.xyz, fragment.texcoord[1];
RSQ R3.y, R3.y;
MAD R2.xyz, R3.y, fragment.texcoord[3], R2;
MOV result.color.w, R2;
KIL -R1.x;
MAD R1.xy, R1.wyzw, c[5].x, -c[5].y;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R1.z, R1, R1.w;
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, R2;
ADD R1.z, -R1, c[5].y;
RSQ R1.z, R1.z;
RCP R1.z, R1.z;
DP3 R2.x, R1, R2;
MOV R1.w, c[5];
MUL R2.y, R1.w, c[3].x;
MAX R1.w, R2.x, c[5].z;
POW R1.w, R1.w, R2.y;
MUL R0.w, R0, R1;
DP3 R1.x, R1, fragment.texcoord[1];
MAX R1.w, R1.x, c[5].z;
MUL R2.xyz, R0, c[0];
MUL R2.xyz, R2, R1.w;
MOV R1.xyz, c[1];
MUL R1.xyz, R1, c[0];
MUL R1.w, R3.x, c[5].x;
MAD R1.xyz, R1, R0.w, R2;
MUL R1.xyz, R1, R1.w;
MAD result.color.xyz, R0, fragment.texcoord[2], R1;
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
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c5, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c6, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4
texld r3, t0, s0
texldp r6, t4, s2
mul_pp r0.x, r3.w, c2.w
add_pp r1.x, r0, -c4
cmp r1.x, r1, c5, c5.y
mov_pp r1, -r1.x
mov r2.y, t0.w
mov r2.x, t0.z
mul_pp r3.xyz, r3, c2
mov_pp r5.xyz, t1
texkill r1.xyzw
texld r1, r2, s1
mov r1.x, r1.w
mad_pp r4.xy, r1, c5.z, c5.w
mul_pp r1.xy, r4, r4
add_pp_sat r1.x, r1, r1.y
dp3_pp r2.x, t3, t3
rsq_pp r2.x, r2.x
mad_pp r5.xyz, r2.x, t3, r5
dp3_pp r2.x, r5, r5
add_pp r1.x, -r1, c5.y
rsq_pp r1.x, r1.x
rcp_pp r4.z, r1.x
rsq_pp r2.x, r2.x
mul_pp r2.xyz, r2.x, r5
dp3_pp r2.x, r4, r2
mov_pp r1.x, c3
mul_pp r1.x, c6, r1
max_pp r2.x, r2, c5
pow r5.w, r2.x, r1.x
dp3_pp r2.x, r4, t1
mov r1.x, r5.w
max_pp r2.x, r2, c5
mul_pp r4.xyz, r3, c0
mul_pp r5.xyz, r4, r2.x
mov_pp r4.xyz, c0
mul r1.x, r3.w, r1
mul_pp r4.xyz, c1, r4
mul_pp r2.x, r6, c5.z
mad r1.xyz, r4, r1.x, r5
mul r1.xyz, r1, r2.x
mad_pp r1.xyz, r3, t2, r1
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 176 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedblajofjlphbapllldbglnflenbdcmngbabaaaaaapmafaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmaeaaaa
eaaaaaaadhabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaad
lcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaa
akiacaiaebaaaaaaaaaaaaaaalaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaaeaaaaaaagaabaaa
abaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaap
dcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
abaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaa
abaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
baaaaaahccaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaacaaaaaadeaaaaak
dcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiecaabaaa
abaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
ahaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaa
aaaaaaaaacaaaaaadiaaaaahncaabaaaabaaaaaaagaabaaaabaaaaaaagajbaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaafgafbaaaabaaaaaa
igadbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaafaaaaaapgbpbaaa
afaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaaaaaaaaahicaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 176 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedklglaaldgkdoceoidcbhfmacjmhkcldbabaaaaaafiajaaaaaeaaaaaa
daaaaaaaiiadaaaagmaiaaaaceajaaaaebgpgodjfaadaaaafaadaaaaaaacpppp
pmacaaaafeaaaaaaadaadaaaaaaafeaaaaaafeaaadaaceaaaaaafeaaacaaaaaa
aaababaaabacacaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaacaaacaaaaaaaaaa
aaaaalaaabaaaeaaaaaaaaaaaaacppppfbaaaaafafaaapkaaaaaaaeaaaaaialp
aaaaaaaaaaaaiadpfbaaaaafagaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaia
acaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapka
ecaaaaadaaaacpiaaaaaoelaabaioekaabaaaaacabaaaiiaacaappkaaeaaaaae
abaacpiaaaaappiaabaappiaaeaaaakbabaaaaacacaaabiaaaaakklaabaaaaac
acaaaciaaaaapplaagaaaaacacaaaeiaaeaapplaafaaaaadadaaadiaacaakkia
aeaaoelaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaacaioekaecaaaaad
acaacpiaadaaoeiaaaaioekaaiaaaaadabaacbiaadaaoelaadaaoelaahaaaaac
abaacbiaabaaaaiaabaaaaacadaaahiaadaaoelaaeaaaaaeadaachiaadaaoeia
abaaaaiaabaaoelaceaaaaacaeaachiaadaaoeiaaeaaaaaeadaacbiaabaappia
afaaaakaafaaffkaaeaaaaaeadaacciaabaaffiaafaaaakaafaaffkafkaaaaae
adaadiiaadaaoeiaadaaoeiaafaakkkaacaaaaadadaaciiaadaappibafaappka
ahaaaaacadaaciiaadaappiaagaaaaacadaaceiaadaappiaaiaaaaadadaaciia
adaaoeiaaeaaoeiaaiaaaaadabaacbiaadaaoeiaabaaoelaalaaaaadacaaccia
abaaaaiaafaakkkaalaaaaadabaaabiaadaappiaafaakkkaabaaaaacadaaabia
adaaaakaafaaaaadabaaaciaadaaaaiaagaaaakacaaaaaadacaaaeiaabaaaaia
abaaffiaafaaaaadabaaabiaaaaappiaacaakkiaabaaaaacadaaahiaaaaaoeka
afaaaaadabaaaoiaadaabliaabaablkaafaaaaadabaaahiaabaaaaiaabaablia
afaaaaadaaaachiaaaaaoeiaacaaoekaafaaaaadadaaciiaaaaappiaacaappka
afaaaaadaeaachiaaaaaoeiaaaaaoekaafaaaaadaaaachiaaaaaoeiaacaaoela
aeaaaaaeabaaahiaaeaaoeiaacaaffiaabaaoeiaacaaaaadaaaaaiiaacaaaaia
acaaaaiaaeaaaaaeadaachiaabaaoeiaaaaappiaaaaaoeiaabaaaaacaaaicpia
adaaoeiappppaaaafdeieefcnmaeaaaaeaaaaaaadhabaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaiaebaaaaaaaaaaaaaaalaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaa
aeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajhcaabaaa
abaaaaaaegbcbaaaaeaaaaaaagaabaaaabaaaaaaegbcbaaaacaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaaacaaaaaaegaabaaa
acaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaacaaaaaadkaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
acaaaaaaegbcbaaaacaaaaaadeaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaaiecaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaa
abeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaa
abaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaadiaaaaajhcaabaaaacaaaaaa
egiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaa
abaaaaaaagaabaaaabaaaaaaagajbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaacaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaaaoaaaaahdcaabaaa
acaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaa
abaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegbcbaaaadaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"!!ARBfp1.0
PARAM c[3] = { program.local[0..1],
		{ 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[1], texture[3], 2D;
TXP R3.x, fragment.texcoord[2], texture[2], 2D;
MUL R0.w, R0, c[0];
SLT R1.x, R0.w, c[1];
MUL R0.xyz, R0, c[0];
MOV result.color.w, R0;
KIL -R1.x;
MUL R1.xyz, R2.w, R2;
MUL R2.xyz, R2, R3.x;
MUL R1.xyz, R1, c[2].x;
MUL R3.xyz, R1, R3.x;
MUL R2.xyz, R2, c[2].y;
MIN R1.xyz, R1, R2;
MAX R1.xyz, R1, R3;
MUL result.color.xyz, R0, R1;
END
# 16 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"ps_2_0
dcl_2d s0
dcl_2d s2
dcl_2d s3
def c2, 0.00000000, 1.00000000, 8.00000000, 2.00000000
dcl t0.xy
dcl t1.xy
dcl t2
texldp r2, t2, s2
texld r3, t0, s0
mul_pp r0.x, r3.w, c0.w
add_pp r1.x, r0, -c1
cmp r1.x, r1, c2, c2.y
mov_pp r1, -r1.x
texkill r1.xyzw
texld r1, t1, s3
mul_pp r4.xyz, r1.w, r1
mul_pp r1.xyz, r1, r2.x
mul_pp r4.xyz, r4, c2.z
mul_pp r1.xyz, r1, c2.w
mul_pp r2.xyz, r4, r2.x
min_pp r1.xyz, r4, r1
max_pp r1.xyz, r1, r2
mul_pp r2.xyz, r3, c0
mul_pp r1.xyz, r2, r1
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 208
Vector 112 [_Color]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgpfalfliblpbjineielilcbdnjcgfedaabaaaaaaimadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcjmacaaaaeaaaaaaakhaaaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaiaebaaaaaa
aaaaaaaaamaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaahaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaa
abaaaaaaagajbaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaa
acaaaaaaddaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadeaaaaah
hcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 208
Vector 112 [_Color]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedpoefgdplkcpaggdjmnjechgdlkpfhklcabaaaaaagiafaaaaaeaaaaaa
daaaaaaaaiacaaaakmaeaaaadeafaaaaebgpgodjnaabaaaanaabaaaaaaacpppp
iiabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaahaaabaaaaaaaaaaaaaaaaaaamaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkaecaaaaadaaaacpiaaaaaoelaabaioekaabaaaaacabaaaiiaaaaappka
aeaaaaaeabaacpiaaaaappiaabaappiaabaaaakbagaaaaacacaaaiiaacaappla
afaaaaadacaaadiaacaappiaacaaoelaebaaaaababaaapiaecaaaaadabaacpia
acaaoeiaaaaioekaecaaaaadacaacpiaabaaoelaacaioekaacaaaaadabaaccia
abaaaaiaabaaaaiaafaaaaadabaacoiaacaabliaabaaffiaafaaaaadacaaciia
acaappiaacaaaakaafaaaaadacaachiaacaaoeiaacaappiaakaaaaadadaachia
abaabliaacaaoeiaafaaaaadabaachiaabaaaaiaacaaoeiaalaaaaadacaachia
adaaoeiaabaaoeiaafaaaaadaaaachiaaaaaoeiaaaaaoekaafaaaaadabaaciia
aaaappiaaaaappkaafaaaaadabaachiaacaaoeiaaaaaoeiaabaaaaacaaaicpia
abaaoeiappppaaaafdeieefcjmacaaaaeaaaaaaakhaaaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaiaebaaaaaa
aaaaaaaaamaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaahaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaa
abaaaaaaagajbaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaa
acaaaaaaddaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadeaaaaah
hcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
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
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_ShadowMapTexture] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"!!ARBfp1.0
PARAM c[8] = { program.local[0..3],
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
TEX R3, fragment.texcoord[1], texture[4], 2D;
TEX R4.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TXP R5.x, fragment.texcoord[3], texture[2], 2D;
MUL R2.w, R0, c[1];
MUL R2.xyz, R3.w, R3;
MUL R3.xyz, R2, c[4].z;
SLT R1.x, R2.w, c[3];
MUL R2.xyz, R3.y, c[6];
MAD R2.xyz, R3.x, c[7], R2;
MAD R5.yzw, R3.z, c[5].xxyz, R2.xxyz;
DP3 R2.x, R5.yzww, R5.yzww;
RSQ R2.z, R2.x;
MAD R2.xy, R4.wyzw, c[4].x, -c[4].y;
MUL R4.xyz, R2.z, R5.yzww;
MUL R5.zw, R2.xyxy, R2.xyxy;
ADD_SAT R3.w, R5.z, R5;
ADD R3.w, -R3, c[4].y;
DP3 R2.z, fragment.texcoord[2], fragment.texcoord[2];
RSQ R2.z, R2.z;
MAD R4.xyz, R2.z, fragment.texcoord[2], R4;
DP3 R2.z, R4, R4;
RSQ R4.w, R3.w;
RSQ R3.w, R2.z;
RCP R2.z, R4.w;
DP3_SAT R5.w, R2, c[5];
DP3_SAT R5.y, R2, c[7];
DP3_SAT R5.z, R2, c[6];
MUL R4.xyz, R3.w, R4;
DP3 R3.w, R5.yzww, R3;
MUL R0.xyz, R0, c[1];
MOV result.color.w, R2;
KIL -R1.x;
TEX R1, fragment.texcoord[1], texture[3], 2D;
MUL R3.xyz, R1.w, R1;
MUL R1.xyz, R1, R5.x;
DP3 R1.w, R2, R4;
MUL R3.xyz, R3, R3.w;
MUL R3.xyz, R3, c[4].z;
MUL R5.yzw, R1.xxyz, c[4].x;
MUL R1.xyz, R3, R5.x;
MIN R5.xyz, R3, R5.yzww;
MOV R2.x, c[5].w;
MAX R3.w, R1, c[4];
MUL R1.w, R2.x, c[2].x;
MUL R2.xyz, R3, c[0];
MAX R1.xyz, R5, R1;
POW R1.w, R3.w, R1.w;
MUL R2.xyz, R0.w, R2;
MUL R2.xyz, R2, R1.w;
MAD result.color.xyz, R0, R1, R2;
END
# 51 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Shininess]
Float 3 [_Cutoff]
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
def c4, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c5, -0.40824828, -0.70710677, 0.57735026, 8.00000000
def c6, -0.40824831, 0.70710677, 0.57735026, 128.00000000
def c7, 0.81649655, 0.00000000, 0.57735026, 0
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t3
texld r0, t0, s0
texld r4, t1, s3
texld r5, t1, s4
mul_pp r1.x, r0.w, c1.w
add_pp r2.x, r1, -c3
cmp r2.x, r2, c4, c4.y
mov_pp r2, -r2.x
mul_pp r5.xyz, r5.w, r5
mul_pp r5.xyz, r5, c5.w
mul r6.xyz, r5.y, c6
mad r6.xyz, r5.x, c7, r6
mad r6.xyz, r5.z, c5, r6
mov r3.y, t0.w
mov r3.x, t0.z
mul_pp r0.xyz, r0, c1
texld r3, r3, s1
texkill r2.xyzw
texldp r2, t3, s2
dp3 r3.x, r6, r6
rsq r3.x, r3.x
mul r6.xyz, r3.x, r6
mov r3.x, r3.w
mad_pp r8.xy, r3, c4.z, c4.w
dp3_pp r3.x, t2, t2
rsq_pp r3.x, r3.x
mad_pp r3.xyz, r3.x, t2, r6
mul_pp r7.xy, r8, r8
add_pp_sat r6.x, r7, r7.y
dp3_pp r7.x, r3, r3
rsq_pp r7.x, r7.x
add_pp r6.x, -r6, c4.y
rsq_pp r6.x, r6.x
rcp_pp r8.z, r6.x
mul_pp r3.xyz, r7.x, r3
dp3_pp r3.x, r8, r3
mov_pp r6.x, c2
max_pp r3.x, r3, c4
mul_pp r6.x, c6.w, r6
pow r7.x, r3.x, r6.x
dp3_pp_sat r3.z, r8, c5
dp3_pp_sat r3.y, r8, c6
dp3_pp_sat r3.x, r8, c7
dp3_pp r3.x, r3, r5
mul_pp r5.xyz, r4.w, r4
mul_pp r4.xyz, r4, r2.x
mul_pp r3.xyz, r5, r3.x
mul_pp r3.xyz, r3, c5.w
mul_pp r4.xyz, r4, c4.z
min_pp r4.xyz, r3, r4
mul_pp r2.xyz, r3, r2.x
mul_pp r3.xyz, r3, c0
mul_pp r3.xyz, r0.w, r3
max_pp r2.xyz, r4, r2
mov r4.x, r7.x
mul r3.xyz, r3, r4.x
mad_pp r0.xyz, r0, r2, r3
mov_pp r0.w, r1.x
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
ConstBuffer "$Globals" 208
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhhgaeflekbmoaipblihfmmbnhapbkpmfabaaaaaadaaiaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcciahaaaaeaaaaaaamkabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaambcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaiaebaaaaaaaaaaaaaa
amaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaa
egbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgapbaaaabaaaaaadiaaaaakhcaabaaaadaaaaaa
fgafbaaaacaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaadcaaaaam
hcaabaaaadaaaaaaagaabaaaacaaaaaaaceaaaaaolaffbdpaaaaaaaadkmnbddp
aaaaaaaaegacbaaaadaaaaaadcaaaaamhcaabaaaadaaaaaakgakbaaaacaaaaaa
aceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaadaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
dcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaa
dkaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
abaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaaapcaaaakbcaabaaaaeaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaa
aaaaaaaaigaabaaaadaaaaaabacaaaakccaabaaaaeaaaaaaaceaaaaaomafnblo
pdaedfdpdkmnbddpaaaaaaaaegacbaaaadaaaaaabacaaaakecaabaaaaeaaaaaa
aceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaah
ccaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaah
ecaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
adaaaaaaegacbaaaacaaaaaakgakbaaaabaaaaaadiaaaaahocaabaaaabaaaaaa
fgafbaaaabaaaaaaagajbaaaadaaaaaaaoaaaaahdcaabaaaadaaaaaaegbabaaa
aeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaacaaaaaaakaabaaa
adaaaaaaakaabaaaadaaaaaadiaaaaahhcaabaaaadaaaaaajgahbaaaabaaaaaa
agaabaaaadaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaa
acaaaaaaddaaaaahhcaabaaaacaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaiocaabaaaabaaaaaafgaobaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaa
diaaaaahocaabaaaabaaaaaapgapbaaaaaaaaaaafgaobaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaadeaaaaah
hcaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaaabaaaaaaagaabaaa
abaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_ShadowMapTexture] 2D 0
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 208
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 192 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedinkmnjgfffcclmmglakkkaaieigjidbaabaaaaaajiamaaaaaeaaaaaa
daaaaaaajeaeaaaamealaaaageamaaaaebgpgodjfmaeaaaafmaeaaaaaaacpppp
aaaeaaaafmaaaaaaadaadiaaaaaafmaaaaaafmaaafaaceaaaaaafmaaacaaaaaa
aaababaaabacacaaadadadaaaeaeaeaaaaaaacaaabaaaaaaaaaaaaaaaaaaahaa
acaaabaaaaaaaaaaaaaaamaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapka
aaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafafaaapkaaaaaaaebdkmnbddp
aaaaaaaaolaffbdpfbaaaaafagaaapkaomafnblopdaedfdpdkmnbddpaaaaaaed
fbaaaaafahaaapkaolafnblopdaedflpdkmnbddpaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaachlabpaaaaac
aaaaaaiaadaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaaja
aeaiapkaecaaaaadaaaacpiaaaaaoelaabaioekaabaaaaacabaaaiiaabaappka
aeaaaaaeabaacpiaaaaappiaabaappiaadaaaakbabaaaaacacaaabiaaaaakkla
abaaaaacacaaaciaaaaapplaagaaaaacacaaaeiaadaapplaafaaaaadadaaadia
acaakkiaadaaoelaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaacaioeka
ecaaaaadacaacpiaabaaoelaaeaioekaecaaaaadaeaacpiaabaaoelaadaioeka
ecaaaaadadaacpiaadaaoeiaaaaioekaaeaaaaaeafaacbiaabaappiaaeaaaaka
aeaaffkaaeaaaaaeafaacciaabaaffiaaeaaaakaaeaaffkafkaaaaaeafaadiia
afaaoeiaafaaoeiaaeaakkkaacaaaaadafaaciiaafaappibaeaappkaahaaaaac
afaaciiaafaappiaagaaaaacafaaceiaafaappiaaiaaaaadabaadbiaafaablka
afaaoeiaaiaaaaadabaadciaagaaoekaafaaoeiaaiaaaaadabaadeiaahaaoeka
afaaoeiaafaaaaadabaaciiaacaappiaafaaaakaafaaaaadacaachiaacaaoeia
abaappiaaiaaaaadacaaciiaabaaoeiaacaaoeiaafaaaaadaeaaciiaaeaappia
afaaaakaafaaaaadabaachiaaeaaoeiaaeaappiaafaaaaadabaachiaacaappia
abaaoeiaacaaaaadabaaciiaadaaaaiaadaaaaiaafaaaaadadaachiaadaaaaia
abaaoeiaafaaaaadaeaachiaaeaaoeiaabaappiaakaaaaadagaachiaaeaaoeia
abaaoeiaafaaaaadabaachiaabaaoeiaaaaaoekaafaaaaadabaaahiaaaaappia
abaaoeiaalaaaaadaeaachiaagaaoeiaadaaoeiaafaaaaadaaaachiaaaaaoeia
abaaoekaafaaaaadadaaciiaaaaappiaabaappkaafaaaaadaaaachiaaeaaoeia
aaaaoeiaafaaaaadaeaaahiaacaaffiaagaaoekaaeaaaaaeaeaaahiaacaaaaia
afaablkaaeaaoeiaaeaaaaaeacaaahiaacaakkiaahaaoekaaeaaoeiaaiaaaaad
aaaaaiiaacaaoeiaacaaoeiaahaaaaacaaaaaiiaaaaappiaceaaaaacaeaachia
acaaoelaaeaaaaaeacaachiaacaaoeiaaaaappiaaeaaoeiaceaaaaacaeaachia
acaaoeiaaiaaaaadaaaaciiaafaaoeiaaeaaoeiaalaaaaadabaaaiiaaaaappia
aeaakkkaabaaaaacaaaaaiiaagaappkaafaaaaadaaaaaiiaaaaappiaacaaaaka
caaaaaadacaacbiaabaappiaaaaappiaaeaaaaaeadaachiaabaaoeiaacaaaaia
aaaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefcciahaaaaeaaaaaaa
mkabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
adaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
afaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaahaaaaaaakiacaiaebaaaaaaaaaaaaaaamaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaa
abaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgapbaaaabaaaaaadiaaaaakhcaabaaaadaaaaaafgafbaaaacaaaaaaaceaaaaa
omafnblopdaedfdpdkmnbddpaaaaaaaadcaaaaamhcaabaaaadaaaaaaagaabaaa
acaaaaaaaceaaaaaolaffbdpaaaaaaaadkmnbddpaaaaaaaaegacbaaaadaaaaaa
dcaaaaamhcaabaaaadaaaaaakgakbaaaacaaaaaaaceaaaaaolafnblopdaedflp
dkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
dcaaaaajhcaabaaaabaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaadaaaaaa
hgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaa
adaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaa
abeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaapcaaaakbcaabaaa
aeaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaaadaaaaaa
bacaaaakccaabaaaaeaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaa
egacbaaaadaaaaaabacaaaakecaabaaaaeaaaaaaaceaaaaaolafnblopdaedflp
dkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
aeaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahecaabaaaabaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaadaaaaaaegacbaaaacaaaaaa
kgakbaaaabaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaaabaaaaaaagajbaaa
adaaaaaaaoaaaaahdcaabaaaadaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaacaaaaaaaagabaaa
aaaaaaaaaaaaaaahicaabaaaacaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
diaaaaahhcaabaaaadaaaaaajgahbaaaabaaaaaaagaabaaaadaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaaddaaaaahhcaabaaa
acaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiocaabaaaabaaaaaa
fgaobaaaabaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahocaabaaaabaaaaaa
pgapbaaaaaaaaaaafgaobaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegiocaaaaaaaaaaaahaaaaaadeaaaaahhcaabaaaacaaaaaaegacbaaa
adaaaaaaegacbaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaaj
hccabaaaaaaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaa
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
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
  ColorMask RGB
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
ConstBuffer "$Globals" 192
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
ConstBuffer "$Globals" 192
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
ConstBuffer "$Globals" 128
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
ConstBuffer "$Globals" 128
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
ConstBuffer "$Globals" 192
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
ConstBuffer "$Globals" 192
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
ConstBuffer "$Globals" 192
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
ConstBuffer "$Globals" 192
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
ConstBuffer "$Globals" 192
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
ConstBuffer "$Globals" 192
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
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"!!ARBfp1.0
PARAM c[6] = { program.local[0..4],
		{ 2, 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R3.w, R0, c[2];
SLT R1.y, R3.w, c[4].x;
DP3 R1.x, fragment.texcoord[3], fragment.texcoord[3];
DP3 R3.x, fragment.texcoord[2], fragment.texcoord[2];
MUL R0.xyz, R0, c[2];
RSQ R3.x, R3.x;
MOV result.color.w, R3;
TEX R2.w, R1.x, texture[2], 2D;
KIL -R1.y;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R1.x, R1.x;
MUL R2.xyz, R1.x, fragment.texcoord[1];
MAD R1.xy, R1.wyzw, c[5].x, -c[5].y;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R1.z, R1, R1.w;
MAD R3.xyz, R3.x, fragment.texcoord[2], R2;
DP3 R1.w, R3, R3;
RSQ R1.w, R1.w;
MUL R3.xyz, R1.w, R3;
ADD R1.z, -R1, c[5].y;
RSQ R1.z, R1.z;
RCP R1.z, R1.z;
DP3 R3.x, R1, R3;
MOV R1.w, c[5];
MUL R3.y, R1.w, c[3].x;
MAX R1.w, R3.x, c[5].z;
POW R1.w, R1.w, R3.y;
MUL R0.w, R0, R1;
DP3 R1.x, R1, R2;
MAX R1.w, R1.x, c[5].z;
MUL R1.xyz, R0, c[0];
MUL R1.xyz, R1, R1.w;
MOV R0.xyz, c[1];
MUL R0.xyz, R0, c[0];
MUL R1.w, R2, c[5].x;
MAD R0.xyz, R0, R0.w, R1;
MUL result.color.xyz, R0, R1.w;
END
# 39 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c5, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c6, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r3, t0, s0
mul_pp r0.x, r3.w, c2.w
add_pp r1.x, r0, -c4
cmp r2.x, r1, c5, c5.y
mov_pp r2, -r2.x
dp3 r1.x, t3, t3
mov r4.xy, r1.x
mul_pp r3.xyz, r3, c2
mul_pp r3.xyz, r3, c0
mov r1.y, t0.w
mov r1.x, t0.z
texld r1, r1, s1
texld r7, r4, s2
texkill r2.xyzw
mov r1.x, r1.w
mad_pp r5.xy, r1, c5.z, c5.w
mul_pp r1.xy, r5, r5
add_pp_sat r1.x, r1, r1.y
dp3_pp r2.x, t1, t1
rsq_pp r4.x, r2.x
dp3_pp r2.x, t2, t2
add_pp r1.x, -r1, c5.y
rsq_pp r1.x, r1.x
rcp_pp r5.z, r1.x
mov_pp r1.x, c3
mul_pp r4.xyz, r4.x, t1
rsq_pp r2.x, r2.x
mad_pp r6.xyz, r2.x, t2, r4
dp3_pp r2.x, r6, r6
rsq_pp r2.x, r2.x
mul_pp r2.xyz, r2.x, r6
dp3_pp r2.x, r5, r2
mul_pp r1.x, c6, r1
max_pp r2.x, r2, c5
pow r6.x, r2.x, r1.x
dp3_pp r2.x, r5, r4
max_pp r2.x, r2, c5
mul_pp r4.xyz, r3, r2.x
mov r1.x, r6.x
mov_pp r3.xyz, c0
mul r1.x, r3.w, r1
mul_pp r3.xyz, c1, r3
mul_pp r2.x, r7, c5.z
mad r1.xyz, r3, r1.x, r4
mul r1.xyz, r1, r2.x
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 176 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedpmkbcmjdbaoiheedoakbcndnhicgnkeoabaaaaaaaaagaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpiaeaaaaeaaaaaaadoabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaam
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaia
ebaaaaaaaaaaaaaaalaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahocaabaaaabaaaaaa
fgafbaaaabaaaaaaagbjbaaaacaaaaaadcaaaaajhcaabaaaacaaaaaaegbcbaaa
adaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
efaaaaajpcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahbcaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
adaaaaaaakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaa
egacbaaaacaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaadaaaaaajgahbaaa
abaaaaaadeaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaiecaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaed
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaabjaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaahaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaa
abaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaabaaaaaaagaabaaa
abaaaaaaagajbaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgafbaaaabaaaaaaigadbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 176 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedggoollbmbgakabpjhpocfleeacjbhfcnabaaaaaadmajaaaaaeaaaaaa
daaaaaaagiadaaaagiaiaaaaaiajaaaaebgpgodjdaadaaaadaadaaaaaaacpppp
nmacaaaafeaaaaaaadaadaaaaaaafeaaaaaafeaaadaaceaaaaaafeaaacaaaaaa
aaababaaabacacaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaacaaacaaaaaaaaaa
aaaaalaaabaaaeaaaaaaaaaaaaacppppfbaaaaafafaaapkaaaaaaaeaaaaaialp
aaaaaaaaaaaaiadpfbaaaaafagaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaia
acaachlabpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpiaaaaaoela
abaioekaabaaaaacabaaaiiaacaappkaaeaaaaaeabaacpiaaaaappiaabaappia
aeaaaakbabaaaaacacaaabiaaaaakklaabaaaaacacaaaciaaaaapplaaiaaaaad
adaaaiiaadaaoelaadaaoelaabaaaaacadaaadiaadaappiaebaaaaababaaapia
ecaaaaadabaacpiaacaaoeiaacaioekaecaaaaadacaacpiaadaaoeiaaaaioeka
aiaaaaadabaacbiaacaaoelaacaaoelaahaaaaacabaacbiaabaaaaiaceaaaaac
adaachiaabaaoelaaeaaaaaeaeaachiaacaaoelaabaaaaiaadaaoeiaceaaaaac
afaachiaaeaaoeiaaeaaaaaeaeaacbiaabaappiaafaaaakaafaaffkaaeaaaaae
aeaacciaabaaffiaafaaaakaafaaffkafkaaaaaeadaadiiaaeaaoeiaaeaaoeia
afaakkkaacaaaaadadaaciiaadaappibafaappkaahaaaaacadaaciiaadaappia
agaaaaacaeaaceiaadaappiaaiaaaaadadaaciiaaeaaoeiaafaaoeiaaiaaaaad
abaacbiaaeaaoeiaadaaoeiaalaaaaadacaacciaabaaaaiaafaakkkaalaaaaad
abaaabiaadaappiaafaakkkaabaaaaacadaaabiaadaaaakaafaaaaadabaaacia
adaaaaiaagaaaakacaaaaaadacaaaeiaabaaaaiaabaaffiaafaaaaadabaaabia
aaaappiaacaakkiaabaaaaacadaaahiaaaaaoekaafaaaaadabaaaoiaadaablia
abaablkaafaaaaadabaaahiaabaaaaiaabaabliaafaaaaadaaaachiaaaaaoeia
acaaoekaafaaaaadadaaciiaaaaappiaacaappkaafaaaaadaaaachiaaaaaoeia
aaaaoekaaeaaaaaeaaaaahiaaaaaoeiaacaaffiaabaaoeiaacaaaaadaaaaaiia
acaaaaiaacaaaaiaafaaaaadadaachiaaaaappiaaaaaoeiaabaaaaacaaaicpia
adaaoeiappppaaaafdeieefcpiaeaaaaeaaaaaaadoabaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
ahaaaaaaakiacaiaebaaaaaaaaaaaaaaalaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
ocaabaaaabaaaaaafgafbaaaabaaaaaaagbjbaaaacaaaaaadcaaaaajhcaabaaa
acaaaaaaegbcbaaaadaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahbcaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaaakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
adaaaaaajgahbaaaabaaaaaadeaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaaiecaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaa
abeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaa
abaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaadiaaaaajhcaabaaaacaaaaaa
egiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaa
abaaaaaaagaabaaaabaaaaaaagajbaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgafbaaa
abaaaaaaigadbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaaeaaaaaa
egbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaaeghobaaa
acaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
"!!ARBfp1.0
PARAM c[6] = { program.local[0..4],
		{ 2, 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R2.w, R0, c[2];
SLT R1.x, R2.w, c[4];
DP3 R3.x, fragment.texcoord[2], fragment.texcoord[2];
MUL R0.xyz, R0, c[2];
MOV R2.xyz, fragment.texcoord[1];
RSQ R3.x, R3.x;
MAD R2.xyz, R3.x, fragment.texcoord[2], R2;
MOV result.color.w, R2;
KIL -R1.x;
MAD R1.xy, R1.wyzw, c[5].x, -c[5].y;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R1.z, R1, R1.w;
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, R2;
ADD R1.z, -R1, c[5].y;
RSQ R1.z, R1.z;
RCP R1.z, R1.z;
DP3 R2.x, R1, R2;
MOV R1.w, c[5];
MUL R2.y, R1.w, c[3].x;
MAX R1.w, R2.x, c[5].z;
POW R1.w, R1.w, R2.y;
MUL R0.w, R0, R1;
DP3 R1.w, R1, fragment.texcoord[1];
MUL R1.xyz, R0, c[0];
MAX R1.w, R1, c[5].z;
MOV R0.xyz, c[1];
MUL R1.xyz, R1, R1.w;
MUL R0.xyz, R0, c[0];
MAD R0.xyz, R0, R0.w, R1;
MUL result.color.xyz, R0, c[5].x;
END
# 34 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c5, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c6, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
texld r3, t0, s0
mul_pp r0.x, r3.w, c2.w
add_pp r1.x, r0, -c4
cmp r1.x, r1, c5, c5.y
mov r2.y, t0.w
mov r2.x, t0.z
mov r4.xy, r2
mov_pp r2, -r1.x
mul_pp r3.xyz, r3, c2
texld r1, r4, s1
texkill r2.xyzw
mov r1.x, r1.w
mad_pp r5.xy, r1, c5.z, c5.w
mul_pp r1.xy, r5, r5
dp3_pp r2.x, t2, t2
add_pp_sat r1.x, r1, r1.y
rsq_pp r2.x, r2.x
mov_pp r4.xyz, t1
mad_pp r4.xyz, r2.x, t2, r4
add_pp r2.x, -r1, c5.y
dp3_pp r1.x, r4, r4
rsq_pp r2.x, r2.x
rcp_pp r5.z, r2.x
rsq_pp r1.x, r1.x
mul_pp r2.xyz, r1.x, r4
dp3_pp r2.x, r5, r2
mov_pp r1.x, c3
mul_pp r1.x, c6, r1
max_pp r2.x, r2, c5
pow r4.w, r2.x, r1.x
mov r1.x, r4.w
mul_pp r4.xyz, r3, c0
dp3_pp r2.x, r5, t1
max_pp r2.x, r2, c5
mov_pp r3.xyz, c0
mul r1.x, r3.w, r1
mul_pp r2.xyz, r4, r2.x
mul_pp r3.xyz, c1, r3
mad r1.xyz, r3, r1.x, r2
mul r1.xyz, r1, c5.z
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
Float 112 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkpefmfidkibghblfmphgpcjefngodaooabaaaaaabiafaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcciaeaaaaeaaaaaaaakabaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaia
ebaaaaaaaaaaaaaaahaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaadaaaaaaagaabaaaabaaaaaa
egbcbaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
acaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaa
egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaah
ccaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaacaaaaaadeaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiecaabaaaabaaaaaa
akiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaa
diaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaahncaabaaaabaaaaaaagaabaaaabaaaaaaagajbaaaacaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaaaaaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
Float 112 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedhpkgolenkalicfjanmjjdjmcehmjodfeabaaaaaapaahaaaaaeaaaaaa
daaaaaaaaeadaaaadeahaaaalmahaaaaebgpgodjmmacaaaammacaaaaaaacpppp
iiacaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaabaaaeaaaaaaaaaaaaaaaaaaahaaabaaaeaaaaaaaaaaaaacpppp
fbaaaaafafaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafagaaapka
aaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaabaaaaac
abaaaiiaacaappkaaeaaaaaeabaacpiaaaaappiaabaappiaaeaaaakbabaaaaac
acaaabiaaaaakklaabaaaaacacaaaciaaaaapplaebaaaaababaaapiaecaaaaad
abaacpiaacaaoeiaabaioekaaiaaaaadabaacbiaacaaoelaacaaoelaahaaaaac
abaacbiaabaaaaiaabaaaaacacaaahiaacaaoelaaeaaaaaeacaachiaacaaoeia
abaaaaiaabaaoelaceaaaaacadaachiaacaaoeiaaeaaaaaeacaacbiaabaappia
afaaaakaafaaffkaaeaaaaaeacaacciaabaaffiaafaaaakaafaaffkafkaaaaae
acaadiiaacaaoeiaacaaoeiaafaakkkaacaaaaadacaaciiaacaappibafaappka
ahaaaaacacaaciiaacaappiaagaaaaacacaaceiaacaappiaaiaaaaadacaaciia
acaaoeiaadaaoeiaaiaaaaadabaacbiaacaaoeiaabaaoelaalaaaaadacaacbia
abaaaaiaafaakkkaalaaaaadabaaabiaacaappiaafaakkkaabaaaaacadaaabia
adaaaakaafaaaaadabaaaciaadaaaaiaagaaaakacaaaaaadacaaaciaabaaaaia
abaaffiaafaaaaadabaaabiaaaaappiaacaaffiaabaaaaacadaaahiaaaaaoeka
afaaaaadabaaaoiaadaabliaabaablkaafaaaaadabaaahiaabaaaaiaabaablia
afaaaaadaaaachiaaaaaoeiaacaaoekaafaaaaadadaaciiaaaaappiaacaappka
afaaaaadaaaachiaaaaaoeiaaaaaoekaaeaaaaaeaaaaahiaaaaaoeiaacaaaaia
abaaoeiaacaaaaadadaachiaaaaaoeiaaaaaoeiaabaaaaacaaaicpiaadaaoeia
ppppaaaafdeieefcciaeaaaaeaaaaaaaakabaaaafjaaaaaeegiocaaaaaaaaaaa
aiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaa
aaaaaaaaahaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
dcaaaaajhcaabaaaabaaaaaaegbcbaaaadaaaaaaagaabaaaabaaaaaaegbcbaaa
acaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaacaaaaaa
hgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaa
acaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaacaaaaaaegbcbaaaacaaaaaadeaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiecaabaaaabaaaaaaakiacaaa
aaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaaj
hcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaa
diaaaaahncaabaaaabaaaaaaagaabaaaabaaaaaaagajbaaaacaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaaaaaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
"!!ARBfp1.0
PARAM c[7] = { program.local[0..4],
		{ 2, 1, 0, 128 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R2, fragment.texcoord[0], texture[0], 2D;
TEX R4.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R3.w, R2, c[2];
SLT R0.w, R3, c[4].x;
DP3 R0.z, fragment.texcoord[3], fragment.texcoord[3];
RCP R0.x, fragment.texcoord[3].w;
MAD R0.xy, fragment.texcoord[3], R0.x, c[6].x;
MOV result.color.w, R3;
TEX R1.w, R0.z, texture[3], 2D;
KIL -R0.w;
TEX R0.w, R0, texture[2], 2D;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R1.xyz, R0.x, fragment.texcoord[1];
MAD R0.xy, R4.wyzw, c[5].x, -c[5].y;
DP3 R0.z, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.z, R0.z;
MAD R3.xyz, R0.z, fragment.texcoord[2], R1;
MUL R4.xy, R0, R0;
ADD_SAT R0.z, R4.x, R4.y;
DP3 R4.x, R3, R3;
RSQ R4.x, R4.x;
MUL R3.xyz, R4.x, R3;
ADD R0.z, -R0, c[5].y;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R1.x, R0, R1;
DP3 R3.x, R0, R3;
MUL R0.xyz, R2, c[2];
MOV R4.x, c[5].w;
SLT R2.x, c[5].z, fragment.texcoord[3].z;
MUL R0.w, R2.x, R0;
MUL R0.w, R0, R1;
MUL R0.xyz, R0, c[0];
MAX R1.x, R1, c[5].z;
MUL R1.xyz, R0, R1.x;
MOV R0.xyz, c[1];
MUL R3.y, R4.x, c[3].x;
MAX R3.x, R3, c[5].z;
POW R3.x, R3.x, R3.y;
MUL R2.w, R2, R3.x;
MUL R0.xyz, R0, c[0];
MUL R0.w, R0, c[5].x;
MAD R0.xyz, R0, R2.w, R1;
MUL result.color.xyz, R0, R0.w;
END
# 45 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c5, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c6, 128.00000000, 0.50000000, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3
texld r3, t0, s0
mul_pp r0.x, r3.w, c2.w
add_pp r1.x, r0, -c4
cmp r2.x, r1, c5, c5.y
dp3 r1.x, t3, t3
mov r4.xy, r1.x
mov_pp r2, -r2.x
rcp r1.x, t3.w
mad r1.xy, t3, r1.x, c6.y
mul_pp r3.xyz, r3, c2
mov r5.y, t0.w
mov r5.x, t0.z
mul_pp r3.xyz, r3, c0
texld r7, r4, s3
texkill r2.xyzw
texld r2, r5, s1
texld r1, r1, s2
dp3_pp r2.x, t1, t1
rsq_pp r4.x, r2.x
dp3_pp r2.x, t2, t2
mov r1.y, r2
mov r1.x, r2.w
mad_pp r5.xy, r1, c5.z, c5.w
mul_pp r1.xy, r5, r5
add_pp_sat r1.x, r1, r1.y
add_pp r1.x, -r1, c5.y
rsq_pp r1.x, r1.x
rcp_pp r5.z, r1.x
mov_pp r1.x, c3
mul_pp r4.xyz, r4.x, t1
rsq_pp r2.x, r2.x
mad_pp r6.xyz, r2.x, t2, r4
dp3_pp r2.x, r6, r6
rsq_pp r2.x, r2.x
mul_pp r2.xyz, r2.x, r6
dp3_pp r2.x, r5, r2
mul_pp r1.x, c6, r1
max_pp r2.x, r2, c5
pow r6.x, r2.x, r1.x
dp3_pp r2.x, r5, r4
max_pp r2.x, r2, c5
mul_pp r3.xyz, r3, r2.x
mov r1.x, r6.x
mul r1.x, r3.w, r1
mov_pp r4.xyz, c0
cmp r2.x, -t3.z, c5, c5.y
mul_pp r2.x, r2, r1.w
mul_pp r2.x, r2, r7
mul_pp r4.xyz, c1, r4
mul_pp r2.x, r2, c5.z
mad r1.xyz, r4, r1.x, r3
mul r1.xyz, r1, r2.x
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_LightTexture0] 2D 0
SetTexture 3 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 176 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedleomcfcgmhkmggdjglojfbdkjjfcaapjabaaaaaaniagaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcnaafaaaaeaaaaaaaheabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaiaebaaaaaa
aaaaaaaaalaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
baaaaaahccaabaaaabaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaa
abaaaaaaagbjbaaaacaaaaaadcaaaaajhcaabaaaacaaaaaaegbcbaaaadaaaaaa
agaabaaaabaaaaaajgahbaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaaefaaaaaj
pcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
bcaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaa
akaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
acaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaadaaaaaajgahbaaaabaaaaaa
deaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
ecaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaahaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaa
egiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaabaaaaaaagaabaaaabaaaaaa
agajbaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaa
aoaaaaahdcaabaaaabaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaaaaaaaak
dcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaa
aeaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaagaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaapaaaaah
icaabaaaaaaaaaaapgapbaaaaaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_LightTexture0] 2D 0
SetTexture 3 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 176 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedcgijknfccjahnnmmjilgnplkcmlnadccabaaaaaahiakaaaaaeaaaaaa
daaaaaaammadaaaakeajaaaaeeakaaaaebgpgodjjeadaaaajeadaaaaaaacpppp
dmadaaaafiaaaaaaadaadeaaaaaafiaaaaaafiaaaeaaceaaaaaafiaaacaaaaaa
adababaaaaacacaaabadadaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaacaaacaa
aaaaaaaaaaaaalaaabaaaeaaaaaaaaaaaaacppppfbaaaaafafaaapkaaaaaaaea
aaaaialpaaaaaaaaaaaaiadpfbaaaaafagaaapkaaaaaaadpaaaaaaedaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaac
aaaaaaiaacaachlabpaaaaacaaaaaaiaadaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaaja
adaiapkaecaaaaadaaaacpiaaaaaoelaacaioekaabaaaaacabaaaiiaacaappka
aeaaaaaeabaacpiaaaaappiaabaappiaaeaaaakbabaaaaacacaaabiaaaaakkla
abaaaaacacaaaciaaaaapplaagaaaaacacaaaeiaadaapplaaeaaaaaeadaaadia
adaaoelaacaakkiaagaaaakaaiaaaaadaeaaaiiaadaaoelaadaaoelaabaaaaac
aeaaadiaaeaappiaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaadaioeka
ecaaaaadacaacpiaadaaoeiaaaaioekaecaaaaadadaacpiaaeaaoeiaabaioeka
aiaaaaadabaacbiaacaaoelaacaaoelaahaaaaacabaacbiaabaaaaiaceaaaaac
acaachiaabaaoelaaeaaaaaeaeaachiaacaaoelaabaaaaiaacaaoeiaceaaaaac
afaachiaaeaaoeiaaeaaaaaeaeaacbiaabaappiaafaaaakaafaaffkaaeaaaaae
aeaacciaabaaffiaafaaaakaafaaffkafkaaaaaeaeaadiiaaeaaoeiaaeaaoeia
afaakkkaacaaaaadaeaaciiaaeaappibafaappkaahaaaaacaeaaciiaaeaappia
agaaaaacaeaaceiaaeaappiaaiaaaaadaeaaciiaaeaaoeiaafaaoeiaaiaaaaad
abaacbiaaeaaoeiaacaaoeiaalaaaaadacaacbiaabaaaaiaafaakkkaalaaaaad
abaaabiaaeaappiaafaakkkaabaaaaacabaaaciaagaaffkaafaaaaadabaaacia
abaaffiaadaaaakacaaaaaadacaaaciaabaaaaiaabaaffiaafaaaaadabaaabia
aaaappiaacaaffiaabaaaaacaeaaahiaaaaaoekaafaaaaadabaaaoiaaeaablia
abaablkaafaaaaadabaaahiaabaaaaiaabaabliaafaaaaadaaaachiaaaaaoeia
acaaoekaafaaaaadaeaaciiaaaaappiaacaappkaafaaaaadaaaachiaaaaaoeia
aaaaoekaaeaaaaaeaaaaahiaaaaaoeiaacaaaaiaabaaoeiaafaaaaadaaaaciia
acaappiaadaaaaiafiaaaaaeaaaaciiaadaakklbafaakkkaaaaappiaacaaaaad
aaaaaiiaaaaappiaaaaappiaafaaaaadaeaachiaaaaappiaaaaaoeiaabaaaaac
aaaicpiaaeaaoeiappppaaaafdeieefcnaafaaaaeaaaaaaaheabaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
ahaaaaaaakiacaiaebaaaaaaaaaaaaaaalaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
ocaabaaaabaaaaaafgafbaaaabaaaaaaagbjbaaaacaaaaaadcaaaaajhcaabaaa
acaaaaaaegbcbaaaadaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahbcaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaaakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
adaaaaaajgahbaaaabaaaaaadeaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaaiecaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaa
abeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaa
abaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaadiaaaaajhcaabaaaacaaaaaa
egiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaa
abaaaaaaagaabaaaabaaaaaaagajbaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgafbaaa
abaaaaaaigadbaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaaeaaaaaa
pgbpbaaaaeaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaa
abeaaaaaaaaaaaaackbabaaaaeaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaa
dkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaa
aeaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaabaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaaaaaaaaaaagaabaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
SetTexture 3 [_LightTexture0] CUBE 3
"!!ARBfp1.0
PARAM c[6] = { program.local[0..4],
		{ 2, 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R2, fragment.texcoord[0], texture[0], 2D;
TEX R4.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R1.w, fragment.texcoord[3], texture[3], CUBE;
MUL R3.w, R2, c[2];
SLT R0.y, R3.w, c[4].x;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
DP3 R0.z, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.z, R0.z;
MOV result.color.w, R3;
TEX R0.w, R0.x, texture[2], 2D;
KIL -R0.y;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R1.xyz, R0.x, fragment.texcoord[1];
MAD R0.xy, R4.wyzw, c[5].x, -c[5].y;
MUL R0.w, R0, R1;
MAD R3.xyz, R0.z, fragment.texcoord[2], R1;
MUL R4.xy, R0, R0;
ADD_SAT R0.z, R4.x, R4.y;
DP3 R4.x, R3, R3;
RSQ R4.x, R4.x;
MUL R3.xyz, R4.x, R3;
ADD R0.z, -R0, c[5].y;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R1.x, R0, R1;
DP3 R3.x, R0, R3;
MOV R4.x, c[5].w;
MUL R0.xyz, R2, c[2];
MUL R0.xyz, R0, c[0];
MAX R1.x, R1, c[5].z;
MUL R1.xyz, R0, R1.x;
MOV R0.xyz, c[1];
MUL R3.y, R4.x, c[3].x;
MAX R3.x, R3, c[5].z;
POW R3.x, R3.x, R3.y;
MUL R2.w, R2, R3.x;
MUL R0.xyz, R0, c[0];
MUL R0.w, R0, c[5].x;
MAD R0.xyz, R0, R2.w, R1;
MUL result.color.xyz, R0, R0.w;
END
# 41 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTextureB0] 2D 2
SetTexture 3 [_LightTexture0] CUBE 3
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c5, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c6, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r3, t0, s0
mul_pp r0.x, r3.w, c2.w
add_pp r1.x, r0, -c4
cmp r1.x, r1, c5, c5.y
mov_pp r2, -r1.x
dp3 r1.x, t3, t3
mov r1.xy, r1.x
mul_pp r3.xyz, r3, c2
mov r4.y, t0.w
mov r4.x, t0.z
mul_pp r3.xyz, r3, c0
texld r7, r1, s2
texkill r2.xyzw
texld r2, r4, s1
texld r1, t3, s3
dp3_pp r2.x, t1, t1
rsq_pp r4.x, r2.x
dp3_pp r2.x, t2, t2
mov r1.y, r2
mov r1.x, r2.w
mad_pp r5.xy, r1, c5.z, c5.w
mul_pp r1.xy, r5, r5
add_pp_sat r1.x, r1, r1.y
add_pp r1.x, -r1, c5.y
rsq_pp r1.x, r1.x
rcp_pp r5.z, r1.x
mov_pp r1.x, c3
mul_pp r4.xyz, r4.x, t1
rsq_pp r2.x, r2.x
mad_pp r6.xyz, r2.x, t2, r4
dp3_pp r2.x, r6, r6
rsq_pp r2.x, r2.x
mul_pp r2.xyz, r2.x, r6
dp3_pp r2.x, r5, r2
mul_pp r1.x, c6, r1
max_pp r2.x, r2, c5
pow r6.x, r2.x, r1.x
dp3_pp r2.x, r5, r4
max_pp r2.x, r2, c5
mov r1.x, r6.x
mul r1.x, r3.w, r1
mov_pp r4.xyz, c0
mul_pp r3.xyz, r3, r2.x
mul r2.x, r7, r1.w
mul_pp r4.xyz, c1, r4
mul_pp r2.x, r2, c5.z
mad r1.xyz, r4, r1.x, r3
mul r1.xyz, r1, r2.x
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_LightTextureB0] 2D 1
SetTexture 3 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 176 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefieceddimhgjhfonknidbblekhjjocafjmfkciabaaaaaaeaagaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcdiafaaaaeaaaaaaaeoabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fidaaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaiaebaaaaaa
aaaaaaaaalaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
baaaaaahccaabaaaabaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaa
abaaaaaaagbjbaaaacaaaaaadcaaaaajhcaabaaaacaaaaaaegbcbaaaadaaaaaa
agaabaaaabaaaaaajgahbaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaaefaaaaaj
pcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
bcaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaa
akaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
acaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaadaaaaaajgahbaaaabaaaaaa
deaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaai
ecaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaahaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaa
egiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaabaaaaaaagaabaaaabaaaaaa
agajbaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaaj
pcaabaaaabaaaaaapgapbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbcbaaaaeaaaaaaeghobaaaadaaaaaaaagabaaa
aaaaaaaaapaaaaahicaabaaaaaaaaaaaagaabaaaabaaaaaapgapbaaaacaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_BumpMap] 2D 3
SetTexture 2 [_LightTextureB0] 2D 1
SetTexture 3 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 176 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedclgenpjcfmcfodfgipokibhnpjbmncblabaaaaaakmajaaaaaeaaaaaa
daaaaaaajiadaaaaniaiaaaahiajaaaaebgpgodjgaadaaaagaadaaaaaaacpppp
aiadaaaafiaaaaaaadaadeaaaaaafiaaaaaafiaaaeaaceaaaaaafiaaadaaaaaa
acababaaaaacacaaabadadaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaacaaacaa
aaaaaaaaaaaaalaaabaaaeaaaaaaaaaaaaacppppfbaaaaafafaaapkaaaaaaaea
aaaaialpaaaaaaaaaaaaiadpfbaaaaafagaaapkaaaaaaaedaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaac
aaaaaaiaacaachlabpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaajiaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaaja
adaiapkaecaaaaadaaaacpiaaaaaoelaacaioekaabaaaaacabaaaiiaacaappka
aeaaaaaeabaacpiaaaaappiaabaappiaaeaaaakbabaaaaacacaaabiaaaaakkla
abaaaaacacaaaciaaaaapplaaiaaaaadadaaaiiaadaaoelaadaaoelaabaaaaac
adaaadiaadaappiaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaadaioeka
ecaaaaadacaaapiaadaaoeiaabaioekaecaaaaadadaaapiaadaaoelaaaaioeka
aiaaaaadabaacbiaacaaoelaacaaoelaahaaaaacabaacbiaabaaaaiaceaaaaac
adaachiaabaaoelaaeaaaaaeaeaachiaacaaoelaabaaaaiaadaaoeiaceaaaaac
afaachiaaeaaoeiaaeaaaaaeaeaacbiaabaappiaafaaaakaafaaffkaaeaaaaae
aeaacciaabaaffiaafaaaakaafaaffkafkaaaaaeaeaadiiaaeaaoeiaaeaaoeia
afaakkkaacaaaaadaeaaciiaaeaappibafaappkaahaaaaacaeaaciiaaeaappia
agaaaaacaeaaceiaaeaappiaaiaaaaadaeaaciiaaeaaoeiaafaaoeiaaiaaaaad
abaacbiaaeaaoeiaadaaoeiaalaaaaadacaacciaabaaaaiaafaakkkaalaaaaad
abaaabiaaeaappiaafaakkkaabaaaaacadaaabiaadaaaakaafaaaaadabaaacia
adaaaaiaagaaaakacaaaaaadacaaaeiaabaaaaiaabaaffiaafaaaaadabaaabia
aaaappiaacaakkiaabaaaaacadaaahiaaaaaoekaafaaaaadabaaaoiaadaablia
abaablkaafaaaaadabaaahiaabaaaaiaabaabliaafaaaaadaaaachiaaaaaoeia
acaaoekaafaaaaadaeaaciiaaaaappiaacaappkaafaaaaadaaaachiaaaaaoeia
aaaaoekaaeaaaaaeaaaaahiaaaaaoeiaacaaffiaabaaoeiaafaaaaadaaaaciia
acaaaaiaadaappiaacaaaaadaaaaaiiaaaaappiaaaaappiaafaaaaadaeaachia
aaaappiaaaaaoeiaabaaaaacaaaicpiaaeaaoeiappppaaaafdeieefcdiafaaaa
eaaaaaaaeoabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafidaaaaeaahabaaa
adaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaiaebaaaaaaaaaaaaaaalaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaabaaaaaahccaabaaa
abaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaaabaaaaaaagbjbaaa
acaaaaaadcaaaaajhcaabaaaacaaaaaaegbcbaaaadaaaaaaagaabaaaabaaaaaa
jgahbaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaa
adaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahbcaabaaaabaaaaaa
egaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaaakaabaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaah
ccaabaaaabaaaaaaegacbaaaadaaaaaajgahbaaaabaaaaaadeaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiecaabaaaabaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaa
diaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaahncaabaaaabaaaaaaagaabaaaabaaaaaaagajbaaaacaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
pgapbaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbcbaaaaeaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaagaabaaaabaaaaaapgapbaaaacaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheojiaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahahaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"!!ARBfp1.0
PARAM c[6] = { program.local[0..4],
		{ 2, 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R2.w, fragment.texcoord[3], texture[2], 2D;
MUL R3.x, R0.w, c[2].w;
SLT R1.x, R3, c[4];
DP3 R3.y, fragment.texcoord[2], fragment.texcoord[2];
MUL R0.xyz, R0, c[2];
MOV R2.xyz, fragment.texcoord[1];
RSQ R3.y, R3.y;
MAD R2.xyz, R3.y, fragment.texcoord[2], R2;
MUL R0.xyz, R0, c[0];
MOV result.color.w, R3.x;
KIL -R1.x;
MAD R1.xy, R1.wyzw, c[5].x, -c[5].y;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R1.z, R1, R1.w;
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, R2;
ADD R1.z, -R1, c[5].y;
RSQ R1.z, R1.z;
RCP R1.z, R1.z;
DP3 R2.x, R1, R2;
MOV R1.w, c[5];
MUL R2.y, R1.w, c[3].x;
MAX R1.w, R2.x, c[5].z;
POW R1.w, R1.w, R2.y;
MUL R0.w, R0, R1;
DP3 R1.x, R1, fragment.texcoord[1];
MAX R1.w, R1.x, c[5].z;
MUL R0.xyz, R0, R1.w;
MOV R1.xyz, c[1];
MUL R1.xyz, R1, c[0];
MUL R1.w, R2, c[5].x;
MAD R0.xyz, R1, R0.w, R0;
MUL result.color.xyz, R0, R1.w;
END
# 36 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightTexture0] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c5, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c6, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3.xy
texld r3, t0, s0
mul_pp r0.x, r3.w, c2.w
add_pp r1.x, r0, -c4
cmp r1.x, r1, c5, c5.y
mov_pp r1, -r1.x
mul_pp r3.xyz, r3, c2
mul_pp r3.xyz, r3, c0
mov r2.y, t0.w
mov r2.x, t0.z
mov_pp r5.xyz, t1
texld r2, r2, s1
texkill r1.xyzw
texld r1, t3, s2
dp3_pp r2.x, t2, t2
rsq_pp r2.x, r2.x
mad_pp r5.xyz, r2.x, t2, r5
dp3_pp r2.x, r5, r5
mov r1.y, r2
mov r1.x, r2.w
mad_pp r4.xy, r1, c5.z, c5.w
mul_pp r1.xy, r4, r4
add_pp_sat r1.x, r1, r1.y
add_pp r1.x, -r1, c5.y
rsq_pp r1.x, r1.x
rcp_pp r4.z, r1.x
rsq_pp r2.x, r2.x
mul_pp r2.xyz, r2.x, r5
dp3_pp r2.x, r4, r2
mov_pp r1.x, c3
mul_pp r1.x, c6, r1
max_pp r2.x, r2, c5
pow r5.x, r2.x, r1.x
dp3_pp r2.x, r4, t1
max_pp r2.x, r2, c5
mul_pp r4.xyz, r3, r2.x
mov r1.x, r5.x
mul r1.x, r3.w, r1
mul_pp r2.x, r1.w, c5.z
mov_pp r3.xyz, c0
mul_pp r3.xyz, c1, r3
mad r1.xyz, r3, r1.x, r4
mul r1.xyz, r1, r2.x
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 176 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkoeecmefepbkfichalgkeoppmeboofidabaaaaaajiafaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcjaaeaaaaeaaaaaaaceabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaaddcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaam
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaia
ebaaaaaaaaaaaaaaalaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaadaaaaaaagaabaaaabaaaaaa
egbcbaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
acaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaa
egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaah
ccaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaacaaaaaadeaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiecaabaaaabaaaaaa
akiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaa
diaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaahncaabaaaabaaaaaaagaabaaaabaaaaaaagajbaaaacaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_BumpMap] 2D 2
SetTexture 2 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 128 [_Shininess]
Float 176 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedpoloolgaponjfejmianpomljbcmiggigabaaaaaaliaiaaaaaeaaaaaa
daaaaaaaemadaaaaoeahaaaaieaiaaaaebgpgodjbeadaaaabeadaaaaaaacpppp
maacaaaafeaaaaaaadaadaaaaaaafeaaaaaafeaaadaaceaaaaaafeaaacaaaaaa
aaababaaabacacaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaacaaacaaaaaaaaaa
aaaaalaaabaaaeaaaaaaaaaaaaacppppfbaaaaafafaaapkaaaaaaaeaaaaaialp
aaaaaaaaaaaaiadpfbaaaaafagaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaia
acaachlabpaaaaacaaaaaaiaadaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpiaaaaaoela
abaioekaabaaaaacabaaaiiaacaappkaaeaaaaaeabaacpiaaaaappiaabaappia
aeaaaakbabaaaaacacaaabiaaaaakklaabaaaaacacaaaciaaaaapplaebaaaaab
abaaapiaecaaaaadabaacpiaacaaoeiaacaioekaecaaaaadacaacpiaadaaoela
aaaioekaaiaaaaadabaacbiaacaaoelaacaaoelaahaaaaacabaacbiaabaaaaia
abaaaaacacaaahiaacaaoelaaeaaaaaeacaachiaacaaoeiaabaaaaiaabaaoela
ceaaaaacadaachiaacaaoeiaaeaaaaaeacaacbiaabaappiaafaaaakaafaaffka
aeaaaaaeacaacciaabaaffiaafaaaakaafaaffkafkaaaaaeadaadiiaacaaoeia
acaaoeiaafaakkkaacaaaaadadaaciiaadaappibafaappkaahaaaaacadaaciia
adaappiaagaaaaacacaaceiaadaappiaaiaaaaadabaacbiaacaaoeiaadaaoeia
aiaaaaadabaacciaacaaoeiaabaaoelaalaaaaadacaacbiaabaaffiaafaakkka
alaaaaadacaaaciaabaaaaiaafaakkkaabaaaaacabaaabiaadaaaakaafaaaaad
abaaabiaabaaaaiaagaaaakacaaaaaadadaaabiaacaaffiaabaaaaiaafaaaaad
abaaabiaaaaappiaadaaaaiaabaaaaacadaaahiaaaaaoekaafaaaaadabaaaoia
adaabliaabaablkaafaaaaadabaaahiaabaaaaiaabaabliaafaaaaadaaaachia
aaaaoeiaacaaoekaafaaaaadadaaciiaaaaappiaacaappkaafaaaaadaaaachia
aaaaoeiaaaaaoekaaeaaaaaeaaaaahiaaaaaoeiaacaaaaiaabaaoeiaacaaaaad
aaaaaiiaacaappiaacaappiaafaaaaadadaachiaaaaappiaaaaaoeiaabaaaaac
aaaicpiaadaaoeiappppaaaafdeieefcjaaeaaaaeaaaaaaaceabaaaafjaaaaae
egiocaaaaaaaaaaaamaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaahaaaaaaakiacaiaebaaaaaaaaaaaaaaalaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaa
adaaaaaaagaabaaaabaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaabaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaadkaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaa
acaaaaaadeaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaiecaabaaaabaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaaaed
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaabjaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaahaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaa
abaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaabaaaaaaagaabaaa
abaaaaaaagajbaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgafbaaaabaaaaaaigadbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
Vector 11 [_BumpMap_ST]
"!!ARBvp1.0
PARAM c[12] = { program.local[0],
		state.matrix.mvp,
		program.local[5..11] };
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
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[11].xyxy, c[11];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 22 instructions, 2 R-regs
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
Vector 9 [_MainTex_ST]
Vector 10 [_BumpMap_ST]
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
mad oT0.zw, v3.xyxy, c10.xyxy, c10
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
ConstBuffer "$Globals" 128
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedoknnicionjkpagipndodgmhbmppfgbolabaaaaaameafaaaaadaaaaaa
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
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcciaeaaaaeaaaabaa
akabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaa
kgiocaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaaakiacaaaabaaaaaa
amaaaaaadgaaaaagccaabaaaabaaaaaaakiacaaaabaaaaaaanaaaaaadgaaaaag
ecaabaaaabaaaaaaakiacaaaabaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaihccabaaaacaaaaaaegacbaaaacaaaaaapgipcaaa
abaaaaaabeaaaaaadgaaaaagbcaabaaaabaaaaaabkiacaaaabaaaaaaamaaaaaa
dgaaaaagccaabaaaabaaaaaabkiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaa
abaaaaaabkiacaaaabaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaihccabaaaadaaaaaaegacbaaaacaaaaaapgipcaaaabaaaaaa
beaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaabaaaaaaamaaaaaadgaaaaag
ccaabaaaabaaaaaackiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaa
ckiacaaaabaaaaaaaoaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaihccabaaaaeaaaaaaegacbaaaaaaaaaaapgipcaaaabaaaaaabeaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 128
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedhdomfeimeiconaldkpfbcohnfocmapgjabaaaaaagaaiaaaaaeaaaaaa
daaaaaaamiacaaaapiagaaaamaahaaaaebgpgodjjaacaaaajaacaaaaaaacpopp
diacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaafaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaabaaamaaadaaahaaaaaaaaaa
abaabeaaabaaakaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoa
adaaeejaacaaeekaacaaoekaabaaaaacaaaaahiaabaaoejaafaaaaadabaaahia
aaaamjiaacaancjaaeaaaaaeaaaaahiaacaamjjaaaaanciaabaaoeibafaaaaad
aaaaahiaaaaaoeiaabaappjaabaaaaacabaaabiaahaaaakaabaaaaacabaaacia
aiaaaakaabaaaaacabaaaeiaajaaaakaaiaaaaadacaaaciaaaaaoeiaabaaoeia
aiaaaaadacaaabiaabaaoejaabaaoeiaaiaaaaadacaaaeiaacaaoejaabaaoeia
afaaaaadabaaahoaacaaoeiaakaappkaabaaaaacabaaabiaahaaffkaabaaaaac
abaaaciaaiaaffkaabaaaaacabaaaeiaajaaffkaaiaaaaadacaaaciaaaaaoeia
abaaoeiaaiaaaaadacaaabiaabaaoejaabaaoeiaaiaaaaadacaaaeiaacaaoeja
abaaoeiaafaaaaadacaaahoaacaaoeiaakaappkaabaaaaacabaaabiaahaakkka
abaaaaacabaaaciaaiaakkkaabaaaaacabaaaeiaajaakkkaaiaaaaadaaaaacia
aaaaoeiaabaaoeiaaiaaaaadaaaaabiaabaaoejaabaaoeiaaiaaaaadaaaaaeia
acaaoejaabaaoeiaafaaaaadadaaahoaaaaaoeiaakaappkaafaaaaadaaaaapia
aaaaffjaaeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaafaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiappppaaaafdeieefcciaeaaaaeaaaabaaakabaaaafjaaaaaeegiocaaa
aaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaa
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
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_Color]
Float 1 [_Shininess]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
"!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 2, 1, 0.5 } };
TEMP R0;
TEMP R1;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, R0.w, c[0].w;
SLT R0.x, R0, c[2];
MOV result.color.w, c[1].x;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
KIL -R0.x;
MAD R0.xy, R0.wyzw, c[3].x, -c[3].y;
MUL R0.zw, R0.xyxy, R0.xyxy;
ADD_SAT R0.z, R0, R0.w;
ADD R0.z, -R0, c[3].y;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R1.z, fragment.texcoord[3], R0;
DP3 R1.x, R0, fragment.texcoord[1];
DP3 R1.y, R0, fragment.texcoord[2];
MAD result.color.xyz, R1, c[3].z, c[3].z;
END
# 16 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Color]
Float 1 [_Shininess]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c3, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c4, 0.50000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r0, t0, s0
mov_pp r0.x, c2
mad_pp r0.x, r0.w, c0.w, -r0
cmp r0.x, r0, c3, c3.y
mov_pp r0, -r0.x
mov r1.y, t0.w
mov r1.x, t0.z
texld r1, r1, s1
texkill r0.xyzw
mov r0.y, r1
mov r0.x, r1.w
mad_pp r0.xy, r0, c3.z, c3.w
mul_pp r1.xy, r0, r0
add_pp_sat r1.x, r1, r1.y
add_pp r1.x, -r1, c3.y
rsq_pp r1.x, r1.x
rcp_pp r0.z, r1.x
dp3 r1.z, t3, r0
dp3 r1.x, r0, t1
dp3 r1.y, r0, t2
mad_pp r0.xyz, r1, c4.x, c4.x
mov_pp r0.w, c1.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
ConstBuffer "$Globals" 128
Vector 48 [_Color]
Float 64 [_Shininess]
Float 112 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedplndakdlokljbghnkhfeieeiefbnkmmfabaaaaaajaadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefciiacaaaaeaaaaaaakcaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaambcaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaa
akiacaiaebaaaaaaaaaaaaaaahaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaa
baaaaaahccaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaah
ecaabaaaabaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaaphccabaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaagiccabaaaaaaaaaaa
akiacaaaaaaaaaaaaeaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
ConstBuffer "$Globals" 128
Vector 48 [_Color]
Float 64 [_Shininess]
Float 112 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedldechcgglbibhlgbelmhopklmekfkdnaabaaaaaaiaafaaaaaeaaaaaa
daaaaaaabmacaaaakmaeaaaaemafaaaaebgpgodjoeabaaaaoeabaaaaaaacpppp
kaabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaadaaacaaaaaaaaaaaaaaaaaaahaaabaaacaaaaaaaaaaaaacpppp
fbaaaaafadaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafaeaaapka
aaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaaiaadaaahla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaadaaaacpia
aaaaoelaaaaioekaabaaaaacabaaaiiaaaaappkaaeaaaaaeaaaacpiaaaaappia
abaappiaacaaaakbabaaaaacabaaabiaaaaakklaabaaaaacabaaaciaaaaappla
ebaaaaabaaaaapiaecaaaaadaaaacpiaabaaoeiaabaioekaaeaaaaaeabaacbia
aaaappiaadaaaakaadaaffkaaeaaaaaeabaacciaaaaaffiaadaaaakaadaaffka
fkaaaaaeabaadiiaabaaoeiaabaaoeiaadaakkkaacaaaaadabaaciiaabaappib
adaappkaahaaaaacabaaciiaabaappiaagaaaaacabaaceiaabaappiaaiaaaaad
aaaacbiaabaaoelaabaaoeiaaiaaaaadaaaacciaacaaoelaabaaoeiaaiaaaaad
aaaaceiaadaaoelaabaaoeiaaeaaaaaeaaaachiaaaaaoeiaaeaaaakaaeaaaaka
abaaaaacaaaaciiaabaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
iiacaaaaeaaaaaaakcaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
bcaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaia
ebaaaaaaaaaaaaaaahaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaah
ccaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahecaabaaa
abaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaaphccabaaaaaaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaagiccabaaaaaaaaaaaakiacaaa
aaaaaaaaaeaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
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
ConstBuffer "$Globals" 144
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
ConstBuffer "$Globals" 144
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
ConstBuffer "$Globals" 176
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
ConstBuffer "$Globals" 176
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
ConstBuffer "$Globals" 176
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
ConstBuffer "$Globals" 176
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
ConstBuffer "$Globals" 144
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
ConstBuffer "$Globals" 144
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
ConstBuffer "$Globals" 176
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
ConstBuffer "$Globals" 176
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
ConstBuffer "$Globals" 176
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
ConstBuffer "$Globals" 176
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
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
"!!ARBfp1.0
PARAM c[3] = { program.local[0..2] };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R1, fragment.texcoord[1], texture[2], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2.w, R0, c[1];
SLT R2.x, R2.w, c[2];
LG2 R1.w, R1.w;
MUL R0.w, -R1, R0;
LG2 R1.x, R1.x;
LG2 R1.z, R1.z;
LG2 R1.y, R1.y;
ADD R1.xyz, -R1, fragment.texcoord[2];
MUL R0.xyz, R0, c[1];
MAD result.color.w, R0, c[0], R2;
KIL -R2.x;
MUL R2.xyz, R1, c[0];
MUL R2.xyz, R0.w, R2;
MAD result.color.xyz, R0, R1, R2;
END
# 16 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s2
def c3, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
dcl t1
dcl t2.xyz
texld r2, t0, s0
mov_pp r0.x, c2
mad_pp r0.x, r2.w, c1.w, -r0
cmp r0.x, r0, c3, c3.y
mov_pp r1, -r0.x
mul_pp r2.xyz, r2, c1
texldp r0, t1, s2
texkill r1.xyzw
log_pp r0.x, r0.x
log_pp r0.z, r0.z
log_pp r0.y, r0.y
add_pp r3.xyz, -r0, t2
log_pp r0.x, r0.w
mul_pp r1.xyz, r3, c0
mul_pp r0.x, r2.w, -r0
mul_pp r4.xyz, r0.x, r1
mul_pp r1.x, r2.w, c1.w
mad_pp r2.xyz, r2, r3, r4
mad_pp r2.w, r0.x, c0, r1.x
mov_pp oC0, r2
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 144
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 128 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedengajeokmbgmbpbfbjhgdoegnaodonjbabaaaaaadeadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefceeacaaaaeaaaaaaajbaaaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaia
ebaaaaaaaaaaaaaaaiaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaafpcaabaaaabaaaaaa
egaobaaaabaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaia
ebaaaaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egbcbaaaadaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaa
acaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 144
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 128 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedaeeonmdohpnnbpaaidjpmpmjjcjejalpabaaaaaaoaaeaaaaaeaaaaaa
daaaaaaaniabaaaaceaeaaaakmaeaaaaebgpgodjkaabaaaakaabaaaaaaacpppp
fmabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaacaaacaaaaaaaaaaaaaaaaaaaiaaabaaacaaaaaaaaaaaaacpppp
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaia
acaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaacpiaaaaaoelaaaaioekaabaaaaacabaaaiiaabaappkaaeaaaaaeabaacpia
aaaappiaabaappiaacaaaakbagaaaaacacaaaiiaabaapplaafaaaaadacaaadia
acaappiaabaaoelaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaabaioeka
apaaaaacacaacbiaabaaaaiaapaaaaacacaacciaabaaffiaapaaaaacacaaceia
abaakkiaapaaaaacacaaciiaabaappiaafaaaaadacaaciiaaaaappiaacaappib
acaaaaadabaachiaacaaoeibacaaoelaafaaaaadacaachiaabaaoeiaaaaaoeka
afaaaaadacaachiaacaappiaacaaoeiaafaaaaadaaaacpiaaaaaoeiaabaaoeka
aeaaaaaeadaaciiaacaappiaaaaappkaaaaappiaaeaaaaaeadaachiaaaaaoeia
abaaoeiaacaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefceeacaaaa
eaaaaaaajbaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
lcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaaaaaaaaaaaiaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaacpaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaadiaaaaaiicaabaaa
abaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaaaaaaaaaihcaabaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaaadaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakiccabaaaaaaaaaaa
dkaabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaadkaabaaaaaaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
doaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [unity_LightmapFade]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R3, fragment.texcoord[2], texture[3], 2D;
TEX R2, fragment.texcoord[2], texture[4], 2D;
MUL R4.x, R0.w, c[1].w;
SLT R1.x, R4, c[3];
MUL R3.xyz, R3.w, R3;
MUL R2.xyz, R2.w, R2;
MUL R2.xyz, R2, c[4].x;
DP4 R3.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R2.w, R3.w;
RCP R2.w, R2.w;
MAD R3.xyz, R3, c[4].x, -R2;
MAD_SAT R2.w, R2, c[2].z, c[2];
MAD R2.xyz, R2.w, R3, R2;
MUL R0.xyz, R0, c[1];
KIL -R1.x;
TXP R1, fragment.texcoord[1], texture[2], 2D;
LG2 R1.w, R1.w;
MUL R0.w, -R1, R0;
LG2 R1.x, R1.x;
LG2 R1.y, R1.y;
LG2 R1.z, R1.z;
ADD R1.xyz, -R1, R2;
MUL R2.xyz, R1, c[0];
MUL R2.xyz, R0.w, R2;
MAD result.color.xyz, R0, R1, R2;
MAD result.color.w, R0, c[0], R4.x;
END
# 27 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [unity_LightmapFade]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"ps_2_0
dcl_2d s0
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c4, 0.00000000, 1.00000000, 8.00000000, 0
dcl t0.xy
dcl t1
dcl t2.xy
dcl t3
texld r1, t0, s0
texldp r2, t1, s2
texld r3, t2, s3
mov_pp r0.x, c3
mad_pp r0.x, r1.w, c1.w, -r0
cmp r0.x, r0, c4, c4.y
mov_pp r0, -r0.x
log_pp r2.x, r2.x
log_pp r2.y, r2.y
log_pp r2.z, r2.z
mul_pp r3.xyz, r3.w, r3
mul_pp r1.xyz, r1, c1
texkill r0.xyzw
texld r0, t2, s4
mul_pp r4.xyz, r0.w, r0
mul_pp r4.xyz, r4, c4.z
dp4 r0.x, t3, t3
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r3.xyz, r3, c4.z, -r4
mad_sat r0.x, r0, c2.z, c2.w
mad_pp r0.xyz, r0.x, r3, r4
add_pp r3.xyz, -r2, r0
log_pp r0.x, r2.w
mul_pp r2.xyz, r3, c0
mul_pp r0.x, r1.w, -r0
mul_pp r4.xyz, r0.x, r2
mul_pp r2.x, r1.w, c1.w
mad_pp r1.xyz, r1, r3, r4
mad_pp r1.w, r0.x, c0, r2.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 176
Vector 32 [_SpecColor]
Vector 48 [_Color]
Vector 128 [unity_LightmapFade]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedeafnoenigicfmjeklgnhmpbccdiflnakabaaaaaaneaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmmadaaaaeaaaaaaapdaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
lcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaa
aaaaaaaaakaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaabbaaaaahbcaabaaaabaaaaaaegbobaaa
aeaaaaaaegbobaaaaeaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
dccaaaalbcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaaaiaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaa
fgafbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdcaaaaakhcaabaaaacaaaaaapgapbaaaacaaaaaaegacbaaa
acaaaaaajgahbaiaebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaagaabaaa
abaaaaaaegacbaaaacaaaaaajgahbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaafpcaabaaaacaaaaaa
egaobaaaacaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaia
ebaaaaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaa
acaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 176
Vector 32 [_SpecColor]
Vector 48 [_Color]
Vector 128 [unity_LightmapFade]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedddmfmahaapemhplhhgloipindmdhfmgiabaaaaaaieahaaaaaeaaaaaa
daaaaaaanmacaaaalaagaaaafaahaaaaebgpgodjkeacaaaakeacaaaaaaacpppp
emacaaaafiaaaaaaadaadeaaaaaafiaaaaaafiaaaeaaceaaaaaafiaaaaaaaaaa
abababaaacacacaaadadadaaaaaaacaaacaaaaaaaaaaaaaaaaaaaiaaabaaacaa
aaaaaaaaaaaaakaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaeb
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaiaadaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapka
bpaaaaacaaaaaajaadaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaabaaaaac
abaaaiiaabaappkaaeaaaaaeabaacpiaaaaappiaabaappiaadaaaakbagaaaaac
acaaaiiaabaapplaafaaaaadacaaadiaacaappiaabaaoelaebaaaaababaaapia
ecaaaaadabaacpiaacaaoelaadaioekaecaaaaadadaacpiaacaaoelaacaioeka
ecaaaaadacaacpiaacaaoeiaabaioekaajaaaaadaeaaaiiaadaaoelaadaaoela
ahaaaaacaeaaabiaaeaappiaagaaaaacaeaaabiaaeaaaaiaaeaaaaaeaeaadbia
aeaaaaiaacaakkkaacaappkaafaaaaadabaaciiaabaappiaaeaaaakaafaaaaad
abaachiaabaaoeiaabaappiaafaaaaadabaaciiaadaappiaaeaaaakaaeaaaaae
adaachiaabaappiaadaaoeiaabaaoeibaeaaaaaeabaachiaaeaaaaiaadaaoeia
abaaoeiaapaaaaacadaacbiaacaaaaiaapaaaaacadaacciaacaaffiaapaaaaac
adaaceiaacaakkiaapaaaaacabaaciiaacaappiaafaaaaadabaaciiaaaaappia
abaappibacaaaaadabaachiaabaaoeiaadaaoeibafaaaaadacaachiaabaaoeia
aaaaoekaafaaaaadacaachiaabaappiaacaaoeiaafaaaaadaaaacpiaaaaaoeia
abaaoekaaeaaaaaeadaaciiaabaappiaaaaappkaaaaappiaaeaaaaaeadaachia
aaaaoeiaabaaoeiaacaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefc
mmadaaaaeaaaaaaapdaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaaaaaaaaaa
akaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaabbaaaaahbcaabaaaabaaaaaaegbobaaaaeaaaaaa
egbobaaaaeaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadccaaaal
bcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaaaiaaaaaadkiacaaa
aaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdiaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaafgafbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdcaaaaakhcaabaaaacaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaa
jgahbaiaebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaajgahbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaa
acaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaacpaaaaafpcaabaaaacaaaaaaegaobaaa
acaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaa
acaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaa
acaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
adaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakiccabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaa
dkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapalaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaa
imaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Shininess]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"!!ARBfp1.0
PARAM c[8] = { program.local[0..3],
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
TEX R5, fragment.texcoord[2], texture[4], 2D;
TEX R2, fragment.texcoord[2], texture[3], 2D;
TEX R4.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R3.xyz, R5.w, R5;
MUL R3.xyz, R3, c[4].z;
MUL R3.w, R0, c[1];
SLT R1.x, R3.w, c[3];
MUL R5.xyz, R3.y, c[6];
MAD R5.xyz, R3.x, c[7], R5;
MAD R5.xyz, R3.z, c[5], R5;
DP3 R4.x, R5, R5;
RSQ R4.x, R4.x;
MUL R5.xyz, R4.x, R5;
MAD R4.xy, R4.wyzw, c[4].x, -c[4].y;
MUL R4.zw, R4.xyxy, R4.xyxy;
DP3 R5.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R5.w, R5.w;
MAD R5.xyz, R5.w, fragment.texcoord[3], R5;
ADD_SAT R4.w, R4.z, R4;
DP3 R4.z, R5, R5;
ADD R5.w, -R4, c[4].y;
RSQ R4.w, R4.z;
RSQ R4.z, R5.w;
MUL R5.xyz, R4.w, R5;
RCP R4.z, R4.z;
DP3 R4.w, R4, R5;
MUL R2.xyz, R2.w, R2;
MAX R4.w, R4, c[4];
DP3_SAT R5.z, R4, c[5];
DP3_SAT R5.x, R4, c[7];
DP3_SAT R5.y, R4, c[6];
DP3 R3.x, R5, R3;
MOV R3.y, c[5].w;
MUL R2.w, R3.y, c[2].x;
MUL R2.xyz, R2, R3.x;
MUL R2.xyz, R2, c[4].z;
POW R2.w, R4.w, R2.w;
MUL R0.xyz, R0, c[1];
KIL -R1.x;
TXP R1, fragment.texcoord[1], texture[2], 2D;
LG2 R1.x, R1.x;
LG2 R1.y, R1.y;
LG2 R1.z, R1.z;
LG2 R1.w, R1.w;
ADD R1, -R1, R2;
MUL R0.w, R1, R0;
MUL R2.xyz, R1, c[0];
MUL R2.xyz, R0.w, R2;
MAD result.color.xyz, R1, R0, R2;
MAD result.color.w, R0, c[0], R3;
END
# 51 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Shininess]
Float 3 [_Cutoff]
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
def c4, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c5, -0.40824828, -0.70710677, 0.57735026, 8.00000000
def c6, -0.40824831, 0.70710677, 0.57735026, 128.00000000
def c7, 0.81649655, 0.00000000, 0.57735026, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3.xyz
texld r0, t0, s0
texld r3, t2, s3
texld r4, t2, s4
mov_pp r1.x, c3
mad_pp r1.x, r0.w, c1.w, -r1
cmp r1.x, r1, c4, c4.y
mov_pp r1, -r1.x
mul_pp r4.xyz, r4.w, r4
mul_pp r4.xyz, r4, c5.w
mul r5.xyz, r4.y, c6
mad r5.xyz, r4.x, c7, r5
mad r5.xyz, r4.z, c5, r5
mul_pp r3.xyz, r3.w, r3
mov r2.y, t0.w
mov r2.x, t0.z
mul_pp r0.xyz, r0, c1
texld r2, r2, s1
texkill r1.xyzw
texldp r1, t1, s2
dp3 r2.x, r5, r5
rsq r2.x, r2.x
mul r5.xyz, r2.x, r5
mov r2.x, r2.w
mad_pp r7.xy, r2, c4.z, c4.w
dp3_pp r2.x, t3, t3
rsq_pp r2.x, r2.x
mad_pp r2.xyz, r2.x, t3, r5
mul_pp r6.xy, r7, r7
add_pp_sat r5.x, r6, r6.y
dp3_pp r6.x, r2, r2
rsq_pp r6.x, r6.x
add_pp r5.x, -r5, c4.y
rsq_pp r5.x, r5.x
rcp_pp r7.z, r5.x
mul_pp r2.xyz, r6.x, r2
dp3_pp r2.x, r7, r2
mov_pp r5.x, c2
max_pp r2.x, r2, c4
mul_pp r5.x, c6.w, r5
pow r6.x, r2.x, r5.x
dp3_pp_sat r2.z, r7, c5
dp3_pp_sat r2.y, r7, c6
dp3_pp_sat r2.x, r7, c7
dp3_pp r2.x, r2, r4
mul_pp r2.xyz, r3, r2.x
mul_pp r2.xyz, r2, c5.w
mov r2.w, r6.x
log_pp r1.x, r1.x
log_pp r1.y, r1.y
log_pp r1.z, r1.z
log_pp r1.w, r1.w
add_pp r1, -r1, r2
mul_pp r3.x, r0.w, r1.w
mul_pp r2.xyz, r1, c0
mul_pp r2.xyz, r3.x, r2
mul_pp r4.x, r0.w, c1.w
mad_pp r0.xyz, r1, r0, r2
mad_pp r0.w, r3.x, c0, r4.x
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
ConstBuffer "$Globals" 176
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedanigonakgpakafigpgnghaocomianfhhabaaaaaaomahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoeagaaaaeaaaaaaaljabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadlcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacagaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaaaaaaaaaa
akaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaacpaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaa
baaaaaahbcaabaaaacaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaaf
bcaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaa
acaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaadaaaaaa
eghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaa
adaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
pgapbaaaacaaaaaadiaaaaakhcaabaaaaeaaaaaafgafbaaaadaaaaaaaceaaaaa
omafnblopdaedfdpdkmnbddpaaaaaaaadcaaaaamhcaabaaaaeaaaaaaagaabaaa
adaaaaaaaceaaaaaolaffbdpaaaaaaaadkmnbddpaaaaaaaaegacbaaaaeaaaaaa
dcaaaaamhcaabaaaaeaaaaaakgakbaaaadaaaaaaaceaaaaaolafnblopdaedflp
dkmnbddpaaaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaa
aeaaaaaaegacbaaaaeaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
dcaaaaajhcaabaaaacaaaaaaegacbaaaaeaaaaaapgapbaaaacaaaaaaegacbaaa
acaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
eeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaacaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaaeaaaaaa
hgapbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaacaaaaaaegaabaaa
aeaaaaaaegaabaaaaeaaaaaaddaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaaeaaaaaadkaabaaaacaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaaiccaabaaaacaaaaaaakiacaaaaaaaaaaaaeaaaaaa
abeaaaaaaaaaaaeddiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaabkaabaaa
acaaaaaabjaaaaaficaabaaaacaaaaaaakaabaaaacaaaaaaapcaaaakbcaabaaa
afaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaaaeaaaaaa
bacaaaakccaabaaaafaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaa
egacbaaaaeaaaaaabacaaaakecaabaaaafaaaaaaaceaaaaaolafnblopdaedflp
dkmnbddpaaaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaa
afaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaadaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahccaabaaaadaaaaaadkaabaaa
aeaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaadaaaaaaagajbaaaaeaaaaaa
fgafbaaaadaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaadaaaaaajgahbaaa
adaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadcaaaaak
iccabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaadkaabaaa
aaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 176
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedfeehhnpagledabibkbhbaleocemkokbpabaaaaaadmamaaaaaeaaaaaa
daaaaaaahmaeaaaagialaaaaaiamaaaaebgpgodjeeaeaaaaeeaeaaaaaaacpppp
peadaaaafaaaaaaaacaadiaaaaaafaaaaaaafaaaafaaceaaaaaafaaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaaaaaacaaadaaaaaaaaaaaaaaaaaaakaa
abaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaaaaa
aaaaiadpfbaaaaafafaaapkaomafnblopdaedfdpdkmnbddpaaaaaaedfbaaaaaf
agaaapkaolafnblopdaedflpdkmnbddpaaaaaaaafbaaaaafahaaapkaaaaaaaeb
dkmnbddpaaaaaaaaolaffbdpbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaiaadaachlabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapka
bpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkaecaaaaadaaaacpia
aaaaoelaaaaioekaabaaaaacabaaaiiaabaappkaaeaaaaaeabaacpiaaaaappia
abaappiaadaaaakbabaaaaacacaaabiaaaaakklaabaaaaacacaaaciaaaaappla
agaaaaacacaaaeiaabaapplaafaaaaadadaaadiaacaakkiaabaaoelaebaaaaab
abaaapiaecaaaaadabaacpiaacaaoelaadaioekaecaaaaadacaacpiaacaaoeia
abaioekaecaaaaadaeaacpiaacaaoelaaeaioekaecaaaaadadaacpiaadaaoeia
acaioekaafaaaaadabaaciiaabaappiaahaaaakaafaaaaadabaachiaabaaoeia
abaappiaaeaaaaaeafaacbiaacaappiaaeaaaakaaeaaffkaaeaaaaaeafaaccia
acaaffiaaeaaaakaaeaaffkafkaaaaaeabaadiiaafaaoeiaafaaoeiaaeaakkka
acaaaaadabaaciiaabaappibaeaappkaahaaaaacabaaciiaabaappiaagaaaaac
afaaceiaabaappiaaiaaaaadacaadbiaahaablkaafaaoeiaaiaaaaadacaadcia
afaaoekaafaaoeiaaiaaaaadacaadeiaagaaoekaafaaoeiaafaaaaadabaaciia
aeaappiaahaaaakaafaaaaadaeaachiaaeaaoeiaabaappiaaiaaaaadabaaciia
acaaoeiaaeaaoeiaafaaaaadabaachiaabaappiaabaaoeiaafaaaaadacaaahia
aeaaffiaafaaoekaaeaaaaaeacaaahiaaeaaaaiaahaablkaacaaoeiaaeaaaaae
acaaahiaaeaakkiaagaaoekaacaaoeiaaiaaaaadacaaaiiaacaaoeiaacaaoeia
ahaaaaacacaaaiiaacaappiaceaaaaacaeaachiaadaaoelaaeaaaaaeacaachia
acaaoeiaacaappiaaeaaoeiaceaaaaacaeaachiaacaaoeiaaiaaaaadacaacbia
afaaoeiaaeaaoeiaalaaaaadaeaaabiaacaaaaiaaeaakkkaabaaaaacacaaaiia
afaappkaafaaaaadacaaabiaacaappiaacaaaakacaaaaaadabaaciiaaeaaaaia
acaaaaiaapaaaaacacaacbiaadaaaaiaapaaaaacacaacciaadaaffiaapaaaaac
acaaceiaadaakkiaapaaaaacacaaciiaadaappiaacaaaaadabaacpiaabaaoeia
acaaoeibafaaaaadacaachiaabaaoeiaaaaaoekaafaaaaadabaaciiaaaaappia
abaappiaafaaaaadacaachiaabaappiaacaaoeiaafaaaaadaaaacpiaaaaaoeia
abaaoekaaeaaaaaeadaaciiaabaappiaaaaappkaaaaappiaaeaaaaaeadaachia
aaaaoeiaabaaoeiaacaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefc
oeagaaaaeaaaaaaaljabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacagaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaaaaaaaaaaakaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaacpaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaabaaaaaah
bcaabaaaacaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaacaaaaaa
egbcbaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaadaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaadaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgapbaaa
acaaaaaadiaaaaakhcaabaaaaeaaaaaafgafbaaaadaaaaaaaceaaaaaomafnblo
pdaedfdpdkmnbddpaaaaaaaadcaaaaamhcaabaaaaeaaaaaaagaabaaaadaaaaaa
aceaaaaaolaffbdpaaaaaaaadkmnbddpaaaaaaaaegacbaaaaeaaaaaadcaaaaam
hcaabaaaaeaaaaaakgakbaaaadaaaaaaaceaaaaaolafnblopdaedflpdkmnbddp
aaaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaaeaaaaaa
egacbaaaaeaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaaeaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
acaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaaeaaaaaahgapbaaa
aeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaacaaaaaaegaabaaaaeaaaaaa
egaabaaaaeaaaaaaddaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaaeaaaaaadkaabaaaacaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaaiccaabaaaacaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaa
aaaaaaeddiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaa
bjaaaaaficaabaaaacaaaaaaakaabaaaacaaaaaaapcaaaakbcaabaaaafaaaaaa
aceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaaaeaaaaaabacaaaak
ccaabaaaafaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaa
aeaaaaaabacaaaakecaabaaaafaaaaaaaceaaaaaolafnblopdaedflpdkmnbddp
aaaaaaaaegacbaaaaeaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaaafaaaaaa
egacbaaaadaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaadaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadiaaaaahccaabaaaadaaaaaadkaabaaaaeaaaaaa
abeaaaaaaaaaaaebdiaaaaahocaabaaaadaaaaaaagajbaaaaeaaaaaafgafbaaa
adaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaadaaaaaajgahbaaaadaaaaaa
aaaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaa
diaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakiccabaaa
aaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaadkaabaaaaaaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
"!!ARBfp1.0
PARAM c[3] = { program.local[0..2] };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TXP R1, fragment.texcoord[1], texture[2], 2D;
MUL R2.w, R0, c[1];
SLT R2.x, R2.w, c[2];
MUL R0.w, R1, R0;
ADD R1.xyz, R1, fragment.texcoord[2];
MUL R0.xyz, R0, c[1];
MAD result.color.w, R0, c[0], R2;
KIL -R2.x;
MUL R2.xyz, R1, c[0];
MUL R2.xyz, R0.w, R2;
MAD result.color.xyz, R0, R1, R2;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s2
def c3, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
dcl t1
dcl t2.xyz
texld r2, t0, s0
mov_pp r0.x, c2
mad_pp r0.x, r2.w, c1.w, -r0
cmp r0.x, r0, c3, c3.y
mov_pp r1, -r0.x
mul_pp r2.xyz, r2, c1
texldp r0, t1, s2
texkill r1.xyzw
add_pp r3.xyz, r0, t2
mul_pp r1.xyz, r3, c0
mul_pp r0.x, r2.w, r0.w
mul_pp r4.xyz, r0.x, r1
mul_pp r1.x, r2.w, c1.w
mad_pp r2.xyz, r2, r3, r4
mad_pp r2.w, r0.x, c0, r1.x
mov_pp oC0, r2
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 144
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 128 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgemnljbiogejnjfjgbdfjjldgjmllkgbabaaaaaabiadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcciacaaaaeaaaaaaaikaaaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaia
ebaaaaaaaaaaaaaaaiaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegbcbaaaadaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaacaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
ConstBuffer "$Globals" 144
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 128 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedamfafoakkggliobnenkphonnpaoafapiabaaaaaajeaeaaaaaeaaaaaa
daaaaaaakiabaaaaniadaaaagaaeaaaaebgpgodjhaabaaaahaabaaaaaaacpppp
cmabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaacaaacaaaaaaaaaaaaaaaaaaaiaaabaaacaaaaaaaaaaaaacpppp
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaia
acaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaacpiaaaaaoelaaaaioekaabaaaaacabaaaiiaabaappkaaeaaaaaeabaacpia
aaaappiaabaappiaacaaaakbagaaaaacacaaaiiaabaapplaafaaaaadacaaadia
acaappiaabaaoelaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaabaioeka
acaaaaadabaachiaabaaoeiaacaaoelaafaaaaadabaaciiaaaaappiaabaappia
afaaaaadacaachiaabaaoeiaaaaaoekaafaaaaadacaachiaabaappiaacaaoeia
afaaaaadaaaacpiaaaaaoeiaabaaoekaaeaaaaaeadaaciiaabaappiaaaaappka
aaaappiaaeaaaaaeadaachiaaaaaoeiaabaaoeiaacaaoeiaabaaaaacaaaicpia
adaaoeiappppaaaafdeieefcciacaaaaeaaaaaaaikaaaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaia
ebaaaaaaaaaaaaaaaiaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegbcbaaaadaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaacaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapadaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapalaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [unity_LightmapFade]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"!!ARBfp1.0
PARAM c[5] = { program.local[0..3],
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R3, fragment.texcoord[2], texture[3], 2D;
TEX R2, fragment.texcoord[2], texture[4], 2D;
MUL R4.x, R0.w, c[1].w;
SLT R1.x, R4, c[3];
MUL R3.xyz, R3.w, R3;
MUL R2.xyz, R2.w, R2;
MUL R2.xyz, R2, c[4].x;
DP4 R3.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R2.w, R3.w;
RCP R2.w, R2.w;
MAD R3.xyz, R3, c[4].x, -R2;
MAD_SAT R2.w, R2, c[2].z, c[2];
MAD R2.xyz, R2.w, R3, R2;
MUL R0.xyz, R0, c[1];
KIL -R1.x;
TXP R1, fragment.texcoord[1], texture[2], 2D;
ADD R1.xyz, R1, R2;
MUL R0.w, R1, R0;
MUL R2.xyz, R1, c[0];
MUL R2.xyz, R0.w, R2;
MAD result.color.xyz, R0, R1, R2;
MAD result.color.w, R0, c[0], R4.x;
END
# 23 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [unity_LightmapFade]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"ps_2_0
dcl_2d s0
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c4, 0.00000000, 1.00000000, 8.00000000, 0
dcl t0.xy
dcl t1
dcl t2.xy
dcl t3
texld r1, t0, s0
texldp r2, t1, s2
texld r3, t2, s4
mov_pp r0.x, c3
mad_pp r0.x, r1.w, c1.w, -r0
cmp r0.x, r0, c4, c4.y
mov_pp r0, -r0.x
mul_pp r3.xyz, r3.w, r3
mul_pp r3.xyz, r3, c4.z
mul_pp r1.xyz, r1, c1
texkill r0.xyzw
texld r0, t2, s3
mul_pp r4.xyz, r0.w, r0
dp4 r0.x, t3, t3
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r4.xyz, r4, c4.z, -r3
mad_sat r0.x, r0, c2.z, c2.w
mad_pp r0.xyz, r0.x, r4, r3
add_pp r3.xyz, r2, r0
mul_pp r2.xyz, r3, c0
mul_pp r0.x, r1.w, r2.w
mul_pp r4.xyz, r0.x, r2
mul_pp r2.x, r1.w, c1.w
mad_pp r1.xyz, r1, r3, r4
mad_pp r1.w, r0.x, c0, r2.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 176
Vector 32 [_SpecColor]
Vector 48 [_Color]
Vector 128 [unity_LightmapFade]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedanlbopenhdlepbeohjejhhjnnklkhljbabaaaaaaliaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefclaadaaaaeaaaaaaaomaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
lcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaa
aaaaaaaaakaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaabbaaaaahbcaabaaaabaaaaaaegbobaaa
aeaaaaaaegbobaaaaeaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
dccaaaalbcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaaaiaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaa
fgafbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdcaaaaakhcaabaaaacaaaaaapgapbaaaacaaaaaaegacbaaa
acaaaaaajgahbaiaebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaagaabaaa
abaaaaaaegacbaaaacaaaaaajgahbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
aaaaaaaadkaabaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaacaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_LightBuffer] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
SetTexture 3 [unity_LightmapInd] 2D 3
ConstBuffer "$Globals" 176
Vector 32 [_SpecColor]
Vector 48 [_Color]
Vector 128 [unity_LightmapFade]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedcibfmeefnfciigicoofbkaocfjbipmlpabaaaaaadiahaaaaaeaaaaaa
daaaaaaakmacaaaageagaaaaaeahaaaaebgpgodjheacaaaaheacaaaaaaacpppp
bmacaaaafiaaaaaaadaadeaaaaaafiaaaaaafiaaaeaaceaaaaaafiaaaaaaaaaa
abababaaacacacaaadadadaaaaaaacaaacaaaaaaaaaaaaaaaaaaaiaaabaaacaa
aaaaaaaaaaaaakaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaeb
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaiaadaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapka
bpaaaaacaaaaaajaadaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaabaaaaac
abaaaiiaabaappkaaeaaaaaeabaacpiaaaaappiaabaappiaadaaaakbagaaaaac
acaaaiiaabaapplaafaaaaadacaaadiaacaappiaabaaoelaebaaaaababaaapia
ecaaaaadabaacpiaacaaoelaadaioekaecaaaaadadaacpiaacaaoelaacaioeka
ecaaaaadacaacpiaacaaoeiaabaioekaajaaaaadaeaaaiiaadaaoelaadaaoela
ahaaaaacaeaaabiaaeaappiaagaaaaacaeaaabiaaeaaaaiaaeaaaaaeaeaadbia
aeaaaaiaacaakkkaacaappkaafaaaaadabaaciiaabaappiaaeaaaakaafaaaaad
abaachiaabaaoeiaabaappiaafaaaaadabaaciiaadaappiaaeaaaakaaeaaaaae
adaachiaabaappiaadaaoeiaabaaoeibaeaaaaaeabaachiaaeaaaaiaadaaoeia
abaaoeiaacaaaaadabaachiaabaaoeiaacaaoeiaafaaaaadabaaciiaaaaappia
acaappiaafaaaaadacaachiaabaaoeiaaaaaoekaafaaaaadacaachiaabaappia
acaaoeiaafaaaaadaaaacpiaaaaaoeiaabaaoekaaeaaaaaeadaaciiaabaappia
aaaappkaaaaappiaaeaaaaaeadaachiaaaaaoeiaabaaoeiaacaaoeiaabaaaaac
aaaicpiaadaaoeiappppaaaafdeieefclaadaaaaeaaaaaaaomaaaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
adaaaaaaakiacaiaebaaaaaaaaaaaaaaakaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabbaaaaah
bcaabaaaabaaaaaaegbobaaaaeaaaaaaegbobaaaaeaaaaaaelaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadccaaaalbcaabaaaabaaaaaaakaabaaaabaaaaaa
ckiacaaaaaaaaaaaaiaaaaaadkiacaaaaaaaaaaaaiaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaadaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaah
ccaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaa
abaaaaaaagajbaaaacaaaaaafgafbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaacaaaaaa
pgapbaaaacaaaaaaegacbaaaacaaaaaajgahbaiaebaaaaaaabaaaaaadcaaaaaj
hcaabaaaabaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaajgahbaaaabaaaaaa
aoaaaaahdcaabaaaacaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakiccabaaaaaaaaaaa
dkaabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaadkaabaaaaaaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
doaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Shininess]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"!!ARBfp1.0
PARAM c[8] = { program.local[0..3],
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
TEX R5, fragment.texcoord[2], texture[4], 2D;
TEX R2, fragment.texcoord[2], texture[3], 2D;
TEX R4.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R3.xyz, R5.w, R5;
MUL R3.xyz, R3, c[4].z;
MUL R3.w, R0, c[1];
SLT R1.x, R3.w, c[3];
MUL R5.xyz, R3.y, c[6];
MAD R5.xyz, R3.x, c[7], R5;
MAD R5.xyz, R3.z, c[5], R5;
DP3 R4.x, R5, R5;
RSQ R4.x, R4.x;
MUL R5.xyz, R4.x, R5;
MAD R4.xy, R4.wyzw, c[4].x, -c[4].y;
MUL R4.zw, R4.xyxy, R4.xyxy;
DP3 R5.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R5.w, R5.w;
MAD R5.xyz, R5.w, fragment.texcoord[3], R5;
ADD_SAT R4.w, R4.z, R4;
DP3 R4.z, R5, R5;
ADD R5.w, -R4, c[4].y;
RSQ R4.w, R4.z;
RSQ R4.z, R5.w;
MUL R5.xyz, R4.w, R5;
RCP R4.z, R4.z;
DP3 R4.w, R4, R5;
MUL R2.xyz, R2.w, R2;
MAX R4.w, R4, c[4];
DP3_SAT R5.z, R4, c[5];
DP3_SAT R5.x, R4, c[7];
DP3_SAT R5.y, R4, c[6];
DP3 R3.x, R5, R3;
MOV R3.y, c[5].w;
MUL R2.w, R3.y, c[2].x;
MUL R2.xyz, R2, R3.x;
MUL R2.xyz, R2, c[4].z;
POW R2.w, R4.w, R2.w;
MUL R0.xyz, R0, c[1];
KIL -R1.x;
TXP R1, fragment.texcoord[1], texture[2], 2D;
ADD R1, R1, R2;
MUL R0.w, R1, R0;
MUL R2.xyz, R1, c[0];
MUL R2.xyz, R0.w, R2;
MAD result.color.xyz, R1, R0, R2;
MAD result.color.w, R0, c[0], R3;
END
# 47 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Shininess]
Float 3 [_Cutoff]
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
def c4, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c5, -0.40824828, -0.70710677, 0.57735026, 8.00000000
def c6, -0.40824831, 0.70710677, 0.57735026, 128.00000000
def c7, 0.81649655, 0.00000000, 0.57735026, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3.xyz
texld r0, t0, s0
texld r3, t2, s3
texld r4, t2, s4
mov_pp r1.x, c3
mad_pp r1.x, r0.w, c1.w, -r1
cmp r1.x, r1, c4, c4.y
mov_pp r1, -r1.x
mul_pp r4.xyz, r4.w, r4
mul_pp r4.xyz, r4, c5.w
mul r5.xyz, r4.y, c6
mad r5.xyz, r4.x, c7, r5
mad r5.xyz, r4.z, c5, r5
mul_pp r3.xyz, r3.w, r3
mov r2.y, t0.w
mov r2.x, t0.z
mul_pp r0.xyz, r0, c1
texld r2, r2, s1
texkill r1.xyzw
texldp r1, t1, s2
dp3 r2.x, r5, r5
rsq r2.x, r2.x
mul r5.xyz, r2.x, r5
mov r2.x, r2.w
mad_pp r7.xy, r2, c4.z, c4.w
dp3_pp r2.x, t3, t3
rsq_pp r2.x, r2.x
mad_pp r2.xyz, r2.x, t3, r5
mul_pp r6.xy, r7, r7
add_pp_sat r5.x, r6, r6.y
dp3_pp r6.x, r2, r2
rsq_pp r6.x, r6.x
add_pp r5.x, -r5, c4.y
rsq_pp r5.x, r5.x
rcp_pp r7.z, r5.x
mul_pp r2.xyz, r6.x, r2
dp3_pp r2.x, r7, r2
mov_pp r5.x, c2
max_pp r2.x, r2, c4
mul_pp r5.x, c6.w, r5
pow r6.x, r2.x, r5.x
dp3_pp_sat r2.z, r7, c5
dp3_pp_sat r2.y, r7, c6
dp3_pp_sat r2.x, r7, c7
dp3_pp r2.x, r2, r4
mul_pp r2.xyz, r3, r2.x
mul_pp r2.xyz, r2, c5.w
mov r2.w, r6.x
add_pp r1, r1, r2
mul_pp r3.x, r0.w, r1.w
mul_pp r2.xyz, r1, c0
mul_pp r2.xyz, r3.x, r2
mul_pp r4.x, r0.w, c1.w
mad_pp r0.xyz, r1, r0, r2
mad_pp r0.w, r3.x, c0, r4.x
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
ConstBuffer "$Globals" 176
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgbhnahlijcnnhccbppfopmaohcjjcpmaabaaaaaaneahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmmagaaaaeaaaaaaaldabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadlcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacagaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaaaaaaaaaa
akaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaa
egbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgapbaaaabaaaaaadiaaaaakhcaabaaaadaaaaaa
fgafbaaaacaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaadcaaaaam
hcaabaaaadaaaaaaagaabaaaacaaaaaaaceaaaaaolaffbdpaaaaaaaadkmnbddp
aaaaaaaaegacbaaaadaaaaaadcaaaaamhcaabaaaadaaaaaakgakbaaaacaaaaaa
aceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaadaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaa
dkaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
abaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaiccaabaaaabaaaaaa
akiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaaficaabaaaabaaaaaaakaabaaa
abaaaaaaaoaaaaahdcaabaaaaeaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaapcaaaakbcaabaaaafaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaa
aaaaaaaaigaabaaaadaaaaaabacaaaakccaabaaaafaaaaaaaceaaaaaomafnblo
pdaedfdpdkmnbddpaaaaaaaaegacbaaaadaaaaaabacaaaakecaabaaaafaaaaaa
aceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaadaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaah
ccaabaaaacaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaa
acaaaaaaagajbaaaadaaaaaafgafbaaaacaaaaaadiaaaaahhcaabaaaabaaaaaa
agaabaaaacaaaaaajgahbaaaacaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaaeaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaa
acaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 176
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 64 [_Shininess]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedkcalobfbckjkeeanhdceiafbaiagackpabaaaaaapealaaaaaeaaaaaa
daaaaaaaemaeaaaacaalaaaamaalaaaaebgpgodjbeaeaaaabeaeaaaaaaacpppp
meadaaaafaaaaaaaacaadiaaaaaafaaaaaaafaaaafaaceaaaaaafaaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaaaaaacaaadaaaaaaaaaaaaaaaaaaakaa
abaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaaaaa
aaaaiadpfbaaaaafafaaapkaomafnblopdaedfdpdkmnbddpaaaaaaedfbaaaaaf
agaaapkaolafnblopdaedflpdkmnbddpaaaaaaaafbaaaaafahaaapkaaaaaaaeb
dkmnbddpaaaaaaaaolaffbdpbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaiaadaachlabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapka
bpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkaecaaaaadaaaacpia
aaaaoelaaaaioekaabaaaaacabaaaiiaabaappkaaeaaaaaeabaacpiaaaaappia
abaappiaadaaaakbagaaaaacacaaaiiaabaapplaafaaaaadacaaadiaacaappia
abaaoelaabaaaaacadaaabiaaaaakklaabaaaaacadaaaciaaaaapplaebaaaaab
abaaapiaecaaaaadabaacpiaacaaoeiaacaioekaecaaaaadacaacpiaacaaoela
adaioekaecaaaaadadaacpiaadaaoeiaabaioekaecaaaaadaeaacpiaacaaoela
aeaioekaafaaaaadacaaciiaacaappiaahaaaakaafaaaaadacaachiaacaaoeia
acaappiaaeaaaaaeafaacbiaadaappiaaeaaaakaaeaaffkaaeaaaaaeafaaccia
adaaffiaaeaaaakaaeaaffkafkaaaaaeacaadiiaafaaoeiaafaaoeiaaeaakkka
acaaaaadacaaciiaacaappibaeaappkaahaaaaacacaaciiaacaappiaagaaaaac
afaaceiaacaappiaaiaaaaadadaadbiaahaablkaafaaoeiaaiaaaaadadaadcia
afaaoekaafaaoeiaaiaaaaadadaadeiaagaaoekaafaaoeiaafaaaaadacaaciia
aeaappiaahaaaakaafaaaaadaeaachiaaeaaoeiaacaappiaaiaaaaadacaaciia
adaaoeiaaeaaoeiaafaaaaadacaachiaacaappiaacaaoeiaafaaaaadadaaahia
aeaaffiaafaaoekaaeaaaaaeadaaahiaaeaaaaiaahaablkaadaaoeiaaeaaaaae
adaaahiaaeaakkiaagaaoekaadaaoeiaaiaaaaadadaaaiiaadaaoeiaadaaoeia
ahaaaaacadaaaiiaadaappiaceaaaaacaeaachiaadaaoelaaeaaaaaeadaachia
adaaoeiaadaappiaaeaaoeiaceaaaaacaeaachiaadaaoeiaaiaaaaadadaacbia
afaaoeiaaeaaoeiaalaaaaadaeaaabiaadaaaaiaaeaakkkaabaaaaacadaaaiia
afaappkaafaaaaadadaaabiaadaappiaacaaaakacaaaaaadacaaciiaaeaaaaia
adaaaaiaacaaaaadabaacpiaabaaoeiaacaaoeiaafaaaaadacaachiaabaaoeia
aaaaoekaafaaaaadabaaciiaaaaappiaabaappiaafaaaaadacaachiaabaappia
acaaoeiaafaaaaadaaaacpiaaaaaoeiaabaaoekaaeaaaaaeadaaciiaabaappia
aaaappkaaaaappiaaeaaaaaeadaachiaaaaaoeiaabaaoeiaacaaoeiaabaaaaac
aaaicpiaadaaoeiappppaaaafdeieefcmmagaaaaeaaaaaaaldabaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaad
aagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaa
akiacaiaebaaaaaaaaaaaaaaakaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaa
aeaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaabaaaaaa
diaaaaakhcaabaaaadaaaaaafgafbaaaacaaaaaaaceaaaaaomafnblopdaedfdp
dkmnbddpaaaaaaaadcaaaaamhcaabaaaadaaaaaaagaabaaaacaaaaaaaceaaaaa
olaffbdpaaaaaaaadkmnbddpaaaaaaaaegacbaaaadaaaaaadcaaaaamhcaabaaa
adaaaaaakgakbaaaacaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaadkaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaaiccaabaaaabaaaaaaakiacaaaaaaaaaaaaeaaaaaaabeaaaaaaaaaaaed
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaaf
icaabaaaabaaaaaaakaabaaaabaaaaaaaoaaaaahdcaabaaaaeaaaaaaegbabaaa
acaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaaeaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaapcaaaakbcaabaaaafaaaaaaaceaaaaa
olaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaaadaaaaaabacaaaakccaabaaa
afaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaadaaaaaa
bacaaaakecaabaaaafaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaa
egacbaaaadaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaadaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadiaaaaahccaabaaaacaaaaaadkaabaaaadaaaaaaabeaaaaa
aaaaaaebdiaaaaahocaabaaaacaaaaaaagajbaaaadaaaaaafgafbaaaacaaaaaa
diaaaaahhcaabaaaabaaaaaaagaabaaaacaaaaaajgahbaaaacaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaa
abaaaaaadkiacaaaaaaaaaaaacaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab
ejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "Transparent/Cutout/VertexLit"
}