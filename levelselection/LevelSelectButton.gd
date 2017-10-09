extends TextureButton

var idx

func init_btn(index):
	#TODO load texture
	idx = index

func _hover():
	get_node("../../LevelPreview").set_preview(idx)

func _click():
	#TODO load level
	pass