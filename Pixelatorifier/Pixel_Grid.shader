shader_type canvas_item;

uniform bool grid = false;
uniform vec2 pos; //Camera position divided by ortho camera size
uniform float aspect_ratio; // X base, used to adgust pixel grid for aspect ratio
uniform float pixel_clamp = 0.7; //Pixel grid step

void fragment() 
{
	float x = pixel_clamp / aspect_ratio; //Adjust pixel grid for aspect ratio
	float y = pixel_clamp;
	
	//Calculate camera offset from pixel grid
	vec2 offset = mod(vec2(pos.x/aspect_ratio, pos.y), vec2(x,y));
	vec2 uv = SCREEN_UV;
	
	//Snap UV to grid intersects, has pixelation effect 
	uv -= mod(uv,vec2(x,y));
	
	//Used to draw pixel grid in last if statment, must be before offset sum.
	vec2 muv = mod(uv, vec2(x, y));	
	
	//Offset UV, has effect of snapping camera to pixel grid
	uv.y += offset.y;
	uv.x -= offset.x;
	COLOR.rgb = textureLod(SCREEN_TEXTURE,uv,0).rgb;
	
	//Draw pixel grid
	if (grid)
		if (muv.x <= 0.00075 || muv.y <= 0.00075) //Values as small as possible, if too small some grid lines will be lost
			COLOR.rgb = vec3(0.5,0.5,0.5);
}
