extends TextureButton

var preview_image

onready var preview = get_node("../../Preview")

func _hover():
	preview.set_preview(preview_image)