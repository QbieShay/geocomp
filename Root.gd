extends Node

func _ready():
	get_node('SceneManager').set_main_scene('res://menu/MainMenu.tscn')