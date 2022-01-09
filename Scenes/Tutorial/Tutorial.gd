extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_FriendPreviewTutorial_mouse_entered():
	$PreviewCardTutorial.visible = false
	$ZoomTutorial.visible = true
	$Level/FriendPreviewTutorial/CollisionShape2D.disabled


func _process(delta):
	if Input.is_action_just_pressed("ui_right_click"):
		$ZoomTutorial.visible = false
		$Level/FindFriendTutorial/FindFriendTutorialInstructions.visible = true
	elif Input.is_action_just_released("ui_right_click"):
		$ZoomTutorial.visible = true
		$Level/FindFriendTutorial/TextureRect.visible = false
