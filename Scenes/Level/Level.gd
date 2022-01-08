extends Node

const PEEP_NODE = preload("res://Scenes/Peep/Peep.tscn")
export var num_peeps = 10

func _ready():
	var peep: Node2D = PEEP_NODE.instance()
	peep.scale = Vector2(1, 1)
	peep.position = Vector2(500, 200)
	
	var peep2: Node2D = PEEP_NODE.instance()
	peep2.scale = Vector2(2, 2)
	peep2.position = Vector2(500, 300)
	
	self.add_child(peep)
	self.add_child(peep2)
	Global.randomize_peeps()
