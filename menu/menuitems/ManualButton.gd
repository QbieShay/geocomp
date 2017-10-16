extends 'PreviewButton.gd'
	
func set_idx(i):
	.set_idx(i)
	preview_image = "res://menu/menuitems/img/manual/Manual_" + str(idx - 1) + ".png"
	