extends Node
class_name Case

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var constructible= true setget setConstructible, getConstructible
var BatimentClasse = load("res://MapScript/Batiment.gd")
var batiment = null setget setBatiment, getBatiment

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Get constuctible boolean 
func getConstructible():
	return constructible

# set le terrain à constructible ou non  
func setConstructible(nouvelleVar):
	constructible= nouvelleVar

# construire un batiment 
func setBatiment(batimentParam):
	batiment= batimentParam
	print("BATIMENT SET", batimentParam)
	setConstructible(false)
	
# Détruire un batiment
func removeBatiment():
	batiment=null
	setConstructible(true)

# Recuperation du batiment
func getBatiment():
	print("TEST", batiment.getBatiment())
	

# Joue le tour sur la case
func jouer():
	if(constructible==false):
		return batiment.produit()
