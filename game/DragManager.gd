extends Node

const Utils = preload('res://Utils.gd')
const DragManagerSingleton = preload('DragManagerSingleton.gd')

static func get_instance(node):
	var inst = node.get_node(Utils.name_from_root('nodemanager'))
	if inst:
		assert(inst extends DragManagerSingleton)
		return inst
	inst = DragManagerSingleton.new()
	inst.set_name('nodemanager')
	node.get_node(Utils.name_from_root()).add_child(inst, true)
	return inst