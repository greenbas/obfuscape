extends QueryGenerator

enum {ADD,SUB,MUL,DIV}
var operators = {ADD:'+',SUB:'-',MUL:'*',DIV:'/'}

func generate_false_answer(x : int) -> int:
	var offset = rng.randi_range(0,19)
	#ensure false_res is never offset by 0
	if(offset < 10):
		return x + offset - 10
	else: 
		return x + offset - 9

func _init():
	set_game_type(game_types.ARITHMETIC)
	
func generate_query():
	var op1 #first operand
	var op2 #second operand
	var res #result
	var false_res
	rng.randomize()
	var question_type : int = rng.randi_range(0,3)
	op1 = rng.randi_range(1,10)
	op2 = rng.randi_range(1,10)
	match question_type:
		ADD:
			res = op1 + op2
		SUB:
			res = op1 - op2
		MUL:
			res = op1 * op2
		DIV:
			#let's avoid sticky floating point numbers by changing up how these questions are generated, shall we?
			res = op1
			op1 = op2 * res
	false_res = generate_false_answer(res)
	var coin_flip = bool(rng.randi_range(0,255) | 1)
	query_data = {
		"desired_flag": globals.promptData.desired_flag,
		"game_type": get_game_type(),
		"prompt_data": {
			"question": center_str(str(op1)+operators[question_type]+str(op2)),
			"L": {},
			"R": {}
		}
	}
	if(coin_flip):
		query_data.prompt_data["L"] = {"val":center_str(res),"flag":true}
		query_data.prompt_data["R"] = {"val":center_str(false_res),"flag":false}
	else:
		query_data.prompt_data["L"] = {"val":center_str(false_res),"flag":false}
		query_data.prompt_data["R"] = {"val":center_str(res),"flag":true}		
	emit_signal("call_finished")

