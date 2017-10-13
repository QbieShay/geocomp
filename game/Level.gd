extends Node

const Game = preload('Game.gd')
const TargetsManager = preload('targets/TargetsManager.gd')

var game
var targets_manager

func _ready():
	game = Game.new()
	game.set_name("Game")
	targets_manager = TargetsManager.new()
	targets_manager.set_name("TargetsManager")
	add_child(game)
	add_child(targets_manager)
	
func load_level(n):
	var LevelScene = load('res://game/levels/Level' + str(n) + '.tscn')
	assert(LevelScene)
	add_child(LevelScene.instance())
	game.set_targets_root(get_node("./Level" + str(n) + "/Targets"))
	targets_manager.find_targets()
	var spawn = get_node('./Level' + str(n) + '/SpawnPoint')
	assert(spawn)
	game.spawn = spawn