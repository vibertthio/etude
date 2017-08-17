
uniform sampler2D tex_1;
uniform sampler2D tex_2;
uniform float alpha;

void main (void)
{

 vec2 uv = gl_FragCoord.xy/vec2(1280.0,1280.0);
 vec4 color_1 = texture2D(tex_1, uv);
 vec4 color_2 = texture2D(tex_2, uv);


 gl_FragColor = vec4(color_1.rgba * color_2.rgba);
//color_1是暈墨，color_2是紙
}
