extends KinematicBody2D

#variables
var vel : Vector2 = Vector2(0,0)
var offset : Vector2 = Vector2(200, 0)
var Shooty = preload("res://Shooty.tscn")
var time : bool = false
var previous_y
var previous_x
var lock = false
var pause = false
signal smolder
signal score_changer

func _ready():
	pass

func _physics_process(delta):
	if pause == false:
		#movement
		if Input.is_action_pressed("down"):
			vel.y += 50
		elif Input.is_action_pressed("up"):
			vel.y -= 50
		else:
			vel.y = lerp(vel.y, 0, 0.2)
		if vel.y >= 300:
			vel.y = 300
		elif vel.y <= -300:
			vel.y = -300
		move_and_slide(vel)
		#playing box
		if position.y >= 800:
			position.y = 800
		elif position.y <= 55:
			position.y = 55
		#quit
		if Input.is_action_just_pressed("quit"):
			Globals.visibility = true
			get_tree().paused = true
		#shoot
		if Input.is_action_just_pressed("Shoot") and time == false:
			var ShootyInstance = Shooty.instance()
			var level_root = get_tree().get_root()
			level_root.add_child(ShootyInstance)
			ShootyInstance.position = self.position + offset
			time = true
			$ShootTimer.start()
		if Input.is_action_just_pressed("Special"):
			#special attack aka smolder
			previous_x = position.x
			previous_y = position.y
			$AnimatedSprite.frame = 1
			$Timer.start()
			emit_signal("smolder")
			lock = true
	elif pause == true:
		pass
	if lock == true:
		vel.x = 0
		vel.y = 0
		position.y = 400
		position.x = 800

func _on_ShootTimer_timeout():
	time = false

func _on_Enemy_die():
	#death animation
	$AnimatedSprite.frame = 2
	Globals.death = true
	pause = true
	emit_signal("score_changer")

func _on_Timer_timeout():
	lock = false
	$AnimatedSprite.frame = 0
	position.x = previous_x
	position.y = previous_y
