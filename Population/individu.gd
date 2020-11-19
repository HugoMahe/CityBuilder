extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sortie = false
var fonction = null

var caseCourante

var tabTrajet = []

var booleanArrivee=false
var booleanTrajetSet=false

var caseObjectif

var positionCouranteX
var positionCouranteZ

var busy=false
var finished=true
var moving=false


#TEST
var noeudS




# Called when the node enters the scene tree for the first time.
func _ready():
	print("Je viens de spawn")
	pass # Replace with function body.

# FONCTION INITIALISATION DES VARAIABLES D'ETAT
func init(caseCouranteParam, noeudSpatial):
	noeudS = noeudSpatial
	caseCourante=caseCouranteParam
	caseObjectif=caseCouranteParam.caseVoisinGauche.caseVoisinGauche.caseVoisinHaut.caseVoisinHaut.caseVoisinGauche.caseVoisinGauche
	positionCouranteX=caseCourante.centerX
	positionCouranteZ=caseCourante.centerZ
	print("[INDIVIDU] - j'ai ma case courante")
pass

#DEFINIR UN TRAJET
func setTrajet(trajet):
	tabTrajet.push_front(trajet)
	pass

func readTrajet():
	if(len(tabTrajet)!=0):
		return tabTrajet[0]
	return []
	pass

#retourne un trajet
func deplacement(trajet):
	if(trajet):
		print(len(trajet))
	if((!moving && !finished) || len(trajet)>0):
		bougerVersUneCase(trajet[0])
	if(finished):
		trajet.pop_front()
pass

func bougerVersUneCase(objectif):
	if(caseCourante!=objectif):
		print("Cas nominal")
		moving = true
		finished=false
		if(caseCourante.centerX<objectif.centerX):
			self.transform.origin += Vector3(0.1,0,0)
		elif(caseCourante.centerX>objectif.centerX):
			self.transform.origin += Vector3(-0.1,0,0)
		elif(caseCourante.centerZ<objectif.centerZ):
			self.transform.origin += Vector3(0,0,0.1)
		elif(caseCourante.centerZ>objectif.centerZ):
			self.transform.origin += Vector3(0,0,-0.1)
	else:
		print("test 3 ")
		moving = false
		finished = true
	positionCouranteZ = self.transform.origin.z
	positionCouranteX = self.transform.origin.x
pass




#UPDATE A CHAQUE FRAME 
func _process(_delta):
		refreshCaseCourante()
		refreshBusy()
		if(!busy):
			setTrajet(caseCourante.getMap().retrouverChemin(caseCourante,caseObjectif))
		else:
			ajoutMesArbres(readTrajet())
			deplacement(readTrajet())
pass

func ajoutMesArbres(trajet):
	#print("ajout de mes arbres")
	for i in len(trajet):
		var mesh = load("res://Models/Terrain/Arbre.dae").instance()
		mesh.transform.origin = Vector3(trajet[i].centerX,1,trajet[i].centerZ)
		noeudS.add_child(mesh)
		


#VERIFICATION DES ETAPES DU TRAJET
func refreshCaseCourante():
	caseCourante = caseCourante.getMap().getClosestCaseMap(positionCouranteX,positionCouranteZ)
	pass

func refreshBusy():
	if(len(tabTrajet)==0):
		busy=false
	else:
		busy=true
	pass

func consommeEtape():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
