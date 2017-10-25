extends Container

const ManualButton = preload('ManualButton.gd')

func _ready():
	var container = get_node("ButtonGroup/ButtonsContainer")
	for i in range(5):
		var btn = ManualButton.new()
		btn.idx = i + 1
		container.add_child(btn)
		if i == 0:
			get_node("Preview").set_preview(btn.preview_image)
			btn.set_pressed(true)
	var button_group = get_node("ButtonGroup")
	assert(button_group)
	var size_x = 64*5
	print("my size is "+str(size_x))
	button_group.set_global_pos(Vector2((get_viewport().get_rect().size.x -
		size_x)/2.0, button_group.get_global_pos().y))
