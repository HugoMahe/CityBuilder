extends Batiment
var nourritureClass = load("res://Ressources/Nourriture.gd")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func produit():
	var nourriture = nourritureClass.new()
	nourriture.setQuantite(50)
	return nourriture

func getBatiment():
	return "Cabane"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
