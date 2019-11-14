extends KinematicBody

const MOVE_SPEED = 10
const SNAP = 1
var ortho
var persp
var ray_origin
var ray_target

func _ready():
	ortho = $"./Orthogonal"
	persp = get_tree().get_root().get_node("Spatial/Perspective")

func _physics_process(delta):
	#------------Look direction---------------------------------------------------------
	ray_origin = persp.project_ray_origin(get_viewport().get_mouse_position())
	ray_target = persp.project_ray_normal(get_viewport().get_mouse_position())*500

	var space_state = get_world().direct_space_state
	var ray = space_state.intersect_ray(ray_origin, ray_target,[self],1,true,true)
	if ray:
		look_at(Vector3(ray.position.x,translation.y,ray.position.z), Vector3(0,1,0))
		
func _process(delta):
	#------------Movement Controls------------------------------------------------------
	if Input.is_action_pressed("forward"):
		move_and_slide(Vector3(0,0,-MOVE_SPEED))
	if Input.is_action_pressed("backward"):
		move_and_slide(Vector3(0,0,MOVE_SPEED))
	if Input.is_action_pressed("left"):
		move_and_slide(Vector3(-MOVE_SPEED,0,0))
	if Input.is_action_pressed("right"):
		move_and_slide(Vector3(MOVE_SPEED,0,0))
		
	#------------Camera controls--------------------------------------------------------
	if Input.is_action_just_pressed("cameraFollow"):
		if persp.follow == true:
			persp.follow = false
		else:
			persp.follow = true
	if Input.is_action_just_pressed("change_camera"):
		if ortho.current == true:
			persp.current = true
			ortho.current = false
		else:
			persp.current = false
			ortho.current = true

