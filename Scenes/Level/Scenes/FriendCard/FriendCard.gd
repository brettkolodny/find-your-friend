extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.modulate.a = 0.8


func _on_Area2D_mouse_entered():
	print("mouse enter")
	self.modulate.a = 1.0


func _on_Area2D_mouse_exited():
	print("mouse exit")
	self.modulate.a = 0.8
