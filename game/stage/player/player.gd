extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var VIEWPORT
var STAGE
var CAMERA
var WIDTH
var HEIGHT
var BOUNDARY
var TEXTURE_POSITION_OFFSET
const MOVE_CAMERA_BOUNDARY = 50

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	VIEWPORT = get_node("/root")
	STAGE = get_node("/root/Stage")
	CAMERA = get_node("/root/Camera")
	
	var texture = get_node("Sprite").get_texture()
	WIDTH = texture.get_width()
	HEIGHT = texture.get_height()
	TEXTURE_POSITION_OFFSET = Rect2()
	TEXTURE_POSITION_OFFSET.pos.y = (HEIGHT / 2) - 10 # top side
	TEXTURE_POSITION_OFFSET.size.height = (HEIGHT / 2); # bottom size - half the size of the texture (since it's centered) minus some value so it doesnt climb up the wall
	TEXTURE_POSITION_OFFSET.pos.x = - (WIDTH / 2) # left side -  half the size of the texture (since it's centered)
	TEXTURE_POSITION_OFFSET.size.width = (WIDTH / 2) # right side
	
	# Player movement boundary
	BOUNDARY = Rect2(0, STAGE.FLOOR_BOUNDARY, VIEWPORT.get_rect().size.width, VIEWPORT.get_rect().size.height);
	
	set_process(true)
	pass
	
func _process(delta):
	var pos = get_pos()
	
	# pos.x - HORIZONTAL_BOUNDARY_MIN_OFFSET becuase we want to check the limiot from the left of the texture
	if(Input.is_action_pressed("move_left") && pos.x + TEXTURE_POSITION_OFFSET.pos.x > BOUNDARY.pos.x):
		pos.x -= 1
	
	if(Input.is_action_pressed("move_right") && pos.x + TEXTURE_POSITION_OFFSET.size.width < BOUNDARY.size.width):
		pos.x += 1
	
	# pos.y + VERTICAL_BOUNDARY_MIN_OFFSET becuase we want to check the limit from the bottom of the texture
	if(Input.is_action_pressed("move_up") && pos.y + TEXTURE_POSITION_OFFSET.pos.y > BOUNDARY.pos.y):
		pos.y -= 1
	
	if(Input.is_action_pressed("move_down") && pos.y + TEXTURE_POSITION_OFFSET.size.height < BOUNDARY.size.height):
		pos.y += 1
		if(pos.y > VIEWPORT.get_rect().size.width - MOVE_CAMERA_BOUNDARY):
			var camera_pos = CAMERA.get_pos()
			camera_pos.x += 1
			CAMERA.set_pos(camera_pos)
	
	set_pos(pos)
	pass