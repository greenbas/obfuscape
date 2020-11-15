extends Node2D
class_name Game

var type : int = -1 setget set_game_type, get_game_type

var g = globals
var GameData = g.promptData.get_all_data()
onready var game_timer = get_node("Timer")
onready var timer_bar = $"Timer Bar"

func set_game_type(value:int): type = value

func get_game_type() -> int: return type



signal player_complete(result)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





