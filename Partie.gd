extends Spatial
var mapClass = load("res://MapScript/Map.gd")
var map = mapClass.new()
var GridMapClass = load("res://MapScript/GridMap.gd")
var reserveClass = load("res://Ressources/Reserve.gd")
var stockage = reserveClass.new() 
var ressourceDuTour
var booleanConstruction =false
var typeBatimentConstruction ="Vide"



func _ready():
	map.genererGrid(5)
	ressourceDuTour= map.jouer(self)
	
	#Connection des boutons d'interface
	var boutonConstruction = get_tree().get_nodes_in_group("boutonConstruction")
	for bouton in boutonConstruction:
		bouton.connect("click",self,"menuConstruction")
	pass


func menuConstruction():
	print("Ouverture du menu construction")
	for child in self.get_children():
		if(child.get_name()=="GUI"):
			child.montrer_menuConstruction()
	pass

func remplirStockage():
	stockage.ajouterBois(ressourceDuTour[0])
	stockage.ajouterCharbon(ressourceDuTour[1])
	stockage.ajouterNourriture(ressourceDuTour[2])
	pass
	

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		$GUI.updateRessource(stockage)
		var from = get_viewport().get_camera().project_ray_origin(event.position)
		var nor =  get_viewport().get_camera().project_ray_normal(event.position)
		var positionX = from.x - nor.x * (from.y/nor.y)
		var positionZ = from.z - nor.z * (from.y/nor.y)
		if booleanConstruction==true:
			creerBatiment(positionX,positionZ, typeBatimentConstruction)
pass

func setBooleanConstruction():
	booleanConstruction = true
	pass
	
func setTypeBatimentConstruction(parametre):
	typeBatimentConstruction = parametre
	pass


func creerBatiment(xCoor,zCoor, typeBatiment):
	var memoireTest
	if typeBatiment == "Cabane":
		memoireTest = load("res://Models/Cabane.dae").instance()
		map.ajoutBatimentMemoire("cabane")
		memoireTest.transform.origin =Vector3(xCoor,0,zCoor)
	elif typeBatiment=="Route":
		memoireTest = load("res://Models/Route.dae").instance()
		memoireTest.transform.origin =Vector3(xCoor,1,zCoor)
		var memoireDeuxTest = load("res://Models/Route.dae").instance()
		memoireDeuxTest.transform.origin =Vector3(xCoor,1,zCoor+1)
		self.add_child(memoireDeuxTest)
	self.add_child(memoireTest)
	
pass


func peutAcheterBatiment(batiment):
	var coutBois=0
	var coutCharbon=0
	var coutMetal=0
	var coutNouriture=0
	if(batiment=="Cabane"):
		if(stockage.peutPrelever("Bois",150)):
			if(stockage.peutPrelever("Nourriture",100)):
				return true
	elif(batiment=="Scierie"):
		if(stockage.peutPrelever("Bois",300)):
			if(stockage.peutPrelever("Nourriture",50)):
				return true
		return false
		coutNouriture=200
