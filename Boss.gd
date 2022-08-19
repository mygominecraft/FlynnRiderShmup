extends KinematicBody2D

#variables
var vel : Vector2 = Vector2(0,0)
var reload : bool = false
var speed
var smolder
var lock = false
var flower_chance
var health = 10
onready var guard = get_parent().get_child(5)
onready var Pan = get_parent().get_node("Shooty")
onready var Flower = preload("res://Flower.tscn")
onready var Guard = preload("res://GuardBoss.tscn")
var notice = true
var person
signal die 
signal death
signal come

func _ready():
	randomize()
	var dir = rand_range(500, -500)
	vel.y += dir
	$VelocityTimer.wait_time = rand_range(0.5, 2)
	$VelocityTimer.start()
	$GuardTimer.wait_time = 0.1
	$GuardTimer.start()

func _physics_process(delta):
	move_and_slide(vel)
	#playing box
	if position.y >= 750:
		position.y = 750
	elif position.y <= 45:
		position.y = 45

func _on_Area2D_area_entered(area):
	if area.name == "Shoots":
		emit_signal("death")
		health -= 1
		$AnimationPlayer.play("New Anim")
		if health <= 0:
			Globals.boss_defeated = true

func _on_Timer_timeout():
	smolder = false
	randomize()
	flower_chance = rand_range(0, 100)
	var flower = Flower.instance()
	var root = get_tree().get_root()
	if flower_chance >= 95:
		flower.position = self.position
		root.call_deferred("add_child", flower)
	else:
		pass
	flower_chance = null
	vel.x = speed
	show()
	position.x = 1525
	randomize()
	position.y = rand_range(15, 850)

func _on_Flynn_score_changer():
	lock = true

func _on_VelocityTimer_timeout():
	randomize()
	var dir = rand_range(500, -500)
	vel.y = dir
	$VelocityTimer.wait_time = rand_range(0.5, 2)
	$VelocityTimer.start()

func _on_GuardTimer_timeout():
	randomize()
	if health < 5:
		Globals.amount = rand_range(3, 5)
	else:
		Globals.amount = 5
	if Globals.amount <= 3:
		Globals.amount = 3
	if Globals.amount >= 3 and Globals.amount < 4:
		Globals.amount = 3
	if Globals.amount <= 4 and Globals.amount > 3:
		Globals.amount = 4
	if Globals.amount <= 5 and Globals.amount > 4:
		Globals.amount = 5
	if Globals.amount > 5:
		Globals.amount = 5
	emit_signal("come")
	randomize()
	$GuardTimer.wait_time = rand_range(3, 8)
	$GuardTimer.start()
