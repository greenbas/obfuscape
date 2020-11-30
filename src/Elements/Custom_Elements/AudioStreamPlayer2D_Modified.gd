extends AudioStreamPlayer2D
class_name AudioStreamPlayer2D_Modified


signal sfinished(name)

func _ready():
	var k = self
	connect("finished",k,"_on_finished")
	connect("sfinished",get_parent(),"_forward_finished_signal", [ self.name ])

func _on_finished():
	print("FINISHED!")
	emit_signal("sfinished")
