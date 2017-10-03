extends HBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var spline_1_button = preload("res://ui/gameui/Spline1Button.tscn")
var spline_2_button = preload("res://ui/gameui/Spline2Button.tscn")
var spline_3_button = preload("res://ui/gameui/Spline3Button.tscn")

func _ready():
	set_available_buttons( 3,1,4)

func set_available_buttons(var spline1, var spline2, var spline3):
	for child in get_children():
		child.queue_free()
	for i in range (spline1):
		add_child(spline_1_button.instance())
	for i in range (spline2):
		add_child(spline_2_button.instance())
	for i in range (spline3):
		add_child(spline_3_button.instance())
	pass
