extends Container

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (NodePath) var ANIM_PATH

var LISTENING = false
var SLEEP = 1;
var ELAPSED = 0;

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var ANIM = self.get_node(ANIM_PATH)
	ANIM.play("Slider")
	self.set_process(true)
	self.set_process_input(true)

func _process(delta):
	ELAPSED += delta
	if (LISTENING == false && ELAPSED >= SLEEP):
		ELAPSED = 0
		LISTENING = true


func _input( ev ):
	if (LISTENING && ELAPSED >= SLEEP && (ev.type == InputEvent.MOUSE_BUTTON || ev.type == InputEvent.KEY)):
		self.get_tree().change_scene("res://menu/menu.tscn")
