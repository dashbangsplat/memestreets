extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var ANIM
var MENU

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	ANIM = self.get_parent()
	MENU = self.get_parent().get_parent().get_parent()

func _on_Resume_mouse_enter():
	ANIM.play("HighlightResume")


func _on_Resume_mouse_exit():
	ANIM.play_backwards("HighlightResume")


func _on_Resume_input_event( ev ):
	if (ev.type == InputEvent.MOUSE_BUTTON):
		if (ev.button_index == 1):
			MENU.hideMenu()


func _on_EscMenu_visibility_changed():
	if (MENU.is_visible()):
		self.show()
	else:
		self.hide()
