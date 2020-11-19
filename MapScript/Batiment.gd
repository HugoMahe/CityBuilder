extends Node
class_name Batiment
var production

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var nodeBatiment
var position3DX
var position3Dy
var position3Dz

var desc = ""

var coutBois = 0
var coutCharbon = 0
var coutNourriture = 0

var travailleurs = []

# Called when the node enters the scene tree for the first time.
func produit():
	pass	

func getBatiment():
	pass
	
func set3Dcoordinates(x,y,z):
	position3DX=x
	position3Dy=y
	position3Dz=z
	
func getCouts():
	var couts = {"bois": coutBois, 
		"charbon": coutCharbon, 
		"nourriture": coutNourriture}
	return couts

func addTravailleur(individu):
	travailleurs.push_front(individu)
	pass

func removeTravailleur(individu):
	for i in len(travailleurs):
		if(travailleurs[i]==individu):
			travailleurs.remove(individu)
			return individu
	return null
	pass

func removeAllTravailleur():
	travailleurs.clear()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
