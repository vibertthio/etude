uniform vec2      dimen;          
uniform float     time;
uniform sampler2D tex; 
uniform float     alpha; 
uniform float vol;


float PI = 3.1415926535897932384626433832795;
float PI180 = float(PI / 180.0);

float sind(float a)
{
	return sin(a * PI180);
}

float cosd(float a)
{
	return cos(a * PI180);
}

float added(vec2 sh, float sa, float ca, vec2 c, float d)
{
	return 0.5 + 0.15 * cos((sh.x * sa + sh.y * ca + c.x) * d) + 0.25 * cos((sh.x * ca - sh.y * sa + c.y) * d);
}

void main(void)
{
	
	float threshold = clamp(0.6, 0.0, 1.0);
	float ratio = dimen.y / dimen.x;
	float coordX = gl_FragCoord.x / dimen.x;
	float coordY = gl_FragCoord.y / dimen.x;
	vec2 dstCoord = vec2(coordX, coordY);
	vec2 srcCoord = vec2(coordX, coordY / ratio);
	vec2 rotationCenter = vec2(vol, vol);
	vec2 shift = dstCoord - rotationCenter;
	
	float dotSize = (0.5+vol)*abs(time-0.5)+2.0;
	float angle = 45.0*abs(time*0.2-0.5);
	
	float rasterPattern = added(shift, sind(angle), cosd(angle), rotationCenter, PI / dotSize * 680.0);
	vec4 srcPixel = texture2D(tex, srcCoord);
        
	float avg = 0.4125 * srcPixel.r + 0.3154 * srcPixel.g + 0.2721 * srcPixel.b;
    	float gray = (rasterPattern * threshold + avg - threshold) / (1.0 - threshold);

    	
	gl_FragColor = vec4(gray*0.7, gray*0.8, gray, alpha);
}
    