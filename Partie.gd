extends Spatial
var mapClass = load("res://MapScript/Map.gd")
var map = mapClass.new()
var GridMapClass = load("res://MapScript/GridMap.gd")
var reserveClass = load("res://Ressources/Reserve.gd")
var routeClass = load("res://chemin/chemin.gd")
var mapGraphique = load("res://MapScript/MapGraphique.gd")
var mapGraphiqueClass = mapGraphique.new()
var route = routeClass.new()
var stockage = reserveClass.new() 
var ressourceDuTour
var booleanConstruction =false
var booleanRoute = false
var typeBatimentConstruction ="Vide"
var positionDebutRoute
var positionDebutRoute3D
var mapCaseGraphique
var booleanPositionDebut = false



func _ready():
	map.genererGrid(5)
	ressourceDuTour= map.jouer(self)
	var nodeOriginGrid = get_node("OriginGrid")
	var nodeEndGrid = get_node("FinGrid")
	mapCaseGraphique= mapGraphiqueClass.generateGraphicalGridMap(nodeOriginGrid,nodeEndGrid,self)
	mapGraphiqueClass.trouverVoisin()
	#Connection des boutons d'interface
	var boutonConstruction = get_tree().get_nodes_in_group("boutonConstruction")
	for bouton in boutonConstruction:
		bouton.connect("click",self,"menuConstruction")
		
	$GUI.updateRessource(stockage)
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
	$GUI.updateRessource(stockage)
	pass
	

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var from = get_viewport().get_camera().project_ray_origin(event.position)
		var nor =  get_viewport().get_camera().project_ray_normal(event.position)
		var positionX = from.x - nor.x * (from.y/nor.y)
		var positionZ = from.z - nor.z * (from.y/nor.y)
		var caseSelection = mapGraphiqueClass.getClosestCaseMap(positionX,positionZ)
		if booleanConstruction==true:
			creerBatiment(caseSelection.centerX,caseSelection.centerZ, typeBatimentConstruction, 0)
			return
		if booleanRoute==true and booleanPositionDebut==false:
			route.setPlacementBoolean(true)
			route.setCaseDebutRoute(caseSelection)
			booleanPositionDebut=true
			return
		if booleanRoute==true and booleanPositionDebut==true:
			route.setCaseFinRoute(caseSelection)
			booleanRoute=false
			booleanPositionDebut=false
			if positionDebutRoute:
				print("Set du fin")
				print("POSITION DEBUT ROUTE",positionDebutRoute)
				route.setPlacementBoolean(true)
				route.setCaseDebut()
				creerBatiment(caseSelection.centerX,caseSelection.centerZ, typeBatimentConstruction, 0)
				positionDebutRoute=0
				booleanRoute=false
				return
		if booleanRoute==true:
			print("Set du debut")
			positionDebutRoute=event.position
			positionDebutRoute3D=[positionX,positionZ]
			
	
	if event.is_action_pressed("ui_cancel"):
		booleanConstruction = false

func setBooleanConstruction():
	booleanConstruction = true
	pass
	
func setTypeBatimentConstruction(parametre):
	typeBatimentConstruction = parametre
	pass
	
func setBooleanRoute():
	booleanRoute = true
	pass


func creerBatiment(xCoor,zCoor, typeBatiment, angle):
	var memoireTest
	print("BATIMENT",typeBatiment)
	if typeBatiment == "Cabane":
		memoireTest = load("res://Models/Cabane.dae").instance()
		map.ajoutBatimentMemoire("cabane")
		memoireTest.transform.origin =Vector3(xCoor,1,zCoor)
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
