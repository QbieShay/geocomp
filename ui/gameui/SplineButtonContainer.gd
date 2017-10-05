extends HBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var spline_button = preload("SplineButton.tscn")
var mouse_follow = preload("MouseFollowSplineTooltip.tscn")
var normals = []
var pressed = []
var cancels = []
var mf

func _loadImgs():
	for i in range (3):
		var img = ImageTexture.new()
		img.load("res://ui/gameui/img/Spline" + str(i+1) + "_Active.png")
		normals.append(img)
		img = ImageTexture.new()
		img.load("res://ui/gameui/img/Spline" + str(i+1) + "_Disable.png")
		pressed.append(img)
		img = ImageTexture.new()
		img.load("res://ui/gameui/img/Spline" + str(i+1) + "_Delete.png")
		cancels.append(img)

func _ready():
	_loadImgs()
	set_available_buttons( 3,1,4)

func set_available_buttons(spline1, spline2, spline3):
	for child in get_children():
		child.queue_free()
	for i in range (spline1):
		init_spline_btn(1)
	for i in range (spline2):
		init_spline_btn(2)
	for i in range (spline3):
		init_spline_btn(3)
	pass

func init_spline_btn(type):
	var btn = spline_button.instance()
	btn.set_spline_type(type, normals[type-1], pressed[type-1] , cancels[type-1])
	add_child(btn)

func position_spline(who, type):
	spawn_mouse_tip(who, type)

func spawn_mouse_tip(caller, type):
		if(mf != null):
			mf.die()
		mf = mouse_follow.instance()
		mf.set_current_curve(type)
		mf.who_notify = self
		mf.who_called = caller
		add_child(mf)
	
