extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var MENU

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	MENU = self.get_parent()


func _on_EscMenu_visibility_changed():
	if (MENU.is_visible()):
		self.show()
	else:
		self.hide()
