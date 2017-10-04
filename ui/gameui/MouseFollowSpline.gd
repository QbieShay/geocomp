extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (Texture) var Spline1Tooltip
export (Texture) var Spline2Tooltip
export (Texture) var Spline3Tooltip

func _ready():
	# Called every time the node is added to the scene.
	# Initialization 
	pass

func set_current_curve(curve):
	if(curve == 1) :
		set_texture(Spline1Tooltip)
	elif(curve == 2):
		set_texture(Spline3Tooltip)
	elif(curve == 3):
		set_texture(Spline2Tooltip)

func _process(delta):
	set_pos( get_viewport().get_mouse_pos() )