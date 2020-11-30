extends Node2D
class_name AudioLibrary2D

signal finished(filename)

var playing : bool setget ,get_playing

var is_playing : bool = false


func get_playing() -> bool:
	for child in get_children():
		if child.playing: return true
	return false

	
func play(sfx = null):
	if sfx:
		get_node(sfx).play()
		is_playing = true;
	else: 
		var c = randi()%get_child_count()
		var child = get_child(c)
		child.play()
		is_playing = true
		

func stop(sfx = null):
	if !sfx:
		for child in get_children():
			if child.playing: child.stop()
	else: 
		get_node(sfx).stop()


func _forward_finished_signal(filename : String):
	print("FOREWARDED FINISHED")
	emit_signal("finished")
