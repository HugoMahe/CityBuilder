extends Node

var spacingX=6
var spacingZ=6
var matrixCaseGraphique = []
var mapCase = {}
var spatial

var listeOuverte = []
var listeFermee = []
var booleanTrouve=false


var caseGraphiqueClass = load("res://MapScript/CaseGraphique.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func generateGraphicalGridMap(nodeOriginGridParam, nodeEndGridParam,spatialParam):
	spatial = spatialParam
	var  xOrigin = nodeOriginGridParam.translation[0]
	var zOrigin = nodeOriginGridParam.translation[2]
	var xFin = nodeEndGridParam.translation[0]
	var zFin = nodeEndGridParam.translation[2]
	var x = 0
	var y = 0
	while( xOrigin < xFin):
		matrixCaseGraphique.append([])
		matrixCaseGraphique[x]=[]
		while(zOrigin <= zFin):
			#CREATION DE LA CASE GRAPHIQUE
			var temporigin = xOrigin+spacingX
			var temporigin2 = zOrigin+spacingZ
			var formatageCle = str(str(xOrigin)  + ":" + str(temporigin) +";" + str(zOrigin) +":" + str(temporigin2))
			mapCase[formatageCle] = caseGraphiqueClass.new()
			mapCase[formatageCle].setCaseTopLeft(xOrigin,zOrigin,spacingX,spacingZ, nodeOriginGridParam.get_parent())
			mapCase[formatageCle].generateModel()
			mapCase[formatageCle].setMap(self)
			zOrigin=zOrigin +spacingZ
			y = y+1
		zOrigin = nodeOriginGridParam.translation[2]
		xOrigin= xOrigin + spacingX
		x = x +1
		y=0
	return mapCase
	pass


func getClosestCaseMap(xCoor,zCoor):
	var keys = mapCase.keys()
	for i in keys.size() :
		var recupCle = keys[i].split(";")
		var valeurX = recupCle[0].split(":")
		var valeurZ = recupCle[1].split(":")
		if(xCoor > float(valeurX[0]) and xCoor <  float(valeurX[1])):
			if(zCoor > float(valeurZ[0]) and zCoor < float(valeurZ[1])):
				return mapCase[keys[i]]

func trouverVoisin():
	var keys = mapCase.keys()
	for i in keys.size() :
		mapCase[keys[i]].trouverVoisinCase(self,spacingX,spacingZ)
	pass 
	
func trouverChemin(caseCourante,caseObjectif):
	#INITIALISATION DE LA LISTE OUVERTE
	if(booleanTrouve==false):
		listeOuverte.insert(0,caseCourante)
		caseCourante.cout_f=0
		var meilleurNoeud
		#DEBUT DU TRAITEMENT TANT QUE MA LISTE OUVERTE N'EST PAS VIDE
		while(len(listeOuverte)!=0):


			#ELECTION DU MEILLEUR NOEUD 
			meilleurNoeud = meilleur_noeud(listeOuverte)
			
			#ON RETIRE CE NOEUD DE LA LISTE OUVERTE 
			listeOuverte.remove(noeudExiste(listeOuverte, meilleurNoeud))

			#AJOUT DE CE MEILLEUR NOEUD A LA LISTE FERMEE
			listeFermee.insert(len(listeFermee), meilleurNoeud)

			#####################TRAITEMENT DES SUCCESSEUR###########################
			var gNew
			var hNew 
			var fNew 

			for i in range(len(meilleurNoeud.casesVoisines)):
				if(meilleurNoeud.casesVoisines[i]):
					#SI MON NOEUD SUCCESSEUR EST LA CASE OBJECTIF
					if(meilleurNoeud.casesVoisines[i]==caseObjectif):
						print("STOP LA RECHERCHE")
						#DEFINI LE NOEUD COURANT COMME PARENT DES SUCCESSEUR
						meilleurNoeud.casesVoisines[i].pointeurNoeudParent=meilleurNoeud
						booleanTrouve=true
						retrouverChemin(caseObjectif,caseCourante)

					#SI MON SUCCESSEUR N'EST PAS DANS LA LISTE FERMEE ET N'EST PAS UN ELEMENT BLOQUANT
					elif(!noeudExiste(listeFermee, meilleurNoeud.casesVoisines[i])):
						gNew = meilleurNoeud.cout_g + calculDistance(meilleurNoeud.centerX, meilleurNoeud.casesVoisines[i].centerX, meilleurNoeud.centerZ, meilleurNoeud.casesVoisines[i].centerZ)
						hNew = calculDistance(caseObjectif.centerX, meilleurNoeud.casesVoisines[i].centerX, caseObjectif.centerZ, meilleurNoeud.casesVoisines[i].centerZ)
						fNew = gNew + hNew


						if(!meilleurNoeud.casesVoisines[i].cout_f or meilleurNoeud.casesVoisines[i].cout_f > fNew):
							meilleurNoeud.casesVoisines[i].cout_f=fNew
							meilleurNoeud.casesVoisines[i].cout_g=gNew
							meilleurNoeud.casesVoisines[i].cout_h=hNew
							meilleurNoeud.casesVoisines[i].pointeurNoeudParent=meilleurNoeud
							listeOuverte.insert(len(listeOuverte),meilleurNoeud.casesVoisines[i])
	pass

#Calcul du carré de la distance euclidienne
func calculDistance(x1,x2,y1,y2):
	return sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))
	pass


#Test si un noeud existe dans la liste donnée
func noeudExiste(liste, noeud):
	for i in range(len(liste)):
		if(liste[i]==noeud):
			return i
	return false
	pass

func getNoeudFromList(liste, noeud):
	for i in range(liste):
		if(liste[i]==noeud):
			return noeud
	return false
	pass


#AJOUT d'un noeud dans la liste fermée
func ajoutListeFermee(noeudParam):
	listeFermee.insert(listeFermee.size(), noeudParam)
	if(listeOuverte.erase(noeudParam)==0):
		print("Erreur impossible de supprimer cet element de la liste fermée, il n'existe pas")
	pass

#DECOUVERTE DU MEILLEUR NOEUD dans la liste donnée (liste Ouverte)
func meilleur_noeud(liste):
	var meilleurQualite
	var meilleurNoeud
	for i in range(len(liste)):
		if(!meilleurQualite):
			meilleurNoeud=listeOuverte[i]
			meilleurQualite=listeOuverte[i].cout_f
		elif(liste[i].cout_f<meilleurQualite):
			meilleurQualite=liste[i].cout_f
			meilleurNoeud=liste[i]
	return meilleurNoeud

#Retrouver son chemin
func retrouverChemin(caseDestination,caseDepart):
	trouverChemin(caseDepart,caseDestination)
	var cheminAEmprunter = []
	var caseTraite = caseDestination
	while caseTraite.pointeurNoeudParent!=caseDepart:
		cheminAEmprunter.push_back(caseTraite.pointeurNoeudParent)
		caseTraite = caseTraite.pointeurNoeudParent
	cheminAEmprunter.push_back(caseDepart)
	return cheminAEmprunter
	pass
