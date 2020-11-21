extends QueryGenerator

const SYMBOLS_NUMBER : int = 3

enum {ROCK,PAPER,SCISSORS}
var symbols = {ROCK:'[img=60x60]res://src/Games/RPS_Game/icon/pixel_rock.svg[/img]',
				PAPER:'[img=60x60]res://src/Games/RPS_Game/icon/pixel_paper.svg[/img]',
				SCISSORS:'[img=60x60]res://src/Games/RPS_Game/icon/pixel_scissor.svg[/img]'}
var names = {ROCK:'Rock',PAPER:'Paper',SCISSORS:'S'}

var rps_games = [
	{"when":ROCK,"lose":PAPER,"win":SCISSORS},
	{"when":PAPER,"lose":SCISSORS,"win":ROCK},
	{"when":SCISSORS,"lose":ROCK,"win":PAPER}
]




func _init():
	set_game_type(game_types.ROCK_PAPER_SCISSORS)
	
func generate_query():
	var rps_game_number = globals.rng.randi_range(0,SYMBOLS_NUMBER - 1)
	var roll_d4 = globals.rng.randi_range(0,255) & 3
	var desired_outcome = bool((roll_d4 >> 1) & 1);
	var answer_flip = bool(roll_d4 & 1)
	var gData = rps_games[rps_game_number]
	globals.promptData.set_game_type(get_game_type())
	if desired_outcome:
		var question_string = center_str("Which Beats %s?" % symbols[gData.when])
		globals.promptData.set_prompt_data_question(question_string,symbols[gData.lose],symbols[gData.win],answer_flip)
	else: 
		var question_string = center_str("Which Loses to %s?" % symbols[gData.when])
		globals.promptData.set_prompt_data_question(question_string,symbols[gData.win],symbols[gData.lose],answer_flip)
	print(str(rps_game_number) + " " + names[gData.when])
	emit_signal("call_finished")



