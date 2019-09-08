extends ColorRect

var pixel_clamp
var screen_size
var cam_perspective
var ortho_size

func _ready():
	cam_perspective = get_tree().get_root().get_node("Spatial/Orthogonal")
	ortho_size = get_tree().get_root().get_node("Spatial/Orthogonal").size

func _process(delta):
	margin_right = get_viewport_rect().size.x
	margin_bottom = get_viewport_rect().size.y
	
	screen_size = get_viewport_rect().size
	pixel_clamp = get_child(0).value
	self.get_material().set_shader_param("pos", Vector2(cam_perspective.translation.x, cam_perspective.translation.z)/ortho_size)
	self.get_material().set_shader_param("aspect_ratio", screen_size.x/screen_size.y)
	self.get_material().set_shader_param("pixel_clamp", pixel_clamp)