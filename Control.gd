extends Control

#variables
onready var animation_player = $FadeAnimationPlayer
var focus : bool = true
var once = false
export var next_level = ""
signal free

#UI Menu Functions
func _ready():
	$Buttons/ResumeButton.grab_focus()

func _on_ResumeButton_pressed():
	get_tree().paused = false
	Globals.visibility = false

func _on_QuitButton_pressed():
	Globals.hide = true
	emit_signal("free")
	$FadeAnimationPlayer/Fade.visible = true
	animation_player.play("Fade")
	yield(animation_player, "animation_finished")
	get_tree().paused = false
	get_tree().change_scene("res://Menu.tscn")

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
	Globals.hide = true
	Globals.visibility = false
	$FadeAnimationPlayer/Fade.visible = true
	animation_player.play("Fade")
	yield(animation_player, "animation_finished")
	get_tree().change_scene("res://Menu.tscn")

func _on_Points_change_scene():
	if Globals.character == "Flynn" and get_parent().get_parent().name != "PasswordLevel":
		var soundy = get_parent().get_parent().get_node("Sounds/AllTheThingsWe'veSeen")
		if once == false:
			once = true
			soundy.play()
		yield(soundy,"finished")
	if Globals.character == "Rapunzel" and get_parent().get_parent().name != "PasswordLevel":
		var soundy = get_parent().get_parent().get_node("Sounds/ICan'tBelieveIDidThis")
		if once == false:
			once = true
			soundy.play()
		yield(soundy,"finished")
	Globals.hide = true
	Globals.visibility = false
	$FadeAnimationPlayer/Fade.visible = true
	animation_player.play("Fade")
	yield(animation_player, "animation_finished")
	Globals.next_scene = next_level
	get_tree().change_scene("res://LevelChange.tscn")
