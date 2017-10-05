extends TextureButton

var type = 0
var cancel_texture 


func set_spline_type(type_index, normal, pressed, used):
	type = type_index
	set_normal_texture(normal)
	#set_pressed_texture(pressed)
	cancel_texture = used
	pass

