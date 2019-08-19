extends ColorRect

var pixel_clamp

func _ready():
	pass

func _process(delta):
	margin_right = get_viewport_rect().size.x
	margin_bottom = get_viewport_rect().size.y
	
	pixel_clamp = get_child(0).value
	self.get_material().set_shader_param("pixel_clamp", pixel_clamp)