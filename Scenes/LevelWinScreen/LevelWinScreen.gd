extends Node2D

const CHARACTER_SCENE = preload("res://Scenes/Character/Character.tscn")


func _ready():
	
	MusicScene.play_music()
	
	
	var friend_preview: Character = CHARACTER_SCENE.instance()
	var body: Sprite = friend_preview.get_node("Body")
	var arms: Sprite = friend_preview.get_node("Arms")
	var facial_hair: Sprite = friend_preview.get_node("FacialHair")
	var legs: Sprite = friend_preview.get_node("Legs")
	var head: Sprite = friend_preview.get_node("Head")
	var face: Sprite = friend_preview.get_node("Face")
	
	body.texture = Global.friend_body
	body.modulate = Global.level_color
	
	arms.texture = Global.friend_arms
	arms.modulate = Global.level_color
	
	face.texture = Global.friend_face
	
	facial_hair.texture = Global.friend_facial_hair
	facial_hair.modulate = Global.level_color.contrasted()
	
	legs.texture = Global.friend_legs
	legs.modulate = Global.level_color
	
	head.texture = Global.friend_head
	
	friend_preview.scale = Vector2(-4, 4)
	friend_preview.should_idle = false
	$FriendPreview.add_child(friend_preview)
	friend_preview.global_position = $FriendPreview.global_position


func _on_NextLevelButton_pressed():
	Global.next_level()
