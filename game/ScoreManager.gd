extends Node

var score setget set_score

func set_score(value):
	if(score > 0):
		score = value
	else:
		score = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
