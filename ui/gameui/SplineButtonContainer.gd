extends HBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var spline_button = preload("SplineButton.tscn")

func _ready():
	set_available_buttons( 3,1,4)

func set_available_buttons(var spline1, var spline2, var spline3):
	for child in get_children():
		child.queue_free()
	var btn
	for i in range (spline1):
		btn = spline_button.instance()
		add_child(spline_button.instance())
		btn.set_spline_type(1)
	for i in range (spline2):
		btn = spline_button.instance()
		btn.set_spline_type(2)
		add_child(spline_button.instance())
	for i in range (spline3):
		btn = spline_button.instance()
		btn.set_spline_type(3)
		add_child(spline_button.instance())
	pass
