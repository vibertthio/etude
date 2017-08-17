uniform float time;
uniform float alpha;
uniform float vol;
uniform vec2 dimen;

void main(void)
{
	vec2 uv= dimen;
	float s=0.,v=0.;
	for (int r=0; r<60; r++) {
		vec3 p=vec3(.5,1.0,floor(time*20.)*.001)
		 +s*vec3(gl_FragCoord.xy*.0001-vec2(.009,.01),0.5);
		p.z=fract(p.z);
		for (int i=0; i<16; i++) p=abs(p)/dot(p,p)*2.-1.;
		v+=length(p*p)*(vol-s)*.005;
		s+=.005;
	}
	gl_FragColor = v*vec4(.1,.425,v,alpha);	
	
}