extends Spatial

export(float, 1, 10) var speed = 30
var speedRotate = 2

var limit = 21

func _process(delta):
	var x_strafe = 0
	var z_strafe = 0
	var y_rotation = 0
	
	if Input.is_action_pressed("strafe_left"):
		x_strafe -=1
	if Input.is_action_pressed("strafe_right"):
		x_strafe +=1
	if Input.is_action_pressed("strafe_up"):
		z_strafe -=1
	if Input.is_action_pressed("strafe_down"):
		z_strafe +=1
	if Input.is_action_pressed("rotate_left"):
		y_rotation +=1
		rotation(1)
	if Input.is_action_pressed("rotate_right"):
		y_rotation -=1
		rotation(-1)
		

#	if transform.origin.x + (x_strafe * speed/20) > limit or transform.origin.x + (x_strafe * speed/20) < -limit:
#		x_strafe = 0
#	if transform.origin.z + (z_strafe * speed/20)> limit or transform.origin.z + (z_strafe * speed/20) < -limit:
#		z_strafe = 0
	
	translate(Vector3(x_strafe , 0, z_strafe) * speed * get_process_delta_time())

func rotation(y_rotation):
		rotate(Vector3(0, y_rotation, 0), speedRotate * get_process_delta_time())
pass
