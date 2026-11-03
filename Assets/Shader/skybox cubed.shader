Shader "RenderFX/Skybox Cubed" {
Properties {
 _Tint ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
 _Tex ("Cubemap", CUBE) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Background" "RenderType"="Background" }
 Pass {
  Tags { "QUEUE"="Background" "RenderType"="Background" }
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
MOV result.texcoord[0].xyz, vertex.texcoord[0];
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
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
mov oT0.xyz, v1
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
eefiecedbdhnfbkajfeiecohecnooobibofbhknnabaaaaaaoeabaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcaeabaaaa
eaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegbcbaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0_level_9_1
eefiecedepplkidgjdkdkcmbnoejjdofgblbblpbabaaaaaalmacaaaaaeaaaaaa
daaaaaaaaeabaaaabaacaaaageacaaaaebgpgodjmmaaaaaammaaaaaaaaacpopp
jiaaaaaadeaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaabaadaaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapia
abaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaeaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaahoaabaaoeja
ppppaaaafdeieefcaeabaaaaeaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafhccabaaa
abaaaaaaegbcbaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahahaaaafaepfdejfeejepeoaafeeffiedepepfc
eeaaklklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [unity_ColorSpaceGrey]
Vector 1 [_Tint]
SetTexture 0 [_Tex] CUBE 0
"!!ARBfp1.0
PARAM c[2] = { program.local[0..1] };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], CUBE;
ADD R0.xyz, R0, c[1];
MUL result.color.w, R0, c[1];
ADD result.color.xyz, R0, -c[0];
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [unity_ColorSpaceGrey]
Vector 1 [_Tint]
SetTexture 0 [_Tex] CUBE 0
"ps_2_0
dcl_cube s0
dcl t0.xyz
texld r0, t0, s0
add_pp r0.xyz, r0, c1
add_pp r0.xyz, r0, -c0
mul_pp r0.w, r0, c1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_Tex] CUBE 0
ConstBuffer "$Globals" 32
Vector 0 [unity_ColorSpaceGrey]
Vector 16 [_Tint]
BindCB  "$Globals" 0
"ps_4_0
eefiecedihdhodbagenbkkjncdddhnapkdpfpefoabaaaaaakaabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoaaaaaaa
eaaaaaaadiaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafidaaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbcbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaaiiccabaaa
aaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaaaaaaaaajhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_Tex] CUBE 0
ConstBuffer "$Globals" 32
Vector 0 [unity_ColorSpaceGrey]
Vector 16 [_Tint]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedejoccpfmdcgedfcpgockoebjcljcgcapabaaaaaaemacaaaaaeaaaaaa
daaaaaaaniaaaaaamaabaaaabiacaaaaebgpgodjkaaaaaaakaaaaaaaaaacpppp
gmaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaaaaaacaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaaahlabpaaaaac
aaaaaajiaaaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaacaaaaadaaaachia
aaaaoeiaabaaoekaafaaaaadabaaciiaaaaappiaabaappkaacaaaaadabaachia
aaaaoeiaaaaaoekbabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcoaaaaaaa
eaaaaaaadiaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafidaaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbcbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadiaaaaaiiccabaaa
aaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaabaaaaaaaaaaaaajhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaaaaaaaaadoaaaaab
ejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}