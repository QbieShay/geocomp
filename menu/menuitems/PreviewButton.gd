extends TextureButton

var preview_image
var idx setget set_idx

onready var preview = get_node("../../Preview")

func _ready():
	connect('mouse_enter', self, 'on_hover')	
	
func on_hover():
	preview.set_preview(preview_image)
	
func set_idx(i):
	idx = i
	# TODO set_normal_texture(i)
	set_normal_texture(load('res://ui/img/BackBtn.png'))