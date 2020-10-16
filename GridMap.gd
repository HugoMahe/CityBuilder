extends GridMap

var matrix = []
var Case = load("Case.gd")
var CabaneClass = load("Cabane.gd")
var ready = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func genererGrid(n):
	for x in range(n):
		matrix.append([])
		matrix[x]=[]
		for y in range(n):
			matrix[x].append([])
			matrix[x][y]=Case.new()


func printEnsembleBatiment():
	for x in range(matrix.size()):
		for y in range(matrix.size()):
			print(matrix[x][y].getConstructible())


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
	
func jouer():
	print("Lancement jeu")
	#printEnsembleBatiment()
	testBatiment()
	jouerTour()
	
func jouerTour():
	for x in range(matrix.size()):
		for y in range(matrix.size()):
			matrix[x][y].jouer()


func testBatiment():
	var Cabane = CabaneClass.new()
	matrix[0][0].setBatiment(Cabane)
	print("Cabane construite")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
