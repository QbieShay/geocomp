extends Popup

const Utils = preload("res://Utils.gd")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func show_score(score):
	get_node("Label").set_text("YOU WIN!")
	get_node("ScoreLabel").set_text("YOUR SCORE: "+str(int(score)))
	get_node("NextButton").set_disabled(false)
	show()
	get_node("NextButton").show()

func show_lost(missed_targets):
	get_node("Label").set_text("YOU LOST...")
	get_node("ScoreLabel").set_text("You missed "+str(missed_targets)+" targets.")
	get_node("NextButton").set_disabled(false)
	show()

func _on_ResetButton_pressed():
	hide()
	var game = get_node(Utils.name_from_root('Level')).game
	game.reset_level()

func _on_NextButton_pressed():
	var lvl = get_node(Utils.name_from_root("Level"))
	if(lvl.level_num >=5):
		var scene_manager = get_tree().get_root().get_node("Root/SceneManager")
		scene_manager.load_previous_scene()
	else:
		lvl.load_level(lvl.level_num + 1)