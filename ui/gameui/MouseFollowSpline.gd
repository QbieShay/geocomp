extends Area2D

var container
var button
var segment
var type

onready var sprite = get_node('Sprite')

export (Texture) var Spline1Tooltip
export (Texture) var Spline2Tooltip
export (Texture) var Spline3Tooltip

func _ready():
	# Called every time the node is added to the scene.
	set_process(true)
	set_process_input(true)

func set_current_curve(curve):
	type = curve
	if(curve == 1) :
		sprite.set_texture(Spline1Tooltip)
	elif(curve == 2):
		sprite.set_texture(Spline2Tooltip)
	elif(curve == 3):
		sprite.set_texture(Spline3Tooltip)

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON and event.pressed:
		if segment != null:
			if segment.add_curve(type+1):
				button.set_segment(segment)
			die()
		else:
			button.set_pressed(false)
			die()
		

func die():
	container.mf = null
	queue_free()

func _process(delta):
	set_global_pos(get_viewport().get_mouse_pos())