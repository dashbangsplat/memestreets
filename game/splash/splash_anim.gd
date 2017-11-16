extends AnimationPlayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var TIME = 0;
var WAITING = true;

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_process(true);

func _process(delta):
	if (WAITING == true):
		TIME += delta

		if (TIME >= 2):
			self.play("Hide")
			WAITING = false


func _on_AnimationPlayer_finished():
	self.get_tree().change_scene("res://menu/menu.tscn")
