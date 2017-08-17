//http://shaderfrog.com/app/view/31

uniform float time;
uniform float speed;
uniform float frequency;
uniform float amplitude;
uniform float channel;
uniform sampler2D tex;
uniform float K;
uniform float K_2;

vec3 vNormal;
float light;
float intensity;

vec3 noise(vec2 n) {
    vec3 nn;
    nn.x=fract(sin(dot(n.xy, vec2(12.9898, 78.233)))* 43758.5453*time);
    nn.y=fract(cos(dot(n.yx, vec2(34.9865, 65.946)))* 28618.3756*time);
    nn.z=fract(sin(dot(n.xy, vec2(56.9865, 34.946)))* 15718.2134*time);
    return nn;
}

void main() {
	
	vec4 dv;
	float df;
		
	dv = texture2D( tex, (gl_TextureMatrix[0] * gl_MultiTexCoord0).st );
	df = (0.2126*dv.x + 0.71529*dv.y + 0.0722*dv.z);
	//求灰階	
	
	//-----------------------局部變形
	float vv;
	if(df> 0.92){
		vv= pow(K_2*0.5,1.6);
		//k = 0.4;
	}else {
		vv= 0.0;
	}
	vec4 v = vec4(gl_Vertex);
	v = vec4(gl_Normal * vv, 0.0)+(vec4(noise((gl_TextureMatrix[0] * gl_MultiTexCoord0).st),0.0)*0.05*K_2);	
	//-----------------------
	
	
	gl_TexCoord[0] = gl_MultiTexCoord0;
	vec4 color = texture2D(tex, (gl_TextureMatrix[0] * gl_MultiTexCoord0).st);
	//C=color;
	
	vec4 position = vec4(gl_Vertex);
	float base ;
	float base2;

	if(channel==0.0){
		 base = sin( ( time * speed ) - ( ( position.x + 100.0 ) * frequency ) ) * amplitude;
    	 base2 = cos( ( time * speed ) - ( ( position.x + 100.0 ) * frequency ) ) * amplitude;
	}else if(channel==1.0){
		 base = sin( ( time * speed ) - ( ( position.y + 100.0 ) * frequency ) ) * amplitude;
    	 base2 = cos( ( time * speed ) - ( ( position.y + 100.0 ) * frequency ) ) * amplitude;
	}else if(channel==2.0){
		 base = sin( ( time * speed ) - ( ( position.z + 100.0 ) * frequency ) ) * amplitude;
    	 base2 = cos( ( time * speed ) - ( ( position.z + 100.0 ) * frequency ) ) * amplitude;
	}
    
    vec4 noiseVel = vec4(gl_Normal, 0.0)* vec4(noise((gl_TextureMatrix[0] * gl_MultiTexCoord0).st)*K,0.0);
    vec3 newPosition = vec3( position.xyz) + noiseVel.xyz + v.xyz;
    //三種不同變形相加
    
    newPosition.x += position.x * base2;
    newPosition.z += position.y * base;

    float halfHeight = 450.0;

    vec4 thingy = gl_ModelViewProjectionMatrix * vec4( newPosition, 1.0 );
    gl_Position = thingy;

}
