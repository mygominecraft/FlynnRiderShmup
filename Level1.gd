extends Node2D

onready var animation_player = $UI/Control/FadeAnimationPlayer 

func _on_Switcher_player_reached_door(loader):
	$UI/Control/FadeAnimationPlayer/Fade.visible = true
	animation_player.play("Fade")
	yield(animation_player, "animation_finished")
	get_tree().change_scene(loader)
