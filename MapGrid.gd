extends MeshInstance

var case = load("Case.gd")
var grid = []
export var n = 5 


func generationMap(n):
	for x in range(n):
		grid[x]=[]
		for y in range(n):
			grid[x][y]= case.new();
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
	



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
