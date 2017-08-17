uniform float vol; 
uniform float grid;  
uniform vec2      dimen;          
uniform float     time;
uniform sampler2D iChannel0;
uniform float     alpha;
uniform vec2      red;
uniform vec2      green;
uniform vec2      blue;

void main(void)
{

  float vv=vol;
  float gg=grid;
  vec2 q = gl_FragCoord.xy / dimen.xy;
  vec2 uv = 0.5 + (q-0.5)*(0.95+0.05*sin(4.0*abs(time-0.5)));
  vec3 col;

  col.r = texture2D(iChannel0, vec2(uv.x, uv.y)).x*1.5;
  col.g = texture2D(iChannel0, vec2(uv.x, uv.y)).y*1.5;
  col.b = texture2D(iChannel0, vec2(uv.x, uv.y)).z*1.5;

  col = clamp(col*0.5+0.5*col*col, 0.1, 1.0);
  col *= 0.4 + 0.4*16.0*uv.x*uv.y*(1.0-uv.x)*(1.0-uv.y);//lomo框
  col *= 0.9+0.1*sin(253.0*time+uv.y*600.0);//電視線
  col *= 0.9+0.1*sin(55.0*time);//整體黑幕

  vec3 color;
  color.r = texture2D( iChannel0, q+red).r;
  color.g = texture2D( iChannel0, q+green).g;
  color.b = texture2D( iChannel0, q+blue).b;
  col=col*color;

  gl_FragColor = vec4(col*3.0, alpha);
}
