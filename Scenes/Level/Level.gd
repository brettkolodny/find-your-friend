extends Node2D

const PEEP_SCENE = preload("res://Scenes/Peep/Peep.tscn")
const FRIEND_SCENE = preload("res://Scenes/Friend/Friend.tscn")
const PLAY_AREA_PADDING = Vector2(75, 75)

export var character_scale = Vector2(2, 2)
export var randomly_spawn = true;
export var is_tutorial = false

onready var start_time = OS.get_ticks_msec()

var is_zoomed = false

func spawn_characters() -> Node2D:
	var spawn_points = self._get_spawn_points()
	spawn_points.shuffle()
	
	var characters = []
	
	var friend_spawn_point = spawn_points[len(spawn_points) - 1]

	var friend = FRIEND_SCENE.instance()
	friend.scale = character_scale
	friend.position = friend_spawn_point
	characters.push_back(friend)

	
	if randi() % 2:
		friend.scale.x *= -1
	
	for i in range(Global.num_peeps):
		var new_peep = PEEP_SCENE.instance()
		new_peep.scale = self.character_scale
		
		if randi() % 2:
			new_peep.scale.x *= -1
		
		var spawn_point = spawn_points[i]
		new_peep.position = spawn_point
		characters.push_back(new_peep)
		
	characters.sort_custom(self, "_sort_by_y_position")
	
	for character in characters:
		$Characters.add_child(character)
		
	return friend


func zoom_in():
	is_zoomed = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$FriendCard.visible = false
	$CanvasLayer/ZoomedIn.visible = true
	$FriendCardZoomedCanvas/FriendCardZoomed.visible = true
	$Camera2D.global_position = get_global_mouse_position()
	$Camera2D.zoom = Vector2(0.5, 0.5)


func zoom_out():
	is_zoomed = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$FriendCard.visible = true
	$FriendCardZoomedCanvas/FriendCardZoomed.visible = false
	$CanvasLayer/ZoomedIn.visible = false
	$Camera2D.position = get_viewport_rect().size / 2
	$Camera2D.zoom = Vector2(1, 1)


func character_is_hit(character) -> bool:
	var hit_box: CollisionShape2D = character.get_node("Character").get_node("HitBox").get_node("HitBoxShape")
	var hit_box_pos = hit_box.global_position
	var abs_scale = Vector2(abs(character.scale.x), abs(character.scale.y))
	var hit_box_size = hit_box.shape.extents * abs_scale
	
	if $Camera2D.global_position.x >= (hit_box_pos.x - hit_box_size.x) \
	and $Camera2D.global_position.x <= (hit_box_pos.x + hit_box_size.x) \
	and $Camera2D.global_position.y >= (hit_box_pos.y - hit_box_size.y) \
	and $Camera2D.global_position.y <= (hit_box_pos.y + hit_box_size.y):
		return true
	else:
		return false


func set_timer():
	var new_time_string = "%ss" % str(int($Countdown.time_left))
	
	$TimerCanvas/Timer.text = new_time_string


func _sort_by_y_position(a: Node2D, b: Node2D) -> bool:
	if a.global_position.y > b.global_position.y:
		return false
	return true


func _get_spawn_points():
	var spawn_area_position = $SpawnArea/SpawnAreaShape.position
	var spawn_area_size = $SpawnArea/SpawnAreaShape.shape.extents
	
	var spawn_points = []
	
	var start_x = spawn_area_position.x - spawn_area_size.x + PLAY_AREA_PADDING.x / 2
	var end_x = spawn_area_position.x + spawn_area_size.x - PLAY_AREA_PADDING.x / 2
	
	var start_y = spawn_area_position.y - spawn_area_size.y + PLAY_AREA_PADDING.y / 2
	var end_y = spawn_area_position.y + spawn_area_size.y
	
	for x in range(start_x, end_x, Character.BASE_SIZE.x):
		for y in range(start_y, end_y, Character.BASE_SIZE.y):
			spawn_points.push_back(Vector2(x, y))
	
	return spawn_points


func _ready():
	$Camera2D.position = get_viewport_rect().size / 2
	$Camera2D.make_current()
	
	Global.randomize_level_color()
	
	var friend = null
	
	if (self.randomly_spawn):
		friend = self.spawn_characters()
	else:
		friend = get_tree().get_nodes_in_group("friend")[0]
		
	Global.randomize_characters()
	
	var friend_preview: Node2D = friend.duplicate()
	friend_preview.remove_from_group("friend")
	friend_preview.get_node("Character").should_idle = false
	$FriendCard/FriendPreview.add_child(friend_preview)
	friend_preview.global_position = $FriendCard/FriendPreview.global_position
	friend_preview.scale = Vector2(6, 6)
	
	#if top most node is Tutorial don't do this
	if(!self.is_tutorial):
		MusicScene.minutePlayer()

func _process(_delta):
	self.set_timer()
	
	if Input.is_action_just_pressed("ui_right_click"):
		zoom_in()
	elif Input.is_action_just_released("ui_right_click"):
		zoom_out()

	if is_zoomed:
		$Camera2D.global_position = $Camera2D.get_viewport().get_mouse_position()
		
		if Input.is_action_just_pressed("ui_left_click"):
			var friend = get_tree().get_nodes_in_group("friend")[0]
			if self.character_is_hit(friend):
				Global.level_win($Countdown.time_left)
			else:
				var peeps = get_tree().get_nodes_in_group("peep")
				for peep in peeps:
					if self.character_is_hit(peep):
						Global.level_lose()
						break


func _on_Countdown_timeout():
	if !self.is_tutorial:
		Global.level_lose()
