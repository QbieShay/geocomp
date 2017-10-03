extends Node

const DragManagerSingleton = preload('DragManagerSingleton.gd')

static func get_instance(node):
	var inst = node.get_node('/root/Node2D/nodemanager')
	if inst:
		assert(inst extends DragManagerSingleton)
		return inst
	inst = DragManagerSingleton.new()
	inst.set_name('nodemanager')
	node.get_node('/root/Node2D').add_child(inst, true)
	return inst