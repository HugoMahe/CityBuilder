extends CanvasLayer

var menuBatimentVisible = false
var menuBatimentConstuction = false
var menuPrincipal = false
	
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
	
func cacher_menuConstruction():
	$menuConstruction.hide()
	menuBatimentConstuction = false
	
func updateRessource(stockage):
	$ressource.updateRessource(stockage)
	
func montrer_menuPrincipal():
	$Batiments.hide()
	$ressource.hide()
	$menuPrincipal.show()
	get_node("/root/Map").set_inMenuPrincipal(true)
	menuPrincipal = true
	
func cacher_menuPrincipal():
	$Batiments.show()
	$ressource.show()
	$menuPrincipal.hide()
	get_node("/root/Map").set_inMenuPrincipal(false)
	menuPrincipal = false

func cancel_menu():
	if menuBatimentVisible:
		cacher_menuBatiment()
	elif menuBatimentConstuction:
		cacher_menuConstruction()
	elif !menuPrincipal:
		montrer_menuPrincipal()
	elif menuPrincipal:
		cacher_menuPrincipal()

func _on_quitter_jeu_pressed():
	get_node("/root/Map").quitter_jeu();
