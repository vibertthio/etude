uniform sampler2D tex;
uniform vec2 dimen;
uniform float alpha;
//varying vec4 C;

void main ()
{
	vec2 uv = gl_FragCoord.xy/ dimen.xy;
	vec4 ccc = texture2D(tex, (gl_TextureMatrix[0] * gl_TexCoord[0]).st);
	gl_FragColor = vec4(ccc.rgb,ccc.a*alpha);
	//gl_FragColor = vec4(0.0,1.0,0.0,1.0);
}


