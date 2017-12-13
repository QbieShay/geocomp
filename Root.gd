extends Node

func _ready():
	var scene_mgr = get_node('SceneManager')
	scene_mgr.set_main_scene('res://menu/MainMenu.tscn')
	var timer = Timer.new()
	timer.set_wait_time(30)
	timer.connect("timeout", scene_mgr, "gc")
	add_child(timer)
	timer.start()