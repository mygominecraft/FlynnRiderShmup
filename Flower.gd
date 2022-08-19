extends KinematicBody2D

var vel = Vector2(-250, 0)
signal heal

func _physics_process(delta):
	if Globals.hide == true:
		queue_free()
	if Globals.lock == false:
		move_and_slide(vel)
	elif Globals.lock == true:
		pass

func _on_Area2D_area_entered(area):
	if area.name == "Flynny":
		if Globals.health > 0:
			Globals.health -= 1
		Globals.song = true
		queue_free()
