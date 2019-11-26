extends Node2D

#warning-ignore:unused_class_variable
export var worldSize = Vector2(2000,1200)
#warning-ignore:unused_class_variable
export var max_room_size = 100000;

export var tileSize = Vector2(10,10)
export var Seed = 666

var rand = RandomNumberGenerator.new()
var drawMode = ["type", "", "Automata"]
onready var BSP = $"./BSP"
onready var CellularAutomata = $"./CellularAutomata"

func _ready():
	rand.seed = Seed

	BSP.build()
	CellularAutomata.prepWorld()
	CellularAutomata.randomizeZones(0)
	CellularAutomata.smooth(300000)

func _on_DrawAutomata_pressed():
	if drawMode[2] == "Automata":
		drawMode[2] = ""
	else:
		drawMode[2] = "Automata"
	update()

func _on_Smooth_pressed():
	print("smooth") 
	CellularAutomata.smooth(10000)
	update()

func _on_NewCave_pressed():
	print("Cave gen")
	CellularAutomata.prepWorld()
	CellularAutomata.randomizeZones(0)
	CellularAutomata.smooth(300000)
	update()

func _on_NewBSP_pressed():
		BSP.build()
		update()

func _on_DrawZones_pressed():
		if drawMode[0] == "type":
			drawMode[0] = "0"
		else:
			drawMode[0] = "type"
		update()

func _on_DrawDivisions_pressed():
		if drawMode[1] == "bsp":
			drawMode[1] = "0"
		else:
			drawMode[1] = "bsp"
		update()

func _draw():
#	for y in CellularAutomata.worldY:
#		for x in CellularAutomata.worldX:
#			if CellularAutomata.worldCurrent[y][x] == 1:
#				draw_rect(Rect2(Vector2(x*tileSize.x, y*tileSize.y) + Vector2.ONE,tileSize + Vector2.ONE), Color(0,0,0))
#			else:
#				draw_rect(Rect2(Vector2(x*tileSize.x, y*tileSize.y) + Vector2.ONE,tileSize +  Vector2.ONE), Color(1,1,1))
#	draw_line(Vector2(1,1), Vector2(121,1), Color(1,1,1))
#
#	for chunk in BSP.world:
#		if chunk:
#			if drawMode[0] == "type":
#				if chunk.type == "cave" && drawMode[2] == "":
#					draw_rect(Rect2(chunk.origin + Vector2.ONE, chunk.size + Vector2.ONE), Color(0,0,1))
#				elif chunk.type == "structure":
#					draw_rect(Rect2(chunk.origin + Vector2.ONE, chunk.size + Vector2.ONE), Color("#615d52"))
#				elif drawMode[2] == "":
#					draw_rect(Rect2(chunk.origin + Vector2.ONE, chunk.size + Vector2.ONE), Color(0,0,0))
#			if chunk.type != "chunk" && drawMode[1] == "bsp":
#				draw_rect(Rect2(chunk.origin + Vector2.ONE, chunk.size + Vector2.ONE), Color(1,0,0), false)
	pass
