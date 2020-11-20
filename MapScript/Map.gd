extends MeshInstance

var matrix = []
var Case = load("res://MapScript/Case.gd")
var CabaneClass = load("res://MapScript/Batiment/Cabane.gd")
var AubergeClass = load("res://MapScript/Batiment/Auberge.gd")
var fermeClass = load("res://MapScript/Batiment/Ferme.gd")
var ready = false


# var pour la production de ressource pour le tour donnée
var retour
var nourriture = 0 
var charbon = 0
var bois = 0 


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
func jouer():
	var ressourcesTour = jouerTour()
	#printEnsembleBatiment()
	printAllRessourcesFromTour()
	return ressourcesTour
	
#	
func jouerTour():
	nourriture=0
	bois=0
	charbon=0
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
	if(retour):
		if(retour.get_class()=="Nourriture"):
			nourriture+=retour.getQuantite()
		if(retour.get_class()=="Charbon"):
			charbon+=retour.getQuantite()
		if(retour.get_class()=="Bois"):
			bois+=retour.getQuantite()
	retour=0


func ajoutBatimentMemoire(batimentType,xCoor,zCoor, caseGraphique):
	print("Ajout du batiment ", batimentType)
	var _valeurClass
	if(batimentType=="Auberge"):
		_valeurClass = AubergeClass
	elif(batimentType=="Cabane"):
		_valeurClass =CabaneClass
	elif(batimentType=="Ferme"):
		print("ajout ferme")
		_valeurClass=fermeClass
	for x in range(matrix.size()):
		for y in range(matrix.size()):
			if(matrix[x][y].getConstructible()==true):
				matrix[x][y].setBatiment(_valeurClass.new(),batimentType)
				matrix[x][y].setCaseGraphique(caseGraphique)
				#print("Batiment :", matrix[x][y].getBatiment())
				#print("ajout du noeud matrice", matrix)
				matrix[x][y].getBatiment().setCoordonnes(xCoor,zCoor,matrix)
				return
	
func chercheBatiment(batimentRecherche):
	for x in range(matrix.size()):
		for y in range(matrix.size()):
			if (matrix[x][y].getConstructible()==false):
				if(matrix[x][y].getBatimentNom()==batimentRecherche):
					return matrix[x][y]
	return null

pass

			

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
