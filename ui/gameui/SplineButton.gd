extends TextureButton

var type = 0
var cancel_texture 
var normal_texture
var using = false

func set_spline_type(type_index, normal, pressed, used):
	type = type_index
	set_normal_texture(normal)
	normal_texture = normal
	set_pressed_texture(pressed)
	cancel_texture = used
	pass

func pressed_callback():
	if(using == true):
		#TODO cancel the active spline
		set_normal_texture(normal_texture)
	else:
		get_parent().position_spline(self, type)
