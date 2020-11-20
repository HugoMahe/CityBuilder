extends TextureButton

var Auberge = load("res://MapScript/Batiment/Auberge.gd")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	print("Construction de l'auberge possible")
	get_node("/root/Map").setBooleanConstruction(true)
	get_node("/root/Map").setTypeBatimentConstruction("Auberge")
	pass

func _on_Auberge_mouse_entered():
	var aub = Auberge.new()
	var batiment = {"nom": "Auberge", 
		"typeRessource": "Population", 
		"prod": 10,
		"couts": aub.getCouts(),
		"desc": aub.desc}
	get_node("/root/Map/GUI").montrer_menuBatiment(batiment)


func _on_Auberge_mouse_exited():
	get_node("/root/Map/GUI").cacher_menuBatiment()
