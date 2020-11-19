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
var scriptPopulation = load("res://Population/individu.gd")
var x=0
var y=0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(spatial,xCoor,zCoor,case):
	caseX = xCoor
	caseZ = zCoor
	noeudSpatial = spatial
	print("spatial reçu")
	print(spatial)
	for i in range(nombrePopulationSpawn):
		var individu = load("res://Models/Individu.dae").instance()
		individu.transform.origin = Vector3(caseX,1,caseZ)
		population.insert(i,individu)
		individu.set_script(scriptPopulation)
		individu.init(case,noeudSpatial)
		noeudSpatial.add_child(individu)


func produit():
	return 0

func getBatiment():
	return "Auberge"
	pass 
	
func setCoordonnes(xParam, yParam):
	x=xParam
	y=yParam
	pass
