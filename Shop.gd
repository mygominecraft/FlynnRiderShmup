extends Node2D

func _physics_process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().change_scene("res://Menu.tscn")
	if Input.is_action_just_pressed("enter"):
		get_tree().change_scene("res://Menu.tscn")
