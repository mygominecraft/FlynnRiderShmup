extends Label

var timer_in_use = false

func _ready():
	get_parent().get_node("SwitchTimer").start()

func _process(delta):
	if text == "Proceeding To Next Level..." and timer_in_use == false:
		timer_in_use = true
		$Timer.start()
	elif text == "Proceeding To Next Level.." and timer_in_use == false:
		timer_in_use = true
		$Timer.start()
	elif text == "Proceeding To Next Level." and timer_in_use == false:
		timer_in_use = true
		$Timer.start()

func _on_Timer_timeout():
	if text == "Proceeding To Next Level.":
		text = "Proceeding To Next Level.."
	elif text == "Proceeding To Next Level..":
		text = "Proceeding To Next Level..."
	elif text == "Proceeding To Next Level...":
		text = "Proceeding To Next Level."
	timer_in_use = false

func _on_SwitchTimer_timeout():
	get_tree().change_scene(Globals.next_scene)
