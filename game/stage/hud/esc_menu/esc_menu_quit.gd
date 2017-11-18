extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (NodePath) var animNodePath
export (NodePath) var escMenuNodePath
var animNode
var escMenuNode

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	animNode = self.get_node(animNodePath)
	escMenuNode = self.get_node(escMenuNodePath)

func _on_Quit_mouse_enter():
	animNode.play("HighlightQuit")

func _on_Quit_mouse_exit():
	animNode.play_backwards("HighlightQuit")

func _on_Quit_input_event( ev ):
	if (ev.type == InputEvent.MOUSE_BUTTON):
		if (ev.button_index == 1):
			self.get_tree().quit()

func _on_EscMenu_visibility_changed():
	self.set("custom_colors/font_color", Color(1,1,1)) # reset color to white
	if (escMenuNode.is_visible()):
		self.show()
	else:
		self.hide()
