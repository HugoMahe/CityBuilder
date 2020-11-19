extends Control

func update_info(batiment):
	$VBoxContainer/Nom.text = batiment.nom
	$VBoxContainer/Ressource/Type.text = batiment.typeRessource
	$VBoxContainer/Ressource/Valeur.text = str(batiment.prod)
	if batiment.couts.bois > 0:
		$VBoxContainer/coutBois.text = "Coûte " + str(batiment.couts.bois) + " bois"
	if batiment.couts.charbon > 0:
		$VBoxContainer/coutCharbon.text = "          " + str(batiment.couts.charbon) + " charbon"
	if batiment.couts.nourriture > 0:
		$VBoxContainer/coutNourriture.text = "          " + str(batiment.couts.nourriture) + " nourriture"
	$VBoxContainer/description.text = batiment.desc
