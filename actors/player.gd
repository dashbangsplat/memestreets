extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var body

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	body = get_node("Body")
	pass
	
func _process(delta):
	var pos = get_pos()
	if(Input.is_action_pressed("move_left")):
		pos.x -= 1
	elif(Input.is_action_pressed("move_right")):
		pos.x += 1
		
	if(Input.is_action_pressed("move_up")):
		pos.y -= 1
	elif(Input.is_action_pressed("move_down")):
		pos.y += 1
	
	set_pos(pos)
	pass