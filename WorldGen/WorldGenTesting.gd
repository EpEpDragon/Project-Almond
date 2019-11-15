extends Node2D 
var world_root = Vector2(0,0)
var world_size = Vector2(1900,1400)
var max_room_size = 150000;
var min_room_size = 5000;
var world = []
var rand = RandomNumberGenerator.new()
var chunkDraw = 0;
var vec1 = Vector2(1,1)
var tree_size = 0

var drawMode = "type"

func _ready():
	
	rand.seed = 34545
	build()
	print("fin")

func build():
	world.resize(1)
	tree_size = 0
	
	#Set world root node
	world[0] = {
		origin = world_root,
		size = world_size,
		type = "overworld"
		}
	
	bsp(world_root, world_size, 0, 0)
	assign_nodes(0)
	return

func bsp(origin : Vector2, size : Vector2, depth : int, node : int):
	var current_size = size.x*size.y
		
	#Threshold to continue division for smaller than max size rooms
	var threshold = log((current_size/max_room_size)*5 + 1)
	
	if tree_size < node:
		tree_size = node
	
	if threshold > 0.9:
		threshold = 0.9
	if current_size <= max_room_size && rand.randf() > threshold:
		return
	else:
		var left_origin
		var left_size
		
		var right_origin
		var right_size
		
		#Split % based on seed
		var split = rand.randf_range(0.3,0.7)
		
		if (fmod(depth, 2) == 0):
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
			size = right_size,
			type = "chunk"
			}
		#Add left node
		world[node*2+1] = {
				origin = left_origin,
				size = left_size,
				type = "chunk"
				}
		#BSP for left and right
		bsp(left_origin, left_size, depth+1, node*2+1)
		bsp(right_origin, right_size, depth+1, node*2+2)
		return

func assign_nodes(node : int):
	var children = 0;
	if node*2+1 <= tree_size: 
		if world[node*2+1]:
			assign_nodes(node*2+1)
			children += 1
	if node*2+2 <= tree_size: 
		if world[node*2+2]:
			assign_nodes(node*2+2)
			children += 1
	if children == 0:
		if rand.randf() < 0.6:
			world[node].type = "cave"
		elif rand.randf() < 0.8:
			world[node].type = "fill"
		else:
			world[node].type = "structure"
	return

func _input(event):
	if event.is_action_released("drawNextChunk"):
		chunkDraw += 1
		update()
	if event.is_action_released("drawPreviousChunk"):
		chunkDraw -= 1
		update()
	if event.is_action_released("newMap"):
		build()
		update()
		print("NBew")
	if event.is_action_released("drawMode"):
		if drawMode == "bsp":
			drawMode = "type"
		else:
			drawMode = "bsp"
		update()

func _draw():
	for chunk in world:
		if chunk:
			#draw_rect(Rect2(chunk.origin + vec1, chunk.size + vec1), Color(1,0,0), false)
			if drawMode == "type":
				if chunk.type == "cave":
					draw_rect(Rect2(chunk.origin + vec1, chunk.size + vec1), Color(0,0,1))
				elif chunk.type == "structure":
					draw_rect(Rect2(chunk.origin + vec1, chunk.size + vec1), Color(0,1,0))
				else:
					draw_rect(Rect2(chunk.origin + vec1, chunk.size + vec1), Color(0,0,0))