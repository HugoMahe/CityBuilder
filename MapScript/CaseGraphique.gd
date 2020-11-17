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
	booleanRoute=true
	if typeBatiment == "Route":
		var batiment = load("res://Models/Route.dae").instance()
		batiment.transform.origin =Vector3(centerX,1,centerZ)
		if(angle!=0):
			batiment.rotate_y(deg2rad(angle))
		print(spatial)
		spatial.add_child(batiment)
pass 


func generateModel():
	var maCaseModel = load("res://Models/CaseGraphHerbe.dae").instance()
	maCaseModel.transform.origin = Vector3(centerX,1,centerZ)
	spatial.add_child(maCaseModel)
pass
