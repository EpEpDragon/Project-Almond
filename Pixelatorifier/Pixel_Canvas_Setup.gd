extends ColorRect

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
	self.get_material().set_shader_param("pos", Vector2(cam_perspective.translation.x, cam_perspective.translation.z)/ortho_size)
	self.get_material().set_shader_param("aspect_ratio", screen_size.x/screen_size.y)
	

func _on_CheckButton_toggled(button_pressed):
	if !(button_pressed):
		self.get_material().set_shader_param("grid", false)
	else:
		self.get_material().set_shader_param("grid", true)


func _on_HScrollBar_value_changed(value):
	self.get_material().set_shader_param("pixel_clamp", value)
