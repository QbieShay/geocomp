extends Control

var spline_button = preload("SplineButton.tscn")
var mouse_follow = preload("MouseFollowSplineTooltip.tscn")
var normals = []
var pressed = []
var cancels = []
var mf

var container

export var n_1_splines = 0
export var n_2_splines = 0
export var n_3_splines = 0

func load_imgs():
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
	container = get_node("HBoxContainer")
	load_imgs()
	set_available_buttons(n_1_splines, n_2_splines, n_3_splines)

func set_available_buttons(spline1, spline2, spline3):
	
	for child in container.get_children():
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
	btn.gameui = self
	container.add_child(btn)

func position_spline(who, type):
	spawn_mouse_tip(who, type)

func spawn_mouse_tip(caller, type):
		if(mf != null):
			mf.die()
		mf = mouse_follow.instance()
		get_tree().get_root().add_child(mf)
		mf.set_current_curve(type)
		mf.container = self
		mf.button = caller
	
