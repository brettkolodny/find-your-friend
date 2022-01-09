extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var minute = 1;
var second = 30;

var family = ["had a wife and 2 kids",
		"had a wife and 2 kids who now have no breadwinner",
		"had a wife and 2.5 kids",
		"had a ex-wife who will be overjoyed at them being [i]found[/i]",
		"had a loving husband of 3 year",
		"was a turbo virgin",
		"had a husband and a kid on the way",
		"had a husband and 2 kids",
		"had a collection of body pillows instead of human connections",
		"had no human contact beyond the League of Legends community"
]

var hobby = ["rock climbing",
		"doing crosswords",
		"to live, laugh, and love",
		"watching Twitch.tv",
		"listening to Daytona",
		"listening to choice picks from the Lisa OST",
		"listening to the John Souls - Magnificent Demon on their commute",
		"unironically listening to Gachi music"
]

var found = ["spammed NAM",
		"subbed to Forsen",
		"smiled when Pokemain was banned",
		"radicalized Markov Bot",
		"posted Elf Tits",
		"was a Prime Pleb",
		"failed the FitnessGram™ Pacer Test",
		"didn’t play Morrowind",
		"wrote Attack on Titan vore fan fiction",
		"didn’t like Gura",
		"@’ed the streamer with hints they didn’t ask for ",
		"filmed themself at the gym",
		"didn’t return the shopping cart",
		"kicked an ice cube under the fridge",
		"microwaved cold brew coffee",
		"tried to go to the bathroom during their warehouse shif"
]


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	var familyInfo = family[randi() % family.size()]
	var hobbyInfo = hobby[randi() % hobby.size()]
	var foundInfo = found[randi() % found.size()]
	var tempString = "[font=res://Scenes/LevelWinScreen/Assets/freshImportFont.tres][wait time=1][color=black]You found your friend in[wait time=2] [color=#CE80D9]%.f minute(s) and %.f second(s)[/color].[wait time=3] Your friend %s.[wait time=4]They enjoyed %s.[wait time=5] You really wanted to be their because they [color=red]%s[/color]."
	tempString = tempString % [minute, second, familyInfo, hobbyInfo, foundInfo]
	self.bbcode_text = tempString
	print(tempString)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	print("Pressed")
	pass # Replace with function body.
