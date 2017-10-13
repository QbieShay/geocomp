extends Node

const Target = preload('Target.gd')
const FinalTarget = preload('FinalTarget.gd')
const Utils = preload('res://Utils.gd')
#const Character = preload('../character/Character.gd')

var targets = []

onready var game = get_node('..').game

func find_targets():
	targets.clear()
	var root = get_node(Utils.name_from_root())
	targets = Utils.find_all_nodes(Target, root)
	print('Found ', targets.size(), ' targets')
	for t in targets:
		if t extends FinalTarget:
			t.connect("target_hit", self, "on_final_target_hit")
		else:
			t.connect("target_hit", self, "on_target_hit", [t])

	
func on_target_hit(distance, target):
	var score = calc_score(distance)
#	print(distance, " ", score)
	# Destroy the target
	var idx = targets.find(target)
	assert(idx >= 0)
	targets.remove(idx)
	target.queue_free()
	
func calc_score(distance):
	return max(0, 100 - distance * distance / 45)
	
func on_final_target_hit(distance):
	print('final target')
	var chara = game.chara
	print('game: ', game, ', targets: ', targets, ' chara: ', chara)
	if chara:
		chara.set_linear_velocity(Vector2())
		chara.set_sleeping(true)
	if targets.size() > 1:
		# Not all targets were hit: game over
		game.game_over()
	else:
		print("win?")
		game.win()