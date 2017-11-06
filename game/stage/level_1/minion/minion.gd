extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var STAGE
var FIND_PLAYER
var RAY_CAST_MOVING_UP = true
var RAY_CAST_MIN_HEIGHT = -100;
var RAY_CAST_MAX_HEIGHT = 100;

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	STAGE = self.get_node("/root/Stage")
	FIND_PLAYER = self.get_node("FindPlayer")
	self.set_process(true)

func _process(delta):
	if(FIND_PLAYER.is_colliding()):
		self.move(- FIND_PLAYER.get_collision_point().normalized())
	
	# Move ray cast up and down to cover a field of vision
	var ray_cast = FIND_PLAYER.get_cast_to()
	
	if(RAY_CAST_MOVING_UP):
		if(ray_cast.y > RAY_CAST_MIN_HEIGHT):
			ray_cast.y -= 1
		else:
			RAY_CAST_MOVING_UP = false
			ray_cast.y += 1
	else:
		if(ray_cast.y < RAY_CAST_MAX_HEIGHT):
			ray_cast.y += 1
		else:
			RAY_CAST_MOVING_UP = true
			ray_cast.y -= 1
	
	FIND_PLAYER.set_cast_to(ray_cast)
