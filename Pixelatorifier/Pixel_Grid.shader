shader_type canvas_item;

uniform vec2 pos;
uniform float aspect_ratio; // X base
uniform float pixel_clamp = 0.003;

void fragment() 
{
	float x = pixel_clamp / aspect_ratio;
	float y = pixel_clamp;
	
	vec2 offset = mod(pos, vec2(x,y));
	vec2 uv = SCREEN_UV;
	
	vec2 muv = mod(uv, vec2(x, y));
	
	COLOR.rgb = textureLod(SCREEN_TEXTURE,uv,0).rgb;

	uv -= offset*10f;
	muv = mod(uv, vec2(x, y));
	if (muv.x <= 0.001 || muv.y <= 0.001)
		COLOR.rgb = vec3(1,1,1);
}
