tool
extends Button 
class_name SceneChangingButton


export(String, FILE) var next_scene_path: = ""

func change_scene():
	get_tree().change_scene(next_scene_path)

func _on_button_up():
	change_scene()
	
func _get_configuration_warning() -> String:
	return "next_scene_path must be set for the button to work" if next_scene_path == "" else ""
