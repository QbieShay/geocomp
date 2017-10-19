extends Popup

const Utils = preload("res://Utils.gd")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func show_score(score):
	get_node("ScoreLabel").set_text("YOUR SCORE: "+str(int(score)))
	show()

func _on_ResetButton_pressed():
	hide()
	var game = get_node(Utils.name_from_root('Level')).game
	game.reset_level()

func _on_NextButton_pressed():
	var lvl = get_node(Utils.name_from_root("Level"))
	if(lvl.level_num >=5):
		print("sa fem?")
	else:
		lvl.load_level(lvl.level_num + 1)