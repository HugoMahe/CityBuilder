extends Spatial
var mapClass = load("res://MapScript/Map.gd")
var map = mapClass.new()
var GridMapClass = load("res://MapScript/GridMap.gd")
var gridMap = GridMapClass.new()
var reserveClass = load("res://Reserve.gd")
var stockage = reserveClass.new() 
var ressourceDuTour 

# Called when the node enters the scene tree for the first time.
func _ready():
	map.genererGrid(5)
	ressourceDuTour= map.jouer(self, gridMap)
	remplirStockage()
	stockage.printReserve()
	pass # Replace with function body.


func remplirStockage():
	stockage.ajouterBois(ressourceDuTour[0])
	stockage.ajouterCharbon(ressourceDuTour[1])
	stockage.ajouterNourriture(ressourceDuTour[2])
	pass
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
	#AJOUTER LA CONDITION UI POUR RECUPERER LE BATIMENT
		var typeBatiment = "Cabane"
		var from = get_viewport().get_camera().project_ray_origin(event.position)
		var nor =  get_viewport().get_camera().project_ray_normal(event.position)
		var positionX = from.x - nor.x * (from.y/nor.y)
		var positionZ = from.z - nor.z * (from.y/nor.y)
		creerBatiment(positionX,positionZ, typeBatiment)
pass

func creerBatiment(xCoor,zCoor, typeBatiment):
	var memoireTest = load("res://Models/Arbre.dae").instance()
	memoireTest.transform.origin =Vector3(xCoor,0,zCoor)
	self.add_child(memoireTest)
	map.ajoutBatimentMemoire("cabane")
pass


	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
