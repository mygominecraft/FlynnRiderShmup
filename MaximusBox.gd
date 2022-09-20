extends CollisionPolygon2D

func _ready():
	if Globals.character != "Maximus":
		queue_free()
	else:
		pass
