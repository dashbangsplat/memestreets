extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var STAGE
var PLAYER
const MAX_HEALTH = 100
var HEALTH
var RAYCAST_ATTACK
const ATTACK_DAMAGE = 5
const ATTACK_DELAY = 1
var ATTACK_TIMER = ATTACK_DELAY
var KILL_SCORE = 50

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	STAGE = self.get_node("/root/Stage")
	RAYCAST_ATTACK = self.get_node("RayCastAttack")
	PLAYER = self.get_node("/root/Stage/Player")
	
	STAGE.connect(STAGE.SIGNAL_PLAYER_DIED, self, "handle_player_died")
	
	HEALTH = MAX_HEALTH
	self.set_process(true)

func _process(delta):
	if(self.get_global_pos().distance_to(PLAYER.get_global_pos()) <= 100):
		self.move(-(self.get_global_pos() - PLAYER.get_global_pos()).normalized())
		
	ATTACK_TIMER += delta
	
	if(ATTACK_TIMER >= ATTACK_DELAY):
		RAYCAST_ATTACK.set_enabled(true)
		RAYCAST_ATTACK.force_raycast_update()
		if(RAYCAST_ATTACK.is_colliding()):
			var obj = RAYCAST_ATTACK.get_collider()
			if(obj.is_in_group('player')):
				print('hit player!')
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