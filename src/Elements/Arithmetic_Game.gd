extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var QuestionData = get_node("/root/PromptData")

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
	var pData = QuestionData.promptData.prompt_data
	QuestionLabel.text = pData.question
	AnswerL.text.text = str(pData.L.val)
	AnswerR.text.text = str(pData.R.val)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
