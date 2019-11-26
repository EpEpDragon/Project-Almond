extends Node2D

onready var tile = $"..".tileSize
onready var BSP = $"../BSP"

export var fillChance = 0.56
var worldX
var worldY
var rand : RandomNumberGenerator
var worldCurrent = []

func _ready():
	rand = $"..".rand

func prepWorld():
	#World current
	worldX = BSP.worldSize.x/tile.x
	worldY = BSP.worldSize.y/tile.y
	
	worldCurrent.resize(worldY)
	for y in worldY:
		worldCurrent[y] = []
		worldCurrent[y].resize(worldX)
		for x in worldX:
			worldCurrent[y][x] = 1

func randomizeZones(node : int):
	var treeSize = BSP.tree_size
	var world = BSP.world

	if node*2+1 <= treeSize: 
		if world[node*2+1]:
			randomizeZones(node*2+1)
	if node*2+2 <= treeSize: 
		if world[node*2+2]:
			randomizeZones(node*2+2)
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
