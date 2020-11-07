extends Node
class_name Batiment
var production

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var nodeBatiment
var position3DX
var position3Dy
var position3Dz

# Called when the node enters the scene tree for the first time.
func produit():
	pass	

func getBatiment():
	pass
	
func set3Dcoordinates(x,y,z):
	position3DX=x
	position3Dy=y
	position3Dz=z

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
