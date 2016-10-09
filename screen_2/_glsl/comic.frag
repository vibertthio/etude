uniform sampler2D tex;
uniform float vol ;
uniform float time;
uniform vec2 dimen;


vec3 stroke=vec3(1.0, 0.8, 0.48);
float a0=0.05;
float a1=3.5;
float a2=14.0;
float a3=2.5;
float a4=1.0;

vec3 sample(const int x, const int y)
{
  vec2 uv = (gl_FragCoord.xy + vec2(x, y)) / dimen.xy;
  return texture2D(tex, uv).xyz;
}

float luminance(vec3 c)
{
  return dot(c, vec3(0.2126, 0.7152, 0.0722));
}

float edge(void)
{
  vec3 hc =sample(-1, -1) *  1.0 + sample( 0, -1) *  2.0
    +sample( 1, -1) *  1.0 + sample(-1, 1) * -1.0
    +sample( 0, 1) * -2.0 + sample( 1, 1) * -1.0;

  vec3 vc =sample(-1, -1) *  1.0 + sample(-1, 0) *  2.0
    +sample(-1, 1) *  1.0 + sample( 1, -1) * -1.0
    +sample( 1, 0) * -2.0 + sample( 1, 1) * -1.0;

  vec3 ee=sample(0, 0) * pow(luminance(vc*vc + hc*hc), stroke.r);
  return (ee.r+ee.g+ee.b)/stroke.g;
}

void main() 
{ 
  vec2 uv = gl_FragCoord.xy/dimen.xy;
  vec3 tc = vec3(0.0, 0.0, 0.0);
  float tt=time;
  float v=vol;

  vec4 lumtotal = texture2D(tex, uv);
  
  float lum = (lumtotal.r*0.2126)+ (lumtotal.g*0.7152)+ (lumtotal.b*0.0722);
  tc = vec3(1.0, 1.0, 1.0);


  if (lum < 1.0) 
  {
    if (mod(gl_FragCoord.x + gl_FragCoord.y , 60.0) < a0) 
      tc = vec3(0.98, 0.98, 0.98);
  }  

  if (lum < 0.75) 
  {
    if (mod(gl_FragCoord.x - gl_FragCoord.y , 8.0+(vol*5.0)) < a1) 
      tc = vec3(0.88, 0.88, 0.88);
  }  

  if (lum < 0.55) 
  {
    if (mod(gl_FragCoord.x + gl_FragCoord.y , 10.0) < a2) 
      tc = vec3(0.80, 0.80, 0.80);
  }  

  if (lum < 0.3) 
  {
    if (mod(gl_FragCoord.x + gl_FragCoord.y , 11.0+(vol*2.0)) < a3) 
      tc = vec3(0.2, 0.2, 0.2);
  } 

  if (lum < 0.15) 
  {
    if (mod(gl_FragCoord.x + gl_FragCoord.y , 1.0+(vol*1.0)) < a4) 
      tc = vec3(0.0, 0.0, 0.0);
  }

  float f=(1.0-edge()) < stroke.b ? 0.0 : 1.0;
  tc =tc*vec3(f);
  if(vol>0.32){
  	tc=1.0-tc;
  }else{
  	tc=tc;
  }

  gl_FragColor = vec4(tc,1.0 );
}
