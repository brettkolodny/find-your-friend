extends Node2D

func _ready():
	MusicScene.play_music()
	pass

func _on_TextureButton_pressed():
	Global.start_game()
	
