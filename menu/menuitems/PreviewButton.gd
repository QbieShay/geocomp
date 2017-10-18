extends TextureButton

var preview_image
var idx setget set_idx

onready var preview = get_node("../../../Preview")

func _ready():
	connect('pressed', self, 'on_click')

func on_click():
	if preview_image:
		preview.set_preview(preview_image)
	
func set_idx(i):
	idx = i
	# TODO set correct textures
	set_normal_texture(load('res://ui/img/BackBtn.png'))
	set_hover_texture(load('res://ui/img/BackBtn_Hover.png'))
	set_pressed_texture(load('res://ui/img/BackBtn_Pressed.png'))