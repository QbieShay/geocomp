extends Node

const Game = preload('Game.gd')

func _ready():
	add_child(Game.new())
	
func load_level(n):
	var LevelScene = load('Level' + n + '.tscn')
	assert(LevelScene)
	add_child(LevelScene.instance())