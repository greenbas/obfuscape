extends Node2D

var g = globals
var game_types = g.game_types
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal query_request(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ArithmeticQueryGen_query_generated():
	print("loading game...") # Replace with function body.


func _on_Button_pressed():
	emit_signal("query_request",game_types.ARITHMETIC)
