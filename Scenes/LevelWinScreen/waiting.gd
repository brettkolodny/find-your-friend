tool
extends RichTextEffect
class_name RichTextWait

var bbcode := "wait"
export var current_char: int = 0

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var waitTime: float = char_fx.env.get("time", 1.0)
	var speed: float = char_fx.env.get("speed", 8.0)

	if char_fx.elapsed_time > waitTime:
		char_fx.visible = false
		if float(char_fx.elapsed_time) > ( (float(char_fx.absolute_index) / speed) + float(waitTime) ):
			char_fx.visible = true
	else:
		char_fx.visible = false
	return true
