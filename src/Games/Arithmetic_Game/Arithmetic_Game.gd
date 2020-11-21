extends Game

onready var ControlContainer = $Control
onready var QuestionLabel = get_node("Control/Question")
onready var AnswerL = get_node("Control/AnswerL")
onready var AnswerR = get_node("Control/AnswerR")
export var red_box : Texture
export var green_box : Texture
var answer_result : bool



func _init():

	set_game_type(globals.game_types.ARITHMETIC)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	ControlContainer.visible = true;
	AnswerL.disabled = false
	AnswerR.disabled = false
	var pData = GameData.prompt_data
	var dFlag : bool = GameData.desired_flag
	QuestionLabel.text = pData.question
	AnswerL.set_text(str(pData.L.val)) 
	AnswerL.set_correctness(pData.L.flag)
	AnswerR.set_text(str(pData.R.val))
	AnswerR.set_correctness(pData.R.flag)
	AnswerL.connect("answer_ready",self,"_on_player_answer")
	AnswerR.connect("answer_ready",self,"_on_player_answer")
	if dFlag:
		QuestionLabel.set_texture(green_box)
	else: 
		QuestionLabel.set_texture(red_box)
	game_timer.start(globals.timer_start_value)


func _on_player_answer(value):
	game_timer.stop()
	AnswerL.disabled = true
	AnswerR.disabled = true
	var answer_result = g.xnor(value,GameData.desired_flag)
	emit_signal("player_complete",answer_result)

func _on_Timer_timeout():
	print("TIMEOUT")
	game_timer.stop();
	AnswerL.disabled = true
	AnswerR.disabled = true
	emit_signal("player_complete",false)