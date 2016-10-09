
uniform sampler2D iChannel0;
uniform float time;
uniform float alpha;
uniform sampler2D tex1;
uniform sampler2D tex2;
uniform sampler2D tex3;
uniform sampler2D tex4;
uniform sampler2D tex5;

uniform vec3 dimen; 

float no;
vec2 uv = gl_FragCoord.xy;



vec4 a1(float n, vec2 p) {
	vec4 ccc=vec4(0.0,0.0,0.0,0.0);
	p=mod(p/n, 1.0) ;
	ccc=texture2D(tex1,p).rgba;	
	return ccc;
}

vec4 a2(float n, vec2 p) {
	vec4 ccc=vec4(0.0,0.0,0.0,0.0);
	p=mod(p/n, 1.0) ;
	ccc=texture2D(tex2,p).rgba;	
	return ccc;
}

vec4 a3(float n, vec2 p) {
	vec4 ccc=vec4(0.0,0.0,0.0,0.0);
	p=mod(p/n, 1.0) ;
	ccc=texture2D(tex3,p).rgba;	
	return ccc;
}

vec4 a4(float n, vec2 p) {
	vec4 ccc=vec4(0.0,0.0,0.0,0.0);
	p=mod(p/n, 1.0) ;
	ccc=texture2D(tex4,p).rgba;	
	return ccc;
}

vec4 a5(float n, vec2 p) {
	vec4 ccc=vec4(0.0,0.0,0.0,0.0);
	p=mod(p/n, 1.0) ;
	ccc=texture2D(tex5,p).rgba;	
	return ccc;
}

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}dimen



void main()
{	int n;
	float gray; 
	vec3 col;
	vec4 a,b,c,d;
	
	
	col = texture2D(iChannel0, floor(uv/7.0)*7.0/dimen.xy).rgb;		
	gray = (col.r*0.33)+ (col.g*0.33)+ (col.b*0.33);            
	if(gray>0.2){
		
		time=gray*rand(floor(uv/7.0)*7.0/dimen.xy);		
		
		
		a=a5(7.0,uv);
		a.rgb=vec3(1.0-a.rgb)*0.2;
		a.a=1.0;
		
	}
	
	
	col = texture2D(iChannel0, floor(uv/10.0)*10.0/dimen.xy).rgb;		
	gray = (col.r*0.33)+ (col.g*0.33)+ (col.b*0.33);        
	if(gray>0.35){
		time=gray*rand(floor(uv/10.0)*10.0/dimen.xy);		
		
		
		a=a2(10.0,uv);
		a.rgb=vec3(1.0-a.rgb)*0.4;
		a.a=1.0;		
	}
	
	
	col = texture2D(iChannel0, floor(uv/20.0)*20.0/dimen.xy).rgb;		
	gray = (col.r*0.33)+ (col.g*0.33)+ (col.b*0.33);        
	if(gray>0.5){
		time=gray*rand(floor(uv/20.0)*20.0/dimen.xy);		
		
		if(time<0.3){
			a=a5(20.0,uv);
		}else if(time<0.7){
			a=a2(20.0,uv);
		}
		a.rgb=vec3(1.0-a.rgb)*0.6;
		a.a=1.0;			
	}

	
	col = texture2D(iChannel0, floor(uv/30.0)*30.0/dimen.xy).rgb;		
	gray = (col.r*0.33)+ (col.g*0.33)+ (col.b*0.33);         
	if(gray>0.7){
		time=gray*rand(floor(uv/30.0)*30.0/dimen.xy);		
		
		if(time<0.16){
			a=a1(30.0,uv);
		}else if(time<0.32){
			a=a2(30.0,uv);
		}else if(time<0.48){
			a=a3(30.0,uv);
		}else if(time<0.66){
			a=a4(30.0,uv);
		}else if(time<0.80){
			a=a5(30.0,uv);
		}	
		a.rgb=vec3(1.0-a.rgb)*0.85;
			
		a.a=1.0;
	}
	
	
	col = texture2D(iChannel0, floor(uv/60.0)*60.0/dimen.xy).rgb;		
	gray = (col.r*0.33)+ (col.g*0.33)+ (col.b*0.33);         
	if(gray>0.85){
		time=gray*rand(floor(uv/60.0)*60.0/dimen.xy);		
		
		if(time<0.16){
			a=a1(60.0,uv);
		}else if(time<0.32){
			a=a2(60.0,uv);
		}else if(time<0.48){
			a=a3(60.0,uv);
		}else if(time<0.66){
			a=a4(60.0,uv);
		}else if(time<0.80){
			a=a5(60.0,uv);
		}	
		a.rgb=vec3(1.0-a.rgb)*1.0;
		a.a=1.0;	
	}

	gl_FragColor = vec4(a.r,a.g,a.b,alpha);
}