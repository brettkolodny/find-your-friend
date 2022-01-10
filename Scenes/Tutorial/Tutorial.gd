extends Node2D

func _on_FriendPreviewTutorial_mouse_entered():
	$PreviewCardTutorial.visible = false
	$ZoomTutorial.visible = true
	$Level/FriendPreviewTutorial/CollisionShape2D.disabled = true


func _process(delta):
	if Input.is_action_just_pressed("ui_right_click"):
		$ZoomTutorial.visible = false
		$Level/FindFriendTutorial/FindFriendTutorialInstructions.visible = true
	elif Input.is_action_just_released("ui_right_click"):
		$ZoomTutorial.visible = true
		$Level/FindFriendTutorial/FindFriendTutorialInstructions.visible = false
