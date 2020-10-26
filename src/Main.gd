extends Node2D

onready var gData = get_node("/root/PromptData")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print(gData.promptData.prompt_data)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
