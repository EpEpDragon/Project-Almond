extends ColorRect

var screen_size
var cam_perspective
var ortho_cam
var rot_adjustment
export(PoolColorArray) var color_palette;

func _ready():
	cam_perspective = get_tree().get_root().get_node("Spatial/Orthogonal")
	ortho_cam = get_tree().get_root().get_node("Spatial/Orthogonal")
	rot_adjustment = Vector2(sin(PI/2-ortho_cam.rotation.y),cos(-PI/2-ortho_cam.rotation.x)) #Adjust shader input for ortho camera rotation
	
	for i in color_palette.size():
		get_material().set_shader_param(str("color", i+1), color_palette[i])
		print(color_palette[i])
func _process(delta):
	margin_right = get_viewport_rect().size.x
	margin_bottom = get_viewport_rect().size.y
	
	screen_size = get_viewport_rect().size
	get_material().set_shader_param("pos", Vector2(cam_perspective.translation.x, cam_perspective.translation.z)*rot_adjustment/ortho_cam.size)
	get_material().set_shader_param("aspect_ratio", screen_size.x/screen_size.y)
	

func _on_CheckButton_toggled(button_pressed):
	if !(button_pressed):
		get_material().set_shader_param("grid", false)
	else:
		get_material().set_shader_param("grid", true)


func _on_HScrollBar_value_changed(value):
	get_material().set_shader_param("pixel_clamp", value)
