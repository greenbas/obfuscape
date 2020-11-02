extends Node
class_name QueryGenerator

var game_type : int setget set_game_type,get_game_type
var query_data = {}

func center_str(val) -> String:
	return "[center]" + str(val) + "[/center]"

func format_answer(val,flag):
	return {"val":center_str(val),"flag":flag}

func set_game_type(value: int): game_type = value
func get_game_type() -> int: return game_type

var g = globals
var rng = g.rng
var game_types = g.game_types

signal query_generated()
signal call_finished()
func _on_query_requested(value): 
	if value != game_type:
		pass
	else:
		call_deferred("generate_query")
		yield(self,"call_finished")
		g.promptData = query_data
		emit_signal("query_generated")

func _ready():
	pass 


