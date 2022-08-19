extends KinematicBody2D

#variables
var vel : Vector2 = Vector2(0,0)
var reload : bool = false
var speed
var smolder
var lock = false
var flower_chance
onready var Pan = get_parent().get_node("Shooty")
onready var Flower = preload("res://Flower.tscn")
signal die 
signal death

func _ready():
	randomize()
	position.y = rand_range(15, 850)
	position.x = 1525
	speed = rand_range(-250, -300)
	vel.x = speed

func _physics_process(delta):
	if position.x <= 0:
		position.x = 1525
		randomize()
		position.y = rand_range(15, 850)
	if speed != -300:
		speed -= 0.1
	else:
		pass
	if smolder == true:
		hide()
	if lock == false:
		move_and_slide(vel)
	elif lock == true:
		pass
	if Globals.menu == true:
		queue_free()
	else:
		pass

func _on_Area2D_area_entered(area):
	if area.name == "Shoots":
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
		position.x = 1525
		randomize()
		position.y = rand_range(15, 850)
		emit_signal("death")
		$Timer2.start()
		hide()
		vel.x = 0
		if name == "Sideburns":
			get_parent().get_node("Sounds/RIDER").play()
		elif name == "Guard":
			get_parent().get_node("Sounds/Satchel").play()
		elif name == "Mother Gothel":
			get_parent().get_node("Sounds/LeavingThisTower").play()
	elif area.name == "Flynny":
		emit_signal("die")
		vel.x = speed
		position.x = 1525
		randomize()
		position.y = rand_range(15, 850)
		$Timer2.start()
		hide()
		vel.x = 0

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

func _on_Timer2_timeout():
	if lock == false:
		show()
		vel.x = speed
	elif lock == true:
		pass

func _on_Flynn_smolder():
	randomize()
	emit_signal("death")
	smolder = true
	hide()
	$Timer.start()
	vel.x = 0

func _on_Flynn_score_changer():
	lock = true
