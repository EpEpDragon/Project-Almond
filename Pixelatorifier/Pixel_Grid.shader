shader_type canvas_item;

uniform float aspect_ratio; // X base
uniform float pixel_clamp = 0.003;

void fragment() 
{
	float x = pixel_clamp / aspect_ratio;
	float y = pixel_clamp;
	
	vec2 uv = SCREEN_UV;
	vec2 muv = mod(uv, vec2(x, y));
	if (muv.x <= 0.002 || muv.y <=0.002)
		COLOR.rgb = vec3(0,0,0);
	else
		COLOR.rgb = textureLod(SCREEN_TEXTURE,uv,0).rgb;
		
}
