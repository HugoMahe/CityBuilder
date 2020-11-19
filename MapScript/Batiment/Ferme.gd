extends Batiment
class_name Ferme
var nourritureClass = load("res://Ressources/Nourriture.gd")
var coutBois
var coutCharbon
var desc 

func _init():
	coutBois = 150
	coutCharbon = 25
	desc = "Une ferme pour produire du choux"


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
	return "Ferme"
	pass 
	
func setCoordonnes(xParam, yParam):
	x=xParam
	y=yParam
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
