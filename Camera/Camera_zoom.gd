extends Camera

var limit_zoom_in = 3
var limit_zoom_out = 15
var bloque = false

func _input(event):
	if !bloque:
		if event is InputEventMouseButton:
			if event.is_pressed():
				var z_strafe = 0
				if event.button_index == BUTTON_WHEEL_UP:
					z_strafe = -1
				if event.button_index == BUTTON_WHEEL_DOWN:
					z_strafe = 1
					
				translate(Vector3(0, 0, z_strafe) * get_parent().speed/10)
			

func set_bloque(boolean):
	bloque = boolean
