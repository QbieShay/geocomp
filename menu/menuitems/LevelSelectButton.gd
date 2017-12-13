extends 'PreviewButton.gd'

const Utils = preload('res://Utils.gd')

onready var label = get_node('../../../Label')

func _ready():
	if !is_connected('pressed', self, 'on_click'):
		connect('pressed', self, 'on_click')
	if !is_connected('mouse_enter', self, 'on_hover'):
		connect('mouse_enter', self, 'on_hover')
	set_default_cursor_shape(CURSOR_POINTING_HAND)
	
func on_click():
	get_node(Utils.name_from_root('SceneManager')).set_main_scene(
		'res://game/Level.tscn').load_level(idx)

func on_hover():
	preview.set_preview(preview_image)
	label.update_label(idx - 1)
		
func set_idx(i):
	.set_idx(i)
	get_node("Label").set_text(str(i))
	preview_image = "res://menu/menuitems/img/level_preview/LevelPreview_" + str(idx - 1) + ".png"