extends Game


func _init():
	set_game_type(globals.game_types.ARITHMETIC)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
onready var QuestionLabel = get_node("Question")

onready var AnswerL = get_node("AnswerL")
onready var AnswerR = get_node("AnswerR")


# Called when the node enters the scene tree for the first time.
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
