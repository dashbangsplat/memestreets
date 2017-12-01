extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var DELAY = 5
var TIMER = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_process(true)

func _process(delta):
	TIMER += delta
	if(TIMER >= DELAY):
		self.get_tree().change_scene("res://menu/menu.tscn")
