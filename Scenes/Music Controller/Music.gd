extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var minuteArcade = preload("res://Assets/MinuteArcade.wav")
var minuteJungle = preload("res://Assets/MinuteJungle.wav")
var minuteTicker = preload("res://Assets/MinuteTicker.wav")
var minuteTrap = preload("res://Assets/MinuteTrap.wav")

var jazzInterlude = preload("res://Assets/JazzInterlude.wav")

var levelSongs = [minuteArcade, minuteJungle, minuteTicker, minuteTrap]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_music():
	$Music.stop()
	$Music.stream = jazzInterlude
	$Music.play()

func minutePlayer():
	
	$Music.stop()
	
	var randomSong = levelSongs[randi() % levelSongs.size()]
	$Music.stream = randomSong
	$Music.play()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
