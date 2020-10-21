extends Node

# Ensemble des valeurs du stockage
var stockageCharbon = 1000
var stockageNourriture = 1000
var stockageBois = 1000
var stockageMetal = 1000


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func printReserve():
	print("BOIS: ",stockageBois)
	print("CHARBON: ",stockageCharbon)
	print("NOURRITURE:", stockageNourriture)

# AJOUTER UNE RESSOURCE
func ajouterCharbon(x):
	stockageCharbon+=x

func ajouterNourriture(x):
	stockageNourriture+=x

func ajouterBois(x):
	stockageBois+=x
	
# RETIRER UNE RESSOURCE
func retirerCharbon(x):
	stockageCharbon-=x

func retirerBois(x):
	stockageBois-=x

func retirerNourriture(x):
	stockageNourriture-=x
	
# GETTER 
func getBois():
	return stockageBois
	
func getCharbon():
	return stockageCharbon
	
func getNourriture():
	return stockageNourriture
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):


#	pass
