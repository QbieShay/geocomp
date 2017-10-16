extends Container

const ManualButton = preload('ManualButton.gd')

func _ready():
	var container = get_node("ButtonsContainer")
	for i in range(5):
		var lvl = ManualButton.new()
		lvl.idx = i + 1
		container.add_child(lvl)
		if i == 0:
			get_node("Preview").set_preview(lvl.preview_image)
