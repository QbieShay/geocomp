extends TextureButton

var type = 0
var cancel_texture 
var normal_texture
var segment = null

func set_spline_type(type_index, normal, pressed, used):
	type = type_index
	set_normal_texture(normal)
	normal_texture = normal
	set_pressed_texture(pressed)
	cancel_texture = used
	pass


func set_segment(segment):
	set_pressed(false)
	set_normal_texture(cancel_texture)
	self.segment = segment

func pressed_callback():
	if(segment != null):
		segment.del_curve()
		segment = null
		set_normal_texture(normal_texture)
		set_pressed(false)
	else:
		get_parent().position_spline(self, type)


func mouse_enter():
	if(segment != null):
		segment.curve.glowing = true
		segment.glowing = true
	pass # replace with function body


func mouse_exit():
	if(segment != null):
		segment.curve.glowing = false
		segment.glowing = false
