extends ProgressBar

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var STAGE
var PLAYER
const STARTING_SCORE = "00000000"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	STAGE = self.get_node("/root/Stage")
	PLAYER = self.get_node("/root/Stage/Player")
	
	self.set_min(0)
	self.set_max(PLAYER.MAX_HEALTH)
	self.set_value(PLAYER.MAX_HEALTH)
	
	STAGE.connect(STAGE.SIGNAL_PLAYER_HEALTH, self, "handle_player_health")

func handle_player_health(health = 0):
	self.set_value(health)
