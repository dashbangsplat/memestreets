extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var ANIM

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	ANIM = self.get_parent()


func _on_Play_mouse_enter():
	ANIM.play("HighlightPlay")



func _on_Play_mouse_exit():
	ANIM.play_backwards("HighlightPlay")



func _on_Play_input_event( ev ):
	if (ev.type == InputEvent.MOUSE_BUTTON):
		if (ev.button_index == 1):
			self.get_tree().change_scene("res://stage/stage.tscn");
