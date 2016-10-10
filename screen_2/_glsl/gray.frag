uniform vec2  dimen; 
uniform float time;         
uniform sampler2D tex;  
uniform float     alpha; 


void main(void)
{	 vec2 uv = gl_FragCoord.xy/dimen.xy;
	 vec2 uv2 = 0.5 + (uv-0.5)*(0.95+0.05*sin(4.0*abs(time-0.5)));
	 vec4 tex = texture2D(tex, uv2);
 	 float gray = (0.2126*tex.x) + (0.7152*tex.y) + (0.0722*tex.z);
	 
	
	gl_FragColor = vec4(gray,gray,gray, alpha);
}