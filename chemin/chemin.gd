extends Node

var debut;
var fin

var placementBoolean = false
var caseDebut
var caseFin
var mapGraphique

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setRoute(debutParam, finParam):
	debut=debutParam
	fin=finParam
	var angle= abs(atan2(fin.y-debut.y,fin.x-debut.x) *180 / PI)
	print (angle)
	return angle
	pass
	
func getDebut():
	return debut

func getfin():
	return fin

func setPlacementBoolean(paramBoolean):
	placementBoolean=paramBoolean

func getPlacementBoolean():
	return placementBoolean

func setCaseDebutRoute(caseDebutParam):
	caseDebut=caseDebutParam
pass

func setCaseFinRoute(caseFinParam):
	caseFin=caseFinParam
	if(caseDebut.centerX==caseFin.centerX):
		if(caseDebut.centerZ>caseFin.centerZ):
			var evolution = caseDebut.centerZ
			var caseCourante = caseDebut
			while(evolution > caseFin.centerZ ):
				caseCourante.ajouterBatiment("Route",0)
				caseCourante = caseCourante.caseVoisinHaut
				evolution = evolution - caseDebut.spacingZ
			caseFin.ajouterBatiment("Route",0)

		else:
			var evolution = caseDebut.centerZ
			var caseCourante = caseDebut
			while(evolution < caseFin.centerZ ):
				caseCourante.ajouterBatiment("Route",0)
				caseCourante = caseCourante.caseVoisinBas
				evolution = evolution + caseDebut.spacingZ
			caseFin.ajouterBatiment("Route",0)

	elif(caseDebut.centerZ==caseFin.centerZ):
		var evolution = caseDebut.centerX
		var caseCourante = caseDebut
		if(caseDebut.centerX < caseFin.centerX):
			while(evolution < caseFin.centerX ):
				caseCourante.ajouterBatiment("Route",90)
				caseCourante = caseCourante.caseVoisinDroite
				evolution = evolution + caseDebut.spacingX
			caseFin.ajouterBatiment("Route",90)
		else:
			while(evolution > caseFin.centerX ):
				caseCourante.ajouterBatiment("Route",90)
				caseCourante = caseCourante.caseVoisinGauche
				evolution = evolution - caseDebut.spacingX
			caseFin.ajouterBatiment("Route",90)
	else:
		print("la route n'est pas droite"); 
	pass

