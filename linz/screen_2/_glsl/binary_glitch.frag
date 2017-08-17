
// Binary Glitch - based on Luminosity.
// use the Mouse to effect the strength.


// by D34N 4L3X
// dean@neuroid.co.uk

uniform sampler2D tex1;
uniform float vol;
uniform float time;
uniform vec2 dimen;


void main( )
{
	vec2 uv = gl_FragCoord.xy / dimen.xy;
//    uv.t = 1.0 - uv.t;
    
    float x = uv.s;
    float y = uv.t;
    float tt=time;
    float v=vol;
    
    //
    float glitchStrength = (vol+1.0) * (5.0+fract(tt)*0.2);

    // get snapped position
    float psize = 0.04 * glitchStrength;
    float psq = 1.0 / psize;

    float px = floor( x * psq + 0.5) * psize;
    float py = floor( y * psq + 0.5) * psize;
    
	vec4 colSnap = texture2D( tex1, vec2( px,py) );
    
	float lum = pow( 1.0 - (colSnap.r + colSnap.g + colSnap.b) / 3.0, glitchStrength ); // remove the minus one if you want to invert luma
    
    
    
    // do move with lum as multiplying factor
    float qsize = psize * lum;
    
    float qsq = 1.0 / qsize;

    float qx = floor( x * qsq + 0.5) * qsize;
    float qy = floor( y * qsq + 0.5) * qsize;

    float rx = (px - qx) * lum + x;
    float ry = (py - qy) * lum + y;
    
	vec4 colMove = texture2D( tex1, vec2( rx,ry) );
    
    
    // final color
    gl_FragColor = colMove;
}

