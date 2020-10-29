extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var Globals = get_node("/root/globals")

onready var QuestionLabel = get_node("Question")

onready var AnswerL = {
	"elem": get_node("AnswerL"),
	"button": get_node("AnswerL/Button"),
	"text": get_node("AnswerL/Button/number")
}
onready var AnswerR = {
	"elem": get_node("AnswerR"),
	"button": get_node("AnswerR/Button"),
	"text": get_node("AnswerR/Button/number")
}


# Called when the node enters the scene tree for the first time.
func _ready():
	var pData = Globals.promptData.prompt_data
	QuestionLabel.text = pData.question
	AnswerL.text.text = str(pData.L.val)
	AnswerL.elem.isDesiredResult = pData.L.flag
	AnswerR.text.text = str(pData.R.val)
	AnswerR.elem.isDesiredResult = pData.R.flag
	AnswerL.elem.connect("answer_ready",self,"_on_player_answer")
	AnswerR.elem.connect("answer_ready",self,"_on_player_answer")

signal player_complete(result)

func _on_player_answer(value):
	print(value)
	var f1 = value && Globals.promptData.desired_flag
	var f2 = !value && !Globals.promptData.desired_flag
	print(f1 || f2)
	emit_signal("player_complete",f1 || f2)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
