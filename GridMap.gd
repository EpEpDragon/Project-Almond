extends GridMap

func _ready():
	update()

func update():
	var map = $"./WorldGen".world
	clear()
	for y in map.size():
		for x in map[y].size():
			if map[y][x] == 0:
				set_cell_item(x,0,y,0)
			elif map[y][x] == 2:
				set_cell_item(x,0,y,2)
	for y in map.size():
		for x in map[y].size():
			if map[y][x] == 1:
				set_cell_item(x,1,y,1)
				
	for y in map.size():
		for x in map[y].size():
			if map[y][x] == 1:
				set_cell_item(x,2,y,1)