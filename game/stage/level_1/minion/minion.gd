extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var STAGE
var PLAYER

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	STAGE = self.get_node("/root/Stage")
	PLAYER = self.get_node("/root/Stage/Player")
	self.set_process(true)

func _process(delta):
	if(self.get_global_pos().distance_to(PLAYER.get_global_pos()) <= 100):
		self.move(-(self.get_global_pos() - PLAYER.get_global_pos()).normalized())
	
