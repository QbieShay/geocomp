extends Node

const Game = preload('Game.gd')
const TargetsManager = preload('targets/TargetsManager.gd')

const N_LEVELS = 5

var game
var targets_manager
var cur_loaded_level
var level_num

func _ready():
	game = Game.new()
	game.set_name("Game")
	targets_manager = TargetsManager.new()
	targets_manager.set_name("TargetsManager")
	add_child(game)
	add_child(targets_manager)
	
func load_level(n):
	if cur_loaded_level:
		cur_loaded_level.queue_free()
	var LevelScene = load('res://game/levels/Level' + str(n) + '.tscn')
	assert(LevelScene)
	var level = LevelScene.instance()
	cur_loaded_level = level
	level_num = n
	add_child(level)
	
	# Setup targets and game
	game.set_targets_root(get_node("./Level" + str(n) + "/Targets"))
	var spawn = get_node('./Level' + str(n) + '/SpawnPoint')
	assert(spawn)
	game.spawn = spawn
	game.reset_level()