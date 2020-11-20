extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var place = false



#FONCTION QUI RECUPERE LES MODELES ET LES RENVOIES DANS UN TABLEAU
func recupereEnsembleModele(path):
	var tabMesh = []
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				if(".dae" in file_name):
					if(!"import" in file_name):
						print("Found file: " + file_name)
						tabMesh.push_front(str(path + file_name))
			file_name =  dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return tabMesh
pass

func lancementGeneration(path,mapCase,spatial):
	if(!place):
		var tabModele = recupereEnsembleModele(path)
		placeFlore(tabModele,mapCase,spatial)
pass



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


#FONCTION QUI LANCE LE PLACEMENT DES MESH SELECTIONNES SUR LA CARTE
func placeFlore(tabModeleParam,mapCase,spatial):
	var maxModele = 6
	var rng
	print("Placement de la flore")
	var keys = mapCase.keys()
	for i in len(keys):
		rng = randi() % 100
		var posRng = mapCase[keys[i]].getRandomPos()
		print(rng)
		if(rng<10):
			print("generation d'un modele ",tabModeleParam[0])
			var modele = load(str(tabModeleParam[0])).instance()
			modele.transform.origin = Vector3(posRng[0],1,posRng[1])
			modele.rotate_y(deg2rad(rand_range(0.0,180.0)))
			spatial.add_child(modele)
			maxModele = maxModele -1
		if(rng>20 && rng<30):
			print("generation d'un modele ",tabModeleParam[2])
			var modele = load(str(tabModeleParam[1])).instance()
			modele.transform.origin = Vector3(posRng[0],1,posRng[1])
			modele.rotate_y(deg2rad(rand_range(0.0,180.0)))
			spatial.add_child(modele)
			maxModele = maxModele -1
		if(rng>40 && rng<60):
			print("generation d'un modele ",tabModeleParam[1])
			var modele = load(str(tabModeleParam[3])).instance()
			modele.transform.origin = Vector3(posRng[0],1,posRng[1])
			modele.rotate_y(deg2rad(rand_range(0.0,180.0)))
			spatial.add_child(modele)
			maxModele = maxModele -1
	place=true
pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
