extends Container

const LevelSelectButtonNode = preload("LevelSelectButton.tscn")

func _ready():
	var container = get_node("ButtonsContainer")
	for i in range(5):
		var lvl = LevelSelectButtonNode.instance()
		lvl.level_idx = i + 1
		container.add_child(lvl)
