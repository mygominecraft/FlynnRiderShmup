extends CollisionPolygon2D

func _ready():
	if Globals.character != "Rapunzel":
		queue_free()
	else:
		pass
