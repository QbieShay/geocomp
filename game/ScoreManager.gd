extends Node

var score = 0 setget set_score

func set_score(value):
	if(value > 0):
		score = value
	else:
		score = 0
func add_score(value):
	if(value > 0):
		score = score + value
		
func _ready():
	
	pass
