extends Node

onready var root = get_node('/root/Root')
# The scenes we came from (class paths)
var scene_stack = []
var cur_main_scene
var cur_main_scene_class_path

# Loads the given scene by path, instances it, destroys the
# current main scene and sets the new loaded one as main.
func set_main_scene(scene_name, save_in_stack = true):
	var SceneClass = scene_name
	assert(SceneClass)
	if cur_main_scene:
		if save_in_stack:
			scene_stack.append(cur_main_scene_class_path)
		cur_main_scene.queue_free()
	var scene = SceneClass.instance()
	cur_main_scene_class_path = scene_name
	root.add_child(scene)
	
func load_prev_scene():
	if scene_stack.size() == 0:
		print('Trying to load previous scene but scene stack is empty!?')
		assert(false)
	var prev_scene_class_path = scene_stack[-1]
	scene_stack.pop_back()
	set_main_scene(prev_scene_class_path, false)