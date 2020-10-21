extends Node
var boisClass = load("res://Ressources/Bois.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func produit():
	var bois = boisClass.new()
	bois.setQuantite(100)
	return bois
	
func getBatiment():
	return "Scierie"
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
