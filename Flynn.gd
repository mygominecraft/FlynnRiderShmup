extends KinematicBody2D

#variables
var vel : Vector2 = Vector2(0,0)
var offset : Vector2 = Vector2(200, 0)
var Shooty = preload("res://Shooty.tscn")
var Flynny = preload("res://Flynny.tscn")
var time : bool = false
var previous_y
var previous_x
var lock = false
var pause = false
var special = true
var sound
signal smolder
signal score_changer

func _ready():
	randomize()
	if Globals.character == "Flynn":
		$AnimatedSprite.frame = 0
		$AnimatedSprite.scale.x = 1
		$AnimatedSprite.scale.y = 1
		sound = randi()%3+1
		if sound == 1:
			get_parent().get_node("Sounds/ThisIsTheStrangestThingI'veEverDone").play()
		elif sound == 2:
			get_parent().get_node("Sounds/Assume").play()
		elif sound == 3:
			get_parent().get_node("Sounds/Bad").play()
	elif Globals.character == "Rapunzel":
		$AnimatedSprite.frame = 3
		$AnimatedSprite.scale.x = 0.25
		$AnimatedSprite.scale.y = 0.25
	else:
		pass
	Globals.menu = false

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
		#healing song
		if Globals.song == true:
			get_parent().get_node("Sounds/Flower").play()
			Globals.song = null
		#shoot
		if Input.is_action_just_pressed("Shoot") and time == false:
			var ShootyInstance = Shooty.instance()
			var level_root = get_tree().get_root()
			level_root.add_child(ShootyInstance)
			ShootyInstance.position = self.position + offset
			time = true
			$ShootTimer.start()
		if Input.is_action_just_pressed("Special"):
			if special == true:
				if Globals.character == "Flynn":
					#special attack aka smolder
					var smolder = get_parent().get_node("Sounds/HereComesTheSmolder")
					smolder.play()
					yield(smolder, "finished")
					get_parent().get_node("Sounds/Smolder").play()
					$Flynny.queue_free()
					previous_x = position.x
					previous_y = position.y
					$AnimatedSprite.frame = 1
					$Timer.wait_time = 3
					$Timer.start()
					emit_signal("smolder")
					lock = true
				elif Globals.character == "Rapunzel":
					$Flynny.queue_free()
					$AnimatedSprite.frame = 5
					$AnimatedSprite.scale.x = 0.15
					$AnimatedSprite.scale.y = 0.15
					$Timer.wait_time = 10
					$Timer.start()
				special = false
				$SpecialTimer.start()
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
	if Globals.health == 2:
		Globals.health += 1
		if Globals.character == "Flynn":
			$AnimatedSprite.frame = 2
		elif Globals.character == "Rapunzel":
			$AnimatedSprite.frame = 4
		else:
			pass
		Globals.death = true
		pause = true
		Globals.lock = true
		emit_signal("score_changer")
	elif Globals.health < 4:
		Globals.health += 1

func _on_Timer_timeout():
	lock = false
	if Globals.character == "Flynn":
		$AnimatedSprite.frame = 0
		var flynny_instance = Flynny.instance()
		add_child(flynny_instance)
		position.x = previous_x
		position.y = previous_y
	elif Globals.character == "Rapunzel":
		var flynny_instance = Flynny.instance()
		add_child(flynny_instance)
		$AnimatedSprite.scale.x = 0.25
		$AnimatedSprite.scale.y = 0.25
		$AnimatedSprite.frame = 3

func _on_SpecialTimer_timeout():
	special = true

func _on_GuardBoss_die():
	if Globals.health == 2:
		Globals.health += 1
		if Globals.character == "Flynn":
			$AnimatedSprite.frame = 2
		elif Globals.character == "Rapunzel":
			$AnimatedSprite.frame = 4
		else:
			pass
		Globals.death = true
		pause = true
		Globals.lock = true
		emit_signal("score_changer")
	elif Globals.health < 4:
		Globals.health += 1
