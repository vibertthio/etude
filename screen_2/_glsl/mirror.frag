/*
	Andor Salga
	March 2014

	Simple demo showing mirror effects.
*/

uniform sampler2D tex;
uniform float vol;
uniform float time;
uniform vec2 dimen;


void main()
{
	
	float scale;
	if(vol>0.2){
  		scale=1.0;
  	}else if(vol>0.3){
  		scale=1.5;
 	}else if(vol>0.4){
  		scale=2.0;
 	}else if(vol>0.49){
  		scale=5.0;
 	}
  
	
	int choice = int(( mod(time*scale, 60.0) )/10.0);
	
	vec2 p = gl_FragCoord.xy/dimen.xy;
	vec4 color;
	
	// No Mirror
	// choice == 0
	
	// Left Mirror
	if(choice == 1){
		p.x -= step(0.5, p.x) * (p.x-0.5) * 2.0;
		//color=vec4(1.0,0.0,0.0,1.0);
	}
	
	// Right Mirror
	if(choice == 2){
		p.x += step(p.x, 0.5) * (0.5-p.x) * 2.0;
		//color=vec4(0.0,1.0,0.0,1.0);
	}
	
	// Top Mirror
	if(choice == 3){
		p.y -= step(p.y, 0.5) * (p.y-.5) * 2.0;
		//color=vec4(0.0,0.0,1.0,1.0);
	}
	
	// Bottom Mirror
	if(choice == 4){
		p.y += step(0.5, p.y) * (0.5-p.y) * 2.0;
		//color=vec4(1.0,1.0,0.0,1.0);
	}
	
	// Quad Mirror
	if(choice == 5){
		p.x += step(p.x, 0.5) * (0.5-p.x) * 2.0;
		p.y += step(0.5, p.y) * (0.5-p.y) * 2.0;
		//color=vec4(1.0,0.0,1.0,1.0);
	}
	
	gl_FragColor = texture2D(tex, p)+color;
}