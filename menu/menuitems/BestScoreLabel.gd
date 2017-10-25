extends Label

const Utils = preload('res://Utils.gd')

var scores

onready var button_group = get_node('../ButtonGroup')

func _ready():
	var score_manager = get_node(Utils.name_from_root('ScoreManager'))
	assert(score_manager)
	var res = score_manager.load_score()
	if res['ok']:
		scores = res['scores']
	update_label(0)
	
func update_label(idx):
	var scorestr = '-'
	if scores != null and scores[idx] > 0:
		scorestr = str(scores[idx])
	set_text("BEST SCORE: " + scorestr)