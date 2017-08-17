uniform sampler2D tex;
uniform float vol;
uniform float time;
uniform vec2 dimen;

#define WEBCAM_RESOLUTION 512.0

void main()
{
	vec2 uv = gl_FragCoord.xy / dimen.xy;
	float tt=time;
	// Sobel operator
	float offset = (2.0*vol+1.0) / dimen.x;
	vec3 o = vec3(-offset, 0.0, offset);
	vec4 gx = vec4(0.0);
	vec4 gy = vec4(0.0);
	vec4 t;
	gx += texture2D(tex, uv + o.xz);
	gy += gx;
	gx += vol*4.0*texture2D(tex, uv + o.xy);
	t = texture2D(tex, uv + o.xx);
	gx += t;
	gy -= t;
	gy += (8.0*vol+2.0)*texture2D(tex, uv + o.yz);
	gy -= (8.0*vol+2.0)*texture2D(tex, uv + o.yx);
	t = texture2D(tex, uv + o.zz);
	gx -= t;
	gy += t;
	gx -= vol*2.0*texture2D(tex, uv + o.zy);
	t = texture2D(tex, uv + o.zx);
	gx -= t;
	gy -= t;
	vec4 grad = sqrt(gx*gx + gy*gy);
	
	gl_FragColor = vec4(grad);
}