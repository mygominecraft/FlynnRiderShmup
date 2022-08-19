extends Node2D

signal stop

func _ready():
	emit_signal("stop")
