extends Batiment
class_name Cabane
var nourritureClass = load("res://Ressources/Nourriture.gd")
var coutBois
var desc

func _init():
	coutBois = 150
	desc = "Une cabane pour se cacher et qui sert de point de chute lors de la chasse"


var x=0
var y=0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func produit():
	var nourriture = nourritureClass.new()
	nourriture.setQuantite(50)
	return nourriture

func getBatiment():
	return "Cabane"
	pass 
	
func setCoordonnes(xParam, yParam):
	x=xParam
	y=yParam
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
