extends 'PreviewButton.gd'

const Utils = preload('res://Utils.gd')

var level_idx setget set_level_idx

func _click():
	get_node(Utils.name_from_root('SceneManager')).set_main_scene(
		'res://game/Level.tscn').load_level(level_idx)
	
func set_level_idx(idx):
	level_idx = idx
	preview_image = "res://menu/menuitems/img/level_preview/LevelPreview_" + str(idx) + ".png"
