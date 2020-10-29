extends Node2D
class_name Game

const type : String = "GenericGame"

onready var g = get_node("/root/globals")
onready var GameData = g.promptData


signal player_complete(result)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


