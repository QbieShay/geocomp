extends 'ButtonsPreviewScene.gd'

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
	center_buttons()