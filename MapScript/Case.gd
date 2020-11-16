extends Node
class_name Case

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
	setConstructible(false)
	
# Détruire un batiment
func removeBatiment():
	batiment=null
	setConstructible(true)

# Recuperation du batiment
func getBatiment():
	return batiment

# Joue le tour sur la case
func jouer():
	if(constructible==false):
		return batiment.produit()
