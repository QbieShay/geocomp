extends TextureButton

export var scene_to_load = ""

var Utils = preload("res://Utils.gd")

func _click():
	assert(scene_to_load.length() > 0)
	get_node(Utils.name_from_root("SceneManager")).set_main_scene(scene_to_load)