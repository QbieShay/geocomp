extends Node

const Utils = preload('res://Utils.gd')
const Level = preload('res://game/Level.gd')

const SAVE_FILE = 'user://bestscore.save'

var score = 0 setget set_score

func set_score(value):
	if(value > 0):
		score = int(value)
	else:
		score = 0

func add_score(value):
	if(value > 0):
		score = int(score + value)

func save_score():
	# Find out level number
	var level = get_node(Utils.name_from_root('Level'))
	assert(level)

	var scores = []
		
#	# Load existing score, if any
	var result = load_score()
	if result['ok']:
		scores = result['scores']
	else:
		for i in range(Level.N_LEVELS):
			scores.append(0)
	
	# Overwrite this level's score if better than previous
	if score > scores[level.level_num - 1]:
		scores[level.level_num - 1] = score
		
	# Save it
	save_score_data(scores)
	
func save_score_data(scores):
	assert(scores.size() == Level.N_LEVELS)
	var savefile = File.new()
	savefile.open(SAVE_FILE, File.WRITE)
	var scorestr = ""
	for s in scores:
		scorestr += str(s) + ','
	# Chop trailing comma
	scorestr = scorestr.substr(0, scorestr.length() - 1)
	savefile.store_string(scorestr)
	savefile.close()

# Tries to load the save data. Returns {'ok': true, 'scores': [int] } on
# success, or { 'ok': false } on failure (invalid data or missing file)
func load_score():
	var savefile = File.new()
	if !savefile.file_exists(SAVE_FILE):
		return { 'ok': false }
	savefile.open(SAVE_FILE, File.READ)
	var raw = savefile.get_as_text()
	# Data is saved like: score1,score2,score3,score4,score5
	var scorestr = raw.split(',')
	if scorestr.size() != Level.N_LEVELS:
		# Data is invalid
		savefile.close()
		return { 'ok': false }
	var scores = []
	for s in scorestr:
		scores.append(int(s))
	assert(scores.size() == Level.N_LEVELS)
	savefile.close()
	return {
		'ok': true,
		'scores': scores
	}