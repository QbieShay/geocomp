extends 'ButtonsPreviewScene.gd'

const LevelSelectButton = preload("LevelSelectButton.tscn")
const Level = preload('res://game/Level.gd')

func _ready():
	var container = get_node("ButtonGroup/ButtonsContainer")
	for i in range(Level.N_LEVELS):
		var lvl = LevelSelectButton.instance()
		lvl.idx = i + 1
		container.add_child(lvl)
		if i == 0:
			get_node("Preview").set_preview(lvl.preview_image)
	center_buttons()