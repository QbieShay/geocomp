extends Node

const Target = preload('Target.gd')
const FinalTarget = preload('FinalTarget.gd')
#const Character = preload('../character/Character.gd')

var targets = []

func _ready():
	var root = get_node('/root/Node2D')
	targets = find_all_targets(root)
	print('Found ', targets.size(), ' targets')
	for t in targets:
		if t extends FinalTarget:
			t.connect("target_hit", self, "on_final_target_hit")
		else:
			t.connect("target_hit", self, "on_target_hit", [t])
	
func find_all_targets(root):
	var found = []
	for node in root.get_children():
		if node extends Target:
			found.append(node)
		else:
			var ts = find_all_targets(node)
			for t in ts:
				found.append(t)
	return found
	
func on_target_hit(distance, target):
	var score = calc_score(distance)
	print(distance, " ", score)
	# Destroy the target
	var idx = targets.find(target)
	assert(idx >= 0)
	targets.remove(idx)
	target.queue_free()
	
func calc_score(distance):
	return max(0, 100 - distance * distance / 45)
	
func on_final_target_hit(distance):
	var chara = get_node('/root/Node2D/Character')
	if chara:
		chara.set_linear_velocity(Vector2())
		chara.set_sleeping(true)
	if targets.size() > 1:
		# Not all targets were hit: game over
		print("Lose!")
	else:
		print("Win!")