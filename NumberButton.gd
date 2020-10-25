extends Node2D

onready var TextLabel = get_node("Button/number")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	TextLabel.text = "3"
	print(TextLabel)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
