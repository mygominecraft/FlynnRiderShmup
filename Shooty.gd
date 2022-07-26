extends KinematicBody2D

#variables
var vel : Vector2 = Vector2(0,0)

func _ready():
	vel.x = 500

func _physics_process(delta):
	move_and_slide(vel)
	rotation_degrees += 5

func _on_Area2D_area_exited(area):
	queue_free()
