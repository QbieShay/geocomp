extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var who_notify
var who_called
var segment

export (Texture) var Spline1Tooltip
export (Texture) var Spline2Tooltip
export (Texture) var Spline3Tooltip

func _ready():
	# Called every time the node is added to the scene.
	set_process(true)
	set_process_input(true)
	pass

func set_current_curve(curve):
	if(curve == 1) :
		set_texture(Spline1Tooltip)
	elif(curve == 2):
		set_texture(Spline2Tooltip)
	elif(curve == 3):
		set_texture(Spline3Tooltip)

func _input(event):
	if(event.type == InputEvent.MOUSE_BUTTON and
		event.pressed):
		if(segment != null):
			who_notify.set_segment(segment)
		else:
			who_called.set_pressed(false)
			die()
		

func die():
	who_notify.mf = null
	queue_free()

func _process(delta):
	set_global_pos( get_viewport().get_mouse_pos() )