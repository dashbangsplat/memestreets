extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var ANIM

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	ANIM = self.get_parent()


func _on_Credits_mouse_enter():
	ANIM.play("HighlightCredits")



func _on_Credits_mouse_exit():
	ANIM.play_backwards("HighlightCredits")



func _on_Credits_input_event( ev ):
	if (ev.type == InputEvent.MOUSE_BUTTON):
		if (ev.button_index == 1):
			self.get_tree().change_scene("res://credits/credits.tscn");
