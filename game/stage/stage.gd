extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const FLOOR_BOUNDARY = 125

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func get_floor_boundary():
	return FLOOR_BOUNDARY
