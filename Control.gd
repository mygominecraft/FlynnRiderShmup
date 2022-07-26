extends Control

#variables
onready var animation_player = $FadeAnimationPlayer
var focus : bool = true

#UI Menu Functions
func _ready():
	$Buttons/ResumeButton.grab_focus()

func _on_ResumeButton_pressed():
	get_tree().paused = false
	Globals.visibility = false

func _on_QuitButton_pressed():
	Globals.visibility = false
	$FadeAnimationPlayer/Fade.visible = true
	animation_player.play("Fade")
	yield(animation_player, "animation_finished")
	get_tree().quit()

func _physics_process(delta):
	if Globals.visibility == true:
		visible = true
		if focus != false:
			$Buttons/ResumeButton.grab_focus()
			focus = false
	elif Globals.visibility == false:
		visible = false
		focus = true

func _on_Restart_Timer_timeout():
	Globals.visibility = false
	$FadeAnimationPlayer/Fade.visible = true
	animation_player.play("Fade")
	yield(animation_player, "animation_finished")
	get_tree().quit()
