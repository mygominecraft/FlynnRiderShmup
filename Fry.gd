extends KinematicBody2D

var vel = Vector2(500, 0)

func _ready():
	hide()
	$ResetTimer.start()

func _physics_process(delta):
	move_and_slide(vel)
	rotation_degrees += 5

func _on_ResetTimer_timeout():
	show()
	randomize()
	position.y = rand_range(15, 850)
	position.x = -20
	randomize()
	$ResetTimer.wait_time = rand_range(5, 20)
	$ResetTimer.start()
