tool
extends Node2D


var STARTING_LIVES  := -1
var FLIP_FRICTION   := -1 
var TIMER_MAX_VALUE := -0.1
var TIMER_MIN_VALUE := -0.1
var TIMER_GAP = -0.1



onready var game_node = get_node("Game Layer Node/Game Layer/Game")
onready var camera = get_node("Camera2D")
onready var correct_icon = get_node("CanvasLayer/Correct Icon")
onready var wrong_icon = get_node("CanvasLayer/Wrong Icon")
var TickTockBG : AudioLibrary2D
onready var SFX = globals.get_node("sfx")

var rng = globals.rng
var number_of_games = globals.game_type_length
var game_paths = globals.game_type_paths
var game_index = 0
var remaining_turns = 0;


#var correct_sfx = load(globals.RESOURCES.sounds.Correct_Sound.resource_path)
#var wrong_sfx   = load(globals.RESOURCES.sounds.Wrong_Sound.resource_path)

func goto_scene(path) -> void:
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path) -> void:
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
	TickTockBG = get_node("TickTockBG")
	pass


func init_starting_variables() -> void:
	match globals.difficulty_mode:
		globals.difficulty_modes.EASY:
			STARTING_LIVES = 4
			FLIP_FRICTION = 4
			TIMER_MAX_VALUE = 4.0
			TIMER_MIN_VALUE = 3.0
		globals.difficulty_modes.MEDIUM:
			STARTING_LIVES = 4
			FLIP_FRICTION = 4
			TIMER_MAX_VALUE = 3.0
			TIMER_MIN_VALUE = 2.5 
		globals.difficulty_modes.HARD:
			STARTING_LIVES = 1 
			FLIP_FRICTION = 2
			TIMER_MAX_VALUE = 2.5
			TIMER_MIN_VALUE = 1.5
	TIMER_GAP = (TIMER_MAX_VALUE - TIMER_MIN_VALUE)/4


signal game_loaded()
func _on_query_generated():
	print("loading game...") # Replace with function body.
	goto_scene(game_paths[game_index])
	emit_signal("game_loaded")

	
func start_game():
	if(!globals.in_game):
		init_starting_variables()
		TickTockBG = get_node("TickTockBG")
		globals.score = 0
		globals.lives = STARTING_LIVES
		globals.timer_start_value = TIMER_MAX_VALUE
		globals.in_game = true
		if globals.IS_MULTIPLAYER:
			remaining_turns = rng.randi_range(3,5)
			globals.lives = 1
		globals.game_level = 20
	var flag_changer = !bool(globals.rng.randi_range(0,FLIP_FRICTION))
	if(flag_changer):
		globals.promptData.flip_desired_flag()
	game_index = rng.randi_range(0,number_of_games - 1)
	print(game_index)
	emit_signal("query_request",game_index)	
	TickTockBG.play(str(globals.game_level))


func _on_Game_player_complete(result):
	TickTockBG.stop()
	if(result):
		globals.score += 1
		if globals.score % 3 == 0 && globals.timer_start_value > TIMER_MIN_VALUE:
			globals.timer_start_value -= 0.1
			var temp : float = globals.timer_start_value - TIMER_MIN_VALUE
			globals.game_level = ceil(temp/TIMER_GAP)*5
			if globals.game_level < 5: 
				globals.game_level = 5
			if globals.game_level > 20: 
				globals.game_level = 20
		correct_icon.visible = true
		SFX.play("correct")
		yield(SFX,"finished")
		correct_icon.visible = false
		print("Victory!")
		print("score: " + str(globals.score))
	else:
		globals.lives -= 1
		wrong_icon.visible = true
		SFX.play("wrong")
		yield(SFX,"finished")
		wrong_icon.visible = false
		print("fail")
		print("lives: " + str(globals.lives))
	if globals.lives > 0:
		if globals.IS_MULTIPLAYER:
			remaining_turns -= 1
			if remaining_turns == 0:
				game_node.visible = false
				$CanvasLayer/CanvasLayer/PassLabel.visible = true
				SFX.play("passgame")
				yield(SFX,"finished")
				$CanvasLayer/CanvasLayer/PassLabel.visible = false
				game_node.visible = true
				remaining_turns = rng.randi_range(3,5)
		start_game()
	else: 
		game_over()
	pass # Replace with function body.

func game_over() -> void:
	globals.in_game = false
	globals.IS_MULTIPLAYER = false
	get_tree().change_scene(globals.RESOURCES.screens.Game_Over_Screen.resource_path)
	pass

func _on_tree_entered():
	start_game()
	pass
