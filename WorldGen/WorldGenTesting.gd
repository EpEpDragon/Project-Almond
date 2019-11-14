extends Node2D 
var world_root = Vector2(0,0)
var world_size = Vector2(1300,1300)
var max_room_size = 100000;
var min_room_size = 5000;
var world = []
var rand = RandomNumberGenerator.new()
var chunkDraw = 0;
var e = 2.718281828
var vec1 = Vector2(1,1)

func _ready():
	
	rand.seed = 34545
	world.resize(1)
	
	#Set world root node
	world[0] = {
		origin = world_root,
		size = world_size
		}
	
	bsp(world_root, world_size, 0, 0)
	print("World Finished")
	
	
func bsp(origin : Vector2, size : Vector2, depth : int, node : int):
	var current_size = size.x*size.y
	var roll = log(-max_room_size/current_size + 1)
	if current_size <= max_room_size && rand.randf() > log((current_size/max_room_size)*5 + 1):
		return
	else:
		var left_origin
		var left_size
		
		var right_origin
		var right_size
		
		#Split % based on seed
		var split = rand.randf_range(0.3,0.7)
		
		if(fmod(depth, 2) == 0):
			#Vertical split
			left_origin = origin
			left_size = size - Vector2(size.x*(1-split),0)
			
			right_origin = origin + Vector2(size.x*split,0)
			right_size = size - Vector2(size.x*split,0)
			
		else:
			#Horizontal split, Left is top, Right is bottom
			left_origin = origin
			left_size = size - Vector2(0,size.y*(1-split))
			
			right_origin = origin + Vector2(0,size.y*split)
			right_size = size - Vector2(0,size.y*split)
			
		#Increase size
		if world.size() < node*2+3:
			world.resize(node*2+3)
		#Add right node
		world[node*2+2] = {
			origin = right_origin,
			size = right_size
			}
		#Add left node
		world[node*2+1] = {
				origin = left_origin,
				size = left_size
				}
		#BSP for left and right
		bsp(left_origin, left_size, depth+1, node*2+1)
		bsp(right_origin, right_size, depth+1, node*2+2)
		return

func _input(event):
	if event.is_action_released("drawNextChunk"):
		chunkDraw += 1
		update()
	if event.is_action_released("drawPreviousChunk"):
		chunkDraw -= 1
		update()
	if event.is_action_released("newMap"):
		world.resize(1);
		bsp(world_root, world_size, 0, 0)
		update()
		print("NBew")

func _draw():
	for chunk in world:
		if chunk:
			draw_rect(Rect2(chunk.origin + vec1, chunk.size + vec1), Color(1,0,0), false)

