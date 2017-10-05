extends HBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var spline_button = preload("SplineButton.tscn")
var normals = []

func _loadImgs():
	for i in range (3):
		var img = ImageTexture.new()
		img.load("res://ui/gameui/img/Spline" + str(i+1) + "_Active.png")
		normals.append(img)
	print(normals)

func _ready():
	_loadImgs()
	set_available_buttons( 3,1,4)

func set_available_buttons(spline1, spline2, spline3):
	for child in get_children():
		child.queue_free()
	var btn
	for i in range (spline1):
		btn = spline_button.instance()
		btn.set_spline_type(1, normals[0], null , null)
		add_child(btn)
	for i in range (spline2):
		btn = spline_button.instance()
		btn.set_spline_type(2, normals[1], null , null)
		add_child(btn)
	for i in range (spline3):
		btn = spline_button.instance()
		btn.set_spline_type(3, normals[2], null , null)
		add_child(btn)
	pass
