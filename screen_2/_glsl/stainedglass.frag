uniform sampler2D tex;
uniform float vol;
uniform float time;
uniform vec2 dimen;


float s;
void srand(vec2 p){
	s=sin(dot(p,vec2(423.62431,321.54323)));
}
float rand(){
	s=fract(s*32322.65432+0.12333);
	return abs(fract(s));
}
float grad(float t){
	return 6.0*pow(t,5.0)-15.0*pow(t,4.0)+10.0*pow(t,3.0);
}
mat2 rot2d(float a){
	float c=cos(a);
	float s=sin(a);
	return mat2(
		c,-s,
		s, c);
}
float RES =200.0*vol+100.0;
//
vec4 voronoi2d(vec2 p,float t){
	float v=8.0;
	vec4 c;
	vec2 f=floor(p);
	for(float i=-3.0;i<3.0;i++)
	for(float j=-3.0;j<3.0;j++){
		srand(f+vec2(i,j));
		vec2 o;
		o.x=rand();
		o.y=rand();
		o*=rot2d(t*(rand()-0.1));
		float d=distance(p,f+vec2(i,j)+o);
		if(d<v){
			v=d;
			c=texture2D(tex,(f+vec2(i,j)+o)/RES);
		}
	}
	return c;
}
void main(){
	float t = time;
	float r = dimen.x/dimen.y;
	vec2 s=gl_FragCoord.xy/vec2(dimen.x,dimen.y);
	//fragColor=texture2D(iChannel0,s);
	gl_FragColor=voronoi2d(s*RES,t);
}