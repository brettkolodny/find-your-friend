extends HTTPRequest


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("request_completed", self, "_on_request_completed")
	self.request("https://tmi.twitch.tv/group/user/moonmoon/chatters")
	pass # Replace with function body.

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	#print(json.chatters.viewers)
	pass # Replace with function body.
