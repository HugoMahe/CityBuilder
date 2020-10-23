extends Node

var quantite=0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setQuantite(x):
	quantite=x

func getQuantite():
	return quantite
	
func get_class():
	return "Bois"
