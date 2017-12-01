extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var VIEWPORT
var STAGE
var CAMERA
var BOSS

export (NodePath) var LEVEL1MUSIC_PATH
export (NodePath) var BOSSMUSIC_PATH
export (NodePath) var BOSS_PATH

var TRIGGERED = false
var STATE = 'waiting'
var BOSS_ZONE_LEFT

var SPEECH_DELAY = 3
var SPEECH_TIMER = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	VIEWPORT = self.get_node("/root")
	CAMERA = self.get_node("/root/Stage/Camera")
	STAGE = self.get_node("/root/Stage")
	BOSS = self.get_node(BOSS_PATH)
	
	self.set_process(true)
	
func _process(delta):
	if(STATE == 'animate_camera'):
		var cam_pos = CAMERA.get_pos()
		if(cam_pos.x < BOSS_ZONE_LEFT):
			cam_pos.x += 1
			CAMERA.set_pos(cam_pos)
		else:
			cam_pos.x = BOSS_ZONE_LEFT
			CAMERA.set_pos(cam_pos)
			STATE = 'boss_music'
	elif(STATE == 'boss_music'):
		self.get_node(LEVEL1MUSIC_PATH).stop()
		self.get_node(BOSSMUSIC_PATH).play()
		STATE = 'boss_intro'
	elif(STATE == 'boss_intro'):
		BOSS.speech_on()
		STATE = 'boss_speech'
	elif(STATE == 'boss_speech'):
		SPEECH_TIMER += delta
		if(SPEECH_TIMER >= SPEECH_DELAY):
			BOSS.speech_off()
			BOSS.set_active()
			self.get_tree().set_pause(false)
			self.set_process(false)


func _on_Boss_Zone_body_enter( body ):
	if (!TRIGGERED):
		self.get_tree().set_pause(true)
		BOSS_ZONE_LEFT = STAGE.meta('level_width') - VIEWPORT.get_rect().size.width
		STATE = 'animate_camera'
		TRIGGERED = true
	
