uniform float time;
uniform float vol;
uniform float alpha;
uniform vec2 dimen;
uniform float ratio;

const float fRadius = 0.08;
const float bubbleSize = 0.8;

const float ySpeed = 0.9;
const float bubblePopHeight = 2.0;
const float bubbleSpreadDist = 4.0;

void main(void)
{
    vec2 uv = -1.0 + 2.0*gl_FragCoord.xy / dimen.xy;
    uv.x *=  dimen.x / dimen.y;
    uv.x *= ratio;
    
    vec3 color = vec3(0.0);

        // bubbles
    for( int i=0; i<64; i++ )//how many
    {
            // bubble seeds
        float pha = tan(float(i)*6.+1.0)*0.5 + 0.5;
        float siz = pow( cos(float(i)*2.4+4.0) * 0.5 + ySpeed, 0.5*vol+3.0);
        float pox = cos(float(i)*2.55+3.1) * dimen.x / dimen.y;
        
            // buble size, position and color
        float rad = (fRadius + sin(float(i))*0.12+0.29) * bubbleSize;
        vec2  pos = vec2( pox+sin(time/50.+pha+siz), -abs(bubblePopHeight)-rad + (bubbleSpreadDist+2.0*rad)
                         *mod(pha+0.1*(time/5.)*(0.2+0.8*siz),1.0)) * vec2(1.0, 1.0);
        float dis = length( uv - pos )*1.5;
	
        vec3  col = mix( vec3(0.2, 0.6, 0.5), vec3(0.15,0.4,0.7), 0.2+0.2*sin(float(i)*sin(time*pox*0.03)+1.9));
	
	col *= clamp(-pos.y, 0.0, 1.0);

        color += col.xyz *(1.- smoothstep( rad*(0.65+0.20*sin(pox*time)), rad, dis )) * (1.0 - cos(pox*time));
    }

    gl_FragColor = vec4(color,alpha);
}


