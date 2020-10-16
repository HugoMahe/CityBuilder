extends Node
class_name Case

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var constructible= true setget setConstructible, getConstructible
var BatimentClasse = load("Batiment.gd")
var batiment = null setget setBatiment, getBatiment

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func getConstructible():
	return constructible

func setConstructible(nouvelleVar):
	constructible = nouvelleVar

func setBatiment(batimentParam):
	batiment= batimentParam
	setConstructible(false)
	print(getConstructible())

func getBatiment():
	return batiment
	
func jouer():
	if(constructible==false):
		print("Joue sa case:")
		batiment.produit()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
