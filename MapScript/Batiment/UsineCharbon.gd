extends Node
var charbonClass = load("res://Ressources/Charbon.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func produit():
	var charbon = charbonClass.new()
	charbon.setQuantite(30)
	return charbon 
	
func getBatiment():
	return "UsineCharbon"
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
