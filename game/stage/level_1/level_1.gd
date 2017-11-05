extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var STAGE

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	STAGE = self.get_node("/root/Stage")
	STAGE.meta('level_width', self.get_level_width())

func get_level_width():
	var regexp = RegEx.new()
	regexp.compile("^Background");
	
	var width = 0;
	
	for child in self.get_children():
		if(regexp.find(child.get_name()) < 0):
			continue
		
		var right = child.get_pos().x + child.get_texture().get_size().width;
		
		if(right > width):
			width = right
	
	return width
