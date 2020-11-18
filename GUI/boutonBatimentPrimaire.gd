extends TextureButton

signal click()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_TextureButton_pressed():
	print("Lancement du menu construction")
	emit_signal("click")
	pass # Replace with function body.
