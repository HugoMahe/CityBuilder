extends TextureButton

var Ferme = load("res://MapScript/Batiment/Ferme.gd")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_TextureButton_pressed():
	print("Construction de la cabane possible")
	get_node("/root/Map").setBooleanConstruction()
	get_node("/root/Map").setTypeBatimentConstruction("Ferme")
	pass # Replace with function body.


func _on_Ferme_mouse_entered():
	var fer = Ferme.new()
	var batiment = {"nom": "Ferme", 
		"typeRessource": "Nourriture", 
		"prod": 50,
		"couts": fer.getCouts(),
		"desc": fer.desc}
	get_node("/root/Map/GUI").montrer_menuBatiment(batiment)


func _on_Ferme_mouse_exited():
	get_node("/root/Map/GUI").cacher_menuBatiment()
