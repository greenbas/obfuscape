extends QueryGenerator

enum {ADD,SUB,MUL,DIV}
var operators = {ADD:'+',SUB:'-',MUL:'*',DIV:'/'}
var difficulty_mode = globals.difficulty_mode
var RANGE_LIMIT : int = -1

func set_difficulty_range() -> void: 
	match globals.difficulty_mode:
		globals.difficulty_modes.EASY:
			RANGE_LIMIT = 1
		globals.difficulty_modes.MEDIUM:
			RANGE_LIMIT = 3
		globals.difficulty_modes.HARD:
			RANGE_LIMIT = 3



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
	set_difficulty_range()
	var op1 #first operand
	var op2 #second operandro
	var res #result
	var false_res
	rng.randomize()
	var question_type : int = rng.randi_range(0,RANGE_LIMIT)
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
	var question = center_str(str(op1)+operators[question_type]+str(op2))
	globals.promptData.set_game_type(get_game_type())
	globals.promptData.set_prompt_data_question(question,center_str(res),center_str(false_res),coin_flip)
	emit_signal("call_finished")

