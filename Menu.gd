extends Control

#variables
onready var animation_player = $FadeAnimationPlayer
var focus : bool = true
var save_path = "user://save.dat"

#UI Menu Functions
func _ready():
	var file = File.new()
	if file.file_exists(save_path):
		var ERROR = file.open(save_path, file.READ)
		if ERROR == OK:
			var player_data = file.get_var()
			Globals.high_score = player_data["HighScore"]
			Globals.total_score = player_data["TotalScore"]
			Globals.total_score = Globals.total_score + Globals.total_points
			if Globals.points > Globals.high_score:
				Globals.high_score = Globals.points
			file.close()
	$Buttons/StartButton.grab_focus()
	Globals.health = 0
	Globals.visibility = false

func _on_ResumeButton_pressed():
	var file = File.new()
	if file.file_exists(save_path):
		var ERROR = file.open(save_path, file.READ)
		if ERROR == OK:
			var player_data = file.get_var()
			Globals.character = player_data["Character"]
			file.close()
	Globals.total_points = 0
	$FadeAnimationPlayer/Fade.visible = true
	animation_player.play("Fade")
	yield(animation_player, "animation_finished")
	get_tree().change_scene("res://MainScene.tscn")

func _on_QuitButton_pressed():
	var data = {
		"Character" : Globals.character,
		"HighScore" : Globals.high_score,
		"TotalScore" : Globals.total_score 
	}
	data["HighScore"] = Globals.high_score 
	var file = File.new()
	var ERROR = file.open(save_path, File.WRITE)
	if ERROR == OK:
		file.store_var(data)
		file.close()
	$FadeAnimationPlayer/Fade.visible = true
	animation_player.play("Fade")
	yield(animation_player, "animation_finished")
	get_tree().quit()

func _on_Shop_pressed():
	$FadeAnimationPlayer/Fade.visible = true
	animation_player.play("Fade")
	yield(animation_player, "animation_finished")
	get_tree().change_scene("res://Shop.tscn")
