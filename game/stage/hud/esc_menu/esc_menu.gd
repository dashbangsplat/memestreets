extends Container

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.hideMenu()
	self.set_process(true)

func _process(delta):
	if (Input.is_action_pressed("esc_menu")):
		if (!self.is_visible()):
			self.showMenu()

func showMenu():
	self.get_tree().set_pause(true)
	self.show()

func hideMenu():
	self.get_tree().set_pause(false)
	self.hide()
