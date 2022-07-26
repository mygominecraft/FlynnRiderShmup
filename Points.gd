extends Label

var points = 0

func _process(delta):
	self.text = "Points: " + str(points)

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
