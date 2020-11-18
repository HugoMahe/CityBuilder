extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mapGraphique;
var spatial

var caseTopLeftX
var caseTopLeftZ
var caseBottomRightX
var caseBottomRightZ
var centerX
var centerZ
var caseTop

var casesVoisines = []
var caseVoisinHaut
var caseVoisinBas
var caseVoisinDroite
var caseVoisinGauche
var spacingZ
var spacingX
var booleanRoute=false
var constructible=true setget setConstructible, isConstructible


var typeRouteModel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setCaseTopLeft(x,z,spacingXParam,spacingZParam, node):
	spatial=node
	spacingX = spacingXParam
	spacingZ = spacingZParam
	caseTopLeftX=x
	caseTopLeftZ=z
	caseBottomRightX=caseTopLeftX+spacingXParam
	caseBottomRightZ=caseTopLeftZ+spacingZParam
	centerX = (caseTopLeftX + caseBottomRightX) / 2
	centerZ = (caseTopLeftZ + caseBottomRightZ) /2
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func trouverVoisinCase(var mapParam,spacingXParam,spacingZParam):
	caseVoisinDroite = mapParam.getClosestCaseMap(centerX+spacingXParam,centerZ)
	caseVoisinGauche = mapParam.getClosestCaseMap(centerX-spacingXParam,centerZ)
	caseVoisinHaut = mapParam.getClosestCaseMap(centerX,centerZ-spacingZParam)
	caseVoisinBas = mapParam.getClosestCaseMap(centerX,centerZ+spacingZParam)
	pass

func ajouterBatiment(typeBatiment,angle):
	if(booleanRoute==true):
		print("Route déjà sur ce terrain : Croisement à update")
		changementModel()
	if typeBatiment == "Route" and booleanRoute==false:
		booleanRoute=true
		typeRouteModel = load("res://Models/Route.dae").instance()
		typeRouteModel.transform.origin =Vector3(centerX,1,centerZ)
		if(angle!=0):
			typeRouteModel.rotate_y(deg2rad(angle))
		print(spatial)
		spatial.add_child(typeRouteModel)
	refreshRouteAutour()
	changementModel()
pass 


func generateModel():
	var maCaseModel = load("res://Models/CaseGraphHerbe.dae").instance()
	maCaseModel.transform.origin = Vector3(centerX,1,centerZ)
	spatial.add_child(maCaseModel)
pass

func changementModel():
	if(booleanRoute):
		if(caseVoisinGauche.booleanRoute==true and caseVoisinHaut.booleanRoute==true and caseVoisinDroite.booleanRoute==false and caseVoisinBas.booleanRoute==false):
			switchModelFromSpatial("res://Models/RouteGaucheVersHaut.dae")
		elif(caseVoisinGauche.booleanRoute and caseVoisinHaut.booleanRoute and caseVoisinDroite.booleanRoute and caseVoisinBas.booleanRoute==false):
			switchModelFromSpatial("res://Models/RouteHautDouble.dae")
		elif(caseVoisinGauche.booleanRoute==true and caseVoisinHaut.booleanRoute==true and caseVoisinDroite.booleanRoute==true and caseVoisinBas.booleanRoute==true):
			switchModelFromSpatial("res://Models/RouteCroix.dae")
		elif(caseVoisinGauche.booleanRoute and caseVoisinHaut.booleanRoute==false and caseVoisinDroite.booleanRoute and caseVoisinBas.booleanRoute):
			switchModelFromSpatial("res://Models/RouteBasDouble.dae")
		elif(caseVoisinGauche.booleanRoute==false and caseVoisinHaut.booleanRoute==false and caseVoisinDroite.booleanRoute==true and caseVoisinBas.booleanRoute==true):
			switchModelFromSpatial("res://Models/RouteDroiteBas.dae")
		elif(caseVoisinGauche.booleanRoute==true and caseVoisinHaut.booleanRoute==true and caseVoisinDroite.booleanRoute==false and caseVoisinBas.booleanRoute==false):
			switchModelFromSpatial("res://Models/RouteGaucheVersHaut.dae")
		elif(caseVoisinGauche.booleanRoute==true and caseVoisinHaut.booleanRoute==false and caseVoisinDroite.booleanRoute==false and caseVoisinBas.booleanRoute==true):
			switchModelFromSpatial("res://Models/RouteGaucheVersBas.dae")
		elif(caseVoisinGauche.booleanRoute==false and caseVoisinHaut.booleanRoute==true and caseVoisinDroite.booleanRoute==true and caseVoisinBas.booleanRoute==true):
			switchModelFromSpatial("res://Models/RouteDroiteVersHautBas.dae")
		elif(caseVoisinGauche.booleanRoute==true and caseVoisinHaut.booleanRoute==true and caseVoisinDroite.booleanRoute==false and caseVoisinBas.booleanRoute==true):
			switchModelFromSpatial("res://Models/RouteGaucheVersHautBas.dae")	
		elif(caseVoisinGauche.booleanRoute==false and caseVoisinHaut.booleanRoute==true and caseVoisinDroite.booleanRoute==true and caseVoisinBas.booleanRoute==false):
			switchModelFromSpatial("res://Models/RouteDroiteVersHaut.dae")	

	pass


func switchModelFromSpatial(chemin):
	spatial.remove_child(typeRouteModel)
	typeRouteModel= load(chemin).instance()
	typeRouteModel.transform.origin =Vector3(centerX,1,centerZ)
	spatial.add_child(typeRouteModel)
	pass

func refreshRouteAutour():
	caseVoisinDroite.changementModel()
	caseVoisinGauche.changementModel()
	caseVoisinBas.changementModel()
	caseVoisinHaut.changementModel()
	pass

func isConstructible():
	return constructible
	
func setConstructible(boolean):
	constructible = boolean
