extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


export var promptData : Dictionary = {
	"desired_flag": false,
	"game_type":"arithmetic",
	"prompt_data": {
		"question":"2+7=",
		"L": { 
			"val":"2",
			"flag":false
		},
		"R": {
			"val":"9",
			"flag":true
		}
	}
}


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
