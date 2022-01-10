extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	var tempString = "[font=res://Scenes/LevelWinScreen/Assets/freshImportFont.tres][wait time=1][color=black]Aww man you didn't find your friend. [wait time=2]Better luck next time!"
	
	self.bbcode_text = tempString
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	Global.next_level()
	pass # Replace with function body.
