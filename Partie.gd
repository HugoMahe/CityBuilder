extends Spatial
var mapClass = load("res://MapScript/Map.gd")
var map = mapClass.new()
var GridMapClass = load("res://MapScript/GridMap.gd")
var reserveClass = load("res://Ressources/Reserve.gd")
var routeClass = load("res://chemin/chemin.gd")
var mapGraphique = load("res://MapScript/MapGraphique.gd")
var generateurFauneClass = load("res://MapScript/generateurFaune.gd").new()
var mapGraphiqueClass = mapGraphique.new()
var route = routeClass.new()
var stockage = reserveClass.new() 
var ressourceDuTour
var booleanConstruction =false
var booleanRoute = false
var typeBatimentConstruction ="Vide"
var mapCaseGraphique
var booleanPositionDebut = false
var inMenuPrincipal = false
var pointeur
var batimentConstructible

func _ready():
	#GENERATION DE LA MAP
	map.genererGrid(5)
	#ressourceDuTour= map.jouer()

	#DEFINITION DE LA GRILLE GRAPHIQUE
	mapCaseGraphique= mapGraphiqueClass.generateGraphicalGridMap(get_node("OriginGrid"), get_node("FinGrid"), self)
	generateurFauneClass.lancementGeneration("res://Models/Flore/",mapCaseGraphique,self)
	#DEFINITION DE LA LOGIQUE DES CASES GRAPHIQUES
	mapGraphiqueClass.trouverVoisin()
	#DEFINITION DU POINTEUR DE CASE
	generatePointeur()

	#Connection des boutons d'interface
	for bouton in get_tree().get_nodes_in_group("boutonConstruction"):
		bouton.connect("click",self,"menuConstruction")
	$GUI.updateRessource(stockage)
	pass

#GENERATION DU POINTEUR 
func generatePointeur():
	pointeur = load("res://Models/Pointeur.dae").instance()
	pointeur.transform.origin = Vector3(0,2,0)
	self.add_child(pointeur)


#OUVERTURE DU MENU CONSTRUCTION 
func menuConstruction():
	print("Ouverture du menu construction")
	for child in self.get_children():
		if(child.get_name()=="GUI"):
			child.montrer_menuConstruction()
	pass


#REMPLI LE STOCKAGE DE LA PARTIE
func remplirStockage():
	stockage.ajouterBois(ressourceDuTour[0])
	stockage.ajouterCharbon(ressourceDuTour[1])
	stockage.ajouterNourriture(ressourceDuTour[2])
	$GUI.updateRessource(stockage)
	pass


#DETECTION DES INPUTS
func _input(event):
	var tabPosition
	if !inMenuPrincipal:
		#cas de la souris qui bouge
		if event is InputEventMouseMotion:
			tabPosition = calculPositionEnv3D(get_viewport().get_camera().project_ray_origin(event.position),  get_viewport().get_camera().project_ray_normal(event.position))
			var caseSelection = mapGraphiqueClass.getClosestCaseMap(tabPosition[0],tabPosition[1])
			if(caseSelection):
				if (!booleanConstruction):
					pointeur.transform.origin = Vector3(caseSelection.centerX,2,caseSelection.centerZ)
				else:
					batimentConstructible.transform.origin = Vector3(caseSelection.centerX,2,caseSelection.centerZ)
		#cas de la souris est cliquée sur le bouton gauche
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
			tabPosition = calculPositionEnv3D(get_viewport().get_camera().project_ray_origin(event.position),  get_viewport().get_camera().project_ray_normal(event.position))
			var caseSelection = mapGraphiqueClass.getClosestCaseMap(tabPosition[0],tabPosition[1])
			if booleanConstruction==true and booleanRoute==false:
				if(caseSelection):
					creerBatiment(caseSelection.centerX,caseSelection.centerZ, typeBatimentConstruction, 0, caseSelection)
					booleanConstruction=false
					return
			#SI PAS DE DEBUT DE ROUTE ENCORE DEFINI
			if booleanRoute==true and booleanPositionDebut==false:
				route.setCaseDebutRoute(caseSelection)
				booleanPositionDebut=true
				return
			#SI IL RESTE LA FIN A DEFINIR
			if booleanRoute==true and booleanPositionDebut==true:
				route.setCaseFinRoute(caseSelection)
				booleanRoute=false
				booleanPositionDebut=false
	#SI ON DECIDE DE QUITTER
	if event.is_action_pressed("ui_cancel"):
		if booleanConstruction:
			booleanConstruction = false
			self.remove_child(batimentConstructible)
			pointeur.show()
		else:
			$GUI.cancel_menu()


#DETERMINE LA POSITION DU CLIC DANS L'ENV 3D
func calculPositionEnv3D(from, nor):
	var tabPositionXZ = []
	var positionX = from.x - nor.x * (from.y/nor.y)
	var positionZ = from.z - nor.z * (from.y/nor.y)
	tabPositionXZ.push_back(positionX)
	tabPositionXZ.push_back(positionZ)
	return tabPositionXZ
	pass

func setBooleanConstruction(etat):
	booleanConstruction = etat
	pass
	
#Set batiment construction 
func setTypeBatimentConstruction(parametre):
	var booleanBatiment=false
	typeBatimentConstruction = parametre
	if typeBatimentConstruction == "Cabane":
		batimentConstructible = load("res://Models/Cabane.dae").instance()
		booleanBatiment=true
	if typeBatimentConstruction == "Auberge":
		batimentConstructible = load("res://Models/Auberge.dae").instance()
		booleanBatiment=true
	if typeBatimentConstruction == "Ferme":
		batimentConstructible = load("res://Models/Champ.dae").instance()
		booleanBatiment=true
	if(booleanBatiment==true):
		self.add_child(batimentConstructible)
		pointeur.hide()
	pass
	
func setBooleanRoute(etat):
	booleanRoute = etat
	pass

func creerBatiment(xCoor,zCoor, typeBatiment, _angle, caseGraphique):
	if caseGraphique.isConstructible():
		print("BATIMENT",typeBatiment)
		if typeBatiment == "Cabane":
			EcrireChargerBatiment("res://Models/Cabane.dae",typeBatiment,xCoor,zCoor,caseGraphique,"null")
			caseGraphique.setConstructible(false)
			self.remove_child(batimentConstructible)
			pointeur.show()
		if typeBatiment == "Auberge":
			var mesh = EcrireChargerBatiment("res://Models/Auberge.dae",typeBatiment,xCoor,zCoor,caseGraphique,"res://MapScript/Batiment/Auberge.gd")
			#var scriptAuberge = load("res://MapScript/Batiment/Auberge.gd")
			mesh.init(self,xCoor,zCoor,caseGraphique)
			caseGraphique.setConstructible(false)
			self.remove_child(batimentConstructible)
			pointeur.show()
		if typeBatiment == "Ferme":
			EcrireChargerBatiment("res://Models/Champ.dae",typeBatiment,xCoor,zCoor,caseGraphique,"null")
			caseGraphique.setConstructible(false)
			self.remove_child(batimentConstructible)
			pointeur.show()

		
func EcrireChargerBatiment(cheminMesh,typeBatiment,xCoor,zCoor,caseGraphique,script):
	var scriptMesh
	if(script!="null"):
		scriptMesh = load(str(script))
	var mesh = load(cheminMesh).instance()
	if(script!="null"):
		mesh.set_script(scriptMesh)
	map.ajoutBatimentMemoire(typeBatiment, xCoor,zCoor,caseGraphique)
	mesh.transform.origin = Vector3(xCoor,1,zCoor)
	self.add_child(mesh)
	return mesh
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

func quitter_jeu():
	get_tree().quit()

func set_inMenuPrincipal(boolean):
	inMenuPrincipal = boolean
	$cameraPosition.set_bloque(boolean)
