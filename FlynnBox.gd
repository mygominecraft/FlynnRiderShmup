extends CollisionPolygon2D

func _ready():
	if Globals.character != "Flynn":
		queue_free()
	else:
		pass
