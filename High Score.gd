extends Label

func _ready():
	Globals.menu = true

func _process(delta):
	text = "High Score: " + str(Globals.high_score)
