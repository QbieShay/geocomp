extends Node

const Target = preload('Target.gd')
const Star = preload('Star.gd')
const FinalTarget = preload('FinalTarget.gd')
const Utils = preload('res://Utils.gd')
#const Character = preload('../character/Character.gd')

const STAR_SCORE = 150

var targets = []

onready var game = get_node('..').game
onready var score_manager = get_node(Utils.name_from_root('ScoreManager'))

func find_targets():
	targets.clear()
	var root = get_node(Utils.name_from_root())
	targets = Utils.find_all_nodes(Target, root)
	print('Found ', targets.size(), ' targets')
	for t in targets:
		if t extends FinalTarget:
			t.connect("target_hit", self, "on_final_target_hit", [t])
		else:
			t.connect("target_hit", self, "on_target_hit", [t])
	var stars = Utils.find_all_nodes(Star, root)
	print('Found ', stars.size(), ' stars')
	for s in stars:
		s.connect("star_hit", self, "on_star_hit", [s])
	
func on_target_hit(distance, target):
	score_manager.add_score(calc_score(distance))
	destroy_target(target)
	
func on_star_hit(star):
	score_manager.add_score(STAR_SCORE)
	star.queue_free()
	
func destroy_target(target):
	var idx = targets.find(target)
	assert(idx >= 0)
	targets.remove(idx)
	target.queue_free()
	
func calc_score(distance):
	return max(0, 100 - distance * distance / 45)
	
func on_final_target_hit(distance, target):
	on_target_hit(distance, target)
#	print('final target')
	var chara = game.chara
#	print('game: ', game, ', targets: ', targets, ' chara: ', chara)
	if chara:
		chara.set_linear_velocity(Vector2())
		chara.set_sleeping(true)
	if targets.size() > 0:
		# Not all targets were hit: game over
		game.game_over(targets.size())
	else:
		game.win()