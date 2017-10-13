extends Node2D

const DragManager = preload('../DragManager.gd')

signal position_changed

enum PointType {
	KNOT,
	IN,
	OUT
}

var max_dist_from_initial_pos = 200
var radius = 10
var dragging = false
var type = PointType.KNOT

onready var initial_pos = get_global_pos()
onready var drag_manager = DragManager.get_instance(self)

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	
func _fixed_process(delta):
	if dragging:
		var mpos = get_global_mouse_pos()
		var r = mpos - initial_pos
		if r.length() > max_dist_from_initial_pos:
			set_global_pos(initial_pos + r.normalized() * max_dist_from_initial_pos)
		else:
			set_global_pos(mpos)
		update()
		
func _input(event):
	if event.type != InputEvent.MOUSE_BUTTON:
		return
	if !event.pressed:
		dragging = false
		update()
		drag_manager.remove_dragged(self)
		return
	var mpos = get_global_mouse_pos()
	var pos = get_global_pos()
	if (pos - mpos).length_squared() <= radius * radius:
		drag_manager.add_dragged(self)
		dragging = drag_manager.check_dragged(self)
		update()

func _draw():
	if dragging:
		draw_set_transform(Vector2(), -get_global_rot(), 
			Vector2(1 / get_global_scale().x, 1 / get_global_scale().y))
		draw_circle((initial_pos - get_global_pos()) * 1, 
			max_dist_from_initial_pos, 
			Color(0.8, 0.1, 0.1, 0.3))
#	if type == PointType.KNOT:
#		draw_circle(Vector2(), radius, Color(1, 0.6, 0.2))
#	elif type == PointType.IN:
#		draw_circle(Vector2(), radius, Color(1, 0.5, 1, 1))
#	elif type == PointType.OUT:
#		draw_circle(Vector2(), radius, Color(0.5, 1, 1, 1))
	
func set_global_pos(p):
	.set_global_pos(p)
	if dragging:
		emit_signal("position_changed")