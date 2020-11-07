extends Control

func update_info(batiment):
	$VBoxContainer/Nom.text = batiment.nom
	$VBoxContainer/Ressource/Type.text = batiment.typeRessource
	$VBoxContainer/Ressource/Valeur.text = String(batiment.prod)
