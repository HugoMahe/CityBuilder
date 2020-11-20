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
var dansBatiment = false


#TEST
var noeudS
var aubergeAssociee
var debutTraitement=false




# Called when the node enters the scene tree for the first time.
func _ready():
	print("Je viens de spawn")
	pass # Replace with function body.

# FONCTION INITIALISATION DES VARAIABLES D'ETAT
func init(caseCouranteParam, noeudSpatial,aubergeParam):
	aubergeAssociee = aubergeParam
	noeudS = noeudSpatial
	caseCourante=caseCouranteParam
	caseObjectif
	positionCouranteX=caseCourante.centerX
	positionCouranteZ=caseCourante.centerZ
pass

var ordre

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
	if((!moving && !finished) || len(trajet)>0 && dansBatiment==false):
		bougerVersUneCase(trajet[0])
	if(finished && len(trajet)!=0):
		print("depilement")
		trajet.pop_front()
		if(len(trajet)==0):
			busy=false
			tabTrajet.pop_front()
pass


func nouvelleTache(ordreParam):
	ordre = ordreParam
	pass

func getTache():
	return ordre


func bougerVersUneCase(objectif):
	print("lancement bouger")
	if(caseCourante!=objectif):
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
		moving = false
		finished = true
	positionCouranteZ = self.transform.origin.z
	positionCouranteX = self.transform.origin.x
pass

func bougerDansLaCase(objectif):
	self.transform.origin.x	= objectif.centerX
	self.transform.origin.z	= objectif.centerZ
pass

func debutTraitementOrdre():
	var batimentRecherche = comprendreOrdre()
	var caseSelectionnee = demanderBatimentCase(batimentRecherche)
	if(caseSelectionnee):
		caseObjectif=caseSelectionnee
		debutTraitement=true
pass

func comprendreOrdre():
	var traitementOrdre = ordre
	var decompositionOrdre = traitementOrdre.split("-")
	print(decompositionOrdre[0])
	print(decompositionOrdre[1])
	if("Produire" in decompositionOrdre[0]):
		match decompositionOrdre[1]:
			" nourriture":
				return "Ferme"
	pass


func demanderBatimentCase(batimentRecherche):
	#aubergeAssociee.trouveBatimentRecherche(batimentRecherche)
	 var caseTrouve  =  noeudS.map.chercheBatiment(batimentRecherche).getCaseGraphique()
	 return caseTrouve
	 pass



#UPDATE A CHAQUE FRAME 
func _process(_delta):
		refreshCaseCourante()
		if(ordre && !debutTraitement):
			print("j'ai un ordre")
			debutTraitementOrdre()
		if(!busy && dansBatiment==false && debutTraitement):
			print("on commence a traiter - ajout du chemin")
			setTrajet(caseCourante.getMap().retrouverChemin(caseCourante,caseObjectif))
			busy=true
		else:
			#ajoutMesArbres(readTrajet())
			deplacement(readTrajet())
		refreshBusy()
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
	if(!caseCourante):
		print("erreur", positionCouranteX, "*", positionCouranteZ)
	pass

func refreshBusy():
	if(len(tabTrajet)==0 && finished):
		busy=false
		if(caseObjectif):
			self.transform.origin.x = stepify(self.transform.origin.x, 0.1)
			self.transform.origin.z = stepify(self.transform.origin.z, 0.1)
			bougerDansLaCase(caseObjectif)
			if(!dansBatiment):
				caseObjectif.getCaseLogique().getBatiment().addTravailleur(self)
				dansBatiment = true
	else:
		busy=true
	pass
	
func entrerBatiment():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
