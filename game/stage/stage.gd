extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var META = {}

signal enemy_died
const SIGNAL_ENEMY_DIED = 'enemy_died'

signal player_died
const SIGNAL_PLAYER_DIED = "player_died"

signal player_score
const SIGNAL_PLAYER_SCORE = "player_score"

signal player_health
const SIGNAL_PLAYER_HEALTH = "player_health"

signal level_timer_expired
const SIGNAL_LEVEL_TIMER_EXPIRED = "level_timer_expired"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.meta('floor_boundary', 125) # the max height any entity can travel upwards on the displayed floor of a level
	
	self.connect(SIGNAL_LEVEL_TIMER_EXPIRED, self, "handle_level_timer_expired")

func meta(key, val = null):
	if (val != null):
		META[key] = val
	return META[key]

func emit_signal_enemy_died(points = 0):
	self.emit_signal(SIGNAL_ENEMY_DIED, points)

func emit_signal_player_died():
	self.emit_signal(SIGNAL_PLAYER_DIED)

func emit_signal_player_score(score = 0):
	self.emit_signal(SIGNAL_PLAYER_SCORE, score)

func emit_signal_player_health(health = 0):
	self.emit_signal(SIGNAL_PLAYER_HEALTH, health)

func emit_signal_level_timer_expired():
	self.emit_signal(SIGNAL_LEVEL_TIMER_EXPIRED)

func handle_level_timer_expired():
	self.get_tree().quit()
