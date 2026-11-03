Shader "Hidden/ContrastComposite" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "" {}
 _MainTexBlurred ("Base Blurred (RGB)", 2D) = "" {}
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
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.texcoord[1].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mad oT0.y, r0.x, r0, r0.z
mov oT1.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT0.x, v1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedoihglfbnckeogeipbdkbcaeaacdejefkabaaaaaajaacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfagphdgjhe
gjgpgoaafeeffiedepepfceeaaklklklfdeieefcjiabaaaaeaaaabaaggaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dhaaaaajcccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecediidoiigpibcjplpnifhemhllcimkjcamabaaaaaanmadaaaaaeaaaaaa
daaaaaaahiabaaaabiadaaaagmadaaaaebgpgodjeaabaaaaeaabaaaaaaacpopp
aaabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaaaaaaaaaaamaaaaaiadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaabaaaaacaaaaabiaagaaaakaamaaaaadaaaaabia
abaaffkaaaaaaaiaaeaaaaaeaaaaaciaabaaffjaagaaffkaagaakkkaaeaaaaae
aaaaacoaaaaaaaiaaaaaffiaabaaffjaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaaboaabaaaajaabaaaaacabaaadoaabaaoejappppaaaafdeieefcjiabaaaa
eaaaabaaggaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadbaaaaaibcaabaaaaaaaaaaabkiacaaaaaaaaaaaabaaaaaa
abeaaaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpdhaaaaajcccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaabkbabaaaabaaaaaadgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaa
acaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
ebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeo
aafeeffiedepepfceeaaklklepfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [intensity]
Float 1 [threshhold]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MainTexBlurred] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 0, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[1], texture[0], 2D;
TEX R1, fragment.texcoord[0], texture[1], 2D;
ADD R2, R0, -R1;
SLT R3, c[2].x, R2;
SLT R1, R0, R1;
ADD R1, R3, -R1;
MOV R4.x, c[2].y;
ADD R3.x, R4, -c[1];
ADD_SAT R2, R2, -c[1].x;
RCP R3.x, R3.x;
MUL R1, R2, R1;
MUL R1, R1, R3.x;
MUL R1, R1, c[0].x;
ADD result.color, R0, R1;
END
# 14 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [intensity]
Float 1 [threshhold]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MainTexBlurred] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c2, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
dcl t1.xy
texld r0, t0, s1
texld r1, t1, s0
add_pp r2, r1, -r0
mov r0.x, c1
add r0.x, c2.y, -r0
cmp_pp r3, -r2, c2.x, c2.y
cmp_pp r4, r2, c2.x, c2.y
add_pp r3, r3, -r4
add_sat r2, r2, -c1.x
rcp r0.x, r0.x
mul r2, r2, r3
mul r0, r2, r0.x
mul r0, r0, c0.x
add_pp r0, r1, r0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MainTexBlurred] 2D 1
ConstBuffer "$Globals" 48
Float 32 [intensity]
Float 36 [threshhold]
BindCB  "$Globals" 0
"ps_4_0
eefiecedokjhomhpbgnbdmkokfpijdaojemnlgegabaaaaaaomacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbeacaaaaeaaaaaaaifaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaai
pcaabaaaaaaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadbaaaaak
pcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegaobaaa
aaaaaaaadbaaaaakpcaabaaaadaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaacaaaajpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
fgifcaiaebaaaaaaaaaaaaaaacaaaaaaboaaaaaipcaabaaaacaaaaaaegaobaia
ebaaaaaaacaaaaaaegaobaaaadaaaaaaclaaaaafpcaabaaaacaaaaaaegaobaaa
acaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaa
aaaaaaajbcaabaaaacaaaaaabkiacaiaebaaaaaaaaaaaaaaacaaaaaaabeaaaaa
aaaaiadpaoaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagaabaaaacaaaaaa
dcaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaa
egaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_MainTexBlurred] 2D 1
ConstBuffer "$Globals" 48
Float 32 [intensity]
Float 36 [threshhold]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedfgjhneoaggloppkocheijmmnjgngbbggabaaaaaagaaeaaaaaeaaaaaa
daaaaaaakaabaaaalmadaaaacmaeaaaaebgpgodjgiabaaaagiabaaaaaaacpppp
daabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaacaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaaa
aaaaiadpaaaaaaiaaaaaialpbpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaia
abaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaacpiaaaaaoelaabaioekaecaaaaadabaacpiaabaaoelaaaaioekaacaaaaad
aaaacpiaaaaaoeibabaaoeiafiaaaaaeacaacpiaaaaaoeibabaaaakaabaaffka
fiaaaaaeadaacpiaaaaaoeiaabaakkkaabaappkaacaaaaadaaaabpiaaaaaoeia
aaaaffkbacaaaaadacaacpiaacaaoeiaadaaoeiaafaaaaadaaaaapiaaaaaoeia
acaaoeiaabaaaaacacaaaciaabaaffkaacaaaaadacaaabiaacaaffiaaaaaffkb
agaaaaacacaaabiaacaaaaiaafaaaaadaaaacpiaaaaaoeiaacaaaaiaaeaaaaae
aaaacpiaaaaaoeiaaaaaaakaabaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcbeacaaaaeaaaaaaaifaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaiaebaaaaaa
aaaaaaaaegaobaaaabaaaaaadbaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaakpcaabaaaadaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacaaaaj
pcaabaaaaaaaaaaaegaobaaaaaaaaaaafgifcaiaebaaaaaaaaaaaaaaacaaaaaa
boaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaaacaaaaaaegaobaaaadaaaaaa
claaaaafpcaabaaaacaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaacaaaaaaaaaaaaajbcaabaaaacaaaaaabkiacaia
ebaaaaaaaaaaaaaaacaaaaaaabeaaaaaaaaaiadpaoaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaagaabaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaa
aaaaaaaaagiacaaaaaaaaaaaacaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheo
giaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
}
 }
}
Fallback Off
}