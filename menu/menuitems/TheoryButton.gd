extends 'PreviewButton.gd'

func set_idx(i):
	.set_idx(i)
	preview_image = "res://menu/menuitems/img/theory/Theory_" + str(idx - 1) + ".png"