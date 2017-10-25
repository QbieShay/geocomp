extends Container

func center_buttons():
	var button_group = get_node("ButtonGroup")
	assert(button_group)
	var size_x = 64 * button_group.get_button_list().size()
	var display_size = Vector2(Globals.get("display/width"), Globals.get("display/height"))
	button_group.set_global_pos(Vector2(
		(display_size.x - size_x) / 2.0, 
		button_group.get_global_pos().y))