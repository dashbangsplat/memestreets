extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var META = {}

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.meta('floor_boundary', 125) # the max height any entity can travel upwards on the displayed floor of a level

func meta(key, val = null):
	if (val != null):
		META[key] = val
	return META[key]
