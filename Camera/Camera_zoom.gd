extends Camera

var limit_zoom_in = -5
var limit_zoom_out = 10

func zoom(zoom, speed):
	if transform.origin.z + (zoom * speed*75) < limit_zoom_in:
		zoom = 0
	elif transform.origin.z + (zoom * speed*75) > limit_zoom_out:
		zoom = 0
	translate(Vector3(0, 0, zoom) * speed*75)

