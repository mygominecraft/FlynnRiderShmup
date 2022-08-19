extends Sprite

var lantern = false
var lantern2 = false
var lantern3 = false

func _physics_process(delta):
	if Globals.health == 2 and name == "Lantern3":
		hide()
		lantern3 = true
	elif Globals.health == 1 and name == "Lantern2":
		hide()
		lantern2 = true
	elif Globals.health == 0 and name == "Lantern":
		hide()
		lantern = true
	else:
		pass
	
