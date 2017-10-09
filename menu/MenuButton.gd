extends TextureButton

var Utils = preload("res://Utils.gd")
export var scene_to_load = ""

func _click():
	get_node(Utils.name_from_root("SceneManager")
		).set_main_scene(scene_to_load)