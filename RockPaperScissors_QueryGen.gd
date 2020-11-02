extends QueryGenerator

const SYMBOLS_NUMBER : int = 3

enum {ROCK,PAPER,SCISSORS}
var symbols = {ROCK:'R',PAPER:'P',SCISSORS:'S'}
var names = {ROCK:'Rock',PAPER:'Paper',SCISSORS:'Scissors'}

var rps_games = [
	{"when":ROCK,"lose":PAPER,"win":SCISSORS},
	{"when":PAPER,"lose":SCISSORS,"win":ROCK},
	{"when":SCISSORS,"lose":ROCK,"win":PAPER}
]



func generate_false_answer(x : int) -> int:
	var offset = rng.randi_range(0,19)
	#ensure false_res is never offset by 0
	if(offset < 10):
		return x + offset - 10
	else: 
		return x + offset - 9

func _init():
	set_game_type(game_types.ROCK_PAPER_SCISSORS)
	
func generate_query():
	var rps_game_number = globals.rng.randi_range(0,SYMBOLS_NUMBER - 1)
	var coin_flip = bool(globals.rng.randi_range(0,255) & 1)
	
	var gData = rps_games[rps_game_number]
	
	var question_string = center_str("Which Beats " + names[gData.when] + "?")
	var __L
	var __R
	if(coin_flip):
		__L = format_answer(symbols[gData.lose],false)
		__R = format_answer(symbols[gData.win],true)
	else:
		__R = format_answer(symbols[gData.lose],false)
		__L = format_answer(symbols[gData.win],true)
	query_data = {
		"desired_flag": globals.promptData.desired_flag,
		"game_type": get_game_type(),
		"prompt_data": {
			"question": question_string,
			"L": __L,
			"R": __R
		}
	}
	emit_signal("call_finished")



