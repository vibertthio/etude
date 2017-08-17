uniform sampler2D tex_1;
uniform sampler2D tex_2;
uniform float v;
uniform float v_alpha;


float hardLight( float s, float d )
{
	return (s < 0.5) ? 2.0 * s * d : 1.0 - 2.0 * (1.0 - s) * (1.0 - d);
}

vec3 hardLight( vec3 s, vec3 d )
{
	vec3 c;
	c.x = hardLight(s.x,d.x);
	c.y = hardLight(s.y,d.y);
	c.z = hardLight(s.z,d.z);
	return c;
}


void main(  )
{


	vec2 uv = gl_FragCoord.xy/vec2(512.0,512.0);
	//int id = int(floor(uv.x * 5.0)) + int(floor(uv.y * 5.0))*5;
	
	// source texture (upper layer)
	vec3 s = texture2D(tex_1,uv).xyz;
	
	// destination texture (lower layer)
	vec3 d = texture2D(tex_2,uv).xyz;
	float alpha = texture2D(tex_1,uv).a * v_alpha;
	
	d.x=v*d.x;
	d.y=v*d.y;
	d.z=v*d.z;
		
	vec3 c = vec3(0.0);
	c = hardLight(s,d);
	
	
	gl_FragColor = vec4(c,alpha);
}