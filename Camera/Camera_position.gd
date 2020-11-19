extends Spatial

export(float, 1, 10) var speed = 30
var bloque = false

var x_min_limit = -50
var x_max_limit = 50
var z_min_limit = -40
var z_max_limit = 60

var speedRotate = 2

func _process(delta):
	if !bloque:
		var x_strafe = 0
		var z_strafe = 0
		var zoom = 0
		
		if Input.is_action_pressed("strafe_left"):
			x_strafe -=1
		if Input.is_action_pressed("strafe_right"):
			x_strafe +=1
		if Input.is_action_pressed("strafe_up"):
			z_strafe -=1
		if Input.is_action_pressed("strafe_down"):
			z_strafe +=1
		if Input.is_action_just_released("zoom_in"):
			zoom -= 1
		if Input.is_action_just_released("zoom_out"):
			zoom += 1
		
		deplacer(x_strafe, z_strafe, delta)
		#$cameraZoom.zoom(zoom, delta)

func deplacer(x_strafe, z_strafe, delta) :
	if transform.origin.x + (x_strafe * speed/20) > x_max_limit:
		x_strafe = 0
	elif transform.origin.x + (x_strafe * speed/20) < x_min_limit:
		x_strafe = 0
	if transform.origin.z + (z_strafe * speed/20) > z_max_limit:
		z_strafe = 0
	elif transform.origin.z + (z_strafe * speed/20) < z_min_limit:
		z_strafe = 0
		
	translate(Vector3(x_strafe , 0, z_strafe) * speed * delta)


func set_bloque(boolean):
	bloque = boolean
