extends Popup

const Level = preload('res://game/Level.gd')

var Utils = preload("res://Utils.gd")

func set_score(score):
	get_node("ScoreLabel").set_text("YOUR SCORE:"+str(score))

func reset():
	hide()
	get_tree().get_root().find_node("GameUI")._on_ResetButton_pressed()

func next():
	var lvl = get_node(Utils.name_from_root("Level"))
	if lvl.level_num >= Level.N_LEVELS:
		print('FIXME')
		assert(false)
	else:
		lvl.load_level(lvl.level_num + 1)