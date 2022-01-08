extends Node

const PEEP_NODE = preload("res://Scenes/Peep/Peep.tscn")
const PLAY_AREA_PADDING = Vector2(100, 100)

export var num_peeps = 50
export var character_scale = Vector2(1.5, 1.5)


func _ready():
	var play_area_position = $ReferenceRect/PlayArea.rect_position
	var play_area_size = $ReferenceRect/PlayArea.rect_size
	
	var spawn_area_x = (play_area_size.x - PLAY_AREA_PADDING.x)
	var spawn_area_y = (play_area_size.y - PLAY_AREA_PADDING.y)
	
	var punch_position_x = play_area_position.x + (PLAY_AREA_PADDING.x / 2)
	var punch_position_y = play_area_position.y + (PLAY_AREA_PADDING.y / 2)
	
	for _i in range(num_peeps):
		var new_peep: Node2D = PEEP_NODE.instance()
		new_peep.scale = character_scale
		
		var rand_x = randi() % int(spawn_area_x)
		var rand_y = randi() % int(spawn_area_y)
		
		var new_peep_position = Vector2(rand_x + punch_position_x, rand_y + punch_position_y)
		print(new_peep_position)
		new_peep.global_position = new_peep_position
		
		self.add_child(new_peep)
	
	
	Global.randomize_peeps()
