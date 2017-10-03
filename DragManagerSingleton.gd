extends Node

const ControlPoint = preload('ControlPoint.gd')

var dragged = []

func add_dragged(point):
	assert(point extends ControlPoint)
	dragged.append(point)
	
func remove_dragged(point):
	var idx = dragged.find(point)
	if idx >= 0:
		dragged.remove(idx)
	
func check_dragged(point):
	if !dragged.has(point):
		return false
	if dragged.size() == 1:
		return true
	for pt in dragged:
		if int(pt.type) > int(point.type):
			remove_dragged(point)
			return false
	return true