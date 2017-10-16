extends 'PreviewButton.gd'

const Utils = preload('res://Utils.gd')
	
func _ready():
	connect('pressed', self, 'on_click')
	
func on_click():
	get_node(Utils.name_from_root('SceneManager')).set_main_scene(
		'res://game/Level.tscn').load_level(idx)
		
func set_idx(i):
	.set_idx(i)
	preview_image = "res://menu/menuitems/img/level_preview/LevelPreview_" + str(idx - 1) + ".png"