extends Container

const LevelSelectButtonNode = preload("LevelSelectButton.tscn")

func _ready():
	var container = get_node("ButtonsContainer")
	for i in range(5):
		var lvl = LevelSelectButtonNode.instance()
		lvl.preview_image = "res://menu/menuitems/img/level_preview/LevelPreview_" + str(i) + ".png"
		container.add_child(lvl)
