extends Node2D

var tile = Vector2(10,10)
var worldX
var worldY
var rand : RandomNumberGenerator
var worldCurrent = []
export var fillChance = 0.5
var BSP
var vec1 = Vector2(1,1)
var draw

func _ready():
	BSP = get_tree().get_root().get_node("Node2D/BSP")
	worldX = BSP.worldSize.x/10
	worldY = BSP.worldSize.y/10
	
	rand = RandomNumberGenerator.new()
	rand.seed = 45645
	prepWorld()

func prepWorld():
	#World current
	worldCurrent.resize(worldY)
	for y in worldY:
		worldCurrent[y] = []
		worldCurrent[y].resize(worldX)
		for x in worldX:
			worldCurrent[y][x] = 1

func randomizeZones(node : int):
	var treeSize = BSP.tree_size
	var world = BSP.world

	var children = 0;
	if node*2+1 <= treeSize: 
		if world[node*2+1]:
			randomizeZones(node*2+1)
			children += 1
	if node*2+2 <= treeSize: 
		if world[node*2+2]:
			randomizeZones(node*2+2)
			children += 1
	if world[node].type == "cave":
		randomizeRect(world[node].origin, world[node].size)
	return

func randomizeRect(origin : Vector2, size : Vector2):
	var yOrigin = origin.y/tile.y
	var xOrigin = origin.x/tile.x
	var y = yOrigin 
	var x = xOrigin
	var ySize = size.y/tile.y
	var xSize = size.x/tile.x
	
	while y < yOrigin + ySize:
		while x < xOrigin + xSize:
			if x == 0 || y == 0 || x == worldX-1 || y == worldY-1:
				worldCurrent[y][x] = 1
			elif rand.randf() > fillChance:
				worldCurrent[y][x] = 1
			else:
				worldCurrent[y][x] = 0
			x += 1
		x = xOrigin
		y += 1

func neighbourCount(var x, var y):
	var count = 0
	var neighbourX = x-1
	var neighbourY = y-1
	
	while neighbourX <= x+1:
		while neighbourY <= y+1:
			if neighbourX < 0 || neighbourY < 0 || neighbourX >= worldX || neighbourY >= worldY:
				count += 1
			elif (neighbourX != x || neighbourY != y):
				if worldCurrent[neighbourY][neighbourX]:
					count += 1
			neighbourY += 1
		neighbourX += 1
		neighbourY = y-1
	return count

func smooth(var iterations : int):
	var y : int
	var x : int
	for i in iterations:
		y = rand.randi_range(0, worldY-1)
		x = rand.randi_range(0, worldX-1)
		
		var neighbours = neighbourCount(x,y)

		if neighbours > 4:
			worldCurrent[y][x] = 1
		elif neighbours < 4:
			worldCurrent[y][x] = 0

func _draw():
	if draw:
		for y in worldY:
			for x in worldX:
				if worldCurrent[y][x] == 1:
					draw_rect(Rect2(Vector2(x*tile.x, y*tile.y) + vec1,tile + vec1), Color(0,0,0))
				else:
					draw_rect(Rect2(Vector2(x*tile.x, y*tile.y) + vec1,tile+  vec1), Color(1,1,1))
	draw_line(Vector2(1,1), Vector2(121,1), Color(1,1,1))
func _on_Button_pressed():
	print("smooth") 
	smooth(10000)
	update()

func _on_Button2_pressed():
	print("Cave gen")
	randomizeZones(0)
	#smooth(300000)
	update()

func _on_DrawAutomata_pressed():
	if draw == false:
		draw = true
	else:
		draw = false
	update()
