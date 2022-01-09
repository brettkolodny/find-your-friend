extends Node

var body_images = _dir_contents("res://Scenes/Character/Assets/body")
var arms_images = _dir_contents("res://Scenes/Character/Assets/arms")
var face_images = _dir_contents("res://Scenes/Character/Assets/face")
var facial_hair_images = _dir_contents("res://Scenes/Character/Assets/facial-hair")
var head_images = _dir_contents("res://Scenes/Character/Assets/head")
var legs_images = _dir_contents("res://Scenes/Character/Assets/legs")

var body_images_copy = []
var arms_images_copy = []
var face_images_copy = []
var facial_hair_images_copy = []
var head_images_copy = []
var legs_images_copy = []

func _dir_contents(path: String) -> Array:
	var files = []
	
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name: String = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				var file_name_split: PoolStringArray = file_name.split(".")
				if !(file_name_split[len(file_name_split) - 1]) == "import":
					files.push_back("%s/%s" % [path, file_name])
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	return files


func _ready():
	randomize()


func randomize_characters():
	self._randomize_friend()
	self._randomize_peeps()


func _randomize_friend():
	var friends = get_tree().get_nodes_in_group("friend")
	
	if len(friends) == 0:
		return
		
	var friend = friends[0]
	
	
	body_images_copy = body_images.duplicate()
	arms_images_copy = arms_images.duplicate()
	face_images_copy = face_images.duplicate()
	facial_hair_images_copy = facial_hair_images.duplicate()
	head_images_copy = head_images.duplicate()
	legs_images_copy = legs_images.duplicate()
	
	var body_index = randi() % len(body_images_copy)
	var arms_index = randi() % len(arms_images_copy)
	var face_index = randi() % len(face_images_copy)
	var facial_hair_index = randi() % len(facial_hair_images_copy)
	var head_index = randi() % len(head_images_copy)
	var legs_index = randi() % len(legs_images_copy)
	
	var body_image = load(body_images_copy[body_index])
	var arms_image = load(arms_images_copy[arms_index])
	var face_image = load(face_images_copy[face_index])
	var facial_hair_image = load(facial_hair_images_copy[facial_hair_index])
	var head_image = load(head_images_copy[head_index])
	var legs_image = load(legs_images_copy[legs_index])
	
	body_images_copy.remove(body_index)
	arms_images_copy.remove(arms_index)
	face_images_copy.remove(face_index)
	facial_hair_images_copy.remove(facial_hair_index)
	head_images_copy.remove(head_index)
	legs_images_copy.remove(legs_index)
	
	
	var character = friend.get_node("Character")
	var body = character.get_node("Body")
	var arms = character.get_node("Arms")
	var facial_hair = character.get_node("FacialHair")
	var legs = character.get_node("Legs")
	var head = character.get_node("Head")
	var face = character.get_node("Face")
	
	body.texture = body_image
	arms.texture = arms_image
	face.texture = face_image
	facial_hair.texture = facial_hair_image
	legs.texture = legs_image
	head.texture = head_image
	
	var friend_zoomed_previews = get_tree().get_nodes_in_group("friend_zoom_preview")
	
	if len(friend_zoomed_previews) == 0:
		return
		
	character = friend_zoomed_previews[0]
	
	body = character.get_node("Body")
	arms = character.get_node("Arms")
	facial_hair = character.get_node("FacialHair")
	legs = character.get_node("Legs")
	head = character.get_node("Head")
	face = character.get_node("Face")
	
	body.texture = body_image
	arms.texture = arms_image
	face.texture = face_image
	facial_hair.texture = facial_hair_image
	legs.texture = legs_image
	head.texture = head_image

func _randomize_peeps():
	body_images_copy = body_images.duplicate()
	arms_images_copy = arms_images.duplicate()
	face_images_copy = face_images.duplicate()
	facial_hair_images_copy = facial_hair_images.duplicate()
	head_images_copy = head_images.duplicate()
	legs_images_copy = legs_images.duplicate()

	# Randomzi Peeps
	var peeps = get_tree().get_nodes_in_group("peep")
	
	for peep in peeps:
		if randi() % 2:
			peep.scale.x *= -1

		var character = peep.get_node("Character")
		var body = character.get_node("Body")
		var arms = character.get_node("Arms")
		var facial_hair = character.get_node("FacialHair")
		var legs = character.get_node("Legs")
		var head = character.get_node("Head")
		var face = character.get_node("Face")
		
		
		var body_image = load(body_images_copy[randi() % len(body_images_copy)])
		var arms_image = load(arms_images_copy[randi() % len(arms_images_copy)])
		var face_image = load(face_images_copy[randi() % len(face_images_copy)])
		var facial_hair_image = load(facial_hair_images_copy[randi() % len(facial_hair_images_copy)])
		var head_image = load(head_images_copy[randi() % len(head_images_copy)])
		var legs_image = load(legs_images_copy[randi() % len(legs_images_copy)])

		body.texture = body_image
		arms.texture = arms_image
		face.texture = face_image
		facial_hair.texture = facial_hair_image
		legs.texture = legs_image
		head.texture = head_image
