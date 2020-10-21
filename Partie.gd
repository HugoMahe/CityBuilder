extends Spatial
var mapClass = load("./MapScript/GridMap.gd")
var map = mapClass.new()
var reserveClass = load("res://Reserve.gd")
var stockage = reserveClass.new() 

# Called when the node enters the scene tree for the first time.
func _ready():
	map.genererGrid(5)
	map.jouer()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
