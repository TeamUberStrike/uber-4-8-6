Shader "Cross Platform Shaders/Mobile Bloom" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _Bloom ("Bloom (RGB)", 2D) = "black" {}
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0], vertex.texcoord[0].xyxy;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c5
slt r0.x, c4.y, r0
max r0.x, -r0, r0
slt r0.x, c5, r0
add r0.y, -r0.x, c5
mul r0.z, v1.y, r0.y
add r0.y, -v1, c5
mad oT0.w, r0.x, r0.y, r0.z
mov oT0.xyz, v1.xyxw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedhkjfkbcnhkcdleheomblljgbhkjnflmmabaaaaaaoeabaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcaeabaaaa
eaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbebaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0_level_9_1
eefiecednpdooailbcccdekmjjmimbldnffekibmabaaaaaalmacaaaaaeaaaaaa
daaaaaaaaeabaaaabaacaaaageacaaaaebgpgodjmmaaaaaammaaaaaaaaacpopp
jiaaaaaadeaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaabaadaaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapia
abaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaeaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaapoaabaaeeja
ppppaaaafdeieefcaeabaaaaeaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
abaaaaaaegbebaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfc
eeaaklklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Bloom] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
ADD result.color, R0, R1;
END
# 3 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Bloom] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl t0
texld r1, t0, s0
mov r0.y, t0.w
mov r0.x, t0.z
texld r0, r0, s1
add r0, r1, r0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Bloom] 2D 1
"ps_4_0
eefiecedoadbljehomopakjhkhhddnnchibehlofabaaaaaaiiabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmiaaaaaa
eaaaaaaadcaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Bloom] 2D 1
"ps_4_0_level_9_1
eefiecedaohckopbfncdibfjihhfobeklfpjcipdabaaaaaaeaacaaaaaeaaaaaa
daaaaaaaoeaaaaaaleabaaaaamacaaaaebgpgodjkmaaaaaakmaaaaaaaaacpppp
iaaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppbpaaaaacaaaaaaiaaaaacplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkaabaaaaacaaaacbiaaaaakklaabaaaaacaaaaccia
aaaapplaecaaaaadaaaaapiaaaaaoeiaabaioekaecaaaaadabaacpiaaaaaoela
aaaioekaacaaaaadaaaacpiaaaaaoeiaabaaoeiaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcmiaaaaaaeaaaaaaadcaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahpccabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_TexelSize]
"!!ARBvp1.0
PARAM c[6] = { { 1.5, -1.5 },
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
MOV R0.xy, c[0];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MAD result.texcoord[1].xy, R0.x, c[5], vertex.texcoord[0];
MAD result.texcoord[2].xy, R0.yxzw, c[5], vertex.texcoord[0];
MAD result.texcoord[3].xy, R0.y, c[5], vertex.texcoord[0];
MAD result.texcoord[4].xy, R0, c[5], vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 10 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
def c5, 1.50000000, -1.50000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.xy, c4
mov r0.zw, c4.xyxy
mad oT1.xy, c5.x, r0, v1
mad oT2.xy, c5.yxzw, r0.zwzw, v1
mov r0.xy, c4
mov r0.zw, c4.xyxy
mov oT0.xy, v1
mad oT3.xy, c5.y, r0, v1
mad oT4.xy, c5, r0.zwzw, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgkfblgfkacljedngdgfakkhmaclajkeiabaaaaaafeadaaaaadaaaaaa
cmaaaaaaiaaaaaaadiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcbeacaaaa
eaaaabaaifaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaaddccabaaaafaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
dcaaaaandccabaaaacaaaaaaegiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaamadp
aaaamadpaaaaaaaaaaaaaaaaegbabaaaabaaaaaadcaaaaandccabaaaadaaaaaa
egiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaamalpaaaamadpaaaaaaaaaaaaaaaa
egbabaaaabaaaaaadcaaaaandccabaaaaeaaaaaaegiacaaaaaaaaaaaacaaaaaa
aceaaaaaaaaamalpaaaamalpaaaaaaaaaaaaaaaaegbabaaaabaaaaaadcaaaaan
dccabaaaafaaaaaaegiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaamadpaaaamalp
aaaaaaaaaaaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedfhholgimbdpnbaholemenabmfmgaeifiabaaaaaakmaeaaaaaeaaaaaa
daaaaaaaieabaaaakaadaaaapeadaaaaebgpgodjemabaaaaemabaaaaaaacpopp
amabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaamadpaaaamalpaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaadiaabaaoekaaeaaaaaeabaaadoa
aaaaoeiaagaaaakaabaaoejaaeaaaaaeacaaadoaaaaaoeiaagaaobkaabaaoeja
aeaaaaaeadaaadoaaaaaoeiaagaaffkaabaaoejaaeaaaaaeaeaaadoaaaaaoeia
agaaoekaabaaoejaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoaabaaoeja
ppppaaaafdeieefcbeacaaaaeaaaabaaifaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaaddccabaaaaeaaaaaagfaaaaaddccabaaaafaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaa
abaaaaaaegbabaaaabaaaaaadcaaaaandccabaaaacaaaaaaegiacaaaaaaaaaaa
acaaaaaaaceaaaaaaaaamadpaaaamadpaaaaaaaaaaaaaaaaegbabaaaabaaaaaa
dcaaaaandccabaaaadaaaaaaegiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaamalp
aaaamadpaaaaaaaaaaaaaaaaegbabaaaabaaaaaadcaaaaandccabaaaaeaaaaaa
egiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaamalpaaaamalpaaaaaaaaaaaaaaaa
egbabaaaabaaaaaadcaaaaandccabaaaafaaaaaaegiacaaaaaaaaaaaacaaaaaa
aceaaaaaaaaamadpaaaamalpaaaaaaaaaaaaaaaaegbabaaaabaaaaaadoaaaaab
ejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
faepfdejfeejepeoaafeeffiedepepfceeaaklklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_Parameter]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { program.local[0] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R4, fragment.texcoord[4], texture[0], 2D;
TEX R3, fragment.texcoord[3], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MAX R0, R0, R1;
MAX R0, R0, R2;
MAX R0, R0, R3;
MAX R0, R0, R4;
ADD_SAT result.color, R0, -c[0].w;
END
# 10 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Parameter]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl t0.xy
dcl t1.xy
dcl t2.xy
dcl t3.xy
dcl t4.xy
texld r0, t4, s0
texld r1, t3, s0
texld r4, t0, s0
texld r2, t2, s0
texld r3, t1, s0
max_pp r3, r4, r3
max_pp r2, r3, r2
max_pp r1, r2, r1
max_pp r0, r1, r0
add_pp_sat r0, r0, -c0.w
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 48 [_Parameter]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkcclndhbcfjmjhknmgadifbmebgdckhmabaaaaaapaacaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnaabaaaa
eaaaaaaaheaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaaddcbabaaa
aeaaaaaagcbaaaaddcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadeaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadeaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadeaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaafaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadeaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaacaaaajpccabaaaaaaaaaaaegaobaaaaaaaaaaapgipcaia
ebaaaaaaaaaaaaaaadaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 48 [_Parameter]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedabgiliejdmfppmhoggcljobcjpnnidjnabaaaaaacmaeaaaaaeaaaaaa
daaaaaaagiabaaaaeaadaaaapiadaaaaebgpgodjdaabaaaadaabaaaaaaacpppp
pmaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaadaaabaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaacdlabpaaaaac
aaaaaaiaabaacdlabpaaaaacaaaaaaiaacaacdlabpaaaaacaaaaaaiaadaacdla
bpaaaaacaaaaaaiaaeaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpia
aaaaoelaaaaioekaecaaaaadabaacpiaabaaoelaaaaioekaecaaaaadacaacpia
acaaoelaaaaioekaecaaaaadadaacpiaadaaoelaaaaioekaecaaaaadaeaacpia
aeaaoelaaaaioekaalaaaaadafaacpiaaaaaoeiaabaaoeiaalaaaaadaaaacpia
afaaoeiaacaaoeiaalaaaaadabaacpiaaaaaoeiaadaaoeiaalaaaaadaaaacpia
abaaoeiaaeaaoeiaacaaaaadaaaadpiaaaaaoeiaaaaappkbabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcnaabaaaaeaaaaaaaheaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
dcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaaddcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadeaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadeaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadeaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadeaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaaacaaaajpccabaaa
aaaaaaaaegaobaaaaaaaaaaapgipcaiaebaaaaaaaaaaaaaaadaaaaaadoaaaaab
ejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadadaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_TexelSize]
"!!ARBvp1.0
PARAM c[7] = { { 0, -1.5, -0.5, 0.5 },
		state.matrix.mvp,
		program.local[5],
		{ 0, 1.5 } };
TEMP R0;
MOV R0, c[0];
MAD result.texcoord[0].xy, R0, c[5], vertex.texcoord[0];
MAD result.texcoord[1].xy, R0.xzzw, c[5], vertex.texcoord[0];
MOV R0.yz, c[6].xxyw;
MAD result.texcoord[2].xy, R0.xwzw, c[5], vertex.texcoord[0];
MAD result.texcoord[3].xy, R0.yzzw, c[5], vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 10 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
def c5, 0.00000000, -1.50000000, -0.50000000, 0.50000000
def c6, 0.00000000, 1.50000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.xy, c4
mov r0.zw, c4.xyxy
mad oT0.xy, c5, r0, v1
mad oT1.xy, c5.xzzw, r0.zwzw, v1
mov r0.xy, c4
mov r0.zw, c4.xyxy
mad oT2.xy, c5.xwzw, r0, v1
mad oT3.xy, c6, r0.zwzw, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednccediciopgomcnifdonfhccjjkmhiefabaaaaaabmadaaaaadaaaaaa
cmaaaaaaiaaaaaaacaabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcpeabaaaaeaaaabaahnaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaandccabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaa
aceaaaaaaaaaaaaaaaaamalpaaaaaaaaaaaaaaaaegbabaaaabaaaaaadcaaaaan
dccabaaaacaaaaaaegiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaalp
aaaaaaaaaaaaaaaaegbabaaaabaaaaaadcaaaaandccabaaaadaaaaaaegiacaaa
aaaaaaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaaaaaaaaaaaaegbabaaa
abaaaaaadcaaaaandccabaaaaeaaaaaaegiacaaaaaaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaamadpaaaaaaaaaaaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedgdelofnajpnncgkfdjdlbfppbhlhgpfhabaaaaaaiaaeaaaaaeaaaaaa
daaaaaaajaabaaaaimadaaaaoaadaaaaebgpgodjfiabaaaafiabaaaaaaacpopp
biabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaaaaaaaaamalpaaaaaalpaaaaaadpfbaaaaafahaaapkaaaaaaaaa
aaaamadpaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjaabaaaaacaaaaadiaabaaoekaaeaaaaaeaaaaadoaaaaaoeiaagaaoeka
abaaoejaaeaaaaaeabaaadoaaaaaoeiaagaaoikaabaaoejaaeaaaaaeacaaadoa
aaaaoeiaagaaomkaabaaoejaaeaaaaaeadaaadoaaaaaoeiaahaaoekaabaaoeja
afaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiappppaaaafdeieefcpeabaaaaeaaaabaahnaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaandccabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaaaaaaaaaamalpaaaaaaaa
aaaaaaaaegbabaaaabaaaaaadcaaaaandccabaaaacaaaaaaegiacaaaaaaaaaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaalpaaaaaaaaaaaaaaaaegbabaaaabaaaaaa
dcaaaaandccabaaaadaaaaaaegiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaadpaaaaaaaaaaaaaaaaegbabaaaabaaaaaadcaaaaandccabaaaaeaaaaaa
egiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaaaaaaaaaamadpaaaaaaaaaaaaaaaa
egbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 0.25 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R3, fragment.texcoord[3], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
ADD R0, R0, R1;
ADD R0, R0, R2;
ADD R0, R0, R3;
MUL result.color, R0, c[0].x;
END
# 8 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 0.25000000, 0, 0, 0
dcl t0.xy
dcl t1.xy
dcl t2.xy
dcl t3.xy
texld r0, t3, s0
texld r1, t2, s0
texld r2, t1, s0
texld r3, t0, s0
add_pp r2, r3, r2
add_pp r1, r2, r1
add_pp r0, r1, r0
mul_pp r0, r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefieceddblmdpkkoejbibfmcfllbbaeigaeflglabaaaaaaiaacaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefchiabaaaaeaaaaaaafoaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaakpccabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaiadodoaaaaab
"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecednomdnanglndngikibbfggbofpkeichhpabaaaaaajmadaaaaaeaaaaaa
daaaaaaaeiabaaaamiacaaaagiadaaaaebgpgodjbaabaaaabaabaaaaaaacpppp
oiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadoaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaacdlabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaiaacaacdla
bpaaaaacaaaaaaiaadaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpia
aaaaoelaaaaioekaecaaaaadabaaapiaabaaoelaaaaioekaecaaaaadacaaapia
acaaoelaaaaioekaecaaaaadadaaapiaadaaoelaaaaioekaacaaaaadaaaacpia
aaaaoeiaabaaoeiaacaaaaadaaaacpiaacaaoeiaaaaaoeiaacaaaaadaaaacpia
adaaoeiaaaaaoeiaafaaaaadaaaacpiaaaaaoeiaaaaaaakaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefchiabaaaaeaaaaaaafoaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaaddcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaak
pccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiado
aaaaiadodoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_TexelSize]
"!!ARBvp1.0
PARAM c[7] = { { -1.5, 0, -0.5, 0.5 },
		state.matrix.mvp,
		program.local[5],
		{ 1.5, 0 } };
TEMP R0;
MOV R0, c[0];
MAD result.texcoord[0].xy, R0, c[5], vertex.texcoord[0];
MAD result.texcoord[1].xy, R0.zyzw, c[5], vertex.texcoord[0];
MOV R0.xz, c[6].xyyw;
MAD result.texcoord[2].xy, R0.wyzw, c[5], vertex.texcoord[0];
MAD result.texcoord[3].xy, R0.xzzw, c[5], vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 10 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
def c5, -1.50000000, 0.00000000, -0.50000000, 0.50000000
def c6, 1.50000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.xy, c4
mov r0.zw, c4.xyxy
mad oT0.xy, c5, r0, v1
mad oT1.xy, c5.zyzw, r0.zwzw, v1
mov r0.xy, c4
mov r0.zw, c4.xyxy
mad oT2.xy, c5.wyzw, r0, v1
mad oT3.xy, c6, r0.zwzw, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefieceddkjihegmaibabcccjgapmlpomjfdfdelabaaaaaabmadaaaaadaaaaaa
cmaaaaaaiaaaaaaacaabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcpeabaaaaeaaaabaahnaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaandccabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaa
aceaaaaaaaaamalpaaaaaaaaaaaaaaaaaaaaaaaaegbabaaaabaaaaaadcaaaaan
dccabaaaacaaaaaaegiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaaaalpaaaaaaaa
aaaaaaaaaaaaaaaaegbabaaaabaaaaaadcaaaaandccabaaaadaaaaaaegiacaaa
aaaaaaaaacaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaaegbabaaa
abaaaaaadcaaaaandccabaaaaeaaaaaaegiacaaaaaaaaaaaacaaaaaaaceaaaaa
aaaamadpaaaaaaaaaaaaaaaaaaaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedkbcbnndgfejbicdpicclpgnanmnkhgaeabaaaaaaiaaeaaaaaeaaaaaa
daaaaaaajaabaaaaimadaaaaoaadaaaaebgpgodjfiabaaaafiabaaaaaaacpopp
biabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaamalpaaaaaaaaaaaaaalpaaaaaadpfbaaaaafahaaapkaaaaamadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjaabaaaaacaaaaadiaabaaoekaaeaaaaaeaaaaadoaaaaaoeiaagaaoeka
abaaoejaaeaaaaaeabaaadoaaaaaoeiaagaaogkaabaaoejaaeaaaaaeacaaadoa
aaaaoeiaagaaohkaabaaoejaaeaaaaaeadaaadoaaaaaoeiaahaaoekaabaaoeja
afaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiappppaaaafdeieefcpeabaaaaeaaaabaahnaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaaddccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaandccabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaamalpaaaaaaaaaaaaaaaa
aaaaaaaaegbabaaaabaaaaaadcaaaaandccabaaaacaaaaaaegiacaaaaaaaaaaa
acaaaaaaaceaaaaaaaaaaalpaaaaaaaaaaaaaaaaaaaaaaaaegbabaaaabaaaaaa
dcaaaaandccabaaaadaaaaaaegiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaaegbabaaaabaaaaaadcaaaaandccabaaaaeaaaaaa
egiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaamadpaaaaaaaaaaaaaaaaaaaaaaaa
egbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 0.25 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R3, fragment.texcoord[3], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
ADD R0, R0, R1;
ADD R0, R0, R2;
ADD R0, R0, R3;
MUL result.color, R0, c[0].x;
END
# 8 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 0.25000000, 0, 0, 0
dcl t0.xy
dcl t1.xy
dcl t2.xy
dcl t3.xy
texld r0, t3, s0
texld r1, t2, s0
texld r2, t1, s0
texld r3, t0, s0
add_pp r2, r3, r2
add_pp r1, r2, r1
add_pp r0, r1, r0
mul_pp r0, r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefieceddblmdpkkoejbibfmcfllbbaeigaeflglabaaaaaaiaacaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefchiabaaaaeaaaaaaafoaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaakpccabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiadoaaaaiadodoaaaaab
"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecednomdnanglndngikibbfggbofpkeichhpabaaaaaajmadaaaaaeaaaaaa
daaaaaaaeiabaaaamiacaaaagiadaaaaebgpgodjbaabaaaabaabaaaaaaacpppp
oiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadoaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaacdlabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaiaacaacdla
bpaaaaacaaaaaaiaadaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpia
aaaaoelaaaaioekaecaaaaadabaaapiaabaaoelaaaaioekaecaaaaadacaaapia
acaaoelaaaaioekaecaaaaadadaaapiaadaaoelaaaaioekaacaaaaadaaaacpia
aaaaoeiaabaaoeiaacaaaaadaaaacpiaacaaoeiaaaaaoeiaacaaaaadaaaacpia
adaaoeiaaaaaoeiaafaaaaadaaaacpiaaaaaoeiaaaaaaakaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefchiabaaaaeaaaaaaafoaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaaddcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaak
pccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadoaaaaiadoaaaaiado
aaaaiadodoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0], vertex.texcoord[0].xyxy;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c5
slt r0.x, c4.y, r0
max r0.x, -r0, r0
slt r0.x, c5, r0
add r0.y, -r0.x, c5
mul r0.z, v1.y, r0.y
add r0.y, -v1, c5
mad oT0.w, r0.x, r0.y, r0.z
mov oT0.xyz, v1.xyxw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedhkjfkbcnhkcdleheomblljgbhkjnflmmabaaaaaaoeabaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcaeabaaaa
eaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbebaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0_level_9_1
eefiecednpdooailbcccdekmjjmimbldnffekibmabaaaaaalmacaaaaaeaaaaaa
daaaaaaaaeabaaaabaacaaaageacaaaaebgpgodjmmaaaaaammaaaaaaaaacpopp
jiaaaaaadeaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaabaadaaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapia
abaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaeaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaapoaabaaeeja
ppppaaaafdeieefcaeabaaaaeaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
abaaaaaaegbebaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfc
eeaaklklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_ColorMix]
Vector 1 [_Parameter]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Bloom] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[0].zwzw, texture[1], 2D;
ADD R2, R0, -c[0];
ABS R3.xyz, R2;
DP3 R3.x, R3, c[2];
MUL R3.x, R3, c[1];
MAD R0, R3.x, -R2, R0;
ADD result.color, R0, R1;
END
# 8 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_ColorMix]
Vector 1 [_Parameter]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Bloom] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c2, 0.21997070, 0.70703125, 0.07098389, 0
dcl t0
texld r2, t0, s0
mov r0.y, t0.w
mov r0.x, t0.z
add_pp r3, r2, -c0
texld r1, r0, s1
abs_pp r0.xyz, r3
dp3_pp r0.x, r0, c2
mul_pp r0.x, r0, c1
mad_pp r0, r0.x, -r3, r2
add_pp r0, r0, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Bloom] 2D 1
ConstBuffer "$Globals" 64
Vector 16 [_ColorMix]
Vector 48 [_Parameter]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhajdgfjaplhlocigbjhlndnmimalnphcabaaaaaafaacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjaabaaaa
eaaaaaaageaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajhcaabaaaabaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaabaaaaaabaaaaaalbcaabaaa
abaaaaaaegacbaiaibaaaaaaabaaaaaaaceaaaaakoehgbdopepndedphdgijbdn
aaaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaa
adaaaaaaaaaaaaajpcaabaaaacaaaaaaegaobaiaebaaaaaaaaaaaaaaegiocaaa
aaaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaaagaabaaaabaaaaaaegaobaaa
acaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Bloom] 2D 1
ConstBuffer "$Globals" 64
Vector 16 [_ColorMix]
Vector 48 [_Parameter]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedfghnolihlodilhjghhfldifgadbaaaikabaaaaaaiiadaaaaaeaaaaaa
daaaaaaageabaaaapmacaaaafeadaaaaebgpgodjcmabaaaacmabaaaaaaacpppp
oiaaaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaaaadaaabaaabaaaaaaaaaaaaacpppp
fbaaaaafacaaapkakoehgbdopepndedphdgijbdnaaaaaaaabpaaaaacaaaaaaia
aaaacplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaabaaaaac
aaaacbiaaaaakklaabaaaaacaaaacciaaaaapplaecaaaaadabaacpiaaaaaoela
aaaioekaecaaaaadaaaaapiaaaaaoeiaabaioekaacaaaaadacaachiaabaaoeia
aaaaoekbcdaaaaacacaachiaacaaoeiaaiaaaaadacaacbiaacaaoeiaacaaoeka
afaaaaadacaacbiaacaaaaiaabaaaakabcaaaaaeadaacpiaacaaaaiaaaaaoeka
abaaoeiaacaaaaadaaaacpiaaaaaoeiaadaaoeiaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcjaabaaaaeaaaaaaageaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaajhcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaa
abaaaaaabaaaaaalbcaabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaaaceaaaaa
koehgbdopepndedphdgijbdnaaaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaaakiacaaaaaaaaaaaadaaaaaaaaaaaaajpcaabaaaacaaaaaaegaobaia
ebaaaaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaa
agaabaaaabaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaah
pccabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_TexelSize]
"!!ARBvp1.0
PARAM c[6] = { { 1.5, -1.5 },
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
MOV R0.xy, c[0];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MAD result.texcoord[1].xy, R0.x, c[5], vertex.texcoord[0];
MAD result.texcoord[2].xy, R0.yxzw, c[5], vertex.texcoord[0];
MAD result.texcoord[3].xy, R0.y, c[5], vertex.texcoord[0];
MAD result.texcoord[4].xy, R0, c[5], vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 10 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_2_0
def c5, 1.50000000, -1.50000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.xy, c4
mov r0.zw, c4.xyxy
mad oT1.xy, c5.x, r0, v1
mad oT2.xy, c5.yxzw, r0.zwzw, v1
mov r0.xy, c4
mov r0.zw, c4.xyxy
mov oT0.xy, v1
mad oT3.xy, c5.y, r0, v1
mad oT4.xy, c5, r0.zwzw, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgkfblgfkacljedngdgfakkhmaclajkeiabaaaaaafeadaaaaadaaaaaa
cmaaaaaaiaaaaaaadiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcbeacaaaa
eaaaabaaifaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaaddccabaaaafaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
dcaaaaandccabaaaacaaaaaaegiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaamadp
aaaamadpaaaaaaaaaaaaaaaaegbabaaaabaaaaaadcaaaaandccabaaaadaaaaaa
egiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaamalpaaaamadpaaaaaaaaaaaaaaaa
egbabaaaabaaaaaadcaaaaandccabaaaaeaaaaaaegiacaaaaaaaaaaaacaaaaaa
aceaaaaaaaaamalpaaaamalpaaaaaaaaaaaaaaaaegbabaaaabaaaaaadcaaaaan
dccabaaaafaaaaaaegiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaamadpaaaamalp
aaaaaaaaaaaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedfhholgimbdpnbaholemenabmfmgaeifiabaaaaaakmaeaaaaaeaaaaaa
daaaaaaaieabaaaakaadaaaapeadaaaaebgpgodjemabaaaaemabaaaaaaacpopp
amabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaamadpaaaamalpaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaadiaabaaoekaaeaaaaaeabaaadoa
aaaaoeiaagaaaakaabaaoejaaeaaaaaeacaaadoaaaaaoeiaagaaobkaabaaoeja
aeaaaaaeadaaadoaaaaaoeiaagaaffkaabaaoejaaeaaaaaeaeaaadoaaaaaoeia
agaaoekaabaaoejaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoaabaaoeja
ppppaaaafdeieefcbeacaaaaeaaaabaaifaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaaddccabaaaaeaaaaaagfaaaaaddccabaaaafaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaa
abaaaaaaegbabaaaabaaaaaadcaaaaandccabaaaacaaaaaaegiacaaaaaaaaaaa
acaaaaaaaceaaaaaaaaamadpaaaamadpaaaaaaaaaaaaaaaaegbabaaaabaaaaaa
dcaaaaandccabaaaadaaaaaaegiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaamalp
aaaamadpaaaaaaaaaaaaaaaaegbabaaaabaaaaaadcaaaaandccabaaaaeaaaaaa
egiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaamalpaaaamalpaaaaaaaaaaaaaaaa
egbabaaaabaaaaaadcaaaaandccabaaaafaaaaaaegiacaaaaaaaaaaaacaaaaaa
aceaaaaaaaaamadpaaaamalpaaaaaaaaaaaaaaaaegbabaaaabaaaaaadoaaaaab
ejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
faepfdejfeejepeoaafeeffiedepepfceeaaklklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_Parameter]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[2] = { program.local[0],
		{ 1, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R4, fragment.texcoord[4], texture[0], 2D;
TEX R3, fragment.texcoord[3], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MAX R0, R0, R1;
MAX R0, R0, R2;
MAX R0, R0, R3;
MAX R0, R0, R4;
ADD R0, R0, c[1].xyyy;
ADD_SAT result.color, R0, -c[0].w;
END
# 11 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Parameter]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c1, 1.00000000, 0.00000000, 0, 0
dcl t0.xy
dcl t1.xy
dcl t2.xy
dcl t3.xy
dcl t4.xy
texld r0, t4, s0
texld r1, t3, s0
texld r4, t0, s0
texld r2, t2, s0
texld r3, t1, s0
max_pp r3, r4, r3
max_pp r2, r3, r2
max_pp r1, r2, r1
max_pp r1, r1, r0
mov r0.x, c1
mov r0.yzw, c1.y
add_pp r0, r1, r0
add_pp_sat r0, r0, -c0.w
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 48 [_Parameter]
BindCB  "$Globals" 0
"ps_4_0
eefiecednijcbdpkpklmdimpccanlbaljeiokjpeabaaaaaabiadaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpiabaaaa
eaaaaaaahoaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaaddcbabaaa
aeaaaaaagcbaaaaddcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadeaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadeaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadeaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaafaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadeaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaacaaaajpccabaaaaaaaaaaaegaobaaa
aaaaaaaapgipcaiaebaaaaaaaaaaaaaaadaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 48 [_Parameter]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedlfneokkcbmhgecihkjjadhlgplhplgdoabaaaaaahmaeaaaaaeaaaaaa
daaaaaaajaabaaaajaadaaaaeiaeaaaaebgpgodjfiabaaaafiabaaaaaaacpppp
ceabaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaadaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaiaabaacdla
bpaaaaacaaaaaaiaacaacdlabpaaaaacaaaaaaiaadaacdlabpaaaaacaaaaaaia
aeaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpiaaaaaoelaaaaioeka
ecaaaaadabaacpiaabaaoelaaaaioekaecaaaaadacaacpiaacaaoelaaaaioeka
ecaaaaadadaacpiaadaaoelaaaaioekaecaaaaadaeaacpiaaeaaoelaaaaioeka
alaaaaadafaacpiaaaaaoeiaabaaoeiaalaaaaadaaaacpiaafaaoeiaacaaoeia
alaaaaadabaacpiaaaaaoeiaadaaoeiaalaaaaadaaaacpiaabaaoeiaaeaaoeia
acaaaaadaaaacpiaaaaaoeiaabaaoekaacaaaaadaaaadpiaaaaaoeiaaaaappkb
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcpiabaaaaeaaaaaaahoaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaad
dcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadeaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadeaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadeaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadeaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaaaacaaaajpccabaaaaaaaaaaaegaobaaaaaaaaaaapgipcaia
ebaaaaaaaaaaaaaaadaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaa
keaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}