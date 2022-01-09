extends Node

const TITLE_SCENE = preload("res://Scenes/TitleScreen/TitleScreen.tscn")
const LEVEL_SCENE = preload("res://Scenes/Level/Level.tscn")
const LEVEL_WIN_SCENE = preload("res://Scenes/LevelWinScreen/LevelWinScreen.tscn")
const LOSE_SCENE = preload("res://Scenes/LoseScreen/LoseScreen.tscn")

export var level_color = Color(1, 0, 0)
export var num_peeps = 5

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

var level = 1

var familyFacts = ["had a wife and 2 kids",
		"had a wife and 2 kids who now have no breadwinner",
		"had a wife and 2.5 kids",
		"had a ex-wife who will be overjoyed at them being [i]found[/i]",
		"had a loving husband of 3 year",
		"was a turbo virgin",
		"had a husband and a kid on the way",
		"had a husband and 2 kids",
		"had a collection of body pillows instead of human connections",
		"had no human contact beyond the League of Legends community"
]

var hobbyFacts = ["rock climbing",
		"doing crosswords",
		"to live, laugh, and love",
		"watching Twitch.tv",
		"listening to Daytona",
		"listening to choice picks from the Lisa OST",
		"listening to the John Souls - Magnificent Demon on their commute",
		"unironically listening to Gachi music"
]

var findFacts = ["spammed NAM",
		"subbed to Forsen",
		"smiled when Pokemain was banned",
		"radicalized Markov Bot",
		"posted Elf Tits",
		"was a Prime Pleb",
		"failed the FitnessGram™ Pacer Test",
		"didn’t play Morrowind",
		"wrote Attack on Titan vore fan fiction",
		"didn’t like Gura",
		"@’ed the streamer with hints they didn’t ask for ",
		"filmed themself at the gym",
		"didn’t return the shopping cart",
		"kicked an ice cube under the fridge",
		"microwaved cold brew coffee",
		"tried to go to the bathroom during their warehouse shif"
]

var familyFact
var hobbyFact
var findFact

# This is where you can implement the random color
func randomize_level_color():
	self.level_color = Color(0.172549019607843, 0.772549019607843, 0.964705882352941)


func randomize_characters():
	self._randomize_friend()
	self._randomize_peeps()


func back_to_title():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to(TITLE_SCENE)


func start_game():
	get_tree().change_scene_to(LEVEL_SCENE)


func next_level():
	self.level += 1
	self.num_peeps = self.level * 5
	get_tree().change_scene_to(LEVEL_SCENE)


func level_win(time):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	print("won in %s" % str(time))
	get_tree().change_scene_to(LEVEL_WIN_SCENE)


func level_lose():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to(LOSE_SCENE)


func _dir_contents(path: String) -> Array:
	var files = []
	
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name: String = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				var file_name_split: PoolStringArray = file_name.split(".")
				if file_name_split[len(file_name_split) - 1] != "import" and file_name != ".DS_Store":
					files.push_back("%s/%s" % [path, file_name])
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	return files


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
	var body: Sprite = character.get_node("Body")
	var arms: Sprite = character.get_node("Arms")
	var facial_hair: Sprite = character.get_node("FacialHair")
	var legs: Sprite = character.get_node("Legs")
	var head: Sprite = character.get_node("Head")
	var face: Sprite = character.get_node("Face")
	
	body.texture = body_image
	body.modulate = self.level_color
	
	arms.texture = arms_image
	arms.modulate = self.level_color
	
	face.texture = face_image
	
	facial_hair.texture = facial_hair_image
	
	legs.texture = legs_image
	legs.modulate = self.level_color
	
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
	body.modulate = self.level_color
	
	arms.texture = arms_image
	arms.modulate = self.level_color
	
	face.texture = face_image
	
	facial_hair.texture = facial_hair_image
	
	legs.texture = legs_image
	legs.modulate = self.level_color
	
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
		var character = peep.get_node("Character")
		var body: Sprite = character.get_node("Body")
		var arms: Sprite = character.get_node("Arms")
		var facial_hair: Sprite = character.get_node("FacialHair")
		var legs: Sprite = character.get_node("Legs")
		var head: Sprite = character.get_node("Head")
		var face: Sprite = character.get_node("Face")
		
		
		var body_image = load(body_images_copy[randi() % len(body_images_copy)])
		var arms_image = load(arms_images_copy[randi() % len(arms_images_copy)])
		var face_image = load(face_images_copy[randi() % len(face_images_copy)])
		var facial_hair_image = load(facial_hair_images_copy[randi() % len(facial_hair_images_copy)])
		var head_image = load(head_images_copy[randi() % len(head_images_copy)])
		var legs_image = load(legs_images_copy[randi() % len(legs_images_copy)])

		body.texture = body_image
		body.modulate = self.level_color
		
		arms.texture = arms_image
		arms.modulate = self.level_color
		
		face.texture = face_image
		
		facial_hair.texture = facial_hair_image
		
		legs.texture = legs_image
		legs.modulate = self.level_color
		
		head.texture = head_image

func _get_friend_facts():
	#Reset seed
	randomize()
	
	#randomly select facts
	var familyFact = familyFacts[randi() % familyFacts.size()]
	var hobbyFact = hobbyFacts[randi() % hobbyFacts.size()]
	var findFact = findFacts[randi() % findFacts.size()]
	
	print(familyFact)

func _ready():
	randomize()
