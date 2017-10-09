extends Container

const PreviewButton = preload('PreviewButton.gd')

func _ready():
	var container = get_node("ButtonsContainer")
#	for i in range(5):
#		var lvl = PreviewButton.new()
#		lvl.preview_image = "res://menu/menuitems/img/manual/Manual_" + str(i) + ".png"
#		container.add_child(lvl)
