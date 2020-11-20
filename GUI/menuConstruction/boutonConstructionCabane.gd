extends TextureButton

var Cabane = load("res://MapScript/Batiment/Cabane.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	print("Construction de la cabane possible")
	get_node("/root/Map").setBooleanConstruction(true)
	get_node("/root/Map").setTypeBatimentConstruction("Cabane")
	pass # Replace with function body.


func _on_Cabane_mouse_entered():
	var cab = Cabane.new()
	var batiment = {"nom": "Cabane", 
		"typeRessource": "Nourriture", 
		"prod": 20,
		"couts": cab.getCouts(),
		"desc": cab.desc}
	get_node("/root/Map/GUI").montrer_menuBatiment(batiment)


func _on_Cabane_mouse_exited():
	get_node("/root/Map/GUI").cacher_menuBatiment()
