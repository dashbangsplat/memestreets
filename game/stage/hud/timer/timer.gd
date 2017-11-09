extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var STAGE
var TIMER_START = 198
var TIME = TIMER_START

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	STAGE = self.get_node("/root/Stage")
	
	self.set_text(str(TIMER_START))
	
	self.set_process(true)

func _process(delta):
	TIME -= delta
	if(TIME < 10):
		self.set_text("0" + str(int(TIME / 2)))
	else:
		self.set_text(str(int(TIME / 2)))
	if(TIME <= 0):
		STAGE.emit_signal_level_timer_expired()

