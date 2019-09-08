shader_type canvas_item;

uniform float pixel_clamp = 0.003;

void fragment() 
{
	vec2 uv = SCREEN_UV;
	vec2 muv = mod(uv, pixel_clamp);
	if (muv.x <= 0.001 || muv.y <=0.001)
		COLOR.rgb = vec3(0,0,0);
	else
		COLOR.rgb = textureLod(SCREEN_TEXTURE,uv,0).rgb;
}
