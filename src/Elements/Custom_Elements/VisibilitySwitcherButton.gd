tool
extends Button
class_name VisibilitySwitcherButton

export(NodePath) var container_to_activate : NodePath

onready var container_node = get_node(container_to_activate)
onready var parent_node = get_parent()


func _on_button_up():
	parent_node.visible = false
	container_node.visible = true

func _get_configuration_warning() -> String: 
	return "node not selected" if container_to_activate.is_empty() else "" 
