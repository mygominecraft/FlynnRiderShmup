extends Label

var points = Globals.total_points
export var level = ""
signal change_scene

func _process(delta):
	self.text = "Points: " + str(points)
	Globals.total_points = points
	if Globals.high_score < points:
		Globals.high_score = points
		Globals.points = points
	if level == "Level1" and points == 250:
		emit_signal("change_scene")
	elif level == "Level2" and points == 750:
		emit_signal("change_scene")
	elif level == "Level3" and points == 1500:
		emit_signal("change_scene")
	elif level == "Level4" and points == 2500:
		emit_signal("change_scene")
	elif level == "Level5" and points == 4000:
		emit_signal("change_scene")
	elif level == "PasswordLevel" and Globals.password == true:
		emit_signal("change_scene")
		Globals.password = false
	elif level == "Boss" and Globals.boss_defeated == true:
		emit_signal("change_scene")
	elif level == "LevelEndless":
		pass

func _on_Mother_Gothel_death():
	points += 10

func _on_Guard_death():
	points += 10

func _on_Patchy_death():
	points += 10

func _on_Sideburns_death():
	points += 10

func _on_Flynn_score_changer():
	self.rect_position.x = 800
	self.rect_position.y = 440
