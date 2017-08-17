uniform float time;
uniform float ratio;
uniform float vol;
uniform vec2 dimen;
uniform float alpha;

float seed = 33.0;
float random () {
	seed = mod((13821.0 * seed), 32768.0);
	return mod(seed, 2.0)+1.0;
}

void main( void ) {
	
	vec2 pixel_pos = gl_FragCoord.xy;
	pixel_pos.x =pixel_pos.x *ratio;
	vec3 color1 = vec3(0.7, 0.25, 2.25*sin(time*vol));
	vec3 color2 = vec3(0.25, 0.7, 0.5*cos(time*vol));
	vec3 color3 = vec3(0.0*sin(time*vol), 0.25, 0.7);
	
	vec3 final_color = vec3(0.05*cos(time*vol), 0.025*cos(time*0.5), 0.05*sin(time));
	for (int i = 0; i < 15; ++i) {
		vec2 center = dimen.xy/2.0 + vec2(sin(0.5 * float(random()) *time*0.1 * 5.0 + pow(2.0, float(i*2)))*dimen.x, cos(0.15 * (float(i)-2.0) * time) * 200.0);
		float dist = length(pixel_pos-center);
		float intensity = pow((8.0 + 20.0 * mod(float(i), 2.5))/dist, 1.0*vol+3.0);
		
		if (mod(float(i), 3.0) == 0.0)
			final_color += color1 * intensity;
		else if (mod(float(i), 3.0) == 1.0)
			final_color += color2 * intensity;
		else
			final_color += color3 * intensity;
	}


	gl_FragColor = vec4(final_color*mod(gl_FragCoord.y, 4.0)*mod(gl_FragCoord.x, 4.0), alpha);
}