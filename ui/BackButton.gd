extends TextureButton

const Utils = preload ("res://Utils.gd")

func _click():
	get_node(Utils.name_from_root("SceneManager")).load_prev_scene()