extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var STAGE
var PLAYER
const STARTING_SCORE = "0000000"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	STAGE = self.get_node("/root/Stage")
	PLAYER = self.get_node("/root/Stage/Player")
	
	STAGE.connect(STAGE.SIGNAL_PLAYER_SCORE, self, "handle_player_score")

func handle_player_score(score = 0):
	var score_len = str(PLAYER.SCORE).length()
	var score = STARTING_SCORE + str(PLAYER.SCORE)
	score = score.substr(score_len, STARTING_SCORE.length())
	self.set_text(score)
