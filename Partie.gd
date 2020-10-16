extends Spatial
var mapClass = load("GridMap.gd")
var map = mapClass.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	map.genererGrid(5)
	map.jouer()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
