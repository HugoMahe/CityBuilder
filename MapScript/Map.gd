extends MeshInstance

var matrix = []
var Case = load("res://MapScript/Case.gd")
var Cabane = load("res://MapScript/Batiment/Cabane.gd").new()
var ready = false


# var pour la production de ressource pour le tour donnée
var retour
var nourriture = 0 
var charbon = 0
var bois = 0 

var noeudSpatial


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
func jouer(xParam):
	print("----------------------------------- Lancement de la partie ------------------------------")
	noeudSpatial = xParam
	print("VALEUR DE test :", noeudSpatial)
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
				#print(matrix[x][y])
				#print(Cabane)
				matrix[x][y].setBatiment(Cabane)
				print("Batiment :", matrix[x][y].getBatiment())
				matrix[x][y].getBatiment().setCoordonnes(x,y)
				return
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
