extends TextureButton

onready var label = get_node("Label")

var correctness : bool setget set_correctness,get_correctness

func set_correctness(val : bool):
	correctness = val;
	
func get_correctness() -> bool:
	return correctness

signal answer_ready(value)

func _ready():
	self.connect("pressed",self,"_button_pressed")

func set_text(text):
	label.set_bbcode(text)

func _button_pressed():
	emit_signal("answer_ready",correctness)

