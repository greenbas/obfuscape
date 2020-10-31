extends Node2D
class_name Game

var type : String = "GenericGame" setget set_game_type, get_game_type

var g = globals
var GameData = g.promptData

func set_game_type(value:String): type = value

func get_game_type() -> String: return type



signal player_complete(result)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_Timer_timeout():
	emit_signal("player_complete",false)
