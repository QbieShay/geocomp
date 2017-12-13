extends TextureButton

var preview_image
var idx setget set_idx

onready var preview = get_node("../../../Preview")

func _ready():
	if !is_connected('pressed', self, 'on_click'):
		connect('pressed', self, 'on_click')
	set_normal_texture(load('res://menu/menuitems/img/Selector_Normal.png'))
	set_hover_texture(load('res://menu/menuitems/img/Selector_Hover.png'))
	set_pressed_texture(load('res://menu/menuitems/img/Selector_Pressed.png'))

func on_click():
	if preview_image:
		preview.set_preview(preview_image)
	
func set_idx(i):
	idx = i