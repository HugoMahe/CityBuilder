extends Spatial

export var nom = ""
export var typeRessource = ""
export var valeurProd = 0
signal survole(nom)
signal quitte()
signal click(batiment)

func _on_Construction_mouse_entered():
	emit_signal("survole", nom)


func _on_Construction_mouse_exited():
	emit_signal("quitte")


func _on_Construction_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("click", {"nom": nom, "typeRessource":typeRessource, "prod":valeurProd})

