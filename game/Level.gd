extends Node

const Game = preload('Game.gd')
const TargetsManager = preload('targets/TargetsManager.gd')

var game
var targets_manager

func _ready():
	game = Game.new()
	targets_manager = TargetsManager.new()
	add_child(game)
	add_child(targets_manager)
	
func load_level(n):
	var LevelScene = load('res://game/levels/Level' + str(n) + '.tscn')
	assert(LevelScene)
	add_child(LevelScene.instance())
	targets_manager.find_targets()