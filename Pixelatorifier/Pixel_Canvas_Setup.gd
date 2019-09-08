extends ColorRect

var pixel_clamp
var screen_size

func _ready():
	pass

func _process(delta):
	margin_right = get_viewport_rect().size.x
	margin_bottom = get_viewport_rect().size.y
	
	screen_size = get_viewport_rect().size
	pixel_clamp = get_child(0).value
	print(screen_size.x/screen_size.y)
	self.get_material().set_shader_param("aspect_ratio", screen_size.x/screen_size.y)
	self.get_material().set_shader_param("pixel_clamp", pixel_clamp)