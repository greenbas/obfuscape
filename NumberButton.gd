extends Node2D

onready var TextLabel = get_node("Button/number")
onready var Btn = get_node("Button")
export var isDesiredResult = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal answer_ready(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	TextLabel.text = "3"
	Btn.connect("pressed",self,"_button_pressed")
	print(TextLabel)


func _button_pressed():
	emit_signal("answer_ready",isDesiredResult)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
