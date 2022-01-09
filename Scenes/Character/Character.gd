extends Node2D
class_name Character

const SCALE_AMOUNT = 0.1
const BASE_SIZE = Vector2(24, 24)

var is_growing = false

export var scale_factor = 1
export var should_idle = true
export var is_friend = false

onready var initial_scale = self.scale.y

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	var initial_scale_state = rng.randf_range(0, SCALE_AMOUNT)
	
	if randi() % 2:
		self.is_growing = true
		self.scale = Vector2(self.scale.x, self.scale.y + initial_scale_state)
	else :
		self.scale = Vector2(self.scale.x, self.scale.y - initial_scale_state)

func _process(delta):
	if !self.should_idle:
		return
	
	var new_scale = self.scale.y
	
	if is_growing:
		new_scale +=  scale_factor * (delta / 2)
		
		if new_scale > initial_scale + SCALE_AMOUNT:
			self.is_growing = false
			return
		
	else:
		new_scale -= scale_factor * (delta / 2)
		
		if new_scale < initial_scale - SCALE_AMOUNT:
			self.is_growing = true
			return
		
	self.scale = Vector2(self.scale.x, new_scale)
