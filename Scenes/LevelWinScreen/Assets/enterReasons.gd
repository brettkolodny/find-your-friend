extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var minute = 1;
var second = 30;

# Called when the node enters the scene tree for the first time.
func _ready():
	self.owner.get_child(5).get_child(0).visible = true
	self.owner.get_child(5).get_child(0).In(1.5)
	#$"."/Transition/Changer.visible = true
	#$"."/Transition/Changer.In(1.5)
	#$Transition/Changer.visible = true
	#$Transition/Changer.In(1.5)
	
	$"../HTTPRequest".connect("request_completed", self, "_on_request_completed")
	$"../HTTPRequest".request("https://tmi.twitch.tv/group/user/moonmoon/chatters")

#	Global.get_friend_facts()
#
#	var tempString = "[font=res://Scenes/LevelWinScreen/Assets/freshImportFont.tres][wait time=1][color=black]You found your friend in[wait time=2] [color=#CE80D9]%.f second(s)[/color].[wait time=3] Your friend %s.[wait time=4]Your friend enjoyed %s.[wait time=5] You really wanted to be their friend because they [color=red]%s[/color].[/wait]"
#	tempString = tempString % [60 - Global.winTime, Global.familyFact, Global.hobbyFact, Global.findFact]
#	self.bbcode_text = tempString


func _on_Button_pressed():
	#Go to new scene?
	pass # Replace with function body.


func _on_TextureButton_pressed():
	self.owner.get_child(5).get_child(0).visible = true
	self.owner.get_child(5).get_child(0).Out(1.5)
	pass # Replace with function body.


func _on_Changer_outro_finished():	
	Global.next_level()
	pass # Replace with function body.


func _on_Changer_intro_finished():
	self.owner.get_child(5).get_child(0).visible = false
	pass # Replace with function body.


func _on_request_completed(result, response_code, headers, body):
	Global.get_friend_facts()
	
	if (response_code != 200): 
		var tempString = "[font=res://Scenes/LevelWinScreen/Assets/freshImportFont.tres][wait time=1][color=black]You found your friend in[wait time=2] [color=#CE80D9]%.f second(s)[/color].[wait time=3] Your friend %s.[wait time=4]Your friend enjoyed %s.[wait time=5] You really wanted to be their friend because they [color=red]%s[/color].[/wait]"
		tempString = tempString % [60 - Global.winTime, Global.familyFact, Global.hobbyFact, Global.findFact]
	
		self.bbcode_text = tempString
		return
	
	var json = JSON.parse(body.get_string_from_utf8())
	var viewers = json.result.chatters.viewers
	
	var friend_name = viewers[randi() % len(viewers)]
	
	var tempString = "[font=res://Scenes/LevelWinScreen/Assets/freshImportFont.tres][wait time=1][color=black]You found your friend, %s in[wait time=2] [color=#CE80D9]%.f second(s)[/color].[wait time=3] Your friend %s.[wait time=4]Your friend enjoyed %s.[wait time=5] You really wanted to be their friend because they [color=red]%s[/color].[/wait]"
	tempString = tempString % [friend_name, 60 - Global.winTime, Global.familyFact, Global.hobbyFact, Global.findFact]
	self.bbcode_text = tempString
