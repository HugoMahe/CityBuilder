extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mapGraphique;

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


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setCaseTopLeft(x,z,spacingX,spacingZ, node):
	caseTopLeftX=x
	caseTopLeftZ=z
	caseBottomRightX=caseTopLeftX+spacingX
	caseBottomRightZ=caseTopLeftZ+spacingZ
	centerX = (caseTopLeftX + caseBottomRightX) / 2
	centerZ = (caseTopLeftZ + caseBottomRightZ) /2
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func trouverVoisinCase(var mapParam,spacingX,spacingZ):
	caseVoisinDroite = mapParam.getClosestCaseMap(centerX+spacingX,centerZ)
	caseVoisinGauche = mapParam.getClosestCaseMap(centerX-spacingX,centerZ)
	caseVoisinHaut = mapParam.getClosestCaseMap(centerX,centerZ-spacingZ)
	caseVoisinBas = mapParam.getClosestCaseMap(centerX,centerZ+spacingZ)
	pass