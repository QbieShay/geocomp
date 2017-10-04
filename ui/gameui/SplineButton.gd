extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var normals = []
var pressed
var del

var loaded = false



func _loadImgs():
	normals = []
	for i in range (3):
		normals.append(ImageTexture.new().load("res://ui/gameui/img/Spline" + str(i+1) + "_Active.png"))
	loaded = true

func set_spline_type(type_index):
	if(not loaded):
		_loadImgs()
	if (type_index == 1):
		set_normal_texture(normals[0])
	if (type_index == 2):
		set_normal_texture(normals[1])
	if (type_index == 3):
		set_normal_texture(normals[2])
	pass

