extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var STAGE
var WIDTH
var HEIGHT
var VERTICAL_BOUNDARY_MIN_OFFSET
var HORIZONTAL_BOUNDARY_MIN_OFFSET

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	STAGE = get_node("/root/Stage")
	
	var texture = get_node("Sprite").get_texture()
	WIDTH = texture.get_width()
	HEIGHT = texture.get_height()
	VERTICAL_BOUNDARY_MIN_OFFSET = (HEIGHT / 2) - 10; # half the size of the texture (since it's centered) minus some value so it doesnt climb up the wall
	HORIZONTAL_BOUNDARY_MIN_OFFSET = (WIDTH / 2); # half the size of the texture (since it's centered)
	
	set_process(true)
	pass
	
func _process(delta):
	var pos = get_pos()
	
	# pos.x - HORIZONTAL_BOUNDARY_MIN_OFFSET becuase we want to check the limiot from the left of the texture
	if(Input.is_action_pressed("move_left") && pos.x - HORIZONTAL_BOUNDARY_MIN_OFFSET > 0):
		pos.x -= 1
	elif(Input.is_action_pressed("move_right")):
		pos.x += 1
		
	# pos.y + VERTICAL_BOUNDARY_MIN_OFFSET becuase we want to check the limit from the bottom of the texture
	if(Input.is_action_pressed("move_up") && pos.y + VERTICAL_BOUNDARY_MIN_OFFSET > STAGE.FLOOR_BOUNDARY):
		pos.y -= 1
	elif(Input.is_action_pressed("move_down")):
		pos.y += 1
	
	set_pos(pos)
	pass