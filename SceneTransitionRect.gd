extends ColorRect

#Variables
export(String, FILE, "*.tscn") var next_scene_path
onready var animation_player = $Fader

func _ready():
	animation_player.play_backwards("Fade")

func transition_to(next_scene := next_scene_path):
	animation_player.play("Fade")
	yield(animation_player, "animation_finished")
	get_tree().change_scene(next_scene)

