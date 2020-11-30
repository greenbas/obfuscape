extends Node

onready var promptData = $GameData

var IS_MULTIPLAYER = false

export(Dictionary) var RESOURCES 

var difficulty_modes = {}

var rng = RandomNumberGenerator.new()

enum game_types {ARITHMETIC,
				ROCK_PAPER_SCISSORS
				}
var game_type_length = game_types.keys().size()


onready var game_type_paths = {
	game_types.ARITHMETIC: RESOURCES.games.ARITHMETIC.resource_path,
	game_types.ROCK_PAPER_SCISSORS: RESOURCES.games.ROCK_PAPER_SCISSORS.resource_path
}

func _ready():
	get_tree().change_scene(RESOURCES.screens.Story_Screen.resource_path) 

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
var game_level = 0

var in_game: bool = false 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
