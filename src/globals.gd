extends Node

onready var promptData = $GameData


var rng = RandomNumberGenerator.new()

enum game_types {ARITHMETIC,
				ROCK_PAPER_SCISSORS
				}
var game_type_length = game_types.keys().size()
var game_type_paths = {
	game_types.ARITHMETIC: 'res://src/Games/Arithmetic_Game/Arithmetic_game_sub.tscn',
	game_types.ROCK_PAPER_SCISSORS: 'res://src/Games/Arithmetic_Game/Arithmetic_game_sub.tscn'
}

enum difficulty_modes {
	EASY,
	MEDIUM,
	HARD
}

func get_all_game_data():
	promptData.get_all_data()

func get_desired_flag() -> bool:
	return promptData.get_desired_flag()

func xnor(a : bool,b: bool) -> bool: return (a && b) || (!a && !b) 
func xor(a: bool,b:bool) -> bool: return !xnor(a,b)

var difficulty_mode = -1;
var timer_start_value : float



var score = 0;
var lives = 4;


var in_game: bool = false 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
