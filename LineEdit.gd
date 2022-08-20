extends LineEdit

func _ready():
	self.grab_focus()
	get_parent().get_node("Sounds/What'sThePassword").play()

func _physics_process(delta):
	if Input.is_action_just_pressed("enter"):
		if text == "21flynn!+$$%steal":
			Globals.password = true
		else:
			var saying = randi()%2+1
			if saying == 1:
				get_parent().get_node("Sounds/Nope").play()
			elif saying == 2:
				get_parent().get_node("Sounds/NotEvenClose").play()
