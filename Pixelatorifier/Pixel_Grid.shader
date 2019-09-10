shader_type canvas_item;

//All uniforms fed from script
uniform bool grid = false;
uniform vec2 pos = vec2(0,0); //Camera position divided by ortho camera size
uniform float aspect_ratio = 1f; // X base, used to adgust pixel grid for aspect ratio
uniform float pixel_clamp = 0.7; //Pixel grid step

uniform vec4 color1 = vec4(1,0,1,1);
uniform vec4 color2;
uniform vec4 color3;
uniform vec4 color4;
uniform vec4 color5;
void fragment() 
{
	float x = pixel_clamp / aspect_ratio; //Adjust pixel grid for aspect ratio
	float y = pixel_clamp;
	
	//Calculate camera offset from pixel grid
	vec2 offset = mod(vec2(pos.x/aspect_ratio, pos.y), vec2(x,y));
	vec2 uv = SCREEN_UV;
	
	//Used to draw pixel grid in last if statment, must be before offset sum and pixellation.
	vec2 muv = mod(uv, vec2(x, y));
	
	//Snap UV to grid intersects, has pixelation effect 
	uv -= mod(uv,vec2(x,y));
	
	//Offset UV, has effect of snapping camera to pixel grid
	uv.y += offset.y;
	uv.x -= offset.x;
	vec4 color = textureLod(SCREEN_TEXTURE,uv,0);
	vec4 use_color;
	
	float min_diff = distance(color, color1);
	float current_diff = distance(color, color1);
	use_color = color1;

	current_diff = distance(color, color2);
	if (current_diff < min_diff){
		min_diff = current_diff;
		use_color = color2;
	}
	current_diff = distance(color, color3);
	if (current_diff < min_diff){
		min_diff = current_diff;
		use_color = color3;
	}
	current_diff = distance(color, color4);
	if (current_diff < min_diff){
		min_diff = current_diff;
		use_color = color4;
	}
	current_diff = distance(color, color5);
	if (current_diff < min_diff){
		min_diff = current_diff;
		use_color = color5;
	}
	COLOR = use_color;
	
	//Draw pixel grid
	if (grid)
		if (muv.x <= 0.00075 || muv.y <= 0.00075) //Values as small as possible, if too small some grid lines will be lost
			COLOR.rgb = vec3(0.5,0.5,0.5);
}
