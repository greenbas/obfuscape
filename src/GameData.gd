extends Node
class_name GameData

export var desired_flag : bool = true setget set_desired_flag, get_desired_flag
export var game_type : int = 0 setget set_game_type,get_game_type
export var prompt_data : Dictionary = {"question":"2+7=","L": { "val":"2","flag":false},"R": {"val":"9","flag":true}} setget set_prompt_data,get_prompt_data

func set_desired_flag(val:bool) -> void:
	desired_flag = val

func get_desired_flag() -> bool:
	return desired_flag
	
func flip_desired_flag() -> void:
	desired_flag = !desired_flag

func get_game_type() -> int:
	return game_type

func set_game_type(val: int):
	game_type = val

func get_prompt_data() -> Dictionary:
	return prompt_data
	
func set_prompt_data(val:Dictionary):
	prompt_data = val

func set_prompt_data_question(question:String,right_answer:String,wrong_answer:String,flipped:bool):
	var right_answer_dict = {"val":right_answer,"flag":true}
	var wrong_answer_dict = {"val":wrong_answer,"flag":false}
	if(flipped):
		set_prompt_data({"question":question,"L":wrong_answer_dict,"R":right_answer_dict})
	else:
		set_prompt_data({"question":question,"L":right_answer_dict,"R":wrong_answer_dict})

func get_all_data() -> Dictionary:
	return {
		"desired_flag": desired_flag,
		"game_type": game_type,
		"prompt_data": prompt_data
	}
