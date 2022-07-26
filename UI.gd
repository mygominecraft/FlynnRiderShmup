extends Control

#UI Menu Functions
func _ready():
	$Buttons/ResumeButton.grab_focus()
func _on_ResumeButton_pressed():
	get_tree().paused = false
	GlobalVariables.visibility = false
	print("Resume")
func _on_QuitButton_pressed():
	GlobalVariables.visibility = false
	get_tree().change_scene("res://Menu.tscn")
	GlobalVariables.scene = "res://Menu.tscn"
	print("quit")
