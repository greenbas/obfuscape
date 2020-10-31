extends Button

var correctness : bool setget set_correctness,get_correctness
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func set_correctness(val : bool):
	correctness = val;
	
func get_correctness() -> bool:
	return correctness

signal answer_ready(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("pressed",self,"_button_pressed")


func _button_pressed():
	emit_signal("answer_ready",correctness)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
