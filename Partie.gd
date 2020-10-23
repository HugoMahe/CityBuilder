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
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
