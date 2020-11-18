extends Batiment


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var nombrePopulationSpawn=1
var nombrePopulationMax=15
var noeudSpatial
var population = []
var caseX
var caseZ



# Called when the node enters the scene tree for the first time.
func _ready():
	var scriptPopulation = load("res://Population/individu.gd")
	for i in range(nombrePopulationSpawn):
		var individu = load("res://Models/Individu.dae").instance()
		individu.transform.origin = Vector3(caseX,1,caseZ)
		noeudSpatial.add_child(noeudSpatial)
		population.insert(i,individu)
		individu.set_script( scriptPopulation )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(spatial):
	noeudSpatial = spatial


func produit():
	return 0

func getBatiment():
	return "Auberge"
	pass 
