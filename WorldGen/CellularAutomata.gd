extends Node2D

var tile = Vector2(10,10)
var worldSize = 100
var rand : RandomNumberGenerator
var worldCurrent = []
var fillChance = 0.5

func _ready():
	rand = RandomNumberGenerator.new()
	rand.seed = 666
	prepArrays()
	populate()
	for i in 5:
		smooth()

func prepArrays():
	#World current
	worldCurrent.resize(worldSize)
	for y in worldSize:
		worldCurrent[y] = []
		worldCurrent[y].resize(worldSize)

func populate():
	for y in worldSize:
		for x in worldSize:
			if x == 0 || y == 0 || x == worldSize-1 || y == worldSize-1:
				worldCurrent[y][x] = 1
			elif rand.randf() > fillChance:
				worldCurrent[y][x] = 1
			else:
				worldCurrent[y][x] = 0

func neighbourCount(var x, var y):
	var count = 0
	var neighbourX = x-1
	var neighbourY = y-1
	
	while neighbourX <= x+1:
		while neighbourY <= y+1:
			if neighbourX < 0 || neighbourY < 0 || neighbourX >= worldSize || neighbourY >= worldSize:
				count += 1
			elif (neighbourX != x || neighbourY != y):
				if worldCurrent[neighbourY][neighbourX]:
					count += 1
			neighbourY += 1
		neighbourX += 1
		neighbourY = y-1
	return count

func smooth():
	for y in worldSize:
		for x in worldSize:
			var neighbours = neighbourCount(x,y)
			if neighbours > 4:
				worldCurrent[y][x] = 1
			elif neighbours < 4:
				worldCurrent[y][x] = 0

func _draw():
	for y in worldSize:
		for x in worldSize:
			if worldCurrent[y][x] == 1:
				draw_rect(Rect2(Vector2(x*tile.x, y*tile.y),tile), Color(0,0,0))
			else:
				draw_rect(Rect2(Vector2(x*tile.x, y*tile.y),tile), Color(1,1,1))
