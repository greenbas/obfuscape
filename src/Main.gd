extends Node2D

onready var game_node = get_node("Game Layer/Game")
onready var camera = get_node("Camera2D")
var rng = globals.rng
var number_of_games = globals.game_type_length
var game_paths = globals.game_type_paths
var game_index = 0

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	var parent = game_node.get_parent()
	
	game_node.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	game_node = s.instance()

	# Add it to the active scene, as child of root.
	parent.add_child(game_node) 
	
	game_node.connect("player_complete",self,"_on_Game_player_complete")




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

signal game_loaded()
func _on_query_generated():
	print("loading game...") # Replace with function body.
	goto_scene(game_paths[game_index])
	emit_signal("game_loaded")


func _on_Button_pressed():
	get_node("Button").hide()
	#camera.
	start_game()
	
func start_game():
	var flag_changer = !bool(globals.rng.randi_range(0,7))
	if(!flag_changer):
		globals.flip_desired_flag()
	game_index = rng.randi_range(0,number_of_games - 1)
	print(game_index)
	emit_signal("query_request",game_index)	


func _on_Game_player_complete(result):
	if(result):
		globals.score += 1
		print("Victory!")
		print("score: " + str(globals.score))
	else:
		globals.lives -= 1
		print("fail")
		print("lives: " + str(globals.lives))
	if globals.lives > 0:
		start_game()
	pass # Replace with function body.




func _on_tree_entered():
	start_game()
	pass
