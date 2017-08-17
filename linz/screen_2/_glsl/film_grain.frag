uniform sampler2D tex1;
uniform float vol;
uniform float time;
uniform vec2 dimen;


void main(  )
{
	vec2 uv = gl_FragCoord.xy / dimen.xy;
    
    vec4 color = texture2D(tex1, uv);
    
    float strength = 4.0;
    
    float x = (uv.x + 4.0 ) * (uv.y + 4.0 ) * (time * 10.0);
	vec4 grain = vec4(mod((mod(x, 13.0) + 2.0) * (mod(x, 123.0) + 2.0), 0.05*vol+0.01)-0.005) * strength;
        
    	grain = 1.0 - grain;
		gl_FragColor = color * grain;
    
 
}