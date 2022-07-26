extends Node2D

#variables
onready var timer = get_node("LoadingTimer")
var change : bool = false
var run : bool = true

#functions
func _physics_process(delta):
	while run == true:
		if change == false:
			change = true
		elif change == true:
			get_tree().change_scene(GlobalVariables.level)
		timer.start()
		run = false

func _on_LoadingTimer_timeout():
	if run == false:
		run = true