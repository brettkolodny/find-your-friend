extends Node

const PEEP_SCENE = preload("res://Scenes/Peep/Peep.tscn")
const FRIEND_SCENE = preload("res://Scenes/Friend/Friend.tscn")
const PLAY_AREA_PADDING = Vector2(100, 100)

export var num_peeps = 100
export var character_scale = Vector2(2, 2)


func spawn_character(node: PackedScene) -> Node2D:
	var spawn_area_position = $SpawnArea/SpawnAreaShape.position
	var spawn_area_size = $SpawnArea/SpawnAreaShape.shape.extents
	
	var new_character: Node2D = node.instance()
	new_character.scale = character_scale
	
	
	var rand_x = randi() % int(spawn_area_size.x)
	var rand_y = randi() % int(spawn_area_size.y)
	
	if randi() % 2:
		rand_x *= -1
	if randi() % 2:
		rand_y *= -1

	var new_character_y_size = 24 * new_character.scale.y

	# The position of the peep is at the bottom of the sprites so we have to offset it so they aren't all spawned upwards
	var new_character_position = Vector2(rand_x + spawn_area_position.x, rand_y + spawn_area_position.y + (new_character_y_size / 2))

	new_character.global_position = new_character_position
	
	return new_character


func spawn_peeps():
	for _i in range(num_peeps):
		var new_peep = spawn_character(PEEP_SCENE)
		$Characters.add_child(new_peep)


func _ready():
	var friend = self.spawn_character(FRIEND_SCENE)
	$Friend.add_child(friend)
	self.spawn_peeps()
	Global.randomize_characters()
	
	var friend_preview: Node2D = friend.duplicate()
	friend_preview.get_node("Character").should_idle = false
	$FriendCard/FriendPreview.add_child(friend_preview)
	friend_preview.global_position = $FriendCard/FriendPreview.global_position
	friend_preview.scale = Vector2(6, 6)
	
	print($FriendCard/FriendPreview.get_children())
	
