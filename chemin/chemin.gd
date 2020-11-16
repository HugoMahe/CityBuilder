extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var debut;
var fin

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setRoute(debutParam, finParam):
	debut=debutParam
	fin=finParam
	print("Position reçue ... Traitement...")
	var angle= abs(atan2(fin.y-debut.y,fin.x-debut.x) *180 / PI)
	print (angle)
	return angle
	pass
	
func construireRoute(noeudSpatial, positionClickDebut, positionClickFin, angle):
	#memoireTest.transform.origin =Vector3(xCoor,1,zCoor)
	if(angle>45 && angle<130):
		print("Ajout des route à la verticale")
		print("POSITION DE DEBUT DU CLICK " , positionClickDebut[1]) 
		print("POSITION DE FIN DU CLICK " , positionClickFin[1]) 
		while(positionClickDebut[1]<positionClickFin[1]):
			print("ajout d'une route")
			var memoireTest = load("res://Models/Route.dae").instance()
			memoireTest.transform.origin =Vector3(positionClickDebut[0],1,positionClickDebut[1])	
			positionClickDebut[1]=positionClickDebut[1]+1
			noeudSpatial.add_child(memoireTest)
	else:
		print("Ajout des route à l'horizontale")
		print("POSITION DE DEBUT DU CLICK " , positionClickDebut[0]) 
		print("POSITION DE FIN DU CLICK " , positionClickFin[0]) 
		while(positionClickDebut[0]<positionClickFin[0]):
			var memoireTest = load("res://Models/Route.dae").instance()
			memoireTest.rotate_y(deg2rad(90.0))
			memoireTest.transform.origin =Vector3(positionClickDebut[0],1,positionClickDebut[1])	
			positionClickDebut[0]=positionClickDebut[0]+1
			noeudSpatial.add_child(memoireTest)
	pass
	
func getDebut():
	return debut

func getfin():
	return fin
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
