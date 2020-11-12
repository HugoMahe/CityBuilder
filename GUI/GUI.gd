extends CanvasLayer

var menuBatimentVisible = false
var menuBatimentConstuction = false
	
func cancel_UI():
	print("cancel")
	if menuBatimentVisible:
		cacher_menuBatiment()
	
func cacher_menuBatiment():
	$menuBatiment.hide()
	menuBatimentVisible = false
	
func montrer_menuBatiment(batiment):
	""" Necessite un batiment sous le format :
		 {
			'nom': nom, 
		'typeRessource':typeRessource, 
		'prod':valeurProd
		}
	"""
	$menuBatiment.update_info(batiment)
	$menuBatiment.show()
	menuBatimentVisible = true

func montrer_batimentSurvole(nom):
	$Survol/Survol.text = nom
	$Survol.show()
	
func cacher_batimentSurvole():
	$Survol.hide()
	$Survol/Survol.text = ""
	
func montrer_menuConstruction():
	$menuConstruction.show()
	menuBatimentConstuction = true
	
func updateRessource(stockage):
	$ressource.updateRessource(stockage)
