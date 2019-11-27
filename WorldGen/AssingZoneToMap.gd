extends Node2D

onready var bspMap = $"../BSP".world
onready var BSP = $"../BSP"

func _ready():
	pass
	
func scanZones(var node : int):
	var treeSize = BSP.tree_size
	var world = BSP.world

	if node*2+1 <= treeSize: 
		if world[node*2+1]:
			scanZones(node*2+1)
	if node*2+2 <= treeSize: 
		if world[node*2+2]:
			scanZones(node*2+2)
	if world[node].type == "structure":
		structureToMap(world[node].origin, world[node].size)

func structureToMap(var origin : Vector2, var size : Vector2):
	var tile = $"..".tileSize
	var worldX = BSP.worldSize.x/tile.x
	var worldY = BSP.worldSize.y/tile.y
	var yOrigin = origin.y/tile.y
	var xOrigin = origin.x/tile.x
	var y = yOrigin 
	var x = xOrigin
	var ySize = size.y/tile.y
	var xSize = size.x/tile.x
	
	while y < yOrigin + ySize:
		while x < xOrigin + xSize:
			$"..".world[y][x] = 2
			x += 1
		x = xOrigin
		y += 1