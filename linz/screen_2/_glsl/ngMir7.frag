uniform sampler2D tex;
uniform float vol;
uniform float time;
uniform vec2 dimen;

void main()
{
	
    float steps=(vol*0.0)+2.0;
	vec2 uv = gl_FragCoord.xy / dimen.xy;
    vec4 c = texture2D(tex,uv);
    float g = max(c.r,max(c.g,c.b))*steps;
    float fuck = 345.678+(dimen.x/4.0+mod(time,50.0));
    float f = mod((((uv.x+uv.y)*(4.0))+500.)*fuck,1.0);
    if(mod(g,1.0)>f)
        c.r = ceil(g);
    else
        c.r = floor(g);
    c.r/=steps;
	gl_FragColor = c.rrra;
}