extends Node

var nourriture
var bois
var charbon

func _ready():
	nourriture = $HBoxContainer/Nourriture
	bois = $HBoxContainer/Bois
	charbon = $HBoxContainer/Charbon

func updateRessource(stockage):
	nourriture.text = "Nourriture : " + str(stockage.getNourriture())
	bois.text = "Bois : " + str(stockage.getBois())
	charbon.text = "Charbon : " + str(stockage.getCharbon())
