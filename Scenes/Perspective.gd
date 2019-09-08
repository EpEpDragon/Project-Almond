extends Camera

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MOVE_SPEED = 10
# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	
	
