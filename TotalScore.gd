extends Label

func _physics_process(delta):
	text = "Points: " + str(Globals.total_score)
