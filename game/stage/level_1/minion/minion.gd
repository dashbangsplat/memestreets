extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var STAGE
var PLAYER
var EFFECTS
export var MAX_HEALTH = 100
export var HEALTH = 100
var RAYCAST_ATTACK
export var ATTACK_DAMAGE = 5
export var ATTACK_DELAY = 1
var ATTACK_TIMER = ATTACK_DELAY
export var KILL_SCORE = 50
export var FIND_PLAYER_RADIUS = 100

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	STAGE = self.get_node("/root/Stage")
	RAYCAST_ATTACK = self.get_node("RayCastAttack")
	PLAYER = self.get_node("/root/Stage/Player")
	EFFECTS = self.get_node("SamplePlayer")
	
	STAGE.connect(STAGE.SIGNAL_PLAYER_DIED, self, "handle_player_died")
	
	HEALTH = MAX_HEALTH
	self.set_process(true)

func _process(delta):
	if(self.get_global_pos().distance_to(PLAYER.get_global_pos()) <= FIND_PLAYER_RADIUS):
		self.move(-(self.get_global_pos() - PLAYER.get_global_pos()).normalized())
		
	ATTACK_TIMER += delta
	
	if(ATTACK_TIMER >= ATTACK_DELAY):
		RAYCAST_ATTACK.set_enabled(true)
		RAYCAST_ATTACK.force_raycast_update()
		if(RAYCAST_ATTACK.is_colliding()):
			var obj = RAYCAST_ATTACK.get_collider()
			if(obj.is_in_group('player')):
				EFFECTS.play("sfx_damage_hit6")
				ATTACK_TIMER = 0
				obj.take_damage(ATTACK_DAMAGE)
		RAYCAST_ATTACK.set_enabled(false)
	

func take_damage(amount):
	HEALTH -= amount
	if(HEALTH <= 0):
		STAGE.emit_signal_enemy_died(KILL_SCORE)
		self.set_process(false)
		self.hide()
		self.queue_free()

func handle_player_died():
	self.set_process(false);