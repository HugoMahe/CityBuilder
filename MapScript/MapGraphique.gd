extends Node

var spacingX=3
var spacingZ=3
var matrixCaseGraphique = []
var mapCase = {}


var caseGraphiqueClass = load("res://MapScript/CaseGraphique.gd")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func generateGraphicalGrid(nodeOriginGridParam, nodeEndGridParam):
	print("LANCEMENT GENERATION GRAPHIQUE")
	print(nodeOriginGridParam.translation[0])
	print(nodeEndGridParam.translation[0])
	var  xOrigin = nodeOriginGridParam.translation[0]
	var zOrigin = nodeOriginGridParam.translation[2]
	var xFin = nodeEndGridParam.translation[0]
	var zFin = nodeEndGridParam.translation[2]
	print("XDEBUT" , xOrigin)
	print("XFIN",xFin)
	print("ZDEBUT" , zOrigin)
	print("ZFIN",zFin)
	var x = 0
	var y = 0
	while( xOrigin < xFin):
		matrixCaseGraphique.append([])
		matrixCaseGraphique[x]=[]
		while(zOrigin <= zFin):
			#CREATION DE LA CASE GRAPHIQUE
			matrixCaseGraphique[x].append([])
			matrixCaseGraphique[x][y]=caseGraphiqueClass.new()
			matrixCaseGraphique[x][y].setCaseTopLeft(xOrigin,zOrigin,spacingX,spacingZ, nodeOriginGridParam.get_parent())
			zOrigin=zOrigin +spacingZ
			y = y+1
		zOrigin = nodeOriginGridParam.translation[2]
		xOrigin= xOrigin + spacingX
		x = x +1
		y=0
	return matrixCaseGraphique
	pass


func getClosestCase(xCoor,zCoor):
	for x in range(matrixCaseGraphique.size()):
		for y in range(matrixCaseGraphique[x].size()):
			if(xCoor > matrixCaseGraphique[x][y].caseTopLeftX && xCoor < matrixCaseGraphique[x][y].caseBottomRightX):
				if(zCoor > matrixCaseGraphique[x][y].caseTopLeftZ && zCoor < matrixCaseGraphique[x][y].caseBottomRightZ):
					return matrixCaseGraphique[x][y]
	pass 


func generateGraphicalGridMap(nodeOriginGridParam, nodeEndGridParam):
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
