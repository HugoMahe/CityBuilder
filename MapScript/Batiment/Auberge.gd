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
var case

var matrice

func _init():
	coutBois = 250
	coutNourriture = 150
	coutCharbon = 200
	desc = "Une auberge pour garder la population bien au chaud"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func init(spatial,xCoor,zCoor,caseParam):
	caseX = xCoor
	caseZ = zCoor
	case = caseParam
	noeudSpatial = spatial
	print("spatial reçu")
	print(spatial)
	for i in range(nombrePopulationSpawn):
		var individu = load("res://Models/Individu.dae").instance()
		individu.transform.origin = Vector3(caseX,1,caseZ)
		population.push_front(individu)
		individu.set_script(scriptPopulation)
		individu.init(caseParam,noeudSpatial,self)
		noeudSpatial.add_child(individu)
	donnerOrdreTous("Produire - nourriture")


func setCoordonnes(xParam, yParam, matriceParam):
	matrice=matriceParam
	x=xParam
	y=yParam
	pass

func produit():
	return 0

func getBatiment():
	return "Auberge"
	pass 
	

func donnerOrdreTous(ordre):
	print("lancement methode donner ordre à tous")
	for i in len(population):
		population[i].nouvelleTache(ordre)
	pass

func donnerOrdre(ordre, individu):
	for i in len(population):
		if(population[i]==individu):
			population[i].nouvelleTache(ordre)
	pass


