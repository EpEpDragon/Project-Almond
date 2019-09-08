extends RigidBody

const MOVE_SPEED = 0.1
const SNAP = 1
var ortho
var persp

# Called when the node enters the scene tree for the first time.
func _ready():
	ortho = $"./Orthogonal"
	persp = $"./Perspective"

func _process(delta):
	if Input.is_action_pressed("forward"):
		translate(Vector3(0,0,-MOVE_SPEED * delta))
	if Input.is_action_pressed("backward"):
		translate(Vector3(0,0,MOVE_SPEED * delta))
	if Input.is_action_pressed("left"):
		translate(Vector3(-MOVE_SPEED * delta,0,0))
	if Input.is_action_pressed("right"):
		translate(Vector3(MOVE_SPEED * delta,0,0))

	if Input.is_action_just_pressed("change_camera"):
		if ortho.current == true:
			persp.current = true
			ortho.current = false
		else:
			persp.current = false
			ortho.current = true
