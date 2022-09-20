extends Label

var Flynn = Vector2(300, 220)
var Rapunzel = Vector2(750, 220)
var Maximus = Vector2(350, 520)
var Mystery = Vector2(650, 520)
var save_path = "user://save.dat"
var blinking = false

func _ready():
	$Timer.start()
	self.rect_position = Flynn

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_end") and self.rect_position == Flynn:
		self.rect_position = Rapunzel
		blinking = false
		$Timer.start()
		show()
	elif Input.is_action_just_pressed("ui_end") and self.rect_position == Rapunzel:
		self.rect_position = Maximus
		blinking = false
		$Timer.start()
		show()
	elif Input.is_action_just_pressed("ui_end") and self.rect_position == Maximus:
		self.rect_position = Mystery
		blinking = false
		$Timer.start()
		show()
	elif Input.is_action_just_pressed("ui_end") and self.rect_position == Mystery:
		self.rect_position = Flynn
		blinking = false
		$Timer.start()
		show()
	elif Input.is_action_just_pressed("ui_home") and self.rect_position == Flynn:
		self.rect_position = Mystery
		blinking = false
		$Timer.start()
		show()
	elif Input.is_action_just_pressed("ui_home") and self.rect_position == Mystery:
		self.rect_position = Maximus
		blinking = false
		$Timer.start()
		show()
	elif Input.is_action_just_pressed("ui_home") and self.rect_position == Maximus:
		self.rect_position = Rapunzel
		blinking = false
		$Timer.start()
		show()
	elif Input.is_action_just_pressed("ui_home") and self.rect_position == Rapunzel:
		self.rect_position = Flynn
		blinking = false
		$Timer.start()
		show()
	elif blinking == true:
		hide()
		$Timer.start()
		blinking = false
	if Input.is_action_just_pressed("enter"):
		if self.rect_position == Flynn:
			Globals.character = "Flynn"
			var data = {
			"Character" : Globals.character,
			"HighScore" : Globals.high_score,
			"TotalScore" : Globals.total_score 
			}
			var file = File.new()
			var ERROR = file.open(save_path, File.WRITE)
			if ERROR == OK:
				file.store_var(data)
				file.close()
		elif self.rect_position == Rapunzel:
			Globals.character = "Rapunzel"
			var data = {
			"Character" : Globals.character,
			"HighScore" : Globals.high_score,
			"TotalScore" : Globals.total_score 
			}
			var file = File.new()
			var ERROR = file.open(save_path, File.WRITE)
			if ERROR == OK:
				file.store_var(data)
				file.close()
		elif self.rect_position == Maximus:
			Globals.character = "Maximus"
			var data = {
			"Character" : Globals.character,
			"HighScore" : Globals.high_score,
			"TotalScore" : Globals.total_score 
			}
			var file = File.new()
			var ERROR = file.open(save_path, File.WRITE)
			if ERROR == OK:
				file.store_var(data)
				file.close()
		elif self.rect_position == Mystery:
			Globals.character = "Frog"
			var data = {
			"Character" : Globals.character,
			"HighScore" : Globals.high_score,
			"TotalScore" : Globals.total_score 
			}
			var file = File.new()
			var ERROR = file.open(save_path, File.WRITE)
			if ERROR == OK:
				file.store_var(data)
				file.close()

func _on_Timer_timeout():
	show()
	$Timer2.start()

func _on_Timer2_timeout():
	blinking = true
