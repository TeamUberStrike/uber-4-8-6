Shader "Hidden/TerrainEngine/Splatmap/Lightmap-AddPass" {
Properties {
 _Control ("Control (RGBA)", 2D) = "black" {}
 _Splat3 ("Layer 3 (A)", 2D) = "white" {}
 _Splat2 ("Layer 2 (B)", 2D) = "white" {}
 _Splat1 ("Layer 1 (G)", 2D) = "white" {}
 _Splat0 ("Layer 0 (R)", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Geometry-99" "IGNOREPROJECTOR"="true" "RenderType"="Opaque" "SplatCount"="4" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Geometry-99" "IGNOREPROJECTOR"="true" "RenderType"="Opaque" "SplatCount"="4" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
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
Vector 17 [_Control_ST]
Vector 18 [_Splat0_ST]
Vector 19 [_Splat1_ST]
Vector 20 [_Splat2_ST]
Vector 21 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
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
ADD result.texcoord[4].xyz, R2, R1;
MOV result.texcoord[3].z, R2.w;
MOV result.texcoord[3].y, R3.w;
MOV result.texcoord[3].x, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[20].xyxy, c[20];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[19], c[19].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[21], c[21].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
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
Vector 16 [_Control_ST]
Vector 17 [_Splat0_ST]
Vector 18 [_Splat1_ST]
Vector 19 [_Splat2_ST]
Vector 20 [_Splat3_ST]
"vs_2_0
def c21, 1.00000000, 0, 0, 0
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
mov r0.w, c21.x
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
add oT4.xyz, r2, r1
mov oT3.z, r2.w
mov oT3.y, r3.w
mov oT3.x, r0
mad oT0.zw, v2.xyxy, c17.xyxy, c17
mad oT0.xy, v2, c16, c16.zwzw
mad oT1.zw, v2.xyxy, c19.xyxy, c19
mad oT1.xy, v2, c18, c18.zwzw
mad oT2.xy, v2, c20, c20.zwzw
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
ConstBuffer "$Globals" 128
Vector 48 [_Control_ST]
Vector 64 [_Splat0_ST]
Vector 80 [_Splat1_ST]
Vector 96 [_Splat2_ST]
Vector 112 [_Splat3_ST]
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
eefiecedjgemfkaadmkdmjejkmofdbkdjkfnkeoaabaaaaaapiafaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefceeaeaaaaeaaaabaabbabaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaa
aaaaaaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaa
kgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaaaaaaaaaadgaaaaaf
icaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaa
abaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaa
abaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaa
abaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaa
aaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaa
cmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 48 [_Control_ST]
Vector 64 [_Splat0_ST]
Vector 80 [_Splat1_ST]
Vector 96 [_Splat2_ST]
Vector 112 [_Splat3_ST]
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
eefiecedmlgljpghmckbmdogodhoikoabmlcfaadabaaaaaajeaiaaaaaeaaaaaa
daaaaaaamiacaaaabeahaaaanmahaaaaebgpgodjjaacaaaajaacaaaaaaacpopp
cmacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
afaaabaaaaaaaaaaabaacgaaahaaagaaaaaaaaaaacaaaaaaaeaaanaaaaaaaaaa
acaaamaaadaabbaaaaaaaaaaacaabeaaabaabeaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbfaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaadaaeejaacaaeeka
acaaoekaaeaaaaaeabaaadoaadaaoejaadaaoekaadaaookaaeaaaaaeabaaamoa
adaaeejaaeaaeekaaeaaoekaaeaaaaaeacaaadoaadaaoejaafaaoekaafaaooka
afaaaaadaaaaahiaacaaoejabeaappkaafaaaaadabaaahiaaaaaffiabcaaoeka
aeaaaaaeaaaaaliabbaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahiabdaaoeka
aaaakkiaaaaapeiaabaaaaacaaaaaiiabfaaaakaajaaaaadabaaabiaagaaoeka
aaaaoeiaajaaaaadabaaaciaahaaoekaaaaaoeiaajaaaaadabaaaeiaaiaaoeka
aaaaoeiaafaaaaadacaaapiaaaaacjiaaaaakeiaajaaaaadadaaabiaajaaoeka
acaaoeiaajaaaaadadaaaciaakaaoekaacaaoeiaajaaaaadadaaaeiaalaaoeka
acaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaadaaaaaiiaaaaaffia
aaaaffiaaeaaaaaeaaaaaiiaaaaaaaiaaaaaaaiaaaaappibabaaaaacadaaahoa
aaaaoeiaaeaaaaaeaeaaahoaamaaoekaaaaappiaabaaoeiaafaaaaadaaaaapia
aaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiappppaaaafdeieefceeaeaaaaeaaaabaabbabaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaaeegiocaaa
acaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaaaaaaaaaa
adaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
aeaaaaaakgiocaaaaaaaaaaaaeaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaa
aaaaaaaaagaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaaaaaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaabaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaabaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaabaaaaaa
ciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaaclaaaaaa
egaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaaabaaaaaacmaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [unity_LightmapST]
Vector 10 [_Control_ST]
Vector 11 [_Splat0_ST]
Vector 12 [_Splat1_ST]
Vector 13 [_Splat2_ST]
Vector 14 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[15] = { program.local[0],
		state.matrix.mvp,
		program.local[5..14] };
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[11].xyxy, c[11];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[13].xyxy, c[13];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[12], c[12].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[14], c[14].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[9], c[9].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 10 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
Vector 9 [_Control_ST]
Vector 10 [_Splat0_ST]
Vector 11 [_Splat1_ST]
Vector 12 [_Splat2_ST]
Vector 13 [_Splat3_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
mad oT0.zw, v2.xyxy, c10.xyxy, c10
mad oT0.xy, v2, c9, c9.zwzw
mad oT1.zw, v2.xyxy, c12.xyxy, c12
mad oT1.xy, v2, c11, c11.zwzw
mad oT2.xy, v2, c13, c13.zwzw
mad oT3.xy, v3, c8, c8.zwzw
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
Vector 48 [unity_LightmapST]
Vector 64 [_Control_ST]
Vector 80 [_Splat0_ST]
Vector 96 [_Splat1_ST]
Vector 112 [_Splat2_ST]
Vector 128 [_Splat3_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedldfhaonnnpkfhhmobnopjebgngdagdojabaaaaaaneadaaaaadaaaaaa
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
adamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdiacaaaaeaaaabaa
ioaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaa
ogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadcaaaaaldccabaaa
adaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaa
aiaaaaaadcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaa
adaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 144
Vector 48 [unity_LightmapST]
Vector 64 [_Control_ST]
Vector 80 [_Splat0_ST]
Vector 96 [_Splat1_ST]
Vector 112 [_Splat2_ST]
Vector 128 [_Splat3_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedojdflokjnjkilkfegdbhanookchjhjciabaaaaaadaafaaaaaeaaaaaa
daaaaaaaiiabaaaamiadaaaajaaeaaaaebgpgodjfaabaaaafaabaaaaaaacpopp
baabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaadaa
agaaabaaaaaaaaaaabaaaaaaaeaaahaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapja
aeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeeja
adaaeekaadaaoekaaeaaaaaeabaaadoaadaaoejaaeaaoekaaeaaookaaeaaaaae
abaaamoaadaaeejaafaaeekaafaaoekaaeaaaaaeacaaadoaadaaoejaagaaoeka
agaaookaaeaaaaaeacaaamoaaeaabejaabaabekaabaalekaafaaaaadaaaaapia
aaaaffjaaiaaoekaaeaaaaaeaaaaapiaahaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaajaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaakaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiappppaaaafdeieefcdiacaaaaeaaaabaaioaaaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaa
kgiocaaaaaaaaaaaahaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaa
adaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaa
adaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaa
imaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [unity_LightmapST]
Vector 10 [_Control_ST]
Vector 11 [_Splat0_ST]
Vector 12 [_Splat1_ST]
Vector 13 [_Splat2_ST]
Vector 14 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[15] = { program.local[0],
		state.matrix.mvp,
		program.local[5..14] };
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[11].xyxy, c[11];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[13].xyxy, c[13];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[12], c[12].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[14], c[14].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[9], c[9].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 10 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
Vector 9 [_Control_ST]
Vector 10 [_Splat0_ST]
Vector 11 [_Splat1_ST]
Vector 12 [_Splat2_ST]
Vector 13 [_Splat3_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
mad oT0.zw, v2.xyxy, c10.xyxy, c10
mad oT0.xy, v2, c9, c9.zwzw
mad oT1.zw, v2.xyxy, c12.xyxy, c12
mad oT1.xy, v2, c11, c11.zwzw
mad oT2.xy, v2, c13, c13.zwzw
mad oT3.xy, v3, c8, c8.zwzw
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
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 144
Vector 48 [unity_LightmapST]
Vector 64 [_Control_ST]
Vector 80 [_Splat0_ST]
Vector 96 [_Splat1_ST]
Vector 112 [_Splat2_ST]
Vector 128 [_Splat3_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedldfhaonnnpkfhhmobnopjebgngdagdojabaaaaaaneadaaaaadaaaaaa
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
adamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdiacaaaaeaaaabaa
ioaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaa
ogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadcaaaaaldccabaaa
adaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaa
aiaaaaaadcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaa
adaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 144
Vector 48 [unity_LightmapST]
Vector 64 [_Control_ST]
Vector 80 [_Splat0_ST]
Vector 96 [_Splat1_ST]
Vector 112 [_Splat2_ST]
Vector 128 [_Splat3_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedojdflokjnjkilkfegdbhanookchjhjciabaaaaaadaafaaaaaeaaaaaa
daaaaaaaiiabaaaamiadaaaajaaeaaaaebgpgodjfaabaaaafaabaaaaaaacpopp
baabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaadaa
agaaabaaaaaaaaaaabaaaaaaaeaaahaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapja
aeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeeja
adaaeekaadaaoekaaeaaaaaeabaaadoaadaaoejaaeaaoekaaeaaookaaeaaaaae
abaaamoaadaaeejaafaaeekaafaaoekaaeaaaaaeacaaadoaadaaoejaagaaoeka
agaaookaaeaaaaaeacaaamoaaeaabejaabaabekaabaalekaafaaaaadaaaaapia
aaaaffjaaiaaoekaaeaaaaaeaaaaapiaahaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaajaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaakaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiappppaaaafdeieefcdiacaaaaeaaaabaaioaaaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaa
kgiocaaaaaaaaaaaahaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaa
adaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaa
adaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaa
imaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
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
Vector 18 [_Control_ST]
Vector 19 [_Splat0_ST]
Vector 20 [_Splat1_ST]
Vector 21 [_Splat2_ST]
Vector 22 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[23] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..22] };
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
ADD result.texcoord[4].xyz, R3, R2;
ADD result.texcoord[5].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[5].zw, R0;
MOV result.texcoord[3].z, R2.w;
MOV result.texcoord[3].y, R3.w;
MOV result.texcoord[3].x, R1.w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[22], c[22].zwzw;
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
Vector 18 [_Control_ST]
Vector 19 [_Splat0_ST]
Vector 20 [_Splat1_ST]
Vector 21 [_Splat2_ST]
Vector 22 [_Splat3_ST]
"vs_2_0
def c23, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1, c17.w
dp3 r3.w, r0, c5
dp3 r2.w, r0, c6
dp3 r1.w, r0, c4
mov r1.x, r3.w
mov r1.y, r2.w
mov r1.z, c23.x
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
mul r1.xyz, r0.xyww, c23.y
mul r1.y, r1, c8.x
add oT4.xyz, r3, r2
mad oT5.xy, r1.z, c9.zwzw, r1
mov oPos, r0
mov oT5.zw, r0
mov oT3.z, r2.w
mov oT3.y, r3.w
mov oT3.x, r1.w
mad oT0.zw, v2.xyxy, c19.xyxy, c19
mad oT0.xy, v2, c18, c18.zwzw
mad oT1.zw, v2.xyxy, c21.xyxy, c21
mad oT1.xy, v2, c20, c20.zwzw
mad oT2.xy, v2, c22, c22.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 112 [_Control_ST]
Vector 128 [_Splat0_ST]
Vector 144 [_Splat1_ST]
Vector 160 [_Splat2_ST]
Vector 176 [_Splat3_ST]
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
eefiecedpfbcmmojomjkofcbfkkeallhamakpkjnabaaaaaaliagaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
aaklklklfdeieefcomaeaaaaeaaaabaadlabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
ahaaaaaaogikcaaaaaaaaaaaahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaadcaaaaal
dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaa
aaaaaaaaajaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaaadaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
diaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaa
egaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
acaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaa
acaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaa
acaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaa
adaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaa
egiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaa
egiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaa
egiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaakhccabaaaafaaaaaa
egiccaaaacaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaagaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
agaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 112 [_Control_ST]
Vector 128 [_Splat0_ST]
Vector 144 [_Splat1_ST]
Vector 160 [_Splat2_ST]
Vector 176 [_Splat3_ST]
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
eefieceddjkpjnhdohcfoefbdgjpkbcpjhggfgmlabaaaaaakmajaaaaaeaaaaaa
daaaaaaacaadaaaabeaiaaaanmaiaaaaebgpgodjoiacaaaaoiacaaaaaaacpopp
hiacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaahaa
afaaabaaaaaaaaaaabaaafaaabaaagaaaaaaaaaaacaacgaaahaaahaaaaaaaaaa
adaaaaaaaeaaaoaaaaaaaaaaadaaamaaadaabcaaaaaaaaaaadaabeaaabaabfaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbgaaapkaaaaaiadpaaaaaadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaae
aaaaamoaadaaeejaacaaeekaacaaoekaaeaaaaaeabaaadoaadaaoejaadaaoeka
adaaookaaeaaaaaeabaaamoaadaaeejaaeaaeekaaeaaoekaaeaaaaaeacaaadoa
adaaoejaafaaoekaafaaookaafaaaaadaaaaahiaacaaoejabfaappkaafaaaaad
abaaahiaaaaaffiabdaaoekaaeaaaaaeaaaaaliabcaakekaaaaaaaiaabaakeia
aeaaaaaeaaaaahiabeaaoekaaaaakkiaaaaapeiaabaaaaacaaaaaiiabgaaaaka
ajaaaaadabaaabiaahaaoekaaaaaoeiaajaaaaadabaaaciaaiaaoekaaaaaoeia
ajaaaaadabaaaeiaajaaoekaaaaaoeiaafaaaaadacaaapiaaaaacjiaaaaakeia
ajaaaaadadaaabiaakaaoekaacaaoeiaajaaaaadadaaaciaalaaoekaacaaoeia
ajaaaaadadaaaeiaamaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeia
afaaaaadaaaaaiiaaaaaffiaaaaaffiaaeaaaaaeaaaaaiiaaaaaaaiaaaaaaaia
aaaappibabaaaaacadaaahoaaaaaoeiaaeaaaaaeaeaaahoaanaaoekaaaaappia
abaaoeiaafaaaaadaaaaapiaaaaaffjaapaaoekaaeaaaaaeaaaaapiaaoaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiabbaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaagaaaaka
afaaaaadabaaaiiaabaaaaiabgaaffkaafaaaaadabaaafiaaaaapeiabgaaffka
acaaaaadafaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacafaaamoaaaaaoeiappppaaaa
fdeieefcomaeaaaaeaaaabaadlabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaa
fjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
gfaaaaadpccabaaaagaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaa
ogikcaaaaaaaaaaaahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaa
ajaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
akaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
abaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaaabaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaa
jgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaaeaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaakhccabaaaafaaaaaaegiccaaa
acaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaagaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [_ProjectionParams]
Vector 10 [unity_LightmapST]
Vector 11 [_Control_ST]
Vector 12 [_Splat0_ST]
Vector 13 [_Splat1_ST]
Vector 14 [_Splat2_ST]
Vector 15 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[16] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[12].xyxy, c[12];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[13], c[13].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[10], c[10].zwzw;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_LightmapST]
Vector 11 [_Control_ST]
Vector 12 [_Splat0_ST]
Vector 13 [_Splat1_ST]
Vector 14 [_Splat2_ST]
Vector 15 [_Splat3_ST]
"vs_2_0
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c16.x
mul r1.y, r1, c8.x
mad oT4.xy, r1.z, c9.zwzw, r1
mov oPos, r0
mov oT4.zw, r0
mad oT0.zw, v2.xyxy, c12.xyxy, c12
mad oT0.xy, v2, c11, c11.zwzw
mad oT1.zw, v2.xyxy, c14.xyxy, c14
mad oT1.xy, v2, c13, c13.zwzw
mad oT2.xy, v2, c15, c15.zwzw
mad oT3.xy, v3, c10, c10.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 208
Vector 112 [unity_LightmapST]
Vector 128 [_Control_ST]
Vector 144 [_Splat0_ST]
Vector 160 [_Splat1_ST]
Vector 176 [_Splat2_ST]
Vector 192 [_Splat3_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedcidilloagbfjbpkfifgjboaodeophfhcabaaaaaajeaeaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcoaacaaaaeaaaabaaliaaaaaafjaaaaae
egiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaajaaaaaakgiocaaa
aaaaaaaaajaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaalmccabaaaacaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaaaaaaaaaaalaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaamaaaaaa
ogikcaaaaaaaaaaaamaaaaaadcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaa
agiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 208
Vector 112 [unity_LightmapST]
Vector 128 [_Control_ST]
Vector 144 [_Splat0_ST]
Vector 160 [_Splat1_ST]
Vector 176 [_Splat2_ST]
Vector 192 [_Splat3_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedfpgihknopeempickoikaaoaionenoamhabaaaaaagaagaaaaaeaaaaaa
daaaaaaapiabaaaaoaaeaaaakiafaaaaebgpgodjmaabaaaamaabaaaaaaacpopp
heabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaahaa
agaaabaaaaaaaaaaabaaafaaabaaahaaaaaaaaaaacaaaaaaaeaaaiaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafamaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeia
aeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoa
adaaeejaadaaeekaadaaoekaaeaaaaaeabaaadoaadaaoejaaeaaoekaaeaaooka
aeaaaaaeabaaamoaadaaeejaafaaeekaafaaoekaaeaaaaaeacaaadoaadaaoeja
agaaoekaagaaookaaeaaaaaeacaaamoaaeaabejaabaabekaabaalekaafaaaaad
aaaaapiaaaaaffjaajaaoekaaeaaaaaeaaaaapiaaiaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaakaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaalaaoeka
aaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaahaaaakaafaaaaadabaaaiia
abaaaaiaamaaaakaafaaaaadabaaafiaaaaapeiaamaaaakaacaaaaadadaaadoa
abaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacadaaamoaaaaaoeiappppaaaafdeieefcoaacaaaa
eaaaabaaliaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaa
aaaaaaaaaiaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaajaaaaaakgiocaaaaaaaaaaaajaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaalaaaaaa
kgiocaaaaaaaaaaaalaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaamaaaaaaogikcaaaaaaaaaaaamaaaaaadcaaaaalmccabaaa
adaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaa
ahaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaamadaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [_ProjectionParams]
Vector 10 [unity_LightmapST]
Vector 11 [_Control_ST]
Vector 12 [_Splat0_ST]
Vector 13 [_Splat1_ST]
Vector 14 [_Splat2_ST]
Vector 15 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[16] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[12].xyxy, c[12];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[13], c[13].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[10], c[10].zwzw;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_LightmapST]
Vector 11 [_Control_ST]
Vector 12 [_Splat0_ST]
Vector 13 [_Splat1_ST]
Vector 14 [_Splat2_ST]
Vector 15 [_Splat3_ST]
"vs_2_0
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c16.x
mul r1.y, r1, c8.x
mad oT4.xy, r1.z, c9.zwzw, r1
mov oPos, r0
mov oT4.zw, r0
mad oT0.zw, v2.xyxy, c12.xyxy, c12
mad oT0.xy, v2, c11, c11.zwzw
mad oT1.zw, v2.xyxy, c14.xyxy, c14
mad oT1.xy, v2, c13, c13.zwzw
mad oT2.xy, v2, c15, c15.zwzw
mad oT3.xy, v3, c10, c10.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 208
Vector 112 [unity_LightmapST]
Vector 128 [_Control_ST]
Vector 144 [_Splat0_ST]
Vector 160 [_Splat1_ST]
Vector 176 [_Splat2_ST]
Vector 192 [_Splat3_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedcidilloagbfjbpkfifgjboaodeophfhcabaaaaaajeaeaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcoaacaaaaeaaaabaaliaaaaaafjaaaaae
egiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaajaaaaaakgiocaaa
aaaaaaaaajaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaadcaaaaalmccabaaaacaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaalaaaaaakgiocaaaaaaaaaaaalaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaamaaaaaa
ogikcaaaaaaaaaaaamaaaaaadcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaa
agiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 208
Vector 112 [unity_LightmapST]
Vector 128 [_Control_ST]
Vector 144 [_Splat0_ST]
Vector 160 [_Splat1_ST]
Vector 176 [_Splat2_ST]
Vector 192 [_Splat3_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedfpgihknopeempickoikaaoaionenoamhabaaaaaagaagaaaaaeaaaaaa
daaaaaaapiabaaaaoaaeaaaakiafaaaaebgpgodjmaabaaaamaabaaaaaaacpopp
heabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaahaa
agaaabaaaaaaaaaaabaaafaaabaaahaaaaaaaaaaacaaaaaaaeaaaiaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafamaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeia
aeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoa
adaaeejaadaaeekaadaaoekaaeaaaaaeabaaadoaadaaoejaaeaaoekaaeaaooka
aeaaaaaeabaaamoaadaaeejaafaaeekaafaaoekaaeaaaaaeacaaadoaadaaoeja
agaaoekaagaaookaaeaaaaaeacaaamoaaeaabejaabaabekaabaalekaafaaaaad
aaaaapiaaaaaffjaajaaoekaaeaaaaaeaaaaapiaaiaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaakaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaalaaoeka
aaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaahaaaakaafaaaaadabaaaiia
abaaaaiaamaaaakaafaaaaadabaaafiaaaaapeiaamaaaakaacaaaaadadaaadoa
abaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacadaaamoaaaaaoeiappppaaaafdeieefcoaacaaaa
eaaaabaaliaaaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaa
aaaaaaaaaiaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaajaaaaaakgiocaaaaaaaaaaaajaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaaakaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaalaaaaaa
kgiocaaaaaaaaaaaalaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaamaaaaaaogikcaaaaaaaaaaaamaaaaaadcaaaaalmccabaaa
adaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaa
ahaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaadaaaaaaamadaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
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
Vector 25 [_Control_ST]
Vector 26 [_Splat0_ST]
Vector 27 [_Splat1_ST]
Vector 28 [_Splat2_ST]
Vector 29 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[30] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..29] };
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
ADD result.texcoord[4].xyz, R0, R1;
MOV result.texcoord[3].z, R3.x;
MOV result.texcoord[3].y, R3.w;
MOV result.texcoord[3].x, R4;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[26].xyxy, c[26];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[25], c[25].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[28].xyxy, c[28];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[27], c[27].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[29], c[29].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
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
Vector 24 [_Control_ST]
Vector 25 [_Splat0_ST]
Vector 26 [_Splat1_ST]
Vector 27 [_Splat2_ST]
Vector 28 [_Splat3_ST]
"vs_2_0
def c29, 1.00000000, 0.00000000, 0, 0
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
mov r4.w, c29.x
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
add r1, r2, c29.x
dp4 r2.z, r4, c18
dp4 r2.y, r4, c17
dp4 r2.x, r4, c16
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c29.y
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
add oT4.xyz, r0, r1
mov oT3.z, r3.x
mov oT3.y, r3.w
mov oT3.x, r4
mad oT0.zw, v2.xyxy, c25.xyxy, c25
mad oT0.xy, v2, c24, c24.zwzw
mad oT1.zw, v2.xyxy, c27.xyxy, c27
mad oT1.xy, v2, c26, c26.zwzw
mad oT2.xy, v2, c28, c28.zwzw
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
ConstBuffer "$Globals" 128
Vector 48 [_Control_ST]
Vector 64 [_Splat0_ST]
Vector 80 [_Splat1_ST]
Vector 96 [_Splat2_ST]
Vector 112 [_Splat3_ST]
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
eefiecedbgdfkoaidkmaeloagbkkndmbbkhipmfcabaaaaaaeiajaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcjeahaaaaeaaaabaaofabaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
agaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaa
aaaaaaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaa
kgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaaaaaaaaaadgaaaaaf
icaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaa
abaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaa
abaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaa
abaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaa
aaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaa
cmaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaa
acaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaa
aaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaa
egaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaacaaaaaa
egiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaakgakbaiaebaaaaaa
acaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaa
afaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaaaaaaaaa
egaobaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaa
adaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaadcaaaaaj
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
eeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaa
egaobaaaacaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaacaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
aaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
abaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 48 [_Control_ST]
Vector 64 [_Splat0_ST]
Vector 80 [_Splat1_ST]
Vector 96 [_Splat2_ST]
Vector 112 [_Splat3_ST]
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
eefiecedogckfbblfpklcjiggckldahcgkmkomkdabaaaaaaoianaaaaaeaaaaaa
daaaaaaammaeaaaagiamaaaadaanaaaaebgpgodjjeaeaaaajeaeaaaaaaacpopp
ceaeaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
afaaabaaaaaaaaaaabaaacaaaiaaagaaaaaaaaaaabaacgaaahaaaoaaaaaaaaaa
acaaaaaaaeaabfaaaaaaaaaaacaaamaaaeaabjaaaaaaaaaaacaabeaaabaabnaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafboaaapkaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaae
aaaaamoaadaaeejaacaaeekaacaaoekaaeaaaaaeabaaadoaadaaoejaadaaoeka
adaaookaaeaaaaaeabaaamoaadaaeejaaeaaeekaaeaaoekaaeaaaaaeacaaadoa
adaaoejaafaaoekaafaaookaafaaaaadaaaaahiaaaaaffjabkaaoekaaeaaaaae
aaaaahiabjaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiablaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaahiabmaaoekaaaaappjaaaaaoeiaacaaaaadabaaapia
aaaaffibahaaoekaafaaaaadacaaapiaabaaoeiaabaaoeiaacaaaaadadaaapia
aaaaaaibagaaoekaacaaaaadaaaaapiaaaaakkibaiaaoekaaeaaaaaeacaaapia
adaaoeiaadaaoeiaacaaoeiaaeaaaaaeacaaapiaaaaaoeiaaaaaoeiaacaaoeia
ahaaaaacaeaaabiaacaaaaiaahaaaaacaeaaaciaacaaffiaahaaaaacaeaaaeia
acaakkiaahaaaaacaeaaaiiaacaappiaabaaaaacafaaabiaboaaaakaaeaaaaae
acaaapiaacaaoeiaajaaoekaafaaaaiaafaaaaadafaaahiaacaaoejabnaappka
afaaaaadagaaahiaafaaffiabkaaoekaaeaaaaaeafaaaliabjaakekaafaaaaia
agaakeiaaeaaaaaeafaaahiablaaoekaafaakkiaafaapeiaafaaaaadabaaapia
abaaoeiaafaaffiaaeaaaaaeabaaapiaadaaoeiaafaaaaiaabaaoeiaaeaaaaae
aaaaapiaaaaaoeiaafaakkiaabaaoeiaafaaaaadaaaaapiaaeaaoeiaaaaaoeia
alaaaaadaaaaapiaaaaaoeiaboaaffkaagaaaaacabaaabiaacaaaaiaagaaaaac
abaaaciaacaaffiaagaaaaacabaaaeiaacaakkiaagaaaaacabaaaiiaacaappia
afaaaaadaaaaapiaaaaaoeiaabaaoeiaafaaaaadabaaahiaaaaaffiaalaaoeka
aeaaaaaeabaaahiaakaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaamaaoeka
aaaakkiaabaaoeiaaeaaaaaeaaaaahiaanaaoekaaaaappiaaaaaoeiaabaaaaac
afaaaiiaboaaaakaajaaaaadabaaabiaaoaaoekaafaaoeiaajaaaaadabaaacia
apaaoekaafaaoeiaajaaaaadabaaaeiabaaaoekaafaaoeiaafaaaaadacaaapia
afaacjiaafaakeiaajaaaaadadaaabiabbaaoekaacaaoeiaajaaaaadadaaacia
bcaaoekaacaaoeiaajaaaaadadaaaeiabdaaoekaacaaoeiaacaaaaadabaaahia
abaaoeiaadaaoeiaafaaaaadaaaaaiiaafaaffiaafaaffiaaeaaaaaeaaaaaiia
afaaaaiaafaaaaiaaaaappibabaaaaacadaaahoaafaaoeiaaeaaaaaeabaaahia
beaaoekaaaaappiaabaaoeiaacaaaaadaeaaahoaaaaaoeiaabaaoeiaafaaaaad
aaaaapiaaaaaffjabgaaoekaaeaaaaaeaaaaapiabfaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiabhaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabiaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiappppaaaafdeieefcjeahaaaaeaaaabaaofabaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaacnaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
agaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaa
aaaaaaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaa
kgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaaaaaaaaaadgaaaaaf
icaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaa
abaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaa
abaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaa
abaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaa
aaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaa
cjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaa
ckaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaa
claaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaa
cmaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaa
acaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaa
aaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaa
egaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaacaaaaaa
egiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaakgakbaiaebaaaaaa
acaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaa
afaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaaaaaaaaa
egaobaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaa
adaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaadcaaaaaj
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaa
eeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaa
egaobaaaacaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaacaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
aaaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
abaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaa
keaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
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
Vector 26 [_Control_ST]
Vector 27 [_Splat0_ST]
Vector 28 [_Splat1_ST]
Vector 29 [_Splat2_ST]
Vector 30 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[31] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..30] };
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
ADD result.texcoord[4].xyz, R4.yzww, R1;
MOV R1.x, R2;
MUL R1.y, R2, c[9].x;
ADD result.texcoord[5].xy, R1, R2.z;
MOV result.position, R0;
MOV result.texcoord[5].zw, R0;
MOV result.texcoord[3].z, R3.x;
MOV result.texcoord[3].y, R3.w;
MOV result.texcoord[3].x, R4;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[27].xyxy, c[27];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[26], c[26].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[29].xyxy, c[29];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[28], c[28].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[30], c[30].zwzw;
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
Vector 26 [_Control_ST]
Vector 27 [_Splat0_ST]
Vector 28 [_Splat1_ST]
Vector 29 [_Splat2_ST]
Vector 30 [_Splat3_ST]
"vs_2_0
def c31, 1.00000000, 0.00000000, 0.50000000, 0
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
mov r4.w, c31.x
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
add r1, r2, c31.x
dp4 r2.z, r4, c20
dp4 r2.y, r4, c19
dp4 r2.x, r4, c18
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c31.y
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
mul r2.xyz, r0.xyww, c31.z
add oT4.xyz, r4.yzww, r1
mov r1.x, r2
mul r1.y, r2, c8.x
mad oT5.xy, r2.z, c9.zwzw, r1
mov oPos, r0
mov oT5.zw, r0
mov oT3.z, r3.x
mov oT3.y, r3.w
mov oT3.x, r4
mad oT0.zw, v2.xyxy, c27.xyxy, c27
mad oT0.xy, v2, c26, c26.zwzw
mad oT1.zw, v2.xyxy, c29.xyxy, c29
mad oT1.xy, v2, c28, c28.zwzw
mad oT2.xy, v2, c30, c30.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 112 [_Control_ST]
Vector 128 [_Splat0_ST]
Vector 144 [_Splat1_ST]
Vector 160 [_Splat2_ST]
Vector 176 [_Splat3_ST]
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
eefiecedemglpifheehoaiajblkccomjiggfnjmoabaaaaaaaiakaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
aaklklklfdeieefcdmaiaaaaeaaaabaaapacaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaacahaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
ahaaaaaaogikcaaaaaaaaaaaahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaadcaaaaal
dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaa
aaaaaaaaajaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaaadaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
diaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaa
egaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
acaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaa
acaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaa
acaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaa
adaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaa
egiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaa
egiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaa
egiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaa
abaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaacaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaai
hcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaadaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
adaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaaaeaaaaaa
fgafbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaa
afaaaaaafgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaahpcaabaaaaeaaaaaa
egaobaaaaeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaaagaaaaaaagaabaia
ebaaaaaaadaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaa
kgakbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaa
afaaaaaaegaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaaafaaaaaadcaaaaaj
pcaabaaaabaaaaaaegaobaaaadaaaaaakgakbaaaabaaaaaaegaobaaaafaaaaaa
dcaaaaajpcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaaagaaaaaaegaobaaa
aeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaa
egaobaaaaeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaaadaaaaaadcaaaaan
pcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaadaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaa
adaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaaabaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaajaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaagaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Vector 112 [_Control_ST]
Vector 128 [_Splat0_ST]
Vector 144 [_Splat1_ST]
Vector 160 [_Splat2_ST]
Vector 176 [_Splat3_ST]
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
eefieceddklmbcidfimfodjlknlbenldcjljcdamabaaaaaaaaapaaaaaeaaaaaa
daaaaaaaceafaaaagianaaaadaaoaaaaebgpgodjomaeaaaaomaeaaaaaaacpopp
haaeaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaahaa
afaaabaaaaaaaaaaabaaafaaabaaagaaaaaaaaaaacaaacaaaiaaahaaaaaaaaaa
acaacgaaahaaapaaaaaaaaaaadaaaaaaaeaabgaaaaaaaaaaadaaamaaaeaabkaa
aaaaaaaaadaabeaaabaaboaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbpaaapka
aaaaiadpaaaaaaaaaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoeja
abaaoekaabaaookaaeaaaaaeaaaaamoaadaaeejaacaaeekaacaaoekaaeaaaaae
abaaadoaadaaoejaadaaoekaadaaookaaeaaaaaeabaaamoaadaaeejaaeaaeeka
aeaaoekaaeaaaaaeacaaadoaadaaoejaafaaoekaafaaookaafaaaaadaaaaahia
aaaaffjablaaoekaaeaaaaaeaaaaahiabkaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaahiabmaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabnaaoekaaaaappja
aaaaoeiaacaaaaadabaaapiaaaaaffibaiaaoekaafaaaaadacaaapiaabaaoeia
abaaoeiaacaaaaadadaaapiaaaaaaaibahaaoekaacaaaaadaaaaapiaaaaakkib
ajaaoekaaeaaaaaeacaaapiaadaaoeiaadaaoeiaacaaoeiaaeaaaaaeacaaapia
aaaaoeiaaaaaoeiaacaaoeiaahaaaaacaeaaabiaacaaaaiaahaaaaacaeaaacia
acaaffiaahaaaaacaeaaaeiaacaakkiaahaaaaacaeaaaiiaacaappiaabaaaaac
afaaabiabpaaaakaaeaaaaaeacaaapiaacaaoeiaakaaoekaafaaaaiaafaaaaad
afaaahiaacaaoejaboaappkaafaaaaadagaaahiaafaaffiablaaoekaaeaaaaae
afaaaliabkaakekaafaaaaiaagaakeiaaeaaaaaeafaaahiabmaaoekaafaakkia
afaapeiaafaaaaadabaaapiaabaaoeiaafaaffiaaeaaaaaeabaaapiaadaaoeia
afaaaaiaabaaoeiaaeaaaaaeaaaaapiaaaaaoeiaafaakkiaabaaoeiaafaaaaad
aaaaapiaaeaaoeiaaaaaoeiaalaaaaadaaaaapiaaaaaoeiabpaaffkaagaaaaac
abaaabiaacaaaaiaagaaaaacabaaaciaacaaffiaagaaaaacabaaaeiaacaakkia
agaaaaacabaaaiiaacaappiaafaaaaadaaaaapiaaaaaoeiaabaaoeiaafaaaaad
abaaahiaaaaaffiaamaaoekaaeaaaaaeabaaahiaalaaoekaaaaaaaiaabaaoeia
aeaaaaaeaaaaahiaanaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiaaoaaoeka
aaaappiaaaaaoeiaabaaaaacafaaaiiabpaaaakaajaaaaadabaaabiaapaaoeka
afaaoeiaajaaaaadabaaaciabaaaoekaafaaoeiaajaaaaadabaaaeiabbaaoeka
afaaoeiaafaaaaadacaaapiaafaacjiaafaakeiaajaaaaadadaaabiabcaaoeka
acaaoeiaajaaaaadadaaaciabdaaoekaacaaoeiaajaaaaadadaaaeiabeaaoeka
acaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaadaaaaaiiaafaaffia
afaaffiaaeaaaaaeaaaaaiiaafaaaaiaafaaaaiaaaaappibabaaaaacadaaahoa
afaaoeiaaeaaaaaeabaaahiabfaaoekaaaaappiaabaaoeiaacaaaaadaeaaahoa
aaaaoeiaabaaoeiaafaaaaadaaaaapiaaaaaffjabhaaoekaaeaaaaaeaaaaapia
bgaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabiaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiabjaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffia
agaaaakaafaaaaadabaaaiiaabaaaaiabpaakkkaafaaaaadabaaafiaaaaapeia
bpaakkkaacaaaaadafaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacafaaamoaaaaaoeia
ppppaaaafdeieefcdmaiaaaaeaaaabaaapacaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaacahaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
ahaaaaaaogikcaaaaaaaaaaaahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaadcaaaaal
dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaa
aaaaaaaaajaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaaadaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaa
diaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
diaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaa
egaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaaaeaaaaaaegacbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
acaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaa
acaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaa
acaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaa
adaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaa
egiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaa
egiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaa
egiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaa
abaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaacaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaai
hcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaadaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
adaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaaaeaaaaaa
fgafbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaa
afaaaaaafgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaahpcaabaaaaeaaaaaa
egaobaaaaeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaaagaaaaaaagaabaia
ebaaaaaaadaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaa
kgakbaiaebaaaaaaadaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaa
afaaaaaaegaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaaafaaaaaadcaaaaaj
pcaabaaaabaaaaaaegaobaaaadaaaaaakgakbaaaabaaaaaaegaobaaaafaaaaaa
dcaaaaajpcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaaagaaaaaaegaobaaa
aeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaa
egaobaaaaeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaaadaaaaaadcaaaaan
pcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaadaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaakpcaabaaaabaaaaaa
egaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaa
adaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaaabaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaajaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaagaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaagaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaa
laaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaa
lmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahaiaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaa
agaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
"!!ARBfp1.0
PARAM c[3] = { program.local[0..1],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R4.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R3.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
MUL R2.xyz, R0.y, R2;
MUL R1.xyz, R0.x, R1;
ADD R1.xyz, R1, R2;
MUL R2.xyz, R0.w, R4;
MUL R0.xyz, R0.z, R3;
ADD R0.xyz, R1, R0;
ADD R1.xyz, R0, R2;
MUL R0.xyz, R1, fragment.texcoord[4];
DP3 R0.w, fragment.texcoord[3], c[0];
MUL R1.xyz, R1, c[1];
MAX R0.w, R0, c[2].x;
MUL R1.xyz, R0.w, R1;
MAD result.color.xyz, R1, c[2].y, R0;
MOV result.color.w, c[2].x;
END
# 19 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c2, 0.00000000, 2.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3.xyz
dcl t4.xyz
texld r3, t2, s4
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.y, t1.w
mov r1.x, t1.z
texld r4, r1, s3
texld r2, r0, s1
texld r0, t1, s2
texld r1, t0, s0
mul r2.xyz, r1.x, r2
mul r0.xyz, r1.y, r0
add_pp r0.xyz, r2, r0
mul r1.xyz, r1.z, r4
add_pp r0.xyz, r0, r1
mul r2.xyz, r1.w, r3
add_pp r1.xyz, r0, r2
mul_pp r2.xyz, r1, c1
dp3_pp r0.x, t3, c0
max_pp r0.x, r0, c2
mul_pp r0.xyz, r0.x, r2
mul_pp r1.xyz, r1, t4
mov_pp r0.w, c2.x
mad_pp r0.xyz, r0, c2.y, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefieceddielachfalicolkklkcpjoilokjlcgnpabaaaaaadaaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbaadaaaa
eaaaaaaameaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaafgafbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
acaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaa
kgakbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaaj
hcaabaaaaaaaaaaapgapbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaai
icaabaaaaaaaaaaaegbcbaaaaeaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedbphdcabcomcciilfhgbdmdkgfpkblpfpabaaaaaagmagaaaaaeaaaaaa
daaaaaaagiacaaaaiaafaaaadiagaaaaebgpgodjdaacaaaadaacaaaaaaacpppp
oaabaaaafaaaaaaaacaadiaaaaaafaaaaaaafaaaafaaceaaaaaafaaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaaaaaabaaabaaaaaaaaaaaaaaabaaaaaa
abaaabaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaac
aaaaaaiaacaaadlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaachla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkaabaaaaac
aaaaabiaabaakklaabaaaaacaaaaaciaabaapplaabaaaaacabaaabiaaaaakkla
abaaaaacabaaaciaaaaapplaecaaaaadaaaaapiaaaaaoeiaadaioekaecaaaaad
abaaapiaabaaoeiaabaioekaecaaaaadacaaapiaabaaoelaacaioekaecaaaaad
adaacpiaaaaaoelaaaaioekaecaaaaadaeaaapiaacaaoelaaeaioekaafaaaaad
acaaahiaacaaoeiaadaaffiaaeaaaaaeabaachiaadaaaaiaabaaoeiaacaaoeia
aeaaaaaeaaaachiaadaakkiaaaaaoeiaabaaoeiaaeaaaaaeaaaachiaadaappia
aeaaoeiaaaaaoeiaafaaaaadabaachiaaaaaoeiaaaaaoekaafaaaaadaaaachia
aaaaoeiaaeaaoelaaiaaaaadaaaaciiaadaaoelaabaaoekaalaaaaadabaaciia
aaaappiaacaaaakaacaaaaadaaaaciiaabaappiaabaappiaaeaaaaaeaaaachia
abaaoeiaaaaappiaaaaaoeiaabaaaaacaaaaaiiaacaaaakaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcbaadaaaaeaaaaaaameaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
dcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaafgafbaaaacaaaaaadcaaaaaj
hcaabaaaaaaaaaaaagaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadcaaaaajhcaabaaaaaaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaafaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaaaeaaaaaa
egiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
ejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [unity_Lightmap] 2D 5
"!!ARBfp1.0
PARAM c[1] = { { 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R1, fragment.texcoord[3], texture[5], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R2.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R5.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R4.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
MUL R3.xyz, R0.y, R3;
MUL R2.xyz, R0.x, R2;
ADD R2.xyz, R2, R3;
MUL R0.xyz, R0.z, R4;
MUL R3.xyz, R0.w, R5;
ADD R0.xyz, R2, R0;
ADD R0.xyz, R0, R3;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, c[0].y;
MOV result.color.w, c[0].x;
END
# 17 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [unity_Lightmap] 2D 5
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c0, 8.00000000, 0.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3.xy
texld r4, t2, s4
texld r2, t0, s0
mov r0.y, t0.w
mov r0.x, t0.z
mov r3.xy, r0
mov r0.y, t1.w
mov r0.x, t1.z
mov r1.xy, r0
texld r5, r1, s3
texld r0, t3, s5
texld r1, t1, s2
texld r3, r3, s1
mul_pp r0.xyz, r0.w, r0
mul r3.xyz, r2.x, r3
mul r1.xyz, r2.y, r1
mul r2.xyz, r2.z, r5
add_pp r1.xyz, r3, r1
add_pp r1.xyz, r1, r2
mul r2.xyz, r2.w, r4
add_pp r1.xyz, r1, r2
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c0.x
mov_pp r0.w, c0.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [unity_Lightmap] 2D 5
"ps_4_0
eefiecedmnnjbhnophpkdpighlccbkipfnnhpdbbabaaaaaamiadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmaacaaaaeaaaaaaalaaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
mcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaafgafbaaa
acaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaakgakbaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaa
pgapbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [unity_Lightmap] 2D 5
"ps_4_0_level_9_1
eefieceddgjebepkicabaikddmndlmdamfcneebjabaaaaaammafaaaaaeaaaaaa
daaaaaaadaacaaaapiaeaaaajiafaaaaebgpgodjpiabaaaapiabaaaaaaacpppp
lmabaaaadmaaaaaaaaaadmaaaaaadmaaaaaadmaaagaaceaaaaaadmaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaafafafaaaaacppppfbaaaaafaaaaapka
aaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaaja
adaiapkabpaaaaacaaaaaajaaeaiapkabpaaaaacaaaaaajaafaiapkaabaaaaac
aaaaabiaabaakklaabaaaaacaaaaaciaabaapplaabaaaaacabaaabiaaaaakkla
abaaaaacabaaaciaaaaapplaabaaaaacacaaadiaacaabllaecaaaaadaaaaapia
aaaaoeiaadaioekaecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadadaaapia
abaaoelaacaioekaecaaaaadaeaacpiaaaaaoelaaaaioekaecaaaaadafaaapia
acaaoelaaeaioekaecaaaaadacaacpiaacaaoeiaafaioekaafaaaaadadaaahia
adaaoeiaaeaaffiaaeaaaaaeabaachiaaeaaaaiaabaaoeiaadaaoeiaaeaaaaae
aaaachiaaeaakkiaaaaaoeiaabaaoeiaaeaaaaaeaaaachiaaeaappiaafaaoeia
aaaaoeiaafaaaaadaaaaciiaacaappiaaaaaaakaafaaaaadabaachiaacaaoeia
aaaappiaafaaaaadaaaachiaaaaaoeiaabaaoeiaabaaaaacaaaaciiaaaaaffka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcmaacaaaaeaaaaaaalaaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaafgafbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaa
agaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaaj
hcaabaaaaaaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaa
aeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaa
afaaaaaaaagabaaaafaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
aaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheojiaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapapaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [unity_Lightmap] 2D 5
"!!ARBfp1.0
PARAM c[1] = { { 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R1, fragment.texcoord[3], texture[5], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R2.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R5.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R4.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
MUL R3.xyz, R0.y, R3;
MUL R2.xyz, R0.x, R2;
ADD R2.xyz, R2, R3;
MUL R0.xyz, R0.z, R4;
MUL R3.xyz, R0.w, R5;
ADD R0.xyz, R2, R0;
ADD R0.xyz, R0, R3;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, c[0].y;
MOV result.color.w, c[0].x;
END
# 17 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [unity_Lightmap] 2D 5
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c0, 8.00000000, 0.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3.xy
texld r4, t2, s4
texld r2, t0, s0
mov r0.y, t0.w
mov r0.x, t0.z
mov r3.xy, r0
mov r0.y, t1.w
mov r0.x, t1.z
mov r1.xy, r0
texld r5, r1, s3
texld r0, t3, s5
texld r1, t1, s2
texld r3, r3, s1
mul_pp r0.xyz, r0.w, r0
mul r3.xyz, r2.x, r3
mul r1.xyz, r2.y, r1
mul r2.xyz, r2.z, r5
add_pp r1.xyz, r3, r1
add_pp r1.xyz, r1, r2
mul r2.xyz, r2.w, r4
add_pp r1.xyz, r1, r2
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c0.x
mov_pp r0.w, c0.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [unity_Lightmap] 2D 5
"ps_4_0
eefiecedmnnjbhnophpkdpighlccbkipfnnhpdbbabaaaaaamiadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmaacaaaaeaaaaaaalaaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
mcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaafgafbaaa
acaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaakgakbaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaa
pgapbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [unity_Lightmap] 2D 5
"ps_4_0_level_9_1
eefieceddgjebepkicabaikddmndlmdamfcneebjabaaaaaammafaaaaaeaaaaaa
daaaaaaadaacaaaapiaeaaaajiafaaaaebgpgodjpiabaaaapiabaaaaaaacpppp
lmabaaaadmaaaaaaaaaadmaaaaaadmaaaaaadmaaagaaceaaaaaadmaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaafafafaaaaacppppfbaaaaafaaaaapka
aaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaaja
adaiapkabpaaaaacaaaaaajaaeaiapkabpaaaaacaaaaaajaafaiapkaabaaaaac
aaaaabiaabaakklaabaaaaacaaaaaciaabaapplaabaaaaacabaaabiaaaaakkla
abaaaaacabaaaciaaaaapplaabaaaaacacaaadiaacaabllaecaaaaadaaaaapia
aaaaoeiaadaioekaecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadadaaapia
abaaoelaacaioekaecaaaaadaeaacpiaaaaaoelaaaaioekaecaaaaadafaaapia
acaaoelaaeaioekaecaaaaadacaacpiaacaaoeiaafaioekaafaaaaadadaaahia
adaaoeiaaeaaffiaaeaaaaaeabaachiaaeaaaaiaabaaoeiaadaaoeiaaeaaaaae
aaaachiaaeaakkiaaaaaoeiaabaaoeiaaeaaaaaeaaaachiaaeaappiaafaaoeia
aaaaoeiaafaaaaadaaaaciiaacaappiaaaaaaakaafaaaaadabaachiaacaaoeia
aaaappiaafaaaaadaaaachiaaaaaoeiaabaaoeiaabaaaaacaaaaciiaaaaaffka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcmaacaaaaeaaaaaaalaaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaafgafbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaa
agaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaaj
hcaabaaaaaaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaa
aeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaa
afaaaaaaaagabaaaafaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
aaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheojiaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapapaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_ShadowMapTexture] 2D 5
"!!ARBfp1.0
PARAM c[3] = { program.local[0..1],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R4.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R3.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TXP R5.x, fragment.texcoord[5], texture[5], 2D;
MUL R2.xyz, R0.y, R2;
MUL R1.xyz, R0.x, R1;
ADD R1.xyz, R1, R2;
MUL R2.xyz, R0.w, R4;
MUL R0.xyz, R0.z, R3;
ADD R0.xyz, R1, R0;
ADD R1.xyz, R0, R2;
MUL R0.xyz, R1, fragment.texcoord[4];
DP3 R0.w, fragment.texcoord[3], c[0];
MAX R0.w, R0, c[2].x;
MUL R1.xyz, R1, c[1];
MUL R0.w, R0, R5.x;
MUL R1.xyz, R0.w, R1;
MAD result.color.xyz, R1, c[2].y, R0;
MOV result.color.w, c[2].x;
END
# 21 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_ShadowMapTexture] 2D 5
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c2, 0.00000000, 2.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3.xyz
dcl t4.xyz
dcl t5
texldp r5, t5, s5
texld r3, t2, s4
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.y, t1.w
mov r1.x, t1.z
texld r4, r1, s3
texld r2, r0, s1
texld r0, t1, s2
texld r1, t0, s0
mul r2.xyz, r1.x, r2
mul r0.xyz, r1.y, r0
add_pp r0.xyz, r2, r0
mul r1.xyz, r1.z, r4
add_pp r0.xyz, r0, r1
mul r2.xyz, r1.w, r3
add_pp r1.xyz, r0, r2
mul_pp r2.xyz, r1, c1
dp3_pp r0.x, t3, c0
max_pp r0.x, r0, c2
mul_pp r0.x, r0, r5
mul_pp r0.xyz, r0.x, r2
mul_pp r1.xyz, r1, t4
mov_pp r0.w, c2.x
mad_pp r0.xyz, r0, c2.y, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_Control] 2D 1
SetTexture 1 [_Splat0] 2D 2
SetTexture 2 [_Splat1] 2D 3
SetTexture 3 [_Splat2] 2D 4
SetTexture 4 [_Splat3] 2D 5
SetTexture 5 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedibhmgclecceknkbfilecpmpecdjopmpcabaaaaaalaaeaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchiadaaaaeaaaaaaanoaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagcbaaaadlcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaagaaaaaapgbpbaaaagaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaafaaaaaaaagabaaa
aaaaaaaabaaaaaaiccaabaaaaaaaaaaaegbcbaaaaeaaaaaaegiccaaaabaaaaaa
aaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
apaaaaahbcaabaaaaaaaaaaafgafbaaaaaaaaaaaagaabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
adaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaaagajbaaaacaaaaaafgafbaaa
adaaaaaadcaaaaajocaabaaaaaaaaaaaagaabaaaadaaaaaaagajbaaaabaaaaaa
fgaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaa
adaaaaaaaagabaaaaeaaaaaadcaaaaajocaabaaaaaaaaaaakgakbaaaadaaaaaa
agajbaaaabaaaaaafgaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaaeaaaaaaaagabaaaafaaaaaadcaaaaajocaabaaaaaaaaaaa
pgapbaaaadaaaaaaagajbaaaabaaaaaafgaobaaaaaaaaaaadiaaaaaihcaabaaa
abaaaaaajgahbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaahocaabaaa
aaaaaaaafgaobaaaaaaaaaaaagbjbaaaafaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaabaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_Control] 2D 1
SetTexture 1 [_Splat0] 2D 2
SetTexture 2 [_Splat1] 2D 3
SetTexture 3 [_Splat2] 2D 4
SetTexture 4 [_Splat3] 2D 5
SetTexture 5 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedcgpaghhnaampekjfecafkhkmjmodonnmabaaaaaaeiahaaaaaeaaaaaa
daaaaaaameacaaaaeeagaaaabeahaaaaebgpgodjimacaaaaimacaaaaaaacpppp
diacaaaafeaaaaaaacaadmaaaaaafeaaaaaafeaaagaaceaaaaaafeaaafaaaaaa
aaababaaabacacaaacadadaaadaeaeaaaeafafaaaaaaabaaabaaaaaaaaaaaaaa
abaaaaaaabaaabaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaapla
bpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaia
aeaachlabpaaaaacaaaaaaiaafaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapka
bpaaaaacaaaaaajaaeaiapkabpaaaaacaaaaaajaafaiapkaagaaaaacaaaaaiia
afaapplaafaaaaadaaaaadiaaaaappiaafaaoelaabaaaaacabaaabiaabaakkla
abaaaaacabaaaciaabaapplaabaaaaacacaaabiaaaaakklaabaaaaacacaaacia
aaaapplaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaadabaaapiaabaaoeia
aeaioekaecaaaaadacaaapiaacaaoeiaacaioekaecaaaaadadaaapiaabaaoela
adaioekaecaaaaadaeaacpiaaaaaoelaabaioekaecaaaaadafaaapiaacaaoela
afaioekaaiaaaaadabaaciiaadaaoelaabaaoekaafaaaaadacaaciiaaaaaaaia
abaappiafiaaaaaeabaaciiaabaappiaacaappiaacaaaakaacaaaaadabaaciia
abaappiaabaappiaafaaaaadaaaaahiaadaaoeiaaeaaffiaaeaaaaaeaaaachia
aeaaaaiaacaaoeiaaaaaoeiaaeaaaaaeaaaachiaaeaakkiaabaaoeiaaaaaoeia
aeaaaaaeaaaachiaaeaappiaafaaoeiaaaaaoeiaafaaaaadabaachiaaaaaoeia
aaaaoekaafaaaaadaaaachiaaaaaoeiaaeaaoelaaeaaaaaeaaaachiaabaaoeia
abaappiaaaaaoeiaabaaaaacaaaaciiaacaaaakaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefchiadaaaaeaaaaaaanoaaaaaafjaaaaaeegiocaaaaaaaaaaa
acaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
adaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadlcbabaaa
agaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaagaaaaaapgbpbaaaagaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaabaaaaaaiccaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaah
ocaabaaaaaaaaaaaagajbaaaacaaaaaafgafbaaaadaaaaaadcaaaaajocaabaaa
aaaaaaaaagaabaaaadaaaaaaagajbaaaabaaaaaafgaobaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaaeaaaaaa
dcaaaaajocaabaaaaaaaaaaakgakbaaaadaaaaaaagajbaaaabaaaaaafgaobaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaa
aagabaaaafaaaaaadcaaaaajocaabaaaaaaaaaaapgapbaaaadaaaaaaagajbaaa
abaaaaaafgaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaajgahbaaaaaaaaaaa
egiccaaaaaaaaaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaa
agbjbaaaafaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaagaabaaa
aaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaabejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_ShadowMapTexture] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
"!!ARBfp1.0
PARAM c[1] = { { 0, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEX R1, fragment.texcoord[3], texture[6], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R3.xyz, fragment.texcoord[1], texture[2], 2D;
TXP R7.x, fragment.texcoord[4], texture[5], 2D;
TEX R5.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R4.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
MUL R6.xyz, R1.w, R1;
MUL R1.xyz, R1, R7.x;
MUL R6.xyz, R6, c[0].y;
MUL R1.xyz, R1, c[0].z;
MUL R3.xyz, R0.y, R3;
MUL R2.xyz, R0.x, R2;
ADD R2.xyz, R2, R3;
MUL R0.xyz, R0.z, R4;
MUL R7.xyz, R6, R7.x;
MIN R1.xyz, R6, R1;
MAX R1.xyz, R1, R7;
MUL R3.xyz, R0.w, R5;
ADD R0.xyz, R2, R0;
ADD R0.xyz, R0, R3;
MUL result.color.xyz, R0, R1;
MOV result.color.w, c[0].x;
END
# 23 instructions, 8 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_ShadowMapTexture] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c0, 8.00000000, 2.00000000, 0.00000000, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3.xy
dcl t4
texld r5, t2, s4
texld r2, t0, s0
texld r3, t1, s2
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.y, t1.w
mov r1.x, t1.z
texld r6, r1, s3
texld r4, r0, s1
texldp r1, t4, s5
texld r0, t3, s6
mul_pp r7.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1.x
mul_pp r7.xyz, r7, c0.x
mul_pp r0.xyz, r0, c0.y
mul_pp r1.xyz, r7, r1.x
min_pp r0.xyz, r7, r0
max_pp r0.xyz, r0, r1
mul r1.xyz, r2.y, r3
mul r3.xyz, r2.x, r4
add_pp r1.xyz, r3, r1
mul r2.xyz, r2.z, r6
mul r3.xyz, r2.w, r5
add_pp r1.xyz, r1, r2
add_pp r1.xyz, r1, r3
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c0.z
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_Control] 2D 1
SetTexture 1 [_Splat0] 2D 2
SetTexture 2 [_Splat1] 2D 3
SetTexture 3 [_Splat2] 2D 4
SetTexture 4 [_Splat3] 2D 5
SetTexture 5 [_ShadowMapTexture] 2D 0
SetTexture 6 [unity_Lightmap] 2D 6
"ps_4_0
eefiecednmmgaenceacelobbfkmiinmddmingpgdabaaaaaaneaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleadaaaa
eaaaaaaaonaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaae
aahabaaaagaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaad
lcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaadiaaaaah
ocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaabaaaaaaddaaaaahocaabaaaaaaaaaaafgaobaaa
aaaaaaaaagajbaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadeaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaafgafbaaaadaaaaaadcaaaaajhcaabaaaabaaaaaaagaabaaaadaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaa
acaaaaaaeghobaaaadaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaaabaaaaaa
kgakbaaaadaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaaafaaaaaadcaaaaaj
hcaabaaaabaaaaaapgapbaaaadaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_Control] 2D 1
SetTexture 1 [_Splat0] 2D 2
SetTexture 2 [_Splat1] 2D 3
SetTexture 3 [_Splat2] 2D 4
SetTexture 4 [_Splat3] 2D 5
SetTexture 5 [_ShadowMapTexture] 2D 0
SetTexture 6 [unity_Lightmap] 2D 6
"ps_4_0_level_9_1
eefiecedpljlfihmenealgnnbifkgfgopkfgoigfabaaaaaahaahaaaaaeaaaaaa
daaaaaaamiacaaaaieagaaaadmahaaaaebgpgodjjaacaaaajaacaaaaaaacpppp
faacaaaaeaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaahaaceaaaaaaeaaaafaaaaaa
aaababaaabacacaaacadadaaadaeaeaaaeafafaaagagagaaaaacppppfbaaaaaf
aaaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaia
adaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapka
bpaaaaacaaaaaajaafaiapkabpaaaaacaaaaaajaagaiapkaagaaaaacaaaaaiia
adaapplaafaaaaadaaaaadiaaaaappiaadaaoelaabaaaaacabaaadiaacaablla
abaaaaacacaaabiaabaakklaabaaaaacacaaaciaabaapplaabaaaaacadaaabia
aaaakklaabaaaaacadaaaciaaaaapplaecaaaaadaaaacpiaaaaaoeiaaaaioeka
ecaaaaadabaacpiaabaaoeiaagaioekaecaaaaadacaaapiaacaaoeiaaeaioeka
ecaaaaadadaaapiaadaaoeiaacaioekaecaaaaadaeaaapiaabaaoelaadaioeka
ecaaaaadafaacpiaaaaaoelaabaioekaecaaaaadagaaapiaacaaoelaafaioeka
acaaaaadacaaciiaaaaaaaiaaaaaaaiaafaaaaadaaaacoiaabaabliaacaappia
afaaaaadabaaciiaabaappiaaaaaaakaafaaaaadabaachiaabaaoeiaabaappia
akaaaaadahaachiaaaaabliaabaaoeiaafaaaaadaaaachiaaaaaaaiaabaaoeia
alaaaaadabaachiaahaaoeiaaaaaoeiaafaaaaadaaaaahiaaeaaoeiaafaaffia
aeaaaaaeaaaachiaafaaaaiaadaaoeiaaaaaoeiaaeaaaaaeaaaachiaafaakkia
acaaoeiaaaaaoeiaaeaaaaaeaaaachiaafaappiaagaaoeiaaaaaoeiaafaaaaad
aaaachiaabaaoeiaaaaaoeiaabaaaaacaaaaciiaaaaaffkaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcleadaaaaeaaaaaaaonaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
fkaaaaadaagabaaaagaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaae
aahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaadmcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaaeaaaaaa
pgbpbaaaaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
afaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaa
agaaaaaaaagabaaaagaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaa
agajbaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
ddaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadeaaaaahhcaabaaa
aaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaaefaaaaaj
pcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaafgafbaaaadaaaaaadcaaaaaj
hcaabaaaabaaaaaaagaabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
aeaaaaaadcaaaaajhcaabaaaabaaaaaakgakbaaaadaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
aeaaaaaaaagabaaaafaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaadaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaamamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_ShadowMapTexture] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
"!!ARBfp1.0
PARAM c[1] = { { 0, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEX R1, fragment.texcoord[3], texture[6], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R3.xyz, fragment.texcoord[1], texture[2], 2D;
TXP R7.x, fragment.texcoord[4], texture[5], 2D;
TEX R5.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R4.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
MUL R6.xyz, R1.w, R1;
MUL R1.xyz, R1, R7.x;
MUL R6.xyz, R6, c[0].y;
MUL R1.xyz, R1, c[0].z;
MUL R3.xyz, R0.y, R3;
MUL R2.xyz, R0.x, R2;
ADD R2.xyz, R2, R3;
MUL R0.xyz, R0.z, R4;
MUL R7.xyz, R6, R7.x;
MIN R1.xyz, R6, R1;
MAX R1.xyz, R1, R7;
MUL R3.xyz, R0.w, R5;
ADD R0.xyz, R2, R0;
ADD R0.xyz, R0, R3;
MUL result.color.xyz, R0, R1;
MOV result.color.w, c[0].x;
END
# 23 instructions, 8 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_ShadowMapTexture] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c0, 8.00000000, 2.00000000, 0.00000000, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3.xy
dcl t4
texld r5, t2, s4
texld r2, t0, s0
texld r3, t1, s2
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.y, t1.w
mov r1.x, t1.z
texld r6, r1, s3
texld r4, r0, s1
texldp r1, t4, s5
texld r0, t3, s6
mul_pp r7.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1.x
mul_pp r7.xyz, r7, c0.x
mul_pp r0.xyz, r0, c0.y
mul_pp r1.xyz, r7, r1.x
min_pp r0.xyz, r7, r0
max_pp r0.xyz, r0, r1
mul r1.xyz, r2.y, r3
mul r3.xyz, r2.x, r4
add_pp r1.xyz, r3, r1
mul r2.xyz, r2.z, r6
mul r3.xyz, r2.w, r5
add_pp r1.xyz, r1, r2
add_pp r1.xyz, r1, r3
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c0.z
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_Control] 2D 1
SetTexture 1 [_Splat0] 2D 2
SetTexture 2 [_Splat1] 2D 3
SetTexture 3 [_Splat2] 2D 4
SetTexture 4 [_Splat3] 2D 5
SetTexture 5 [_ShadowMapTexture] 2D 0
SetTexture 6 [unity_Lightmap] 2D 6
"ps_4_0
eefiecednmmgaenceacelobbfkmiinmddmingpgdabaaaaaaneaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleadaaaa
eaaaaaaaonaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaae
aahabaaaagaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaad
lcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaadaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaadiaaaaah
ocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaabaaaaaaddaaaaahocaabaaaaaaaaaaafgaobaaa
aaaaaaaaagajbaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadeaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaafgafbaaaadaaaaaadcaaaaajhcaabaaaabaaaaaaagaabaaaadaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaa
acaaaaaaeghobaaaadaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaaabaaaaaa
kgakbaaaadaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaaafaaaaaadcaaaaaj
hcaabaaaabaaaaaapgapbaaaadaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_Control] 2D 1
SetTexture 1 [_Splat0] 2D 2
SetTexture 2 [_Splat1] 2D 3
SetTexture 3 [_Splat2] 2D 4
SetTexture 4 [_Splat3] 2D 5
SetTexture 5 [_ShadowMapTexture] 2D 0
SetTexture 6 [unity_Lightmap] 2D 6
"ps_4_0_level_9_1
eefiecedpljlfihmenealgnnbifkgfgopkfgoigfabaaaaaahaahaaaaaeaaaaaa
daaaaaaamiacaaaaieagaaaadmahaaaaebgpgodjjaacaaaajaacaaaaaaacpppp
faacaaaaeaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaahaaceaaaaaaeaaaafaaaaaa
aaababaaabacacaaacadadaaadaeaeaaaeafafaaagagagaaaaacppppfbaaaaaf
aaaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaia
adaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapka
bpaaaaacaaaaaajaafaiapkabpaaaaacaaaaaajaagaiapkaagaaaaacaaaaaiia
adaapplaafaaaaadaaaaadiaaaaappiaadaaoelaabaaaaacabaaadiaacaablla
abaaaaacacaaabiaabaakklaabaaaaacacaaaciaabaapplaabaaaaacadaaabia
aaaakklaabaaaaacadaaaciaaaaapplaecaaaaadaaaacpiaaaaaoeiaaaaioeka
ecaaaaadabaacpiaabaaoeiaagaioekaecaaaaadacaaapiaacaaoeiaaeaioeka
ecaaaaadadaaapiaadaaoeiaacaioekaecaaaaadaeaaapiaabaaoelaadaioeka
ecaaaaadafaacpiaaaaaoelaabaioekaecaaaaadagaaapiaacaaoelaafaioeka
acaaaaadacaaciiaaaaaaaiaaaaaaaiaafaaaaadaaaacoiaabaabliaacaappia
afaaaaadabaaciiaabaappiaaaaaaakaafaaaaadabaachiaabaaoeiaabaappia
akaaaaadahaachiaaaaabliaabaaoeiaafaaaaadaaaachiaaaaaaaiaabaaoeia
alaaaaadabaachiaahaaoeiaaaaaoeiaafaaaaadaaaaahiaaeaaoeiaafaaffia
aeaaaaaeaaaachiaafaaaaiaadaaoeiaaaaaoeiaaeaaaaaeaaaachiaafaakkia
acaaoeiaaaaaoeiaaeaaaaaeaaaachiaafaappiaagaaoeiaaaaaoeiaafaaaaad
aaaachiaabaaoeiaaaaaoeiaabaaaaacaaaaciiaaaaaffkaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcleadaaaaeaaaaaaaonaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
fkaaaaadaagabaaaagaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaae
aahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaadmcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaaeaaaaaa
pgbpbaaaaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
afaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaa
agaaaaaaaagabaaaagaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaa
agajbaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaa
ddaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadeaaaaahhcaabaaa
aaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaaefaaaaaj
pcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaafgafbaaaadaaaaaadcaaaaaj
hcaabaaaabaaaaaaagaabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
aeaaaaaadcaaaaajhcaabaaaabaaaaaakgakbaaaadaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
aeaaaaaaaagabaaaafaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaadaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaakeaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaadaaaaaaamamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Geometry-99" "IGNOREPROJECTOR"="true" "RenderType"="Opaque" "SplatCount"="4" }
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
Vector 15 [_Control_ST]
Vector 16 [_Splat0_ST]
Vector 17 [_Splat1_ST]
Vector 18 [_Splat2_ST]
Vector 19 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[20] = { program.local[0],
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[5].z, R0, c[11];
DP4 result.texcoord[5].y, R0, c[10];
DP4 result.texcoord[5].x, R0, c[9];
DP3 result.texcoord[3].z, R1, c[7];
DP3 result.texcoord[3].y, R1, c[6];
DP3 result.texcoord[3].x, R1, c[5];
ADD result.texcoord[4].xyz, -R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[19], c[19].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
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
Vector 14 [_Control_ST]
Vector 15 [_Splat0_ST]
Vector 16 [_Splat1_ST]
Vector 17 [_Splat2_ST]
Vector 18 [_Splat3_ST]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c13.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT5.z, r0, c10
dp4 oT5.y, r0, c9
dp4 oT5.x, r0, c8
dp3 oT3.z, r1, c6
dp3 oT3.y, r1, c5
dp3 oT3.x, r1, c4
add oT4.xyz, -r0, c12
mad oT0.zw, v2.xyxy, c15.xyxy, c15
mad oT0.xy, v2, c14, c14.zwzw
mad oT1.zw, v2.xyxy, c17.xyxy, c17
mad oT1.xy, v2, c16, c16.zwzw
mad oT2.xy, v2, c18, c18.zwzw
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
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 112 [_Control_ST]
Vector 128 [_Splat0_ST]
Vector 144 [_Splat1_ST]
Vector 160 [_Splat2_ST]
Vector 176 [_Splat3_ST]
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
eefiecedfbofgjgpknhdkjdpbcieggopompmegdgabaaaaaahmagaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
aaklklklfdeieefclaaeaaaaeaaaabaacmabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaa
ogikcaaaaaaaaaaaahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaa
ajaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
akaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhccabaaaafaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 112 [_Control_ST]
Vector 128 [_Splat0_ST]
Vector 144 [_Splat1_ST]
Vector 160 [_Splat2_ST]
Vector 176 [_Splat3_ST]
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
eefiecedgjmcjpbfhgjkncehhefnodkodhoafmmnabaaaaaaceajaaaaaeaaaaaa
daaaaaaaneacaaaaimahaaaafeaiaaaaebgpgodjjmacaaaajmacaaaaaaacpopp
diacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
ajaaabaaaaaaaaaaabaaaaaaabaaakaaaaaaaaaaacaaaaaaaeaaalaaaaaaaaaa
acaaamaaaeaaapaaaaaaaaaaacaabeaaabaabdaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjaaeaaaaaeaaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoa
adaaeejaagaaeekaagaaoekaaeaaaaaeabaaadoaadaaoejaahaaoekaahaaooka
aeaaaaaeabaaamoaadaaeejaaiaaeekaaiaaoekaaeaaaaaeacaaadoaadaaoeja
ajaaoekaajaaookaafaaaaadaaaaahiaacaaoejabdaappkaafaaaaadabaaahia
aaaaffiabaaaoekaaeaaaaaeaaaaaliaapaakekaaaaaaaiaabaakeiaaeaaaaae
adaaahoabbaaoekaaaaakkiaaaaapeiaafaaaaadaaaaahiaaaaaffjabaaaoeka
aeaaaaaeaaaaahiaapaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabbaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaahiabcaaoekaaaaappjaaaaaoeiaacaaaaad
aeaaahoaaaaaoeibakaaoekaafaaaaadaaaaapiaaaaaffjabaaaoekaaeaaaaae
aaaaapiaapaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabbaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabcaaoekaaaaappjaaaaaoeiaafaaaaadabaaahia
aaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoekaaaaaaaiaabaaoeiaaeaaaaae
aaaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaaeafaaahoaaeaaoekaaaaappia
aaaaoeiaafaaaaadaaaaapiaaaaaffjaamaaoekaaeaaaaaeaaaaapiaalaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaaoaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefclaaeaaaaeaaaabaa
cmabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaiaaaaaakgiocaaa
aaaaaaaaaiaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaacaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaa
pgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaaeaaaaaa
egiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaafaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
aaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_WorldSpaceLightPos0]
Vector 10 [unity_Scale]
Vector 11 [_Control_ST]
Vector 12 [_Splat0_ST]
Vector 13 [_Splat1_ST]
Vector 14 [_Splat2_ST]
Vector 15 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[16] = { program.local[0],
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
MUL R0.xyz, vertex.normal, c[10].w;
DP3 result.texcoord[3].z, R0, c[7];
DP3 result.texcoord[3].y, R0, c[6];
DP3 result.texcoord[3].x, R0, c[5];
MOV result.texcoord[4].xyz, c[9];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[12].xyxy, c[12];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[13], c[13].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
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
Vector 10 [_Control_ST]
Vector 11 [_Splat0_ST]
Vector 12 [_Splat1_ST]
Vector 13 [_Splat2_ST]
Vector 14 [_Splat3_ST]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1, c9.w
dp3 oT3.z, r0, c6
dp3 oT3.y, r0, c5
dp3 oT3.x, r0, c4
mov oT4.xyz, c8
mad oT0.zw, v2.xyxy, c11.xyxy, c11
mad oT0.xy, v2, c10, c10.zwzw
mad oT1.zw, v2.xyxy, c13.xyxy, c13
mad oT1.xy, v2, c12, c12.zwzw
mad oT2.xy, v2, c14, c14.zwzw
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
ConstBuffer "$Globals" 128
Vector 48 [_Control_ST]
Vector 64 [_Splat0_ST]
Vector 80 [_Splat1_ST]
Vector 96 [_Splat2_ST]
Vector 112 [_Splat3_ST]
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
eefiecedneeajnpeknaaklelmkplnleoimlefbihabaaaaaaieaeaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcnaacaaaaeaaaabaaleaaaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaa
aaaaaaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaa
kgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadgaaaaaghccabaaaafaaaaaaegiccaaaabaaaaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 48 [_Control_ST]
Vector 64 [_Splat0_ST]
Vector 80 [_Splat1_ST]
Vector 96 [_Splat2_ST]
Vector 112 [_Splat3_ST]
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
eefiecedgjigbeoiieffbencoofahdechalcbcndabaaaaaaeeagaaaaaeaaaaaa
daaaaaaaomabaaaameaeaaaaimafaaaaebgpgodjleabaaaaleabaaaaaaacpopp
faabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
afaaabaaaaaaaaaaabaaaaaaabaaagaaaaaaaaaaacaaaaaaaeaaahaaaaaaaaaa
acaaamaaadaaalaaaaaaaaaaacaabeaaabaaaoaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoa
adaaeejaacaaeekaacaaoekaaeaaaaaeabaaadoaadaaoejaadaaoekaadaaooka
aeaaaaaeabaaamoaadaaeejaaeaaeekaaeaaoekaaeaaaaaeacaaadoaadaaoeja
afaaoekaafaaookaafaaaaadaaaaahiaacaaoejaaoaappkaafaaaaadabaaahia
aaaaffiaamaaoekaaeaaaaaeaaaaaliaalaakekaaaaaaaiaabaakeiaaeaaaaae
adaaahoaanaaoekaaaaakkiaaaaapeiaafaaaaadaaaaapiaaaaaffjaaiaaoeka
aeaaaaaeaaaaapiaahaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaajaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaakaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aeaaahoaagaaoekappppaaaafdeieefcnaacaaaaeaaaabaaleaaaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaae
egiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaadaaaaaaogikcaaa
aaaaaaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaa
kgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadgaaaaaghccabaaaafaaaaaaegiccaaaabaaaaaaaaaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
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
Vector 15 [_Control_ST]
Vector 16 [_Splat0_ST]
Vector 17 [_Splat1_ST]
Vector 18 [_Splat2_ST]
Vector 19 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[20] = { program.local[0],
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[5].w, R0, c[12];
DP4 result.texcoord[5].z, R0, c[11];
DP4 result.texcoord[5].y, R0, c[10];
DP4 result.texcoord[5].x, R0, c[9];
DP3 result.texcoord[3].z, R1, c[7];
DP3 result.texcoord[3].y, R1, c[6];
DP3 result.texcoord[3].x, R1, c[5];
ADD result.texcoord[4].xyz, -R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[19], c[19].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
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
Vector 14 [_Control_ST]
Vector 15 [_Splat0_ST]
Vector 16 [_Splat1_ST]
Vector 17 [_Splat2_ST]
Vector 18 [_Splat3_ST]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c13.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT5.w, r0, c11
dp4 oT5.z, r0, c10
dp4 oT5.y, r0, c9
dp4 oT5.x, r0, c8
dp3 oT3.z, r1, c6
dp3 oT3.y, r1, c5
dp3 oT3.x, r1, c4
add oT4.xyz, -r0, c12
mad oT0.zw, v2.xyxy, c15.xyxy, c15
mad oT0.xy, v2, c14, c14.zwzw
mad oT1.zw, v2.xyxy, c17.xyxy, c17
mad oT1.xy, v2, c16, c16.zwzw
mad oT2.xy, v2, c18, c18.zwzw
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
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 112 [_Control_ST]
Vector 128 [_Splat0_ST]
Vector 144 [_Splat1_ST]
Vector 160 [_Splat2_ST]
Vector 176 [_Splat3_ST]
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
eefiecedbnkaobfggoihlmenikjoagfpicdcieobabaaaaaahmagaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
aaklklklfdeieefclaaeaaaaeaaaabaacmabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadpccabaaaagaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaa
ogikcaaaaaaaaaaaahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaa
ajaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
akaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhccabaaaafaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaagaaaaaaegiocaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 112 [_Control_ST]
Vector 128 [_Splat0_ST]
Vector 144 [_Splat1_ST]
Vector 160 [_Splat2_ST]
Vector 176 [_Splat3_ST]
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
eefiecedibkkfbapofgacpjmladeodgaflmclomaabaaaaaaceajaaaaaeaaaaaa
daaaaaaaneacaaaaimahaaaafeaiaaaaebgpgodjjmacaaaajmacaaaaaaacpopp
diacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
ajaaabaaaaaaaaaaabaaaaaaabaaakaaaaaaaaaaacaaaaaaaeaaalaaaaaaaaaa
acaaamaaaeaaapaaaaaaaaaaacaabeaaabaabdaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjaaeaaaaaeaaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoa
adaaeejaagaaeekaagaaoekaaeaaaaaeabaaadoaadaaoejaahaaoekaahaaooka
aeaaaaaeabaaamoaadaaeejaaiaaeekaaiaaoekaaeaaaaaeacaaadoaadaaoeja
ajaaoekaajaaookaafaaaaadaaaaahiaacaaoejabdaappkaafaaaaadabaaahia
aaaaffiabaaaoekaaeaaaaaeaaaaaliaapaakekaaaaaaaiaabaakeiaaeaaaaae
adaaahoabbaaoekaaaaakkiaaaaapeiaafaaaaadaaaaahiaaaaaffjabaaaoeka
aeaaaaaeaaaaahiaapaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabbaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaahiabcaaoekaaaaappjaaaaaoeiaacaaaaad
aeaaahoaaaaaoeibakaaoekaafaaaaadaaaaapiaaaaaffjabaaaoekaaeaaaaae
aaaaapiaapaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabbaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabcaaoekaaaaappjaaaaaoeiaafaaaaadabaaapia
aaaaffiaacaaoekaaeaaaaaeabaaapiaabaaoekaaaaaaaiaabaaoeiaaeaaaaae
abaaapiaadaaoekaaaaakkiaabaaoeiaaeaaaaaeafaaapoaaeaaoekaaaaappia
abaaoeiaafaaaaadaaaaapiaaaaaffjaamaaoekaaeaaaaaeaaaaapiaalaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaaoaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefclaaeaaaaeaaaabaa
cmabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaiaaaaaakgiocaaa
aaaaaaaaaiaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaacaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaa
pgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaaeaaaaaa
egiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaafaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpccabaaaagaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaa
egaobaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
aaklklkl"
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
Vector 15 [_Control_ST]
Vector 16 [_Splat0_ST]
Vector 17 [_Splat1_ST]
Vector 18 [_Splat2_ST]
Vector 19 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[20] = { program.local[0],
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[5].z, R0, c[11];
DP4 result.texcoord[5].y, R0, c[10];
DP4 result.texcoord[5].x, R0, c[9];
DP3 result.texcoord[3].z, R1, c[7];
DP3 result.texcoord[3].y, R1, c[6];
DP3 result.texcoord[3].x, R1, c[5];
ADD result.texcoord[4].xyz, -R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[19], c[19].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
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
Vector 14 [_Control_ST]
Vector 15 [_Splat0_ST]
Vector 16 [_Splat1_ST]
Vector 17 [_Splat2_ST]
Vector 18 [_Splat3_ST]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c13.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT5.z, r0, c10
dp4 oT5.y, r0, c9
dp4 oT5.x, r0, c8
dp3 oT3.z, r1, c6
dp3 oT3.y, r1, c5
dp3 oT3.x, r1, c4
add oT4.xyz, -r0, c12
mad oT0.zw, v2.xyxy, c15.xyxy, c15
mad oT0.xy, v2, c14, c14.zwzw
mad oT1.zw, v2.xyxy, c17.xyxy, c17
mad oT1.xy, v2, c16, c16.zwzw
mad oT2.xy, v2, c18, c18.zwzw
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
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 112 [_Control_ST]
Vector 128 [_Splat0_ST]
Vector 144 [_Splat1_ST]
Vector 160 [_Splat2_ST]
Vector 176 [_Splat3_ST]
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
eefiecedfbofgjgpknhdkjdpbcieggopompmegdgabaaaaaahmagaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
aaklklklfdeieefclaaeaaaaeaaaabaacmabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagfaaaaadhccabaaaagaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaa
ogikcaaaaaaaaaaaahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaa
ajaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
akaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaalaaaaaaogikcaaaaaaaaaaaalaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
amaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaajhccabaaaafaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaa
abaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaagaaaaaaegiccaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 112 [_Control_ST]
Vector 128 [_Splat0_ST]
Vector 144 [_Splat1_ST]
Vector 160 [_Splat2_ST]
Vector 176 [_Splat3_ST]
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
eefiecedgjmcjpbfhgjkncehhefnodkodhoafmmnabaaaaaaceajaaaaaeaaaaaa
daaaaaaaneacaaaaimahaaaafeaiaaaaebgpgodjjmacaaaajmacaaaaaaacpopp
diacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
ajaaabaaaaaaaaaaabaaaaaaabaaakaaaaaaaaaaacaaaaaaaeaaalaaaaaaaaaa
acaaamaaaeaaapaaaaaaaaaaacaabeaaabaabdaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjaaeaaaaaeaaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoa
adaaeejaagaaeekaagaaoekaaeaaaaaeabaaadoaadaaoejaahaaoekaahaaooka
aeaaaaaeabaaamoaadaaeejaaiaaeekaaiaaoekaaeaaaaaeacaaadoaadaaoeja
ajaaoekaajaaookaafaaaaadaaaaahiaacaaoejabdaappkaafaaaaadabaaahia
aaaaffiabaaaoekaaeaaaaaeaaaaaliaapaakekaaaaaaaiaabaakeiaaeaaaaae
adaaahoabbaaoekaaaaakkiaaaaapeiaafaaaaadaaaaahiaaaaaffjabaaaoeka
aeaaaaaeaaaaahiaapaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabbaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaahiabcaaoekaaaaappjaaaaaoeiaacaaaaad
aeaaahoaaaaaoeibakaaoekaafaaaaadaaaaapiaaaaaffjabaaaoekaaeaaaaae
aaaaapiaapaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabbaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabcaaoekaaaaappjaaaaaoeiaafaaaaadabaaahia
aaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoekaaaaaaaiaabaaoeiaaeaaaaae
aaaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaaeafaaahoaaeaaoekaaaaappia
aaaaoeiaafaaaaadaaaaapiaaaaaffjaamaaoekaaeaaaaaeaaaaapiaalaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaaoaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefclaaeaaaaeaaaabaa
cmabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadhccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaaiaaaaaakgiocaaa
aaaaaaaaaiaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaacaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaa
pgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaaeaaaaaa
egiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaafaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
aaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaakhccabaaaagaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
aaklklkl"
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
Vector 15 [_Control_ST]
Vector 16 [_Splat0_ST]
Vector 17 [_Splat1_ST]
Vector 18 [_Splat2_ST]
Vector 19 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[20] = { program.local[0],
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 result.texcoord[5].y, R0, c[10];
DP4 result.texcoord[5].x, R0, c[9];
DP3 result.texcoord[3].z, R1, c[7];
DP3 result.texcoord[3].y, R1, c[6];
DP3 result.texcoord[3].x, R1, c[5];
MOV result.texcoord[4].xyz, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[19], c[19].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
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
Vector 14 [_Control_ST]
Vector 15 [_Splat0_ST]
Vector 16 [_Splat1_ST]
Vector 17 [_Splat2_ST]
Vector 18 [_Splat3_ST]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c13.w
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 oT5.y, r0, c9
dp4 oT5.x, r0, c8
dp3 oT3.z, r1, c6
dp3 oT3.y, r1, c5
dp3 oT3.x, r1, c4
mov oT4.xyz, c12
mad oT0.zw, v2.xyxy, c15.xyxy, c15
mad oT0.xy, v2, c14, c14.zwzw
mad oT1.zw, v2.xyxy, c17.xyxy, c17
mad oT1.xy, v2, c16, c16.zwzw
mad oT2.xy, v2, c18, c18.zwzw
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
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 112 [_Control_ST]
Vector 128 [_Splat0_ST]
Vector 144 [_Splat1_ST]
Vector 160 [_Splat2_ST]
Vector 176 [_Splat3_ST]
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
eefiecedenkgcnjnhjnplildmhiibhheemldjndpabaaaaaaniafaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
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
aaklklklfdeieefcamaeaaaaeaaaabaaadabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaa
ogikcaaaaaaaaaaaahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaa
ajaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
akaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaa
aaaaaaaaaeaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakmccabaaa
adaaaaaaagiecaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaagaebaaaaaaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaa
pgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaaeaaaaaa
egiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaag
hccabaaaafaaaaaaegiccaaaabaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 192
Matrix 48 [_LightMatrix0]
Vector 112 [_Control_ST]
Vector 128 [_Splat0_ST]
Vector 144 [_Splat1_ST]
Vector 160 [_Splat2_ST]
Vector 176 [_Splat3_ST]
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
eefieceddkfhjickpdfgjppfmfhinpieoodlgognabaaaaaadaaiaaaaaeaaaaaa
daaaaaaaieacaaaajiagaaaagaahaaaaebgpgodjemacaaaaemacaaaaaaacpopp
oiabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
ajaaabaaaaaaaaaaabaaaaaaabaaakaaaaaaaaaaacaaaaaaaeaaalaaaaaaaaaa
acaaamaaaeaaapaaaaaaaaaaacaabeaaabaabdaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjaaeaaaaaeaaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoa
adaaeejaagaaeekaagaaoekaaeaaaaaeabaaadoaadaaoejaahaaoekaahaaooka
aeaaaaaeabaaamoaadaaeejaaiaaeekaaiaaoekaaeaaaaaeacaaadoaadaaoeja
ajaaoekaajaaookaafaaaaadaaaaahiaacaaoejabdaappkaafaaaaadabaaahia
aaaaffiabaaaoekaaeaaaaaeaaaaaliaapaakekaaaaaaaiaabaakeiaaeaaaaae
adaaahoabbaaoekaaaaakkiaaaaapeiaafaaaaadaaaaapiaaaaaffjabaaaoeka
aeaaaaaeaaaaapiaapaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabbaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiabcaaoekaaaaappjaaaaaoeiaafaaaaad
abaaadiaaaaaffiaacaaobkaaeaaaaaeaaaaadiaabaaobkaaaaaaaiaabaaoeia
aeaaaaaeaaaaadiaadaaobkaaaaakkiaaaaaoeiaaeaaaaaeacaaamoaaeaabeka
aaaappiaaaaaeeiaafaaaaadaaaaapiaaaaaffjaamaaoekaaeaaaaaeaaaaapia
alaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaanaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaoaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaeaaahoaakaaoeka
ppppaaaafdeieefcamaeaaaaeaaaabaaadabaaaafjaaaaaeegiocaaaaaaaaaaa
amaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaa
ogikcaaaaaaaaaaaahaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaaiaaaaaakgiocaaaaaaaaaaaaiaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaajaaaaaaogikcaaaaaaaaaaa
ajaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
akaaaaaakgiocaaaaaaaaaaaakaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaa
aaaaaaaaaeaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakmccabaaa
adaaaaaaagiecaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaagaebaaaaaaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaalaaaaaa
ogikcaaaaaaaaaaaalaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaa
pgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaaeaaaaaa
egiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaag
hccabaaaafaaaaaaegiccaaaabaaaaaaaaaaaaaadoaaaaabejfdeheomaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
lmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaa
adaaaaaaamadaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightTexture0] 2D 5
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R4.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R3.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
DP3 R1.w, fragment.texcoord[5], fragment.texcoord[5];
MUL R2.xyz, R0.y, R2;
MUL R1.xyz, R0.x, R1;
ADD R1.xyz, R1, R2;
MUL R0.xyz, R0.z, R3;
ADD R0.xyz, R1, R0;
MUL R1.xyz, R0.w, R4;
DP3 R2.x, fragment.texcoord[4], fragment.texcoord[4];
RSQ R2.x, R2.x;
MUL R2.xyz, R2.x, fragment.texcoord[4];
ADD R0.xyz, R0, R1;
DP3 R0.w, fragment.texcoord[3], R2;
MUL R0.xyz, R0, c[0];
MAX R0.w, R0, c[1].x;
MOV result.color.w, c[1].x;
TEX R1.w, R1.w, texture[5], 2D;
MUL R0.w, R0, R1;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[1].y;
END
# 24 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightTexture0] 2D 5
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c1, 0.00000000, 2.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3.xyz
dcl t4.xyz
dcl t5.xyz
texld r4, t0, s0
dp3 r0.x, t5, t5
mov r0.xy, r0.x
mov r2.y, t0.w
mov r2.x, t0.z
mov r1.y, t1.w
mov r1.x, t1.z
texld r5, r0, s5
texld r3, r2, s1
texld r0, t2, s4
texld r2, t1, s2
texld r1, r1, s3
mul r1.xyz, r4.z, r1
mul r3.xyz, r4.x, r3
mul r2.xyz, r4.y, r2
add_pp r2.xyz, r3, r2
add_pp r2.xyz, r2, r1
mul r3.xyz, r4.w, r0
dp3_pp r1.x, t4, t4
rsq_pp r0.x, r1.x
mul_pp r0.xyz, r0.x, t4
dp3_pp r0.x, t3, r0
add_pp r1.xyz, r2, r3
mul_pp r1.xyz, r1, c0
max_pp r0.x, r0, c1
mul_pp r0.x, r0, r5
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c1.y
mov_pp r0.w, c1.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
SetTexture 0 [_Control] 2D 1
SetTexture 1 [_Splat0] 2D 2
SetTexture 2 [_Splat1] 2D 3
SetTexture 3 [_Splat2] 2D 4
SetTexture 4 [_Splat3] 2D 5
SetTexture 5 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmhdnnaocggmkaikgeemkhibicdmlabkmabaaaaaameaeaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcimadaaaaeaaaaaaaodaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaafgafbaaaacaaaaaadcaaaaaj
hcaabaaaaaaaaaaaagaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
aeaaaaaadcaaaaajhcaabaaaaaaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaa
aeaaaaaaaagabaaaafaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaa
abaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
pgapbaaaaaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" }
SetTexture 0 [_Control] 2D 1
SetTexture 1 [_Splat0] 2D 2
SetTexture 2 [_Splat1] 2D 3
SetTexture 3 [_Splat2] 2D 4
SetTexture 4 [_Splat3] 2D 5
SetTexture 5 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedpbpenmniidkojcimgecdgihacmijolpgabaaaaaaeiahaaaaaeaaaaaa
daaaaaaalaacaaaaeeagaaaabeahaaaaebgpgodjhiacaaaahiacaaaaaaacpppp
daacaaaaeiaaaaaaabaadmaaaaaaeiaaaaaaeiaaagaaceaaaaaaeiaaafaaaaaa
aaababaaabacacaaacadadaaadaeaeaaaeafafaaaaaaabaaabaaaaaaaaaaaaaa
aaacppppfbaaaaafabaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaadla
bpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaaia
afaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapka
bpaaaaacaaaaaajaafaiapkaabaaaaacaaaaabiaabaakklaabaaaaacaaaaacia
abaapplaabaaaaacabaaabiaaaaakklaabaaaaacabaaaciaaaaapplaaiaaaaad
acaaaiiaafaaoelaafaaoelaabaaaaacacaaadiaacaappiaecaaaaadaaaaapia
aaaaoeiaaeaioekaecaaaaadabaaapiaabaaoeiaacaioekaecaaaaadadaaapia
abaaoelaadaioekaecaaaaadaeaacpiaaaaaoelaabaioekaecaaaaadafaaapia
acaaoelaafaioekaecaaaaadacaacpiaacaaoeiaaaaioekaafaaaaadacaaaoia
adaabliaaeaaffiaaeaaaaaeabaachiaaeaaaaiaabaaoeiaacaabliaaeaaaaae
aaaachiaaeaakkiaaaaaoeiaabaaoeiaaeaaaaaeaaaachiaaeaappiaafaaoeia
aaaaoeiaafaaaaadaaaachiaaaaaoeiaaaaaoekaceaaaaacabaachiaaeaaoela
aiaaaaadaaaaciiaadaaoelaabaaoeiaafaaaaadabaacbiaacaaaaiaaaaappia
fiaaaaaeaaaaciiaaaaappiaabaaaaiaabaaaakaacaaaaadaaaaciiaaaaappia
aaaappiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaaaiiaabaaaaka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcimadaaaaeaaaaaaaodaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaafgafbaaaacaaaaaadcaaaaaj
hcaabaaaaaaaaaaaagaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
aeaaaaaadcaaaaajhcaabaaaaaaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaa
aeaaaaaaaagabaaaafaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
afaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaa
abaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
pgapbaaaaaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaabejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R4.xyz, fragment.texcoord[2], texture[4], 2D;
MUL R2.xyz, R0.y, R2;
MUL R3.xyz, R0.z, R3;
MUL R0.xyz, R0.x, R1;
ADD R0.xyz, R0, R2;
MUL R1.xyz, R0.w, R4;
ADD R0.xyz, R0, R3;
MOV R2.xyz, fragment.texcoord[4];
ADD R0.xyz, R0, R1;
DP3 R0.w, fragment.texcoord[3], R2;
MUL R0.xyz, R0, c[0];
MAX R0.w, R0, c[1].x;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[1].y;
MOV result.color.w, c[1].x;
END
# 19 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c1, 0.00000000, 2.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3.xyz
dcl t4.xyz
texld r3, t2, s4
texld r1, t0, s0
mov r0.y, t0.w
mov r0.x, t0.z
mov r2.xy, r0
mov r0.y, t1.w
mov r0.x, t1.z
texld r4, r0, s3
texld r0, t1, s2
texld r2, r2, s1
mul r2.xyz, r1.x, r2
mul r0.xyz, r1.y, r0
add_pp r0.xyz, r2, r0
mul r1.xyz, r1.z, r4
add_pp r0.xyz, r0, r1
mul r1.xyz, r1.w, r3
add_pp r1.xyz, r0, r1
mov_pp r2.xyz, t4
dp3_pp r0.x, t3, r2
mul_pp r1.xyz, r1, c0
max_pp r0.x, r0, c1
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c1.y
mov_pp r0.w, c1.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
BindCB  "$Globals" 0
"ps_4_0
eefieceddlbaimamghgdkbaclhpfmhgnnognfolmabaaaaaapiadaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcniacaaaa
eaaaaaaalgaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
dcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaafgafbaaaacaaaaaadcaaaaaj
hcaabaaaaaaaaaaaagaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadcaaaaajhcaabaaaaaaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
aeaaaaaaegbcbaaaafaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedpcjgmkmhgegjfjhiagbgcpfaenooenlhabaaaaaacaagaaaaaeaaaaaa
daaaaaaafeacaaaadeafaaaaomafaaaaebgpgodjbmacaaaabmacaaaaaaacpppp
niabaaaaeeaaaaaaabaadiaaaaaaeeaaaaaaeeaaafaaceaaaaaaeeaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaaaaaabaaabaaaaaaaaaaaaaaaaacpppp
fbaaaaafabaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaadlabpaaaaac
aaaaaaiaadaachlabpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaaja
adaiapkabpaaaaacaaaaaajaaeaiapkaabaaaaacaaaaabiaabaakklaabaaaaac
aaaaaciaabaapplaabaaaaacabaaabiaaaaakklaabaaaaacabaaaciaaaaappla
ecaaaaadaaaaapiaaaaaoeiaadaioekaecaaaaadabaaapiaabaaoeiaabaioeka
ecaaaaadacaaapiaabaaoelaacaioekaecaaaaadadaacpiaaaaaoelaaaaioeka
ecaaaaadaeaaapiaacaaoelaaeaioekaafaaaaadacaaahiaacaaoeiaadaaffia
aeaaaaaeabaachiaadaaaaiaabaaoeiaacaaoeiaaeaaaaaeaaaachiaadaakkia
aaaaoeiaabaaoeiaaeaaaaaeaaaachiaadaappiaaeaaoeiaaaaaoeiaafaaaaad
aaaachiaaaaaoeiaaaaaoekaabaaaaacabaaahiaadaaoelaaiaaaaadaaaaciia
abaaoeiaaeaaoelaalaaaaadabaacbiaaaaappiaabaaaakaacaaaaadaaaaciia
abaaaaiaabaaaaiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaaaiia
abaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcniacaaaaeaaaaaaa
lgaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
adaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaafgafbaaaacaaaaaadcaaaaajhcaabaaa
aaaaaaaaagaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaa
dcaaaaajhcaabaaaaaaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaacaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaaeaaaaaa
egbcbaaaafaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightTexture0] 2D 5
SetTexture 6 [_LightTextureB0] 2D 6
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 0, 0.5, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R2, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R3.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R4.xyz, fragment.texcoord[2], texture[4], 2D;
RCP R0.x, fragment.texcoord[5].w;
MAD R5.xy, fragment.texcoord[5], R0.x, c[1].y;
DP3 R1.w, fragment.texcoord[5], fragment.texcoord[5];
MUL R1.xyz, R2.y, R1;
MUL R3.xyz, R2.z, R3;
MOV result.color.w, c[1].x;
TEX R0.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R0.w, R5, texture[5], 2D;
TEX R1.w, R1.w, texture[6], 2D;
MUL R0.xyz, R2.x, R0;
ADD R0.xyz, R0, R1;
DP3 R2.x, fragment.texcoord[4], fragment.texcoord[4];
ADD R0.xyz, R0, R3;
MUL R1.xyz, R2.w, R4;
ADD R1.xyz, R0, R1;
RSQ R2.x, R2.x;
MUL R0.xyz, R2.x, fragment.texcoord[4];
DP3 R0.x, fragment.texcoord[3], R0;
SLT R0.y, c[1].x, fragment.texcoord[5].z;
MUL R0.y, R0, R0.w;
MUL R0.y, R0, R1.w;
MAX R0.x, R0, c[1];
MUL R1.xyz, R1, c[0];
MUL R0.x, R0, R0.y;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[1].z;
END
# 30 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightTexture0] 2D 5
SetTexture 6 [_LightTextureB0] 2D 6
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c1, 0.50000000, 0.00000000, 1.00000000, 2.00000000
dcl t0
dcl t1
dcl t2.xy
dcl t3.xyz
dcl t4.xyz
dcl t5
dp3 r3.x, t5, t5
mov r3.xy, r3.x
rcp r2.x, t5.w
mad r2.xy, t5, r2.x, c1.x
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.y, t1.w
mov r1.x, t1.z
texld r5, r3, s6
texld r6, r2, s5
texld r4, r1, s3
texld r2, r0, s1
texld r0, t1, s2
texld r3, t2, s4
texld r1, t0, s0
mul r2.xyz, r1.x, r2
mul r0.xyz, r1.y, r0
mul r1.xyz, r1.z, r4
add_pp r0.xyz, r2, r0
add_pp r0.xyz, r0, r1
mul r2.xyz, r1.w, r3
add_pp r0.xyz, r0, r2
mul_pp r2.xyz, r0, c0
dp3_pp r0.x, t4, t4
rsq_pp r1.x, r0.x
mul_pp r1.xyz, r1.x, t4
dp3_pp r1.x, t3, r1
cmp r0.x, -t5.z, c1.y, c1.z
mul_pp r0.x, r0, r6.w
mul_pp r0.x, r0, r5
max_pp r1.x, r1, c1.y
mul_pp r0.x, r1, r0
mul_pp r0.xyz, r0.x, r2
mul_pp r0.xyz, r0, c1.w
mov_pp r0.w, c1.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
SetTexture 0 [_Control] 2D 2
SetTexture 1 [_Splat0] 2D 3
SetTexture 2 [_Splat1] 2D 4
SetTexture 3 [_Splat2] 2D 5
SetTexture 4 [_Splat3] 2D 6
SetTexture 5 [_LightTexture0] 2D 0
SetTexture 6 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbpibibdgfjngblmdhlofcglobjmkbfneabaaaaaaliafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefciaaeaaaaeaaaaaaacaabaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaa
ffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadpcbabaaaagaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
agaaaaaapgbpbaaaagaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaadbaaaaahbcaabaaa
aaaaaaaaabeaaaaaaaaaaaaackbabaaaagaaaaaaabaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaagaaaaaa
egbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaa
agaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahocaabaaa
aaaaaaaafgafbaaaaaaaaaaaagbjbaaaafaaaaaabaaaaaahccaabaaaaaaaaaaa
egbcbaaaaeaaaaaajgahbaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaafgafbaaaaaaaaaaa
agaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahocaabaaaaaaaaaaa
agajbaaaacaaaaaafgafbaaaadaaaaaadcaaaaajocaabaaaaaaaaaaaagaabaaa
adaaaaaaagajbaaaabaaaaaafgaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaafaaaaaadcaaaaajocaabaaa
aaaaaaaakgakbaaaadaaaaaaagajbaaaabaaaaaafgaobaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaaagaaaaaa
dcaaaaajocaabaaaaaaaaaaapgapbaaaadaaaaaaagajbaaaabaaaaaafgaobaaa
aaaaaaaadiaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaaagijcaaaaaaaaaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" }
SetTexture 0 [_Control] 2D 2
SetTexture 1 [_Splat0] 2D 3
SetTexture 2 [_Splat1] 2D 4
SetTexture 3 [_Splat2] 2D 5
SetTexture 4 [_Splat3] 2D 6
SetTexture 5 [_LightTexture0] 2D 0
SetTexture 6 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedplldaahhdmilchpphfnejihmigbnfehoabaaaaaajmaiaaaaaeaaaaaa
daaaaaaabaadaaaajiahaaaagiaiaaaaebgpgodjniacaaaaniacaaaaaaacpppp
imacaaaaemaaaaaaabaaeaaaaaaaemaaaaaaemaaahaaceaaaaaaemaaafaaaaaa
agababaaaaacacaaabadadaaacaeaeaaadafafaaaeagagaaaaaaabaaabaaaaaa
aaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaia
acaaadlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaachlabpaaaaac
aaaaaaiaafaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaaja
aeaiapkabpaaaaacaaaaaajaafaiapkabpaaaaacaaaaaajaagaiapkaagaaaaac
aaaaaiiaafaapplaaeaaaaaeaaaaadiaafaaoelaaaaappiaabaaaakaaiaaaaad
abaaaiiaafaaoelaafaaoelaabaaaaacabaaadiaabaappiaabaaaaacacaaabia
abaakklaabaaaaacacaaaciaabaapplaabaaaaacadaaabiaaaaakklaabaaaaac
adaaaciaaaaapplaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaadabaacpia
abaaoeiaabaioekaecaaaaadacaaapiaacaaoeiaafaioekaecaaaaadadaaapia
adaaoeiaadaioekaecaaaaadaeaaapiaabaaoelaaeaioekaecaaaaadafaacpia
aaaaoelaacaioekaecaaaaadagaaapiaacaaoelaagaioekaafaaaaadacaaciia
aaaappiaabaaaaiafiaaaaaeacaaciiaafaakklbabaaffkaacaappiaceaaaaac
aaaachiaaeaaoelaaiaaaaadadaaciiaadaaoelaaaaaoeiaalaaaaadaeaaciia
adaappiaabaaffkaafaaaaadacaaciiaacaappiaaeaappiaacaaaaadacaaciia
acaappiaacaappiaafaaaaadaaaaahiaaeaaoeiaafaaffiaaeaaaaaeaaaachia
afaaaaiaadaaoeiaaaaaoeiaaeaaaaaeaaaachiaafaakkiaacaaoeiaaaaaoeia
aeaaaaaeaaaachiaafaappiaagaaoeiaaaaaoeiaafaaaaadaaaachiaaaaaoeia
aaaaoekaafaaaaadaaaachiaacaappiaaaaaoeiaabaaaaacaaaaaiiaabaaffka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefciaaeaaaaeaaaaaaacaabaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaa
ffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadpcbabaaaagaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
agaaaaaapgbpbaaaagaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaadbaaaaahbcaabaaa
aaaaaaaaabeaaaaaaaaaaaaackbabaaaagaaaaaaabaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaagaaaaaa
egbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaa
agaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaafaaaaaaegbcbaaa
afaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahocaabaaa
aaaaaaaafgafbaaaaaaaaaaaagbjbaaaafaaaaaabaaaaaahccaabaaaaaaaaaaa
egbcbaaaaeaaaaaajgahbaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaafgafbaaaaaaaaaaa
agaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaahocaabaaaaaaaaaaa
agajbaaaacaaaaaafgafbaaaadaaaaaadcaaaaajocaabaaaaaaaaaaaagaabaaa
adaaaaaaagajbaaaabaaaaaafgaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaafaaaaaadcaaaaajocaabaaa
aaaaaaaakgakbaaaadaaaaaaagajbaaaabaaaaaafgaobaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaaagaaaaaa
dcaaaaajocaabaaaaaaaaaaapgapbaaaadaaaaaaagajbaaaabaaaaaafgaobaaa
aaaaaaaadiaaaaaiocaabaaaaaaaaaaafgaobaaaaaaaaaaaagijcaaaaaaaaaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadadaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaagaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightTextureB0] 2D 5
SetTexture 6 [_LightTexture0] CUBE 6
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R2, fragment.texcoord[0], texture[0], 2D;
TEX R0.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R1.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R3.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R4.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R1.w, fragment.texcoord[5], texture[6], CUBE;
MUL R0.xyz, R2.x, R0;
MUL R1.xyz, R2.y, R1;
ADD R0.xyz, R0, R1;
DP3 R0.w, fragment.texcoord[5], fragment.texcoord[5];
MUL R3.xyz, R2.z, R3;
DP3 R2.x, fragment.texcoord[4], fragment.texcoord[4];
ADD R0.xyz, R0, R3;
MUL R1.xyz, R2.w, R4;
ADD R1.xyz, R0, R1;
RSQ R2.x, R2.x;
MUL R0.xyz, R2.x, fragment.texcoord[4];
DP3 R0.x, fragment.texcoord[3], R0;
MUL R1.xyz, R1, c[0];
MAX R0.x, R0, c[1];
MOV result.color.w, c[1].x;
TEX R0.w, R0.w, texture[5], 2D;
MUL R0.y, R0.w, R1.w;
MUL R0.x, R0, R0.y;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[1].y;
END
# 26 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightTextureB0] 2D 5
SetTexture 6 [_LightTexture0] CUBE 6
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_cube s6
def c1, 0.00000000, 2.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3.xyz
dcl t4.xyz
dcl t5.xyz
texld r5, t5, s6
texld r3, t2, s4
dp3 r2.x, t5, t5
mov r2.xy, r2.x
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.y, t1.w
mov r1.x, t1.z
texld r6, r2, s5
texld r4, r1, s3
texld r2, r0, s1
texld r0, t1, s2
texld r1, t0, s0
mul r2.xyz, r1.x, r2
mul r0.xyz, r1.y, r0
add_pp r0.xyz, r2, r0
mul r1.xyz, r1.z, r4
add_pp r0.xyz, r0, r1
mul r2.xyz, r1.w, r3
add_pp r1.xyz, r0, r2
dp3_pp r0.x, t4, t4
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, t4
dp3_pp r0.x, t3, r0
mul_pp r1.xyz, r1, c0
mul r2.x, r6, r5.w
max_pp r0.x, r0, c1
mul_pp r0.x, r0, r2
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c1.y
mov_pp r0.w, c1.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_Control] 2D 2
SetTexture 1 [_Splat0] 2D 3
SetTexture 2 [_Splat1] 2D 4
SetTexture 3 [_Splat2] 2D 5
SetTexture 4 [_Splat3] 2D 6
SetTexture 5 [_LightTextureB0] 2D 1
SetTexture 6 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjfnpmpnckjgnolaohpfcbaakdokgcaoaabaaaaaacaafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiadaaaaeaaaaaaapkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaa
ffffaaaafidaaaaeaahabaaaagaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaadhcbabaaaagaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaafgafbaaaacaaaaaadcaaaaajhcaabaaa
aaaaaaaaagaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaafaaaaaa
dcaaaaajhcaabaaaaaaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaa
aagabaaaagaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaacaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaafaaaaaa
egbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaafaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
agaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaa
eghobaaaafaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaa
agaaaaaaeghobaaaagaaaaaaaagabaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaadkaabaaaacaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_Control] 2D 2
SetTexture 1 [_Splat0] 2D 3
SetTexture 2 [_Splat1] 2D 4
SetTexture 3 [_Splat2] 2D 5
SetTexture 4 [_Splat3] 2D 6
SetTexture 5 [_LightTextureB0] 2D 1
SetTexture 6 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedjocobklhjjndblfaieoiibbpmladgknjabaaaaaanaahaaaaaeaaaaaa
daaaaaaanmacaaaammagaaaajmahaaaaebgpgodjkeacaaaakeacaaaaaaacpppp
fiacaaaaemaaaaaaabaaeaaaaaaaemaaaaaaemaaahaaceaaaaaaemaaagaaaaaa
afababaaaaacacaaabadadaaacaeaeaaadafafaaaeagagaaaaaaabaaabaaaaaa
aaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaia
acaaadlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaachlabpaaaaac
aaaaaaiaafaaahlabpaaaaacaaaaaajiaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaaja
aeaiapkabpaaaaacaaaaaajaafaiapkabpaaaaacaaaaaajaagaiapkaabaaaaac
aaaaabiaabaakklaabaaaaacaaaaaciaabaapplaabaaaaacabaaabiaaaaakkla
abaaaaacabaaaciaaaaapplaaiaaaaadacaaaiiaafaaoelaafaaoelaabaaaaac
acaaadiaacaappiaecaaaaadaaaaapiaaaaaoeiaafaioekaecaaaaadabaaapia
abaaoeiaadaioekaecaaaaadadaaapiaabaaoelaaeaioekaecaaaaadaeaacpia
aaaaoelaacaioekaecaaaaadafaaapiaacaaoelaagaioekaecaaaaadacaaapia
acaaoeiaabaioekaecaaaaadagaaapiaafaaoelaaaaioekaafaaaaadacaaaoia
adaabliaaeaaffiaaeaaaaaeabaachiaaeaaaaiaabaaoeiaacaabliaaeaaaaae
aaaachiaaeaakkiaaaaaoeiaabaaoeiaaeaaaaaeaaaachiaaeaappiaafaaoeia
aaaaoeiaafaaaaadaaaachiaaaaaoeiaaaaaoekaafaaaaadaaaaciiaacaaaaia
agaappiaceaaaaacabaachiaaeaaoelaaiaaaaadabaacbiaadaaoelaabaaoeia
alaaaaadacaacbiaabaaaaiaabaaaakaafaaaaadaaaaciiaaaaappiaacaaaaia
acaaaaadaaaaciiaaaaappiaaaaappiaafaaaaadaaaachiaaaaappiaaaaaoeia
abaaaaacaaaaaiiaabaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
oiadaaaaeaaaaaaapkaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaa
afaaaaaafkaaaaadaagabaaaagaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaa
fibiaaaeaahabaaaafaaaaaaffffaaaafidaaaaeaahabaaaagaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaa
adaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagcbaaaad
hcbabaaaagaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
aeaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaafgafbaaa
acaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaa
adaaaaaaaagabaaaafaaaaaadcaaaaajhcaabaaaaaaaaaaakgakbaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaaeaaaaaaaagabaaaagaaaaaadcaaaaajhcaabaaaaaaaaaaa
pgapbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaafaaaaaaegbcbaaaafaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaa
afaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaaeaaaaaaegacbaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaagaaaaaaegbcbaaaagaaaaaaefaaaaajpcaabaaa
abaaaaaaagaabaaaabaaaaaaeghobaaaafaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbcbaaaagaaaaaaeghobaaaagaaaaaaaagabaaaaaaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaaacaaaaaaapaaaaah
icaabaaaaaaaaaaapgapbaaaaaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaabejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaagaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightTexture0] 2D 5
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R3.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R4.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R1.w, fragment.texcoord[5], texture[5], 2D;
MUL R2.xyz, R0.y, R2;
MUL R3.xyz, R0.z, R3;
MUL R0.xyz, R0.x, R1;
ADD R0.xyz, R0, R2;
MUL R1.xyz, R0.w, R4;
ADD R0.xyz, R0, R3;
MOV R2.xyz, fragment.texcoord[4];
ADD R0.xyz, R0, R1;
DP3 R0.w, fragment.texcoord[3], R2;
MAX R0.w, R0, c[1].x;
MUL R0.xyz, R0, c[0];
MUL R0.w, R0, R1;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[1].y;
MOV result.color.w, c[1].x;
END
# 21 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightTexture0] 2D 5
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c1, 0.00000000, 2.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3.xyz
dcl t4.xyz
dcl t5.xy
texld r5, t5, s5
texld r3, t2, s4
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.y, t1.w
mov r1.x, t1.z
texld r4, r1, s3
texld r2, r0, s1
texld r0, t1, s2
texld r1, t0, s0
mul r2.xyz, r1.x, r2
mul r0.xyz, r1.y, r0
add_pp r0.xyz, r2, r0
mul r1.xyz, r1.z, r4
add_pp r0.xyz, r0, r1
mul r2.xyz, r1.w, r3
add_pp r1.xyz, r0, r2
mov_pp r0.xyz, t4
dp3_pp r0.x, t3, r0
max_pp r0.x, r0, c1
mul_pp r1.xyz, r1, c0
mul_pp r0.x, r0, r5.w
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c1.y
mov_pp r0.w, c1.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_Control] 2D 1
SetTexture 1 [_Splat0] 2D 2
SetTexture 2 [_Splat1] 2D 3
SetTexture 3 [_Splat2] 2D 4
SetTexture 4 [_Splat3] 2D 5
SetTexture 5 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmochginmkfkiipfkjapllhcjdchpgffbabaaaaaafmaeaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcceadaaaaeaaaaaaamjaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
mcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaafgafbaaaacaaaaaadcaaaaaj
hcaabaaaaaaaaaaaagaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
aeaaaaaadcaaaaajhcaabaaaaaaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaa
aeaaaaaaaagabaaaafaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaa
aeaaaaaaegbcbaaaafaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaa
afaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaaaaaaaaaa
pgapbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_Control] 2D 1
SetTexture 1 [_Splat0] 2D 2
SetTexture 2 [_Splat1] 2D 3
SetTexture 3 [_Splat2] 2D 4
SetTexture 4 [_Splat3] 2D 5
SetTexture 5 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 192
Vector 16 [_LightColor0]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedageianhcdbceimclpcchiiehjhjapehlabaaaaaameagaaaaaeaaaaaa
daaaaaaajeacaaaamaafaaaajaagaaaaebgpgodjfmacaaaafmacaaaaaaacpppp
beacaaaaeiaaaaaaabaadmaaaaaaeiaaaaaaeiaaagaaceaaaaaaeiaaafaaaaaa
aaababaaabacacaaacadadaaadaeaeaaaeafafaaaaaaabaaabaaaaaaaaaaaaaa
aaacppppfbaaaaafabaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaapla
bpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaachlabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaac
aaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkabpaaaaacaaaaaajaafaiapka
abaaaaacaaaaabiaabaakklaabaaaaacaaaaaciaabaapplaabaaaaacabaaabia
aaaakklaabaaaaacabaaaciaaaaapplaabaaaaacacaaadiaacaabllaecaaaaad
aaaaapiaaaaaoeiaaeaioekaecaaaaadabaaapiaabaaoeiaacaioekaecaaaaad
adaaapiaabaaoelaadaioekaecaaaaadaeaacpiaaaaaoelaabaioekaecaaaaad
afaaapiaacaaoelaafaioekaecaaaaadacaacpiaacaaoeiaaaaioekaafaaaaad
acaaahiaadaaoeiaaeaaffiaaeaaaaaeabaachiaaeaaaaiaabaaoeiaacaaoeia
aeaaaaaeaaaachiaaeaakkiaaaaaoeiaabaaoeiaaeaaaaaeaaaachiaaeaappia
afaaoeiaaaaaoeiaafaaaaadaaaachiaaaaaoeiaaaaaoekaabaaaaacabaaahia
adaaoelaaiaaaaadaaaaciiaabaaoeiaaeaaoelaafaaaaadabaacbiaacaappia
aaaappiafiaaaaaeaaaaciiaaaaappiaabaaaaiaabaaaakaacaaaaadaaaaciia
aaaappiaaaaappiaafaaaaadaaaachiaaaaappiaaaaaoeiaabaaaaacaaaaaiia
abaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcceadaaaaeaaaaaaa
mjaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
adaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaadmcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaafgafbaaaacaaaaaa
dcaaaaajhcaabaaaaaaaaaaaagaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaa
aagabaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaakgakbaaaacaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaa
eghobaaaaeaaaaaaaagabaaaafaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegbcbaaaafaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaa
eghobaaaafaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaa
aaaaaaaapgapbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
ejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
lmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaalmaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaa
adaaaaaaamamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaa
lmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "QUEUE"="Geometry-99" "IGNOREPROJECTOR"="true" "RenderType"="Opaque" "SplatCount"="4" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
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
Vector 18 [_Control_ST]
Vector 19 [_Splat0_ST]
Vector 20 [_Splat1_ST]
Vector 21 [_Splat2_ST]
Vector 22 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[23] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..22] };
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
ADD result.texcoord[4].xyz, R3, R2;
ADD result.texcoord[3].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[3].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[22], c[22].zwzw;
END
# 32 instructions, 4 R-regs
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
Vector 18 [_Control_ST]
Vector 19 [_Splat0_ST]
Vector 20 [_Splat1_ST]
Vector 21 [_Splat2_ST]
Vector 22 [_Splat3_ST]
"vs_2_0
def c23, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c17.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c23.y
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
mul r0.xyz, r1.xyww, c23.x
mul r0.y, r0, c8.x
add oT4.xyz, r3, r2
mad oT3.xy, r0.z, c9.zwzw, r0
mov oPos, r1
mov oT3.zw, r1
mad oT0.zw, v2.xyxy, c19.xyxy, c19
mad oT0.xy, v2, c18, c18.zwzw
mad oT1.zw, v2.xyxy, c21.xyxy, c21
mad oT1.xy, v2, c20, c20.zwzw
mad oT2.xy, v2, c22, c22.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Vector 48 [_Control_ST]
Vector 64 [_Splat0_ST]
Vector 80 [_Splat1_ST]
Vector 96 [_Splat2_ST]
Vector 112 [_Splat3_ST]
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
eefiecedmieojikjgebnagllfmojcpplfmkhloahabaaaaaaiaagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcmmaeaaaaeaaaabaaddabaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaadaaaaaa
ogikcaaaaaaaaaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
agaaaaaakgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
aeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
abaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaa
abaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaa
abaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaafaaaaaa
egiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Vector 48 [_Control_ST]
Vector 64 [_Splat0_ST]
Vector 80 [_Splat1_ST]
Vector 96 [_Splat2_ST]
Vector 112 [_Splat3_ST]
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
eefiecedffendiafoankfcibcggjccodnommcakaabaaaaaagiajaaaaaeaaaaaa
daaaaaaabeadaaaaoiahaaaalaaiaaaaebgpgodjnmacaaaanmacaaaaaaacpopp
gmacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
afaaabaaaaaaaaaaabaaafaaabaaagaaaaaaaaaaacaacgaaahaaahaaaaaaaaaa
adaaaaaaaeaaaoaaaaaaaaaaadaaamaaadaabcaaaaaaaaaaadaabeaaabaabfaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbgaaapkaaaaaaadpaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaae
aaaaamoaadaaeejaacaaeekaacaaoekaaeaaaaaeabaaadoaadaaoejaadaaoeka
adaaookaaeaaaaaeabaaamoaadaaeejaaeaaeekaaeaaoekaaeaaaaaeacaaadoa
adaaoejaafaaoekaafaaookaafaaaaadaaaaapiaaaaaffjaapaaoekaaeaaaaae
aaaaapiaaoaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabbaaoekaaaaappjaaaaaoeiaafaaaaadabaaabia
aaaaffiaagaaaakaafaaaaadabaaaiiaabaaaaiabgaaaakaafaaaaadabaaafia
aaaapeiabgaaaakaacaaaaadadaaadoaabaakkiaabaaomiaafaaaaadabaaahia
acaaoejabfaappkaafaaaaadacaaahiaabaaffiabdaaoekaaeaaaaaeabaaalia
bcaakekaabaaaaiaacaakeiaaeaaaaaeabaaahiabeaaoekaabaakkiaabaapeia
abaaaaacabaaaiiabgaaffkaajaaaaadacaaabiaahaaoekaabaaoeiaajaaaaad
acaaaciaaiaaoekaabaaoeiaajaaaaadacaaaeiaajaaoekaabaaoeiaafaaaaad
adaaapiaabaacjiaabaakeiaajaaaaadaeaaabiaakaaoekaadaaoeiaajaaaaad
aeaaaciaalaaoekaadaaoeiaajaaaaadaeaaaeiaamaaoekaadaaoeiaacaaaaad
acaaahiaacaaoeiaaeaaoeiaafaaaaadabaaaciaabaaffiaabaaffiaaeaaaaae
abaaabiaabaaaaiaabaaaaiaabaaffibaeaaaaaeaeaaahoaanaaoekaabaaaaia
acaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacadaaamoaaaaaoeiappppaaaafdeieefcmmaeaaaaeaaaabaa
ddabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaa
ogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaa
adaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaa
ahaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaai
bcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaai
ecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaak
hccabaaaafaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaa
keaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
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
Vector 16 [_Control_ST]
Vector 17 [_Splat0_ST]
Vector 18 [_Splat1_ST]
Vector 19 [_Splat2_ST]
Vector 20 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[21] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..20] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[3].zw, R0;
MUL result.texcoord[5].xyz, R1, c[14].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[5].w, -R0.x, R0.y;
END
# 24 instructions, 2 R-regs
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
Vector 16 [_Control_ST]
Vector 17 [_Splat0_ST]
Vector 18 [_Splat1_ST]
Vector 19 [_Splat2_ST]
Vector 20 [_Splat3_ST]
"vs_2_0
def c21, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c21.x
mul r1.y, r1, c12.x
mad oT3.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov r0.x, c14.w
add r0.y, c21, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov oT3.zw, r0
mul oT5.xyz, r1, c14.w
mad oT0.zw, v1.xyxy, c17.xyxy, c17
mad oT0.xy, v1, c16, c16.zwzw
mad oT1.zw, v1.xyxy, c19.xyxy, c19
mad oT1.xy, v1, c18, c18.zwzw
mad oT2.xy, v1, c20, c20.zwzw
mad oT4.xy, v2, c15, c15.zwzw
mul oT5.w, -r0.x, r0.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 176
Vector 48 [unity_LightmapST]
Vector 64 [_Control_ST]
Vector 80 [_Splat0_ST]
Vector 96 [_Splat1_ST]
Vector 112 [_Splat2_ST]
Vector 128 [_Splat3_ST]
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
eefiecedbhpjeijcgmclciehdohlnpcidgpigkfbabaaaaaaiaagaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcleaeaaaaeaaaabaacnabaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
bkaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
aeaaaaaaogikcaaaaaaaaaaaaeaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadcaaaaal
dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaa
aaaaaaaaagaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadcaaaaaldccabaaaadaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaa
dcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaadaaaaaa
kgiocaaaaaaaaaaaadaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaa
diaaaaaihccabaaaafaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaa
aaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaai
iccabaaaafaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 176
Vector 48 [unity_LightmapST]
Vector 64 [_Control_ST]
Vector 80 [_Splat0_ST]
Vector 96 [_Splat1_ST]
Vector 112 [_Splat2_ST]
Vector 128 [_Splat3_ST]
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
eefiecedhhcgkondimbgpgpgbehdaiibadponmghabaaaaaaeiajaaaaaeaaaaaa
daaaaaaapeacaaaalaahaaaahiaiaaaaebgpgodjlmacaaaalmacaaaaaaacpopp
fiacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
agaaabaaaaaaaaaaabaaafaaabaaahaaaaaaaaaaacaabjaaabaaaiaaaaaaaaaa
adaaaaaaaiaaajaaaaaaaaaaadaaamaaaeaabbaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbfaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaae
aaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeejaadaaeeka
adaaoekaaeaaaaaeabaaadoaadaaoejaaeaaoekaaeaaookaaeaaaaaeabaaamoa
adaaeejaafaaeekaafaaoekaaeaaaaaeacaaadoaadaaoejaagaaoekaagaaooka
afaaaaadaaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapiaajaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
amaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaahaaaakaafaaaaad
abaaaiiaabaaaaiabfaaaakaafaaaaadabaaafiaaaaapeiabfaaaakaacaaaaad
adaaadoaabaakkiaabaaomiaaeaaaaaeacaaamoaaeaabejaabaabekaabaaleka
afaaaaadabaaahiaaaaaffjabcaaoekaaeaaaaaeabaaahiabbaaoekaaaaaaaja
abaaoeiaaeaaaaaeabaaahiabdaaoekaaaaakkjaabaaoeiaaeaaaaaeabaaahia
beaaoekaaaaappjaabaaoeiaacaaaaadabaaahiaabaaoeiaaiaaoekbafaaaaad
aeaaahoaabaaoeiaaiaappkaafaaaaadabaaabiaaaaaffjaaoaakkkaaeaaaaae
abaaabiaanaakkkaaaaaaajaabaaaaiaaeaaaaaeabaaabiaapaakkkaaaaakkja
abaaaaiaaeaaaaaeabaaabiabaaakkkaaaaappjaabaaaaiaabaaaaacabaaaiia
aiaappkaacaaaaadabaaaciaabaappibbfaaffkaafaaaaadaeaaaioaabaaffia
abaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacadaaamoaaaaaoeiappppaaaafdeieefcleaeaaaaeaaaabaa
cnabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaafaaaaaa
kgiocaaaaaaaaaaaafaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaa
acaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaa
ahaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
aiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaadaaaaaaagbebaaa
aeaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
aeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaa
aaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaa
bjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaafaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadamaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaa
lmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 5 [_ProjectionParams]
Vector 6 [unity_LightmapST]
Vector 7 [_Control_ST]
Vector 8 [_Splat0_ST]
Vector 9 [_Splat1_ST]
Vector 10 [_Splat2_ST]
Vector 11 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[12] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..11] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[5].x;
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[8].xyxy, c[8];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[7], c[7].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[10].xyxy, c[10];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[9], c[9].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[6], c[6].zwzw;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ProjectionParams]
Vector 5 [_ScreenParams]
Vector 6 [unity_LightmapST]
Vector 7 [_Control_ST]
Vector 8 [_Splat0_ST]
Vector 9 [_Splat1_ST]
Vector 10 [_Splat2_ST]
Vector 11 [_Splat3_ST]
"vs_2_0
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c4.x
mad oT3.xy, r1.z, c5.zwzw, r1
mov oPos, r0
mov oT3.zw, r0
mad oT0.zw, v1.xyxy, c8.xyxy, c8
mad oT0.xy, v1, c7, c7.zwzw
mad oT1.zw, v1.xyxy, c10.xyxy, c10
mad oT1.xy, v1, c9, c9.zwzw
mad oT2.xy, v1, c11, c11.zwzw
mad oT4.xy, v2, c6, c6.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 176
Vector 48 [unity_LightmapST]
Vector 64 [_Control_ST]
Vector 80 [_Splat0_ST]
Vector 96 [_Splat1_ST]
Vector 112 [_Splat2_ST]
Vector 128 [_Splat3_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedfdneblifmmplbkjioelaholbngdppojaabaaaaaajeaeaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcoaacaaaaeaaaabaaliaaaaaafjaaaaae
egiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaafaaaaaakgiocaaa
aaaaaaaaafaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaacaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaa
ogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaa
agiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 176
Vector 48 [unity_LightmapST]
Vector 64 [_Control_ST]
Vector 80 [_Splat0_ST]
Vector 96 [_Splat1_ST]
Vector 112 [_Splat2_ST]
Vector 128 [_Splat3_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecediihcbcpecnbecceojmbjnkamdgghcjlkabaaaaaagaagaaaaaeaaaaaa
daaaaaaapiabaaaaoaaeaaaakiafaaaaebgpgodjmaabaaaamaabaaaaaaacpopp
heabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaadaa
agaaabaaaaaaaaaaabaaafaaabaaahaaaaaaaaaaacaaaaaaaeaaaiaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafamaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeia
aeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoa
adaaeejaadaaeekaadaaoekaaeaaaaaeabaaadoaadaaoejaaeaaoekaaeaaooka
aeaaaaaeabaaamoaadaaeejaafaaeekaafaaoekaaeaaaaaeacaaadoaadaaoeja
agaaoekaagaaookaafaaaaadaaaaapiaaaaaffjaajaaoekaaeaaaaaeaaaaapia
aiaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaakaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaalaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffia
ahaaaakaafaaaaadabaaaiiaabaaaaiaamaaaakaafaaaaadabaaafiaaaaapeia
amaaaakaacaaaaadadaaadoaabaakkiaabaaomiaaeaaaaaeacaaamoaaeaabeja
abaabekaabaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacadaaamoaaaaaoeiappppaaaafdeieefcoaacaaaa
eaaaabaaliaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaa
kgiocaaaaaaaaaaaahaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaa
adaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaa
adaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaadaaaaaaamadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
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
Vector 18 [_Control_ST]
Vector 19 [_Splat0_ST]
Vector 20 [_Splat1_ST]
Vector 21 [_Splat2_ST]
Vector 22 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[23] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..22] };
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
ADD result.texcoord[4].xyz, R3, R2;
ADD result.texcoord[3].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[3].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[22], c[22].zwzw;
END
# 32 instructions, 4 R-regs
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
Vector 18 [_Control_ST]
Vector 19 [_Splat0_ST]
Vector 20 [_Splat1_ST]
Vector 21 [_Splat2_ST]
Vector 22 [_Splat3_ST]
"vs_2_0
def c23, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c17.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c23.y
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
mul r0.xyz, r1.xyww, c23.x
mul r0.y, r0, c8.x
add oT4.xyz, r3, r2
mad oT3.xy, r0.z, c9.zwzw, r0
mov oPos, r1
mov oT3.zw, r1
mad oT0.zw, v2.xyxy, c19.xyxy, c19
mad oT0.xy, v2, c18, c18.zwzw
mad oT1.zw, v2.xyxy, c21.xyxy, c21
mad oT1.xy, v2, c20, c20.zwzw
mad oT2.xy, v2, c22, c22.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Vector 48 [_Control_ST]
Vector 64 [_Splat0_ST]
Vector 80 [_Splat1_ST]
Vector 96 [_Splat2_ST]
Vector 112 [_Splat3_ST]
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
eefiecedmieojikjgebnagllfmojcpplfmkhloahabaaaaaaiaagaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcmmaeaaaaeaaaabaaddabaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
gfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaadaaaaaa
ogikcaaaaaaaaaaaadaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaa
afaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
agaaaaaakgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaaahaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
aeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
abaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaa
abaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaa
abaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaafaaaaaa
egiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 144
Vector 48 [_Control_ST]
Vector 64 [_Splat0_ST]
Vector 80 [_Splat1_ST]
Vector 96 [_Splat2_ST]
Vector 112 [_Splat3_ST]
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
eefiecedffendiafoankfcibcggjccodnommcakaabaaaaaagiajaaaaaeaaaaaa
daaaaaaabeadaaaaoiahaaaalaaiaaaaebgpgodjnmacaaaanmacaaaaaaacpopp
gmacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
afaaabaaaaaaaaaaabaaafaaabaaagaaaaaaaaaaacaacgaaahaaahaaaaaaaaaa
adaaaaaaaeaaaoaaaaaaaaaaadaaamaaadaabcaaaaaaaaaaadaabeaaabaabfaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbgaaapkaaaaaaadpaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaae
aaaaamoaadaaeejaacaaeekaacaaoekaaeaaaaaeabaaadoaadaaoejaadaaoeka
adaaookaaeaaaaaeabaaamoaadaaeejaaeaaeekaaeaaoekaaeaaaaaeacaaadoa
adaaoejaafaaoekaafaaookaafaaaaadaaaaapiaaaaaffjaapaaoekaaeaaaaae
aaaaapiaaoaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabbaaoekaaaaappjaaaaaoeiaafaaaaadabaaabia
aaaaffiaagaaaakaafaaaaadabaaaiiaabaaaaiabgaaaakaafaaaaadabaaafia
aaaapeiabgaaaakaacaaaaadadaaadoaabaakkiaabaaomiaafaaaaadabaaahia
acaaoejabfaappkaafaaaaadacaaahiaabaaffiabdaaoekaaeaaaaaeabaaalia
bcaakekaabaaaaiaacaakeiaaeaaaaaeabaaahiabeaaoekaabaakkiaabaapeia
abaaaaacabaaaiiabgaaffkaajaaaaadacaaabiaahaaoekaabaaoeiaajaaaaad
acaaaciaaiaaoekaabaaoeiaajaaaaadacaaaeiaajaaoekaabaaoeiaafaaaaad
adaaapiaabaacjiaabaakeiaajaaaaadaeaaabiaakaaoekaadaaoeiaajaaaaad
aeaaaciaalaaoekaadaaoeiaajaaaaadaeaaaeiaamaaoekaadaaoeiaacaaaaad
acaaahiaacaaoeiaaeaaoeiaafaaaaadabaaaciaabaaffiaabaaffiaaeaaaaae
abaaabiaabaaaaiaabaaaaiaabaaffibaeaaaaaeaeaaahoaanaaoekaabaaaaia
acaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacadaaamoaaaaaoeiappppaaaafdeieefcmmaeaaaaeaaaabaa
ddabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagfaaaaadhccabaaaafaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaadaaaaaaogikcaaaaaaaaaaaadaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaaeaaaaaakgiocaaaaaaaaaaaaeaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaa
ogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaa
adaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaahaaaaaaogikcaaaaaaaaaaa
ahaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaaaaaaaaa
bbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaaaaaaaaa
bbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaaaaaaaaa
diaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaai
bcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaai
ccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaai
ecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaak
hccabaaaafaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaa
keaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
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
Vector 16 [_Control_ST]
Vector 17 [_Splat0_ST]
Vector 18 [_Splat1_ST]
Vector 19 [_Splat2_ST]
Vector 20 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[21] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..20] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[3].zw, R0;
MUL result.texcoord[5].xyz, R1, c[14].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[5].w, -R0.x, R0.y;
END
# 24 instructions, 2 R-regs
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
Vector 16 [_Control_ST]
Vector 17 [_Splat0_ST]
Vector 18 [_Splat1_ST]
Vector 19 [_Splat2_ST]
Vector 20 [_Splat3_ST]
"vs_2_0
def c21, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c21.x
mul r1.y, r1, c12.x
mad oT3.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov r0.x, c14.w
add r0.y, c21, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov oT3.zw, r0
mul oT5.xyz, r1, c14.w
mad oT0.zw, v1.xyxy, c17.xyxy, c17
mad oT0.xy, v1, c16, c16.zwzw
mad oT1.zw, v1.xyxy, c19.xyxy, c19
mad oT1.xy, v1, c18, c18.zwzw
mad oT2.xy, v1, c20, c20.zwzw
mad oT4.xy, v2, c15, c15.zwzw
mul oT5.w, -r0.x, r0.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 176
Vector 48 [unity_LightmapST]
Vector 64 [_Control_ST]
Vector 80 [_Splat0_ST]
Vector 96 [_Splat1_ST]
Vector 112 [_Splat2_ST]
Vector 128 [_Splat3_ST]
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
eefiecedbhpjeijcgmclciehdohlnpcidgpigkfbabaaaaaaiaagaaaaadaaaaaa
cmaaaaaapeaaaaaameabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaaahaaaaaa
aiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaafaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcleaeaaaaeaaaabaacnabaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
bkaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaadpccabaaa
aeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
aeaaaaaaogikcaaaaaaaaaaaaeaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadcaaaaal
dccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaa
aaaaaaaaagaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaadcaaaaaldccabaaaadaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaa
dcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaadaaaaaa
kgiocaaaaaaaaaaaadaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaa
diaaaaaihccabaaaafaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaa
aaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaai
iccabaaaafaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 176
Vector 48 [unity_LightmapST]
Vector 64 [_Control_ST]
Vector 80 [_Splat0_ST]
Vector 96 [_Splat1_ST]
Vector 112 [_Splat2_ST]
Vector 128 [_Splat3_ST]
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
eefiecedhhcgkondimbgpgpgbehdaiibadponmghabaaaaaaeiajaaaaaeaaaaaa
daaaaaaapeacaaaalaahaaaahiaiaaaaebgpgodjlmacaaaalmacaaaaaaacpopp
fiacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
agaaabaaaaaaaaaaabaaafaaabaaahaaaaaaaaaaacaabjaaabaaaiaaaaaaaaaa
adaaaaaaaiaaajaaaaaaaaaaadaaamaaaeaabbaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbfaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaae
aaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeejaadaaeeka
adaaoekaaeaaaaaeabaaadoaadaaoejaaeaaoekaaeaaookaaeaaaaaeabaaamoa
adaaeejaafaaeekaafaaoekaaeaaaaaeacaaadoaadaaoejaagaaoekaagaaooka
afaaaaadaaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapiaajaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
amaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaahaaaakaafaaaaad
abaaaiiaabaaaaiabfaaaakaafaaaaadabaaafiaaaaapeiabfaaaakaacaaaaad
adaaadoaabaakkiaabaaomiaaeaaaaaeacaaamoaaeaabejaabaabekaabaaleka
afaaaaadabaaahiaaaaaffjabcaaoekaaeaaaaaeabaaahiabbaaoekaaaaaaaja
abaaoeiaaeaaaaaeabaaahiabdaaoekaaaaakkjaabaaoeiaaeaaaaaeabaaahia
beaaoekaaaaappjaabaaoeiaacaaaaadabaaahiaabaaoeiaaiaaoekbafaaaaad
aeaaahoaabaaoeiaaiaappkaafaaaaadabaaabiaaaaaffjaaoaakkkaaeaaaaae
abaaabiaanaakkkaaaaaaajaabaaaaiaaeaaaaaeabaaabiaapaakkkaaaaakkja
abaaaaiaaeaaaaaeabaaabiabaaakkkaaaaappjaabaaaaiaabaaaaacabaaaiia
aiaappkaacaaaaadabaaaciaabaappibbfaaffkaafaaaaadaeaaaioaabaaffia
abaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacadaaamoaaaaaoeiappppaaaafdeieefcleaeaaaaeaaaabaa
cnabaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
mccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaafaaaaaa
kgiocaaaaaaaaaaaafaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaa
acaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaa
ahaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
aiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaadaaaaaaagbebaaa
aeaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
aeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaaafaaaaaaegacbaaa
aaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaa
aaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
adaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaa
bjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaafaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheomiaaaaaa
ahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
lmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaalmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadamaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaa
lmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaalmaaaaaaafaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 5 [_ProjectionParams]
Vector 6 [unity_LightmapST]
Vector 7 [_Control_ST]
Vector 8 [_Splat0_ST]
Vector 9 [_Splat1_ST]
Vector 10 [_Splat2_ST]
Vector 11 [_Splat3_ST]
"!!ARBvp1.0
PARAM c[12] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..11] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[5].x;
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[8].xyxy, c[8];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[7], c[7].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[10].xyxy, c[10];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[9], c[9].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[4].xy, vertex.texcoord[1], c[6], c[6].zwzw;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ProjectionParams]
Vector 5 [_ScreenParams]
Vector 6 [unity_LightmapST]
Vector 7 [_Control_ST]
Vector 8 [_Splat0_ST]
Vector 9 [_Splat1_ST]
Vector 10 [_Splat2_ST]
Vector 11 [_Splat3_ST]
"vs_2_0
def c12, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c12.x
mul r1.y, r1, c4.x
mad oT3.xy, r1.z, c5.zwzw, r1
mov oPos, r0
mov oT3.zw, r0
mad oT0.zw, v1.xyxy, c8.xyxy, c8
mad oT0.xy, v1, c7, c7.zwzw
mad oT1.zw, v1.xyxy, c10.xyxy, c10
mad oT1.xy, v1, c9, c9.zwzw
mad oT2.xy, v1, c11, c11.zwzw
mad oT4.xy, v2, c6, c6.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 176
Vector 48 [unity_LightmapST]
Vector 64 [_Control_ST]
Vector 80 [_Splat0_ST]
Vector 96 [_Splat1_ST]
Vector 112 [_Splat2_ST]
Vector 128 [_Splat3_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedfdneblifmmplbkjioelaholbngdppojaabaaaaaajeaeaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcoaacaaaaeaaaabaaliaaaaaafjaaaaae
egiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaafaaaaaakgiocaaa
aaaaaaaaafaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaacaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaakgiocaaaaaaaaaaaahaaaaaa
dcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaa
ogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaadaaaaaaagbebaaaaeaaaaaa
agiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaaeaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 176
Vector 48 [unity_LightmapST]
Vector 64 [_Control_ST]
Vector 80 [_Splat0_ST]
Vector 96 [_Splat1_ST]
Vector 112 [_Splat2_ST]
Vector 128 [_Splat3_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecediihcbcpecnbecceojmbjnkamdgghcjlkabaaaaaagaagaaaaaeaaaaaa
daaaaaaapiabaaaaoaaeaaaakiafaaaaebgpgodjmaabaaaamaabaaaaaaacpopp
heabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaadaa
agaaabaaaaaaaaaaabaaafaaabaaahaaaaaaaaaaacaaaaaaaeaaaiaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafamaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeia
aeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoa
adaaeejaadaaeekaadaaoekaaeaaaaaeabaaadoaadaaoejaaeaaoekaaeaaooka
aeaaaaaeabaaamoaadaaeejaafaaeekaafaaoekaaeaaaaaeacaaadoaadaaoeja
agaaoekaagaaookaafaaaaadaaaaapiaaaaaffjaajaaoekaaeaaaaaeaaaaapia
aiaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaakaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaalaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffia
ahaaaakaafaaaaadabaaaiiaabaaaaiaamaaaakaafaaaaadabaaafiaaaaapeia
amaaaakaacaaaaadadaaadoaabaakkiaabaaomiaaeaaaaaeacaaamoaaeaabeja
abaabekaabaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacadaaamoaaaaaoeiappppaaaafdeieefcoaacaaaa
eaaaabaaliaaaaaafjaaaaaeegiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaadmccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaahaaaaaa
kgiocaaaaaaaaaaaahaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaa
adaaaaaaagbebaaaaeaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaa
adaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaadaaaaaaamadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
"!!ARBfp1.0
PARAM c[1] = { { 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TXP R5.xyz, fragment.texcoord[3], texture[5], 2D;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R4.xyz, fragment.texcoord[2], texture[4], 2D;
MUL R2.xyz, R0.y, R2;
MUL R3.xyz, R0.z, R3;
MUL R0.xyz, R0.x, R1;
ADD R0.xyz, R0, R2;
ADD R0.xyz, R0, R3;
MUL R1.xyz, R0.w, R4;
LG2 R2.x, R5.x;
LG2 R2.z, R5.z;
LG2 R2.y, R5.y;
ADD R2.xyz, -R2, fragment.texcoord[4];
ADD R0.xyz, R0, R1;
MUL result.color.xyz, R0, R2;
MOV result.color.w, c[0].x;
END
# 19 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c0, 0.00000000, 0, 0, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3
dcl t4.xyz
texld r1, t2, s4
texld r5, t0, s0
mov r0.y, t1.w
mov r0.x, t1.z
mov r2.xy, r0
mov r0.y, t0.w
mov r0.x, t0.z
mov r3.xy, r0
mul r1.xyz, r5.w, r1
texld r4, r3, s1
texldp r0, t3, s5
texld r3, t1, s2
texld r2, r2, s3
mul r2.xyz, r5.z, r2
mul r3.xyz, r5.y, r3
mul r4.xyz, r5.x, r4
add_pp r3.xyz, r4, r3
add_pp r2.xyz, r3, r2
log_pp r0.x, r0.x
log_pp r0.z, r0.z
log_pp r0.y, r0.y
add_pp r0.xyz, -r0, t4
add_pp r1.xyz, r2, r1
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
"ps_4_0
eefiecedhkjobojnikeollnfdpjgnfkdgcmngoigabaaaaaaaeaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoeacaaaa
eaaaaaaaljaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaa
fibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
fgafbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaacaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaakgakbaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaa
aaaaaaaapgapbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaacpaaaaaf
hcaabaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaaegbcbaaaafaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
"ps_4_0_level_9_1
eefiecedkgkaioeecmdlalejepabnogbmhljdheaabaaaaaaeeagaaaaaeaaaaaa
daaaaaaagmacaaaafiafaaaabaagaaaaebgpgodjdeacaaaadeacaaaaaaacpppp
piabaaaadmaaaaaaaaaadmaaaaaadmaaaaaadmaaagaaceaaaaaadmaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaafafafaaaaacppppfbaaaaafaaaaapka
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaiaadaaapla
bpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkabpaaaaac
aaaaaajaaeaiapkabpaaaaacaaaaaajaafaiapkaabaaaaacaaaaabiaabaakkla
abaaaaacaaaaaciaabaapplaabaaaaacabaaabiaaaaakklaabaaaaacabaaacia
aaaapplaagaaaaacaaaaaeiaadaapplaafaaaaadacaaadiaaaaakkiaadaaoela
ecaaaaadaaaaapiaaaaaoeiaadaioekaecaaaaadabaaapiaabaaoeiaabaioeka
ecaaaaadadaaapiaabaaoelaacaioekaecaaaaadaeaacpiaaaaaoelaaaaioeka
ecaaaaadafaaapiaacaaoelaaeaioekaecaaaaadacaacpiaacaaoeiaafaioeka
afaaaaadadaaahiaadaaoeiaaeaaffiaaeaaaaaeabaachiaaeaaaaiaabaaoeia
adaaoeiaaeaaaaaeaaaachiaaeaakkiaaaaaoeiaabaaoeiaaeaaaaaeaaaachia
aeaappiaafaaoeiaaaaaoeiaapaaaaacabaacbiaacaaaaiaapaaaaacabaaccia
acaaffiaapaaaaacabaaceiaacaakkiaacaaaaadabaachiaabaaoeibaeaaoela
afaaaaadaaaachiaaaaaoeiaabaaoeiaabaaaaacaaaaciiaaaaaaakaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcoeacaaaaeaaaaaaaljaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaa
afaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaad
dcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaafgafbaaaacaaaaaadcaaaaaj
hcaabaaaaaaaaaaaagaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadcaaaaajhcaabaaaaaaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
aeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaafaaaaaaaagabaaaafaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaa
afaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheolaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
keaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaadadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaa
keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [unity_LightmapFade]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
SetTexture 7 [unity_LightmapInd] 2D 7
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEX R1, fragment.texcoord[4], texture[7], 2D;
TEX R2, fragment.texcoord[4], texture[6], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R3.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TXP R7.xyz, fragment.texcoord[3], texture[5], 2D;
TEX R6.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R5.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R4.xyz, fragment.texcoord[1], texture[2], 2D;
MUL R2.xyz, R2.w, R2;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[1].y;
DP4 R2.w, fragment.texcoord[5], fragment.texcoord[5];
RSQ R1.w, R2.w;
RCP R1.w, R1.w;
MAD R2.xyz, R2, c[1].y, -R1;
MAD_SAT R1.w, R1, c[0].z, c[0];
MAD R1.xyz, R1.w, R2, R1;
MUL R3.xyz, R0.x, R3;
LG2 R2.x, R7.x;
LG2 R2.y, R7.y;
LG2 R2.z, R7.z;
ADD R1.xyz, -R2, R1;
MUL R2.xyz, R0.y, R4;
ADD R2.xyz, R3, R2;
MUL R0.xyz, R0.z, R5;
MUL R3.xyz, R0.w, R6;
ADD R0.xyz, R2, R0;
ADD R0.xyz, R0, R3;
MUL result.color.xyz, R0, R1;
MOV result.color.w, c[1].x;
END
# 30 instructions, 8 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [unity_LightmapFade]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
SetTexture 7 [unity_LightmapInd] 2D 7
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
def c1, 8.00000000, 0.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3
dcl t4.xy
dcl t5
texld r6, t2, s4
texld r3, t1, s2
texldp r2, t3, s5
texld r5, t4, s7
mul_pp r5.xyz, r5.w, r5
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.y, t1.w
mov r1.x, t1.z
mul_pp r5.xyz, r5, c1.x
log_pp r2.x, r2.x
log_pp r2.y, r2.y
log_pp r2.z, r2.z
texld r7, r1, s3
texld r4, r0, s1
texld r1, t0, s0
texld r0, t4, s6
mul_pp r8.xyz, r0.w, r0
dp4 r0.x, t5, t5
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r8.xyz, r8, c1.x, -r5
mad_sat r0.x, r0, c0.z, c0.w
mad_pp r0.xyz, r0.x, r8, r5
add_pp r0.xyz, -r2, r0
mul r2.xyz, r1.y, r3
mul r3.xyz, r1.x, r4
add_pp r2.xyz, r3, r2
mul r1.xyz, r1.z, r7
mul r3.xyz, r1.w, r6
add_pp r1.xyz, r2, r1
add_pp r1.xyz, r1, r3
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c1.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
SetTexture 7 [unity_LightmapInd] 2D 7
ConstBuffer "$Globals" 176
Vector 144 [unity_LightmapFade]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmpnlceanmehkjjjebklnfofgdokpdbbbabaaaaaaleafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchmaeaaaaeaaaaaaabpabaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafkaaaaadaagabaaaahaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaa
fibiaaaeaahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaa
fibiaaaeaahabaaaahaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaadlcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaabbaaaaahbcaabaaaaaaaaaaaegbobaaaafaaaaaa
egbobaaaafaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaal
bcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaajaaaaaadkiacaaa
aaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaa
ahaaaaaaaagabaaaahaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaagaaaaaa
aagabaaaagaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdcaaaaakhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
jgahbaiaebaaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
aeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaafaaaaaaaagabaaaafaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaafgafbaaaadaaaaaadcaaaaajhcaabaaaabaaaaaaagaabaaaadaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaa
acaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaabaaaaaa
kgakbaaaadaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaaj
hcaabaaaabaaaaaapgapbaaaadaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
SetTexture 7 [unity_LightmapInd] 2D 7
ConstBuffer "$Globals" 176
Vector 144 [unity_LightmapFade]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedlolccoadefdgoncoepcdjcogojjphaecabaaaaaaoaaiaaaaaeaaaaaa
daaaaaaafiadaaaanmahaaaakmaiaaaaebgpgodjcaadaaaacaadaaaaaaacpppp
naacaaaafaaaaaaaabaaeeaaaaaafaaaaaaafaaaaiaaceaaaaaafaaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaafafafaaagagagaaahahahaaaaaaajaa
abaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaebaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaac
aaaaaaiaacaaaplabpaaaaacaaaaaaiaadaaaplabpaaaaacaaaaaaiaaeaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkabpaaaaac
aaaaaajaafaiapkabpaaaaacaaaaaajaagaiapkabpaaaaacaaaaaajaahaiapka
ajaaaaadaaaaaiiaaeaaoelaaeaaoelaahaaaaacaaaaabiaaaaappiaagaaaaac
aaaaabiaaaaaaaiaaeaaaaaeaaaadbiaaaaaaaiaaaaakkkaaaaappkaabaaaaac
abaaadiaacaabllaagaaaaacaaaaaciaadaapplaafaaaaadacaaadiaaaaaffia
adaaoelaabaaaaacadaaabiaabaakklaabaaaaacadaaaciaabaapplaabaaaaac
aeaaabiaaaaakklaabaaaaacaeaaaciaaaaapplaecaaaaadafaacpiaabaaoeia
ahaioekaecaaaaadabaacpiaabaaoeiaagaioekaecaaaaadacaacpiaacaaoeia
afaioekaecaaaaadadaaapiaadaaoeiaadaioekaecaaaaadaeaaapiaaeaaoeia
abaioekaecaaaaadagaaapiaabaaoelaacaioekaecaaaaadahaacpiaaaaaoela
aaaioekaecaaaaadaiaaapiaacaaoelaaeaioekaafaaaaadacaaciiaafaappia
abaaaakaafaaaaadaaaacoiaafaabliaacaappiaafaaaaadabaaciiaabaappia
abaaaakaaeaaaaaeabaachiaabaappiaabaaoeiaaaaablibaeaaaaaeaaaachia
aaaaaaiaabaaoeiaaaaabliaapaaaaacabaacbiaacaaaaiaapaaaaacabaaccia
acaaffiaapaaaaacabaaceiaacaakkiaacaaaaadaaaachiaaaaaoeiaabaaoeib
afaaaaadabaaahiaagaaoeiaahaaffiaaeaaaaaeabaachiaahaaaaiaaeaaoeia
abaaoeiaaeaaaaaeabaachiaahaakkiaadaaoeiaabaaoeiaaeaaaaaeabaachia
ahaappiaaiaaoeiaabaaoeiaafaaaaadaaaachiaaaaaoeiaabaaoeiaabaaaaac
aaaaciiaabaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefchmaeaaaa
eaaaaaaabpabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
fkaaaaadaagabaaaagaaaaaafkaaaaadaagabaaaahaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaaeaahabaaa
agaaaaaaffffaaaafibiaaaeaahabaaaahaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
mcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaabbaaaaahbcaabaaaaaaaaaaa
egbobaaaafaaaaaaegbobaaaafaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadccaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaa
ajaaaaaadkiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
adaaaaaaeghobaaaahaaaaaaaagabaaaahaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaa
abaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaa
eghobaaaagaaaaaaaagabaaaagaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaajgahbaiaebaaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaacpaaaaafhcaabaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaafgafbaaaadaaaaaadcaaaaajhcaabaaaabaaaaaa
agaabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaaj
hcaabaaaabaaaaaakgakbaaaadaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaa
aeaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaadaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheo
miaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaalmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaalmaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadadaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaa
amamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaalmaaaaaa
afaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
"!!ARBfp1.0
PARAM c[1] = { { 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TXP R6.xyz, fragment.texcoord[3], texture[5], 2D;
TEX R1, fragment.texcoord[4], texture[6], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R3.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R5.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R4.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
MUL R3.xyz, R0.y, R3;
MUL R2.xyz, R0.x, R2;
ADD R2.xyz, R2, R3;
MUL R0.xyz, R0.z, R4;
MUL R1.xyz, R1.w, R1;
LG2 R6.x, R6.x;
LG2 R6.z, R6.z;
LG2 R6.y, R6.y;
MAD R1.xyz, R1, c[0].y, -R6;
MUL R3.xyz, R0.w, R5;
ADD R0.xyz, R2, R0;
ADD R0.xyz, R0, R3;
MUL result.color.xyz, R0, R1;
MOV result.color.w, c[0].x;
END
# 21 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c0, 8.00000000, 0.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3
dcl t4.xy
texldp r6, t3, s5
texld r4, t2, s4
texld r2, t0, s0
mov r0.y, t0.w
mov r0.x, t0.z
mov r3.xy, r0
mov r0.y, t1.w
mov r0.x, t1.z
mov r1.xy, r0
texld r5, r1, s3
texld r0, t4, s6
texld r1, t1, s2
texld r3, r3, s1
mul_pp r0.xyz, r0.w, r0
mul r3.xyz, r2.x, r3
mul r1.xyz, r2.y, r1
add_pp r1.xyz, r3, r1
mul r2.xyz, r2.z, r5
add_pp r1.xyz, r1, r2
mul r2.xyz, r2.w, r4
log_pp r3.x, r6.x
log_pp r3.z, r6.z
log_pp r3.y, r6.y
mad_pp r0.xyz, r0, c0.x, -r3
add_pp r1.xyz, r1, r2
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c0.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
"ps_4_0
eefiecedpplfckgignolgcfdofikehniikmompfnabaaaaaagiaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceiadaaaa
eaaaaaaancaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaae
aahabaaaagaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaad
lcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaafgafbaaa
acaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaakgakbaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaa
pgapbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaacpaaaaafhcaabaaa
abaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaadaaaaaa
eghobaaaagaaaaaaaagabaaaagaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
"ps_4_0_level_9_1
eefiecedpdblanpbejfggojmcieadfkbelfdcobpabaaaaaanmagaaaaaeaaaaaa
daaaaaaakaacaaaapaafaaaakiagaaaaebgpgodjgiacaaaagiacaaaaaaacpppp
ciacaaaaeaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaahaaceaaaaaaeaaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaafafafaaagagagaaaaacppppfbaaaaaf
aaaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaia
adaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapka
bpaaaaacaaaaaajaafaiapkabpaaaaacaaaaaajaagaiapkaabaaaaacaaaaabia
abaakklaabaaaaacaaaaaciaabaapplaabaaaaacabaaabiaaaaakklaabaaaaac
abaaaciaaaaapplaabaaaaacacaaadiaacaabllaagaaaaacaaaaaeiaadaappla
afaaaaadadaaadiaaaaakkiaadaaoelaecaaaaadaaaaapiaaaaaoeiaadaioeka
ecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadaeaaapiaabaaoelaacaioeka
ecaaaaadafaacpiaaaaaoelaaaaioekaecaaaaadagaaapiaacaaoelaaeaioeka
ecaaaaadacaacpiaacaaoeiaagaioekaecaaaaadadaacpiaadaaoeiaafaioeka
afaaaaadaeaaahiaaeaaoeiaafaaffiaaeaaaaaeabaachiaafaaaaiaabaaoeia
aeaaoeiaaeaaaaaeaaaachiaafaakkiaaaaaoeiaabaaoeiaaeaaaaaeaaaachia
afaappiaagaaoeiaaaaaoeiaafaaaaadaaaaciiaacaappiaaaaaaakaapaaaaac
abaacbiaadaaaaiaapaaaaacabaacciaadaaffiaapaaaaacabaaceiaadaakkia
aeaaaaaeabaachiaaaaappiaacaaoeiaabaaoeibafaaaaadaaaachiaaaaaoeia
abaaoeiaabaaaaacaaaaciiaaaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefceiadaaaaeaaaaaaancaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaa
ffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaafgafbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
acaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaa
kgakbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaaj
hcaabaaaaaaaaaaapgapbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaa
cpaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
ogbkbaaaadaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaabaaaaaa
pgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaa
keaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
"!!ARBfp1.0
PARAM c[1] = { { 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TXP R5.xyz, fragment.texcoord[3], texture[5], 2D;
TEX R4.xyz, fragment.texcoord[2], texture[4], 2D;
MUL R2.xyz, R0.y, R2;
MUL R3.xyz, R0.z, R3;
MUL R0.xyz, R0.x, R1;
ADD R0.xyz, R0, R2;
ADD R0.xyz, R0, R3;
MUL R1.xyz, R0.w, R4;
ADD R2.xyz, R5, fragment.texcoord[4];
ADD R0.xyz, R0, R1;
MUL result.color.xyz, R0, R2;
MOV result.color.w, c[0].x;
END
# 16 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c0, 0.00000000, 0, 0, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3
dcl t4.xyz
texld r1, t2, s4
texld r5, t0, s0
mov r0.y, t1.w
mov r0.x, t1.z
mov r2.xy, r0
mov r0.y, t0.w
mov r0.x, t0.z
mov r3.xy, r0
mul r1.xyz, r5.w, r1
texld r4, r3, s1
texldp r0, t3, s5
texld r3, t1, s2
texld r2, r2, s3
mul r2.xyz, r5.z, r2
mul r3.xyz, r5.y, r3
mul r4.xyz, r5.x, r4
add_pp r3.xyz, r4, r3
add_pp r2.xyz, r3, r2
add_pp r0.xyz, r0, t4
add_pp r1.xyz, r2, r1
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
"ps_4_0
eefiecedlmfcgklogibaoplgmmnmohacabjfibieabaaaaaaomadaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmmacaaaa
eaaaaaaaldaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaa
fibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaa
gcbaaaadhcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
fgafbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaacaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaakgakbaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaa
aaaaaaaapgapbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegbcbaaaafaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
"ps_4_0_level_9_1
eefiecedmagpmileealjbpkfejdogebhipeeepjkabaaaaaaaiagaaaaaeaaaaaa
daaaaaaaeiacaaaabmafaaaaneafaaaaebgpgodjbaacaaaabaacaaaaaaacpppp
neabaaaadmaaaaaaaaaadmaaaaaadmaaaaaadmaaagaaceaaaaaadmaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaafafafaaaaacppppfbaaaaafaaaaapka
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaiaadaaapla
bpaaaaacaaaaaaiaaeaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkabpaaaaac
aaaaaajaaeaiapkabpaaaaacaaaaaajaafaiapkaabaaaaacaaaaabiaabaakkla
abaaaaacaaaaaciaabaapplaabaaaaacabaaabiaaaaakklaabaaaaacabaaacia
aaaapplaagaaaaacaaaaaeiaadaapplaafaaaaadacaaadiaaaaakkiaadaaoela
ecaaaaadaaaaapiaaaaaoeiaadaioekaecaaaaadabaaapiaabaaoeiaabaioeka
ecaaaaadadaaapiaabaaoelaacaioekaecaaaaadaeaacpiaaaaaoelaaaaioeka
ecaaaaadafaaapiaacaaoelaaeaioekaecaaaaadacaacpiaacaaoeiaafaioeka
afaaaaadadaaahiaadaaoeiaaeaaffiaaeaaaaaeabaachiaaeaaaaiaabaaoeia
adaaoeiaaeaaaaaeaaaachiaaeaakkiaaaaaoeiaabaaoeiaaeaaaaaeaaaachia
aeaappiaafaaoeiaaaaaoeiaacaaaaadabaachiaacaaoeiaaeaaoelaafaaaaad
aaaachiaaaaaoeiaabaaoeiaabaaaaacaaaaciiaaaaaaakaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcmmacaaaaeaaaaaaaldaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
fibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaa
adaaaaaagcbaaaadlcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaafgafbaaaacaaaaaadcaaaaajhcaabaaa
aaaaaaaaagaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaa
dcaaaaajhcaabaaaaaaaaaaakgakbaaaacaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaacaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaaeaaaaaa
pgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
afaaaaaaaagabaaaafaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egbcbaaaafaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apalaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [unity_LightmapFade]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
SetTexture 7 [unity_LightmapInd] 2D 7
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEX R1, fragment.texcoord[4], texture[7], 2D;
TEX R2, fragment.texcoord[4], texture[6], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R3.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R6.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R5.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R4.xyz, fragment.texcoord[1], texture[2], 2D;
TXP R7.xyz, fragment.texcoord[3], texture[5], 2D;
MUL R2.xyz, R2.w, R2;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[1].y;
DP4 R2.w, fragment.texcoord[5], fragment.texcoord[5];
RSQ R1.w, R2.w;
RCP R1.w, R1.w;
MAD R2.xyz, R2, c[1].y, -R1;
MAD_SAT R1.w, R1, c[0].z, c[0];
MAD R1.xyz, R1.w, R2, R1;
MUL R3.xyz, R0.x, R3;
MUL R2.xyz, R0.y, R4;
ADD R2.xyz, R3, R2;
MUL R0.xyz, R0.z, R5;
ADD R1.xyz, R7, R1;
MUL R3.xyz, R0.w, R6;
ADD R0.xyz, R2, R0;
ADD R0.xyz, R0, R3;
MUL result.color.xyz, R0, R1;
MOV result.color.w, c[1].x;
END
# 27 instructions, 8 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [unity_LightmapFade]
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
SetTexture 7 [unity_LightmapInd] 2D 7
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
def c1, 8.00000000, 0.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3
dcl t4.xy
dcl t5
texldp r6, t3, s5
texld r7, t2, s4
texld r1, t4, s7
texld r5, t0, s0
mul_pp r1.xyz, r1.w, r1
mul_pp r1.xyz, r1, c1.x
mov r0.y, t1.w
mov r0.x, t1.z
mov r2.xy, r0
mov r0.y, t0.w
mov r0.x, t0.z
mov r3.xy, r0
texld r4, r3, s1
texld r0, t4, s6
texld r3, t1, s2
texld r2, r2, s3
mul r2.xyz, r5.z, r2
mul r3.xyz, r5.y, r3
mul r4.xyz, r5.x, r4
add_pp r3.xyz, r4, r3
add_pp r2.xyz, r3, r2
mul_pp r3.xyz, r0.w, r0
dp4 r0.x, t5, t5
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r3.xyz, r3, c1.x, -r1
mad_sat r0.x, r0, c0.z, c0.w
mad_pp r0.xyz, r0.x, r3, r1
mul r1.xyz, r5.w, r7
add_pp r0.xyz, r6, r0
add_pp r1.xyz, r2, r1
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c1.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
SetTexture 7 [unity_LightmapInd] 2D 7
ConstBuffer "$Globals" 176
Vector 144 [unity_LightmapFade]
BindCB  "$Globals" 0
"ps_4_0
eefieceddpaamcaffglmjpffmgaogopejijcgkbdabaaaaaajmafaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapalaaaalmaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgeaeaaaaeaaaaaaabjabaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafkaaaaadaagabaaaahaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaa
fibiaaaeaahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaa
fibiaaaeaahabaaaahaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaadlcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaabbaaaaahbcaabaaaaaaaaaaaegbobaaaafaaaaaa
egbobaaaafaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaal
bcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaajaaaaaadkiacaaa
aaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaa
ahaaaaaaaagabaaaahaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaaagaaaaaa
aagabaaaagaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaebdcaaaaakhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
jgahbaiaebaaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egacbaaaabaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
aeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaafaaaaaaaagabaaaafaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaafgafbaaaadaaaaaadcaaaaajhcaabaaaabaaaaaa
agaabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaaj
hcaabaaaabaaaaaakgakbaaaadaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaa
aeaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaadaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
SetTexture 7 [unity_LightmapInd] 2D 7
ConstBuffer "$Globals" 176
Vector 144 [unity_LightmapFade]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedbemcgdbikendcbeciilhhjfholhobhpiabaaaaaakeaiaaaaaeaaaaaa
daaaaaaadeadaaaakaahaaaahaaiaaaaebgpgodjpmacaaaapmacaaaaaaacpppp
kmacaaaafaaaaaaaabaaeeaaaaaafaaaaaaafaaaaiaaceaaaaaafaaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaafafafaaagagagaaahahahaaaaaaajaa
abaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaebaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaac
aaaaaaiaacaaaplabpaaaaacaaaaaaiaadaaaplabpaaaaacaaaaaaiaaeaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkabpaaaaac
aaaaaajaafaiapkabpaaaaacaaaaaajaagaiapkabpaaaaacaaaaaajaahaiapka
ajaaaaadaaaaaiiaaeaaoelaaeaaoelaahaaaaacaaaaabiaaaaappiaagaaaaac
aaaaabiaaaaaaaiaaeaaaaaeaaaadbiaaaaaaaiaaaaakkkaaaaappkaabaaaaac
abaaadiaacaabllaagaaaaacaaaaaciaadaapplaafaaaaadacaaadiaaaaaffia
adaaoelaabaaaaacadaaabiaabaakklaabaaaaacadaaaciaabaapplaabaaaaac
aeaaabiaaaaakklaabaaaaacaeaaaciaaaaapplaecaaaaadafaacpiaabaaoeia
ahaioekaecaaaaadabaacpiaabaaoeiaagaioekaecaaaaadacaacpiaacaaoeia
afaioekaecaaaaadadaaapiaadaaoeiaadaioekaecaaaaadaeaaapiaaeaaoeia
abaioekaecaaaaadagaaapiaabaaoelaacaioekaecaaaaadahaacpiaaaaaoela
aaaioekaecaaaaadaiaaapiaacaaoelaaeaioekaafaaaaadacaaciiaafaappia
abaaaakaafaaaaadaaaacoiaafaabliaacaappiaafaaaaadabaaciiaabaappia
abaaaakaaeaaaaaeabaachiaabaappiaabaaoeiaaaaablibaeaaaaaeaaaachia
aaaaaaiaabaaoeiaaaaabliaacaaaaadaaaachiaaaaaoeiaacaaoeiaafaaaaad
abaaahiaagaaoeiaahaaffiaaeaaaaaeabaachiaahaaaaiaaeaaoeiaabaaoeia
aeaaaaaeabaachiaahaakkiaadaaoeiaabaaoeiaaeaaaaaeabaachiaahaappia
aiaaoeiaabaaoeiaafaaaaadaaaachiaaaaaoeiaabaaoeiaabaaaaacaaaaciia
abaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcgeaeaaaaeaaaaaaa
bjabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
adaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaad
aagabaaaagaaaaaafkaaaaadaagabaaaahaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaa
ffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaa
ffffaaaafibiaaaeaahabaaaahaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadpcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaa
adaaaaaagcbaaaadlcbabaaaaeaaaaaagcbaaaadpcbabaaaafaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaabbaaaaahbcaabaaaaaaaaaaaegbobaaa
afaaaaaaegbobaaaafaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dccaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaajaaaaaa
dkiacaaaaaaaaaaaajaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaa
eghobaaaahaaaaaaaagabaaaahaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaa
fgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaadaaaaaaeghobaaa
agaaaaaaaagabaaaagaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdcaaaaakhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaajgahbaiaebaaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaafgafbaaaadaaaaaadcaaaaajhcaabaaa
abaaaaaaagaabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaogbkbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaa
dcaaaaajhcaabaaaabaaaaaakgakbaaaadaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaaadaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
ejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
lmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapapaaaalmaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadadaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
adaaaaaaamamaaaalmaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaa
lmaaaaaaafaaaaaaaaaaaaaaadaaaaaaafaaaaaaapapaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
"!!ARBfp1.0
PARAM c[1] = { { 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R1, fragment.texcoord[4], texture[6], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R4.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R3.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R2.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TXP R6.xyz, fragment.texcoord[3], texture[5], 2D;
TEX R5.xyz, fragment.texcoord[2], texture[4], 2D;
MUL R1.xyz, R1.w, R1;
MUL R4.xyz, R0.z, R4;
MUL R3.xyz, R0.y, R3;
MUL R0.xyz, R0.x, R2;
ADD R0.xyz, R0, R3;
ADD R0.xyz, R0, R4;
MUL R2.xyz, R0.w, R5;
MAD R1.xyz, R1, c[0].y, R6;
ADD R0.xyz, R0, R2;
MUL result.color.xyz, R0, R1;
MOV result.color.w, c[0].x;
END
# 18 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c0, 8.00000000, 0.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3
dcl t4.xy
texldp r6, t3, s5
texld r4, t2, s4
texld r2, t0, s0
mov r0.y, t0.w
mov r0.x, t0.z
mov r3.xy, r0
mov r0.y, t1.w
mov r0.x, t1.z
mov r1.xy, r0
texld r5, r1, s3
texld r0, t4, s6
texld r1, t1, s2
texld r3, r3, s1
mul_pp r0.xyz, r0.w, r0
mul r3.xyz, r2.x, r3
mul r1.xyz, r2.y, r1
mul r2.xyz, r2.z, r5
add_pp r1.xyz, r3, r1
add_pp r1.xyz, r1, r2
mul r2.xyz, r2.w, r4
mad_pp r0.xyz, r0, c0.x, r6
add_pp r1.xyz, r1, r2
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c0.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
"ps_4_0
eefiecedloaiehmfahffbekgckefpddhnafknbdgabaaaaaafaaeaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaakeaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdaadaaaa
eaaaaaaammaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaafibiaaae
aahabaaaagaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadpcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaagcbaaaad
lcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaafgafbaaa
acaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaakgakbaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
adaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaaaaaaaaaa
pgapbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaaefaaaaajpcaabaaa
acaaaaaaogbkbaaaadaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdcaaaaajhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_Control] 2D 0
SetTexture 1 [_Splat0] 2D 1
SetTexture 2 [_Splat1] 2D 2
SetTexture 3 [_Splat2] 2D 3
SetTexture 4 [_Splat3] 2D 4
SetTexture 5 [_LightBuffer] 2D 5
SetTexture 6 [unity_Lightmap] 2D 6
"ps_4_0_level_9_1
eefiecedkeggoiapojfehopoahlghcjnmioebihgabaaaaaakaagaaaaaeaaaaaa
daaaaaaahmacaaaaleafaaaagmagaaaaebgpgodjeeacaaaaeeacaaaaaaacpppp
aeacaaaaeaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaahaaceaaaaaaeaaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaafafafaaagagagaaaaacppppfbaaaaaf
aaaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaia
adaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapka
bpaaaaacaaaaaajaafaiapkabpaaaaacaaaaaajaagaiapkaabaaaaacaaaaabia
abaakklaabaaaaacaaaaaciaabaapplaabaaaaacabaaabiaaaaakklaabaaaaac
abaaaciaaaaapplaagaaaaacaaaaaeiaadaapplaafaaaaadacaaadiaaaaakkia
adaaoelaabaaaaacadaaadiaacaabllaecaaaaadaaaaapiaaaaaoeiaadaioeka
ecaaaaadabaaapiaabaaoeiaabaioekaecaaaaadaeaaapiaabaaoelaacaioeka
ecaaaaadafaacpiaaaaaoelaaaaioekaecaaaaadagaaapiaacaaoelaaeaioeka
ecaaaaadacaacpiaacaaoeiaafaioekaecaaaaadadaacpiaadaaoeiaagaioeka
afaaaaadaeaaahiaaeaaoeiaafaaffiaaeaaaaaeabaachiaafaaaaiaabaaoeia
aeaaoeiaaeaaaaaeaaaachiaafaakkiaaaaaoeiaabaaoeiaaeaaaaaeaaaachia
afaappiaagaaoeiaaaaaoeiaafaaaaadaaaaciiaadaappiaaaaaaakaaeaaaaae
abaachiaaaaappiaadaaoeiaacaaoeiaafaaaaadaaaachiaaaaaoeiaabaaoeia
abaaaaacaaaaciiaaaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
daadaaaaeaaaaaaammaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaad
aagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaaagaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
fibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaa
fibiaaaeaahabaaaagaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
pcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadmcbabaaaadaaaaaa
gcbaaaadlcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
fgafbaaaacaaaaaadcaaaaajhcaabaaaaaaaaaaaagaabaaaacaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaakgakbaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaajhcaabaaa
aaaaaaaapgapbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaabaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaaefaaaaaj
pcaabaaaacaaaaaaogbkbaaaadaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdcaaaaaj
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapapaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adadaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaadaaaaaaamamaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
}
 }
}
Fallback Off
}