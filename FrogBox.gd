extends CollisionPolygon2D

func _ready():
	if Globals.character != "Frog":
		queue_free()
	else:
		pass
