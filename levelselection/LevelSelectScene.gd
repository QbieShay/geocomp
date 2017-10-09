extends Container

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var levelbtn = preload("LevelSelectButton.tscn")

func _ready():
	for i in range(5):
		var lvl = levelbtn.instance()
		lvl.init_btn(i)
		get_node("LevelButtonsContainer").add_child(lvl)
	pass
