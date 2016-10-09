uniform float vel;
uniform vec2 noise;
varying vec4 color;

void main()
{  
	vec2 pos = gl_Vertex.xy + noise2( gl_Vertex.xy * vel * noise) ;
     gl_Position = gl_ModelViewProjectionMatrix * vec4(pos,0.0,1.0);
}
