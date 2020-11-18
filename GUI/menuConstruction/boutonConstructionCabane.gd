extends TextureButton

var nodeGui = "vide"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	print("Construction de la cabane possible")
	get_node("/root/Map").setBooleanConstruction()
	get_node("/root/Map").setTypeBatimentConstruction("Cabane")
	pass # Replace with function body.
