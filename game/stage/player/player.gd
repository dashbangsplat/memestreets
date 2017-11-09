extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var VIEWPORT
var STAGE
var CAMERA
var CAMERA_START
var WIDTH
var HEIGHT
var TEXTURE_POSITION_OFFSET
const MOVE_CAMERA_BOUNDARY = 64
var RAYCAST_ATTACK
export var ATTACK_DAMAGE = 50
export var ATTACK_DELAY = 1
var ATTACK_TIMER = ATTACK_DELAY
export var MAX_HEALTH = 100
export var HEALTH = 100
export var SCORE = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	VIEWPORT = self.get_node("/root")
	STAGE = self.get_node("/root/Stage")
	RAYCAST_ATTACK = self.get_node("RayCastAttack")
	CAMERA = self.get_node("/root/Stage/Camera")
	CAMERA_START = CAMERA.get_pos()
	CAMERA.make_current()
	
	STAGE.connect(STAGE.SIGNAL_ENEMY_DIED, self, "handle_enemy_died")
	
	var texture = self.get_node("Sprite").get_texture()
	WIDTH = texture.get_width()
	HEIGHT = texture.get_height()
	TEXTURE_POSITION_OFFSET = Rect2()
	TEXTURE_POSITION_OFFSET.pos.y = (HEIGHT / 2) - 10 # top side
	TEXTURE_POSITION_OFFSET.size.height = (HEIGHT / 2); # bottom size - half the size of the texture (since it's centered) minus some value so it doesnt climb up the wall
	TEXTURE_POSITION_OFFSET.pos.x = - (WIDTH / 2) # left side -  half the size of the texture (since it's centered)
	TEXTURE_POSITION_OFFSET.size.width = (WIDTH / 2) # right side
	
	HEALTH = MAX_HEALTH
	
	self.set_process(true)
	
func _process(delta):
	var pos = self.get_pos()
	
	# pos.x - HORIZONTAL_BOUNDARY_MIN_OFFSET becuase we want to check the limiot from the left of the texture
	if(Input.is_action_pressed("move_left") && self.can_player_move_left()):
		pos.x -= 1
	
	if(Input.is_action_pressed("move_right") && self.can_player_move_right()):
		pos.x += 1
		if(self.can_level_scroll_to_the_right()):
			var camera_pos = CAMERA.get_pos()
			camera_pos.x += 1
			CAMERA.set_pos(camera_pos)
	
	# pos.y + VERTICAL_BOUNDARY_MIN_OFFSET becuase we want to check the limit from the bottom of the texture
	if(Input.is_action_pressed("move_up") && self.can_player_move_up()):
		pos.y -= 1
	
	if(Input.is_action_pressed("move_down") && self.can_player_move_down()):
		pos.y += 1
	
	self.set_pos(pos)
	
	ATTACK_TIMER += delta
	
	if(Input.is_action_pressed("main_attack") && ATTACK_TIMER >= ATTACK_DELAY):
		RAYCAST_ATTACK.set_enabled(true)
		RAYCAST_ATTACK.force_raycast_update()
		if(RAYCAST_ATTACK.is_colliding()):
			var obj = RAYCAST_ATTACK.get_collider()
			if(obj.is_in_group('enemy')):
				ATTACK_TIMER = 0
				obj.take_damage(ATTACK_DAMAGE)
		RAYCAST_ATTACK.set_enabled(false)
	

func can_level_scroll_to_the_right():
	return self.get_pos().x > VIEWPORT.get_rect().size.width + CAMERA.get_pos().x - CAMERA_START.x - MOVE_CAMERA_BOUNDARY && CAMERA.get_pos().x + VIEWPORT.get_rect().size.width < STAGE.meta('level_width')

func can_player_move_left():
	return self.get_pos().x + TEXTURE_POSITION_OFFSET.pos.x > self.get_movement_boundary().pos.x

func can_player_move_right():
	var left = self.get_pos().x + TEXTURE_POSITION_OFFSET.size.width
	return left < self.get_movement_boundary().size.width && left < STAGE.meta('level_width')

func can_player_move_up():
	return self.get_pos().y + TEXTURE_POSITION_OFFSET.pos.y > self.get_movement_boundary().pos.y

func can_player_move_down():
	return self.get_pos().y + TEXTURE_POSITION_OFFSET.size.height < self.get_movement_boundary().size.height

func get_movement_boundary():
	return Rect2(0 + CAMERA.get_pos().x - CAMERA_START.x, STAGE.meta('floor_boundary'), VIEWPORT.get_rect().size.width + CAMERA.get_pos().x - CAMERA_START.x, VIEWPORT.get_rect().size.height)
	
func take_damage(amount):
	HEALTH -= amount
	STAGE.emit_signal_player_health(HEALTH)
	if(HEALTH <= 0):
		STAGE.emit_signal_player_died()
		self.set_process(false)
		self.hide()
		self.queue_free()
		self.get_tree().quit()

func handle_enemy_died(points = 0):
	SCORE += points
	STAGE.emit_signal_player_score(SCORE)
	