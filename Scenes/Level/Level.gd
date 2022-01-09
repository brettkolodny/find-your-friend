extends Node2D

const PEEP_SCENE = preload("res://Scenes/Peep/Peep.tscn")
const FRIEND_SCENE = preload("res://Scenes/Friend/Friend.tscn")
const PLAY_AREA_PADDING = Vector2(100, 100)

export var num_peeps = 50
export var character_scale = Vector2(2, 2)

onready var start_time = OS.get_ticks_msec()

var is_zoomed = false

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


func zoom_in():
	is_zoomed = true
	$FriendCard.visible = false
	$CanvasLayer/ZoomedIn.visible = true
	$FriendCardZoomedCanvas/FriendCardZoomed.visible = true
	$Camera2D.global_position = get_global_mouse_position()
	$Camera2D.zoom = Vector2(0.5, 0.5)


func zoom_out():
	is_zoomed = false
	$FriendCard.visible = true
	$FriendCardZoomedCanvas/FriendCardZoomed.visible = false
	$CanvasLayer/ZoomedIn.visible = false
	$Camera2D.position = get_viewport_rect().size / 2
	$Camera2D.zoom = Vector2(1, 1)
	


func set_timer():
	var elapsed_time = OS.get_ticks_msec()
	
	var seconds = elapsed_time / 1_000 % 60
	var minutes = elapsed_time / 60_000 % 60
	
	var new_time_string = "%sm %ss" % [str(minutes), str(seconds)]
	
	if $TimerCanvas/Timer.text != new_time_string:
		$TimerCanvas/Timer.text = new_time_string

func _ready():
	$Camera2D.position = get_viewport_rect().size / 2
	$Camera2D.make_current()
	
	var friend = self.spawn_character(FRIEND_SCENE)
	$Friend.add_child(friend)
	self.spawn_peeps()
	Global.randomize_characters()
	
	var friend_preview: Node2D = friend.duplicate()
	friend_preview.get_node("Character").should_idle = false
	$FriendCard/FriendPreview.add_child(friend_preview)
	friend_preview.global_position = $FriendCard/FriendPreview.global_position
	friend_preview.scale = Vector2(6, 6)


func _process(_delta):
	set_timer()
	
	if Input.is_action_just_pressed("ui_right_click"):
		zoom_in()
	elif Input.is_action_just_released("ui_right_click"):
		zoom_out()

	if is_zoomed:
		$Camera2D.global_position = $Camera2D.get_viewport().get_mouse_position()
