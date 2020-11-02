extends Node

var rng = RandomNumberGenerator.new()

enum game_types {ARITHMETIC,
				ROCK_PAPER_SCISSORS
				}
var game_type_length = game_types.keys().size()
var game_type_paths = {
	game_types.ARITHMETIC: 'res://src/Games/Arithmetic_Game/Arithmetic_game_sub.tscn',
	game_types.ROCK_PAPER_SCISSORS: 'res://src/Games/Arithmetic_Game/Arithmetic_game_sub.tscn'
}


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func flip_desired_flag() -> void:
	promptData["desired_flag"] = !promptData["desired_flag"]

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

var score = 0;
var lives = 4;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
