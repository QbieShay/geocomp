extends Node

const Game = preload('Game.gd')
const TargetsManager = preload('targets/TargetsManager.gd')

var game

func _ready():
	game = Game.new()
	add_child(game)
	add_child(TargetsManager.new())
	
func load_level(n):
	var LevelScene = load('res://game/levels/Level' + str(n) + '.tscn')
	assert(LevelScene)
	add_child(LevelScene.instance())