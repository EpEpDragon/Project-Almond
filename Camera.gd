extends Camera

const MOVE_SPEED = 50
var follow = false;
var player
func _ready():
	player = get_tree().get_root().get_node("Spatial/Player")
	
func _process(delta):
	if follow:
		translation.x = player.translation.x
		translation.z = player.translation.z + 20
	else:
		if Input.is_action_pressed("camRight"):
			global_translate(Vector3(MOVE_SPEED * delta,0,0))
		if Input.is_action_pressed("camLeft"):
			global_translate(Vector3(-MOVE_SPEED * delta,0,0))
		if Input.is_action_pressed("camForward"):
			global_translate(Vector3(0,0,-MOVE_SPEED * delta))
		if Input.is_action_pressed("camBackward"):
			global_translate(Vector3(0,0,MOVE_SPEED * delta))
		if Input.is_action_pressed("camUp"):
			global_translate(Vector3(0,MOVE_SPEED * delta,0))
		if Input.is_action_pressed("camDown"):
			global_translate(Vector3(0,-MOVE_SPEED * delta,0))
	
	
