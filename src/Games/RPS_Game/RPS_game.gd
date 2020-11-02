extends Game

onready var QuestionLabel = get_node("Question")
onready var AnswerL = get_node("AnswerL")
onready var AnswerR = get_node("AnswerR")


func _init():
	set_game_type(globals.game_types.ROCK_PAPER_SCISSORS)


func _ready():
	var pData = GameData.prompt_data
	QuestionLabel.text = pData.question
	AnswerL.set_text(str(pData.L.val)) 
	AnswerL.set_correctness(pData.L.flag)
	AnswerR.set_text(str(pData.R.val))
	AnswerR.set_correctness(pData.R.flag)
	AnswerL.connect("answer_ready",self,"_on_player_answer")
	AnswerR.connect("answer_ready",self,"_on_player_answer")
	game_timer.start(3.0)


func _on_player_answer(value):
	emit_signal("player_complete",g.xnor(value,GameData.desired_flag))
	game_timer.stop()


