extends TextureRect
onready var label = get_node("Label")
export var text : String setget set_text,get_text

func set_text(value : String):
	text = value;
	label.set_bbcode(value)
	
func get_text() -> String: 
	return text 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#synchronize the label's value
	set_text(label.get_text())
	print(get_text())



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
