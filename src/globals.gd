extends Node

var rng = RandomNumberGenerator.new()

enum game_types {ARITHMETIC,ROCK_PAPER_SCISSORS}


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

func xnor(a : bool,b: bool) -> bool: return (a && b) || (!a && !b) 
func xor(a: bool,b:bool) -> bool: return !xnor(a,b)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
