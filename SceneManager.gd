extends Node

const Utils = preload('Utils.gd')

onready var root = get_node(Utils.name_from_root())

# The scenes we came from (class paths)
var scene_stack = []
var cur_main_scene
var cur_main_scene_class_path
var unloaded_scenes = []

# Loads the given scene by path, instances it, destroys the
# current main scene and sets the new loaded one as main.
func set_main_scene(scene_name, save_in_stack = true):
	var SceneClass = load(scene_name)
	assert(SceneClass)
	if cur_main_scene:
		if save_in_stack:
			scene_stack.append(cur_main_scene_class_path)
		root.remove_child(cur_main_scene)
		unloaded_scenes.append(cur_main_scene)
		# This crashes the game randomly, so we use a manual GC approach
#		cur_main_scene.queue_free()
	var scene = SceneClass.instance()
	cur_main_scene = scene
	cur_main_scene_class_path = scene_name
	root.add_child(scene)
	return scene
	
func load_prev_scene():
	if scene_stack.size() == 0:
		print('Trying to load previous scene but scene stack is empty!?')
		assert(false)
	var prev_scene_class_path = scene_stack[-1]
	scene_stack.pop_back()
	set_main_scene(prev_scene_class_path, false)
	
func gc():
	print("GC'ing ", unloaded_scenes.size(), " scenes.")
	for scene in unloaded_scenes:
		scene.free()
	unloaded_scenes.clear()