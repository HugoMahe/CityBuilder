extends MeshInstance

var matrix = []
var Case = load("res://MapScript/Case.gd")
var ready = false


# var pour la production de ressource pour le tour donnée
var retour
var nourriture = 0 
var charbon = 0
var bois = 0 

var noeudSpatial
var cabaneClass = load("res://MapScript/Batiment/Cabane.gd")


func genererGrid(n):
	for x in range(n):
		matrix.append([])
		matrix[x]=[]
		for y in range(n):
			matrix[x].append([])
			matrix[x][y]=Case.new()


func printEnsembleBatiment():
	for x in range(matrix.size()):
		for y in range(matrix.size()):
			if (matrix[x][y].getConstructible()==false):
				print(" CASE [",x, "]","[", y, "]: ", matrix[x][y].getBatiment())


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
#	
func jouer(xParam, memoireBatimentParam):
	print("----------------------------------- Lancement de la partie ------------------------------")
	noeudSpatial = xParam
	print("VALEUR DE test :", noeudSpatial)
	#testBatiment()
	var ressourcesTour = jouerTour()
	printEnsembleBatiment()
	#printAllRessourcesFromTour()
	return ressourcesTour
	
#	
func jouerTour():
	for x in range(matrix.size()):
		for y in range(matrix.size()):
			if(matrix[x][y].getConstructible()==false):
					retour=matrix[x][y].jouer()
					checkTypeProduction()
	var tableau = [bois, charbon, nourriture ]
	return tableau


#func testBatiment():
#	var Cabane = CabaneClass.new()
#	matrix[0][0].setBatiment(Cabane)
#	matrix[0][1].setBatiment(UsineCharbonClass.new())
#	matrix[0][2].setBatiment(ScierieClass.new())
	
func removeBatiment(x,y):
	matrix[x][y].removeBatiment()
	print("Batiment détruit")

func printAllRessourcesFromTour():
	print("------------------  AFFICHAGE DES RESSOURCES POUR LE TOUR: ------------------------- ")
	print("Nourriture: ",nourriture)
	print("Charbon: ",charbon)
	print("Bois: ",bois)


func checkTypeProduction():
	if(retour.get_class()=="Nourriture"):
		nourriture=retour.getQuantite()
	if(retour.get_class()=="Charbon"):
		charbon=retour.getQuantite()
	if(retour.get_class()=="Bois"):
		bois=retour.getQuantite()
	retour=0


func ajoutBatimentMemoire(batimentType):
	print("Ajout du batiment ", batimentType)
	for x in range(matrix.size()):
		for y in range(matrix.size()):
			if(matrix[x][y].getConstructible()==true):
				matrix[x][y].setBatiment(cabaneClass.new())
				return
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
