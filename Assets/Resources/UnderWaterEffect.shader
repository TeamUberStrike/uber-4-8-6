Shader "CMune/Under Water Effect" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _RampTex ("Base (RGB)", 2D) = "grayscaleRamp" {}
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
Vector 5 [_CenterRadius]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
MOV result.texcoord[0].xy, vertex.texcoord[0];
ADD result.texcoord[1].xy, vertex.texcoord[0], -c[5];
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
Vector 4 [_CenterRadius]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
mov oT0.xy, v1
add oT1.xy, v1, -c4
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 16 [_CenterRadius]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedkclaongmdmdkfemoninbmlonaoojdjjbabaaaaaadmacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfagphdgjhe
gjgpgoaafeeffiedepepfceeaaklklklfdeieefceeabaaaaeaaaabaafbaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadmccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aaaaaaajmccabaaaabaaaaaaagbebaaaabaaaaaaagiecaiaebaaaaaaaaaaaaaa
abaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 16 [_CenterRadius]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedfcempnhdfcjonfebjnbdildijmakggdkabaaaaaadaadaaaaaeaaaaaa
daaaaaaacaabaaaagmacaaaamaacaaaaebgpgodjoiaaaaaaoiaaaaaaaaacpopp
kiaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaacaaaaadaaaaamoaabaabeja
abaabekbafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoaabaaoejappppaaaa
fdeieefceeabaaaaeaaaabaafbaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaajmccabaaaabaaaaaaagbebaaa
abaaaaaaagiecaiaebaaaaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaabaaaaaa
egbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaafdfgfpfagphdgjhe
gjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_RotationMatrix]
Vector 4 [_ZBufferParams]
Vector 5 [_CenterRadius]
Float 6 [_FadeDistance]
Float 7 [_EffectWeight]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RampTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[10] = { program.local[0..7],
		{ 0, 1, 9.9999997e-006, 1.9999999e-005 },
		{ 2.9999999e-005 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.zw, c[8].x;
RCP R0.y, c[5].w;
RCP R0.x, c[5].z;
MUL R0.xy, fragment.texcoord[1], R0;
MUL R0.xy, R0, R0;
ADD R1.x, R0, R0.y;
MOV R0.xy, fragment.texcoord[1];
RSQ R1.z, R1.x;
DP4 R1.y, R0, c[1];
DP4 R1.x, R0, c[0];
RCP R0.x, R1.z;
ADD R0.zw, fragment.texcoord[1].xyxy, -R1.xyxy;
MIN R0.x, R0, c[8].y;
MAD R0.xy, R0.x, R0.zwzw, R1;
ADD R0.xy, R0, c[5];
ADD R0.xy, R0, -fragment.texcoord[0];
MAD R1.xy, R0, c[7].x, fragment.texcoord[0];
TEX R2, R1, texture[0], 2D;
TEX R1.x, R1, texture[2], 2D;
TEX R0.z, R2.z, texture[1], 2D;
TEX R0.y, R2.y, texture[1], 2D;
TEX R0.x, R2.x, texture[1], 2D;
MAD R0.w, R1.x, c[4].x, c[4].y;
RCP R0.w, R0.w;
RCP R1.x, c[6].x;
MUL_SAT R1.x, R0.w, R1;
ADD R0.x, R0, c[8].z;
ADD R0.y, R0, c[8].w;
MOV R0.w, R2;
ADD R0.z, R0, c[9].x;
ADD R0, R0, -R2;
MUL R1.x, R1, c[7];
MAD result.color, R1.x, R0, R2;
END
# 33 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_RotationMatrix]
Vector 4 [_ZBufferParams]
Vector 5 [_CenterRadius]
Float 6 [_FadeDistance]
Float 7 [_EffectWeight]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RampTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c9, 1.00000000, 0.00000000, 0.00001000, 0.00002000
def c10, 0.00003000, 0, 0, 0
dcl t0.xy
dcl t1.xy
mov r1.zw, c9.y
mov r1.xy, t1
dp4 r2.y, r1, c1
dp4 r2.x, r1, c0
add r1.xy, t1, -r2
rcp r0.y, c5.w
rcp r0.x, c5.z
mul r0.xy, t1, r0
mul r0.xy, r0, r0
add r0.x, r0, r0.y
rsq r0.x, r0.x
rcp r0.x, r0.x
min r0.x, r0, c9
mad r0.xy, r0.x, r1, r2
add r0.xy, r0, c5
add r0.xy, r0, -t0
mad r4.xy, r0, c7.x, t0
add r0.x, -r4.y, c9
texld r1, r4, s0
cmp r4.y, c8, r4, r0.x
mov r3.xy, r1.x
mov r2.xy, r1.y
mov r0.xy, r1.z
texld r0, r0, s1
texld r4, r4, s2
texld r3, r3, s1
texld r2, r2, s1
mad r2.x, r4, c4, c4.y
rcp r2.x, r2.x
rcp r0.x, c6.x
mul_sat r0.x, r2, r0
add r2.z, r0, c10.x
add r2.x, r3, c9.z
add r2.y, r2, c9.w
mov_pp r2.w, r1
add_pp r2, r2, -r1
mul r0.x, r0, c7
mad_pp r0, r0.x, r2, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RampTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
ConstBuffer "$Globals" 128
Matrix 32 [_RotationMatrix]
Vector 16 [_CenterRadius]
Float 96 [_FadeDistance]
Float 100 [_EffectWeight]
Vector 112 [_MainTex_TexelSize]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedkmkoofdonloimbmbfcedahpiechdfmhfabaaaaaageafaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcimaeaaaaeaaaaaaacdabaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadmcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
aoaaaaaidcaabaaaaaaaaaaaogbkbaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaa
apaaaaahbcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaelaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaaigcaabaaaaaaaaaaapgbpbaaaabaaaaaa
agibcaaaaaaaaaaaadaaaaaadcaaaaakgcaabaaaaaaaaaaaagibcaaaaaaaaaaa
acaaaaaakgbkbaaaabaaaaaafgagbaaaaaaaaaaaaaaaaaaidcaabaaaabaaaaaa
jgafbaiaebaaaaaaaaaaaaaaogbkbaaaabaaaaaadcaaaaajdcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegaabaaaabaaaaaajgafbaaaaaaaaaaaaaaaaaaidcaabaaa
aaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaabaaaaaaaaaaaaaidcaabaaa
aaaaaaaaegaabaaaaaaaaaaaegbabaiaebaaaaaaabaaaaaadcaaaaakdcaabaaa
aaaaaaaafgifcaaaaaaaaaaaagaaaaaaegaabaaaaaaaaaaaegbabaaaabaaaaaa
aaaaaaaiicaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
dbaaaaaibcaabaaaabaaaaaabkiacaaaaaaaaaaaahaaaaaaabeaaaaaaaaaaaaa
dhaaaaajecaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaabkaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaigaabaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaaabaaaaaa
ahaaaaaaakaabaaaabaaaaaabkiacaaaabaaaaaaahaaaaaaaoaaaaakbcaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaa
aoaaaaalccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
akiacaaaaaaaaaaaagaaaaaadicaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaabkiacaaa
aaaaaaaaagaaaaaaefaaaaajpcaabaaaacaaaaaaagaabaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
abeaaaaakmmfchdhefaaaaajpcaabaaaadaaaaaafgafbaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaahccaabaaaacaaaaaabkaabaaaadaaaaaa
abeaaaaakmmfkhdhefaaaaajpcaabaaaadaaaaaakgakbaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaahecaabaaaacaaaaaackaabaaaadaaaaaa
abeaaaaaickipldhdgaaaaaficaabaaaacaaaaaadkaabaaaaaaaaaaaaaaaaaai
pcaabaaaacaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaacaaaaaadcaaaaaj
pccabaaaaaaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RampTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
ConstBuffer "$Globals" 128
Matrix 32 [_RotationMatrix]
Vector 16 [_CenterRadius]
Float 96 [_FadeDistance]
Float 100 [_EffectWeight]
Vector 112 [_MainTex_TexelSize]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0_level_9_1
eefiecedobgklhpjbeioclpombchneamnldcamkjabaaaaaadiaiaaaaaeaaaaaa
daaaaaaaaaadaaaajeahaaaaaeaiaaaaebgpgodjmiacaaaamiacaaaaaaacpppp
heacaaaafeaaaaaaadaadaaaaaaafeaaaaaafeaaadaaceaaaaaafeaaaaaaaaaa
abababaaacacacaaaaaaabaaadaaaaaaaaaaaaaaaaaaagaaacaaadaaaaaaaaaa
abaaahaaabaaafaaaaaaaaaaaaacppppfbaaaaafagaaapkaaaaaaaaaaaaaiadp
kmmfchdhkmmfkhdhfbaaaaafahaaapkaickipldhaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkaagaaaaacaaaaabiaaaaakkkaagaaaaac
aaaaaciaaaaappkaafaaaaadaaaaadiaaaaaoeiaaaaabllafkaaaaaeaaaaabia
aaaaoeiaaaaaoeiaagaaaakaahaaaaacaaaaabiaaaaaaaiaagaaaaacaaaaabia
aaaaaaiaakaaaaadabaaaiiaaaaaaaiaagaaffkaafaaaaadaaaaadiaaaaakkla
acaaoekaaeaaaaaeaaaaadiaabaaoekaaaaapplaaaaaoeiabcaaaaaeacaaadia
abaappiaaaaabllaaaaaoeiaacaaaaadaaaaadiaacaaoeiaaaaaoekabcaaaaae
abaaadiaadaaffkaaaaaoeiaaaaaoelaacaaaaadaaaaabiaabaaffibagaaffka
fiaaaaaeaaaaaciaaeaaffkaabaaffiaaaaaaaiaabaaaaacaaaaabiaabaaaaia
ecaaaaadabaacpiaabaaoeiaaaaioekaabaaaaacacaacdiaabaaaaiaabaaaaac
adaacdiaabaaffiaabaaaaacaeaacdiaabaakkiaecaaaaadaaaacpiaaaaaoeia
acaioekaecaaaaadacaaapiaacaaoeiaabaioekaecaaaaadadaaapiaadaaoeia
abaioekaecaaaaadaeaaapiaaeaaoeiaabaioekaaeaaaaaeaaaaabiaafaaaaka
aaaaaaiaafaaffkaagaaaaacaaaacbiaaaaaaaiaagaaaaacaaaaaciaadaaaaka
afaaaaadaaaadbiaaaaaffiaaaaaaaiaafaaaaadaaaaabiaaaaaaaiaadaaffka
acaaaaadacaacbiaacaaaaiaagaakkkaacaaaaadacaacciaadaaffiaagaappka
acaaaaadacaaceiaaeaakkiaahaaaakaabaaaaacacaaciiaabaappiabcaaaaae
adaacpiaaaaaaaiaacaaoeiaabaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaa
fdeieefcimaeaaaaeaaaaaaacdabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaa
fjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaaidcaabaaaaaaaaaaaogbkbaaa
abaaaaaaogikcaaaaaaaaaaaabaaaaaaapaaaaahbcaabaaaaaaaaaaaegaabaaa
aaaaaaaaegaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaai
gcaabaaaaaaaaaaapgbpbaaaabaaaaaaagibcaaaaaaaaaaaadaaaaaadcaaaaak
gcaabaaaaaaaaaaaagibcaaaaaaaaaaaacaaaaaakgbkbaaaabaaaaaafgagbaaa
aaaaaaaaaaaaaaaidcaabaaaabaaaaaajgafbaiaebaaaaaaaaaaaaaaogbkbaaa
abaaaaaadcaaaaajdcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaa
jgafbaaaaaaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaa
aaaaaaaaabaaaaaaaaaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegbabaia
ebaaaaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaafgifcaaaaaaaaaaaagaaaaaa
egaabaaaaaaaaaaaegbabaaaabaaaaaaaaaaaaaiicaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaibcaabaaaabaaaaaabkiacaaa
aaaaaaaaahaaaaaaabeaaaaaaaaaaaaadhaaaaajecaabaaaaaaaaaaaakaabaaa
abaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
igaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaal
bcaabaaaabaaaaaaakiacaaaabaaaaaaahaaaaaaakaabaaaabaaaaaabkiacaaa
abaaaaaaahaaaaaaaoaaaaakbcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaabaaaaaaaoaaaaalccaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakiacaaaaaaaaaaaagaaaaaadicaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaabkiacaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaa
acaaaaaaagaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaakmmfchdhefaaaaajpcaabaaa
adaaaaaafgafbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaah
ccaabaaaacaaaaaabkaabaaaadaaaaaaabeaaaaakmmfkhdhefaaaaajpcaabaaa
adaaaaaakgakbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaah
ecaabaaaacaaaaaackaabaaaadaaaaaaabeaaaaaickipldhdgaaaaaficaabaaa
acaaaaaadkaabaaaaaaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaiaebaaaaaa
aaaaaaaaegaobaaaacaaaaaadcaaaaajpccabaaaaaaaaaaaagaabaaaabaaaaaa
egaobaaaacaaaaaaegaobaaaaaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}