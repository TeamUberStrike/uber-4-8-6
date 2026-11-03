Shader "Cross Platform Shaders/AlphaRenderTexture Add" {
Properties {
 _TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
 _MainTex ("Particle Texture", 2D) = "white" {}
 _InvFade ("Soft Particles Factor", Range(0.01,3)) = 1
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "color", Color
   Bind "texcoord", TexCoord
  }
  ZWrite Off
  Cull Off
  Fog {
   Color (0,0,0,0)
  }
  Blend SrcAlpha One
  AlphaTest Greater 0.01
  ColorMask RGB
Program "vp" {
SubProgram "opengl " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Vector 5 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.attrib[14], c[5], c[5].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
MOV result.texcoord[2].z, vertex.attrib[14];
END
# 8 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dcl_tangent0 v3
mov oD0, v1
mad oT0.xy, v2, c4, c4.zwzw
mad oT2.xy, v3, c4, c4.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT2.z, v3
"
}
SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 64
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedjhdhjooechogehigafejobcikcnkkaokabaaaaaaaaadaaaaadaaaaaa
cmaaaaaalmaaaaaaeiabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaiaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaafeebeoehefeofeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahaiaaaafdfgfpfagphdgjhegjgpgoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefclaabaaaaeaaaabaagmaaaaaafjaaaaaeegiocaaa
aaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
hcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaabaaaaaaegbobaaaabaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
dccabaaaadaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadgaaaaafeccabaaaadaaaaaackbabaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 64
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedambjfidbdeonjdpedilmibdgdifooeneabaaaaaadaaeaaaaaeaaaaaa
daaaaaaafmabaaaabeadaaaakeadaaaaebgpgodjceabaaaaceabaaaaaaacpopp
oeaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjaaeaaaaaeabaaadoaacaaoejaabaaoekaabaaooka
aeaaaaaeacaaadoaadaaoejaabaaoekaabaaookaafaaaaadaaaaapiaaaaaffja
adaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacaaaaapoaabaaoejaabaaaaacacaaaeoaadaakkjappppaaaafdeieefc
laabaaaaeaaaabaagmaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaae
egiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaadhcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaa
abaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadgaaaaaf
eccabaaaadaaaaaackbabaaaadaaaaaadoaaaaabejfdeheoiiaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaaiaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apahaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaafeebeoeh
efeofeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfagphdgjhegjgpgoaa
edepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Vector 9 [_ProjectionParams]
Vector 10 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[11] = { { 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..10] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
MOV R0.w, R1;
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
DP4 R0.z, vertex.position, c[7];
MOV result.position, R0;
DP4 R0.x, vertex.position, c[3];
ADD result.texcoord[1].xy, R1, R1.z;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.attrib[14], c[10], c[10].zwzw;
MOV result.texcoord[1].z, -R0.x;
MOV result.texcoord[1].w, R1;
MOV result.texcoord[2].z, vertex.attrib[14];
END
# 16 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_ST]
"vs_2_0
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dcl_tangent0 v3
dp4 r1.w, v0, c7
dp4 r0.x, v0, c4
mov r0.w, r1
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
dp4 r0.z, v0, c6
mov oPos, r0
dp4 r0.x, v0, c2
mad oT1.xy, r1.z, c9.zwzw, r1
mov oD0, v1
mad oT0.xy, v2, c10, c10.zwzw
mad oT2.xy, v3, c10, c10.zwzw
mov oT1.z, -r0.x
mov oT1.w, r1
mov oT2.z, v3
"
}
SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 64
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedccnfmbfmhmfbfhjkhabbijjhdifjhhkbabaaaaaahaaeaaaaadaaaaaa
cmaaaaaalmaaaaaagaabaaaaejfdeheoiiaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaiaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapahaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaafeebeoehefeofeaaepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaajcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahaiaaaafdfgfpfagphdgjhegjgpgoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcaiadaaaaeaaaabaamcaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaiaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaafpaaaaadhcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaaaaaaaaaa
aaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaai
bcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaaadaaaaaa
akaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaaeaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadgaaaaafeccabaaa
aeaaaaaackbabaaaadaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 64
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedoemecphfjlgmmfdinemigklpblbegebdabaaaaaagiagaaaaaeaaaaaa
daaaaaaaceacaaaadeafaaaameafaaaaebgpgodjomabaaaaomabaaaaaaacpopp
kaabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaacaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaaaaaaaiaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafalaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoeka
aeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaacaaaakaafaaaaadabaaaiiaabaaaaiaalaaaakaafaaaaad
abaaafiaaaaapeiaalaaaakaacaaaaadacaaadoaabaakkiaabaaomiaafaaaaad
abaaabiaaaaaffjaaiaakkkaaeaaaaaeabaaabiaahaakkkaaaaaaajaabaaaaia
aeaaaaaeabaaabiaajaakkkaaaaakkjaabaaaaiaaeaaaaaeabaaabiaakaakkka
aaaappjaabaaaaiaabaaaaacacaaaeoaabaaaaibaeaaaaaeabaaadoaacaaoeja
abaaoekaabaaookaaeaaaaaeadaaadoaadaaoejaabaaoekaabaaookaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaaioaaaaappiaabaaaaacaaaaapoaabaaoejaabaaaaacadaaaeoaadaakkja
ppppaaaafdeieefcaiadaaaaeaaaabaamcaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aiaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
dcbabaaaacaaaaaafpaaaaadhcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaadcaaaaal
dccabaaaacaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaficcabaaaadaaaaaadkaabaaa
aaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaa
ckbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaa
acaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaaaaaaaaaadgaaaaageccabaaa
adaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaaldccabaaaaeaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadgaaaaaf
eccabaaaaeaaaaaackbabaaaadaaaaaadoaaaaabejfdeheoiiaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaaiaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apahaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaafeebeoeh
efeofeaaepfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaa
abaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaajcaaaaaaacaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfagphdgjhegjgpgoaaedepemepfcaafeef
fiedepepfceeaakl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "SOFTPARTICLES_OFF" }
Vector 0 [_TintColor]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[2] = { program.local[0],
		{ 2 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[2], texture[0], 2D;
ADD R1, R1, -R0;
MAD R1, fragment.texcoord[2].z, R1, R0;
MUL R0, fragment.color.primary, c[0];
MUL R0, R0, R1;
MUL result.color, R0, c[1].x;
END
# 7 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SOFTPARTICLES_OFF" }
Vector 0 [_TintColor]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c1, 2.00000000, 0, 0, 0
dcl v0
dcl t0.xy
dcl t2.xyz
texld r1, t0, s0
texld r0, t2, s0
add_pp r0, r0, -r1
mad_pp r1, t2.z, r0, r1
mul r0, v0, c0
mul r0, r0, r1
mul r0, r0, c1.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 16 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecednoifldjpcoibpaomndkmnhhbndkcfnapabaaaaaaeiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
gphdgjhegjgpgoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcfeabaaaaeaaaaaaaffaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaia
ebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaakgbkbaaaadaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaahpcaabaaaabaaaaaaegbobaaaabaaaaaa
egbobaaaabaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_OFF" }
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 16 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedmeijbfbnoehklmlnphemnbgmojancnlfabaaaaaadaadaaaaaeaaaaaa
daaaaaaabeabaaaahaacaaaapmacaaaaebgpgodjnmaaaaaanmaaaaaaaaacpppp
kiaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaadlabpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaacpiaabaaoelaaaaioekaecaaaaadabaacpiaacaaoelaaaaioeka
bcaaaaaeacaacpiaacaakklaabaaoeiaaaaaoeiaafaaaaadaaaaapiaaaaaoela
aaaaoekaacaaaaadaaaaapiaaaaaoeiaaaaaoeiaafaaaaadaaaacpiaacaaoeia
aaaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcfeabaaaaeaaaaaaa
ffaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaakgbkbaaa
adaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaahpcaabaaaabaaaaaa
egbobaaaabaaaaaaegbobaaaabaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaaabaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaahkaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaa
fdfgfpfagphdgjhegjgpgoaaedepemepfcaafeeffiedepepfceeaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "SOFTPARTICLES_ON" }
Vector 0 [_ZBufferParams]
Vector 1 [_TintColor]
Float 2 [_InvFade]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[4] = { program.local[0..2],
		{ 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[1], 2D;
TEX R1, fragment.texcoord[2], texture[1], 2D;
ADD R1, R1, -R0;
MAD R1, fragment.texcoord[2].z, R1, R0;
MAD R2.x, R2, c[0].z, c[0].w;
RCP R2.x, R2.x;
ADD R2.x, R2, -fragment.texcoord[1].z;
MUL_SAT R0.w, R2.x, c[2].x;
MOV R0.xyz, fragment.color.primary;
MUL R0.w, fragment.color.primary, R0;
MUL R0, R0, c[1];
MUL R0, R0, R1;
MUL result.color, R0, c[3].x;
END
# 14 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SOFTPARTICLES_ON" }
Vector 0 [_ZBufferParams]
Vector 1 [_TintColor]
Float 2 [_InvFade]
SetTexture 0 [_CameraDepthTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c3, 2.00000000, 0, 0, 0
dcl v0
dcl t0.xy
dcl t1
dcl t2.xyz
texldp r0, t1, s0
texld r2, t2, s1
texld r1, t0, s1
mad r0.x, r0, c0.z, c0.w
rcp r0.x, r0.x
add r0.x, r0, -t1.z
add_pp r2, r2, -r1
mad_pp r1, t2.z, r2, r1
mul_sat r0.x, r0, c2
mov_pp r2.xyz, v0
mul_pp r2.w, v0, r0.x
mul r0, r2, c1
mul r0, r0, r1
mul r0, r0, c3.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "SOFTPARTICLES_ON" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 16 [_TintColor]
Float 48 [_InvFade]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedpdpddnlobilpjpejgccghoggdlbbolfhabaaaaaajmadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaajcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfagphdgjhegjgpgoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcjaacaaaaeaaaaaaakeaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaackiacaaa
abaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaak
bcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
aaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackbabaiaebaaaaaa
adaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaa
adaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaadkbabaaaabaaaaaa
dgaaaaafhcaabaaaaaaaaaaaegbcbaaaabaaaaaaaaaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegiocaaaaaaaaaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaakgbkbaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadiaaaaah
pccabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SOFTPARTICLES_ON" }
SetTexture 0 [_CameraDepthTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 16 [_TintColor]
Float 48 [_InvFade]
ConstBuffer "UnityPerCamera" 128
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0_level_9_1
eefiecedgglceajjndoigaonlcplkgnilehmieoiabaaaaaahiafaaaaaeaaaaaa
daaaaaaaaiacaaaakaaeaaaaeeafaaaaebgpgodjnaabaaaanaabaaaaaaacpppp
iaabaaaafaaaaaaaadaacmaaaaaafaaaaaaafaaaacaaceaaaaaafaaaabaaaaaa
aaababaaaaaaabaaabaaaaaaaaaaaaaaaaaaadaaabaaabaaaaaaaaaaabaaahaa
abaaacaaaaaaaaaaaaacppppfbaaaaafadaaapkaaaaaaaeaaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaac
aaaaaaiaacaaaplabpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkaagaaaaacaaaaaiiaacaapplaafaaaaadaaaaadia
aaaappiaacaaoelaecaaaaadaaaaapiaaaaaoeiaabaioekaecaaaaadabaacpia
abaaoelaaaaioekaecaaaaadacaacpiaadaaoelaaaaioekaaeaaaaaeaaaaabia
acaakkkaaaaaaaiaacaappkaagaaaaacaaaaabiaaaaaaaiaacaaaaadaaaaabia
aaaaaaiaacaakklbafaaaaadaaaabbiaaaaaaaiaabaaaakaafaaaaadaaaacbia
aaaaaaiaaaaapplaafaaaaadaaaaabiaaaaaaaiaadaaaakaafaaaaadaaaaaiia
aaaaaaiaaaaappkabcaaaaaeadaacpiaadaakklaacaaoeiaabaaoeiaabaaaaac
abaaahiaaaaaoelaafaaaaadabaaahiaabaaoeiaaaaaoekaafaaaaadaaaaahia
abaaoeiaadaaaakaafaaaaadaaaacpiaaaaaoeiaadaaoeiaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcjaacaaaaeaaaaaaakeaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaiaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaadaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaalbcaabaaaaaaaaaaa
ckiacaaaabaaaaaaahaaaaaaakaabaaaaaaaaaaadkiacaaaabaaaaaaahaaaaaa
aoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
akaabaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaackbabaia
ebaaaaaaadaaaaaadicaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaaadaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaafhcaabaaaaaaaaaaaegbcbaaaabaaaaaaaaaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaacaaaaaadcaaaaaj
pcaabaaaabaaaaaakgbkbaaaaeaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaa
diaaaaahpccabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab
ejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
jcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaajcaaaaaaabaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapapaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahahaaaafdfgfpfagphdgjhegjgpgoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  BindChannels {
   Bind "color", Color
   Bind "texcoord", TexCoord
  }
  ZWrite Off
  Cull Off
  Fog {
   Color (0,0,0,0)
  }
  Blend SrcAlpha One
  SetTexture [_MainTex] { ConstantColor [_TintColor] combine constant * primary }
  SetTexture [_MainTex] { combine texture * previous double }
 }
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  BindChannels {
   Bind "color", Color
   Bind "texcoord", TexCoord
  }
  ZWrite Off
  Cull Off
  Fog {
   Color (0,0,0,0)
  }
  Blend SrcAlpha One
  SetTexture [_MainTex] { ConstantColor [_TintColor] combine texture * constant double }
 }
}
}