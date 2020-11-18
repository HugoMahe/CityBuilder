extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sortie = false
var fonction = null

var caseObjectif
var caseCourante

var positionCouranteX
var positionCouranteZ

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Je viens de spawn")
	pass # Replace with function body.


func lancerDeplacement(caseParam):
	print("Debut deplacement")
	caseObjectif=caseParam
	deplacement()
pass

func init(caseCouranteParam):
	caseCourante=caseCouranteParam
	caseObjectif=caseCouranteParam.caseVoisinGauche
	positionCouranteX=caseCourante.centerX
	positionCouranteZ=caseCourante.centerZ
	print("[INDIVIDU] - j'ai ma case courante")
	pass

func deplacement():
	pass

func _process(delta):
	refreshCaseCourante()
	if(caseCourante!=caseObjectif):
		if(caseCourante.centerX!=caseObjectif.centerX):
			if(caseCourante.centerX<caseObjectif.centerX):
				self.transform.origin += Vector3(0.1,0,0)
			else:
				self.transform.origin += Vector3(-0.1,0,0)
		if(caseCourante.centerZ!=caseObjectif.centerZ):
			if(caseCourante.centerZ<caseObjectif.centerZ):
				self.transform.origin += Vector3(0,0,0.1)
			else:
				self.transform.origin += Vector3(0,0,-0.1)
		positionCouranteZ = self.transform.origin.z
		positionCouranteX = self.transform.origin.x

	pass


func refreshCaseCourante():
	var caseTemp = caseCourante.getMap().getClosestCaseMap(positionCouranteX,positionCouranteZ)
	if(caseTemp==caseObjectif):
		caseCourante=caseObjectif
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
