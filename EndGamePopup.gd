extends Popup
var Utils = preload("res://Utils.gd")

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func set_score(score):
	get_node("ScoreLabel").set_text("YOUR SCORE:"+str(score))

func reset():
	hide()
	get_tree().get_root().find_node("GameUI")._on_ResetButton_pressed()

func next():
	var lvl = get_node(Utils.name_from_root("Level"))
	if(lvl.level_num >=5):
		print("sa fem?")
		pass
	else:
		lvl.load_level(lvl.level_num + 1)