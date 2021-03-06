extends Node2D

const DragManager = preload('res://game/DragManager.gd')
const Utils = preload('res://Utils.gd')

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
var knot # The knot this Control Point belongs to (null if is itself a knot)
var anchor_pos
var drag_manager
var enabled = true

onready var initial_pos = get_global_pos()

func _ready():
	if !enabled:
		return
	set_process_input(true)
	set_fixed_process(true)
	var game = get_node(Utils.name_from_root('Level')).game
	assert(game)
	drag_manager = game.drag_manager
	assert(drag_manager)
	
func _fixed_process(delta):
	if !enabled:
		return
	anchor_pos = initial_pos if type == PointType.KNOT else knot.get_global_pos()
	var vpsize = get_viewport().get_rect()
	if dragging:
		var mpos = get_global_mouse_pos()
		if mpos.x < 0 or mpos.y < 0 or mpos.x > vpsize.size.x or mpos.y > vpsize.size.y:
			return
		var r = mpos - anchor_pos
		if r.length() > max_dist_from_initial_pos:
			set_global_pos(anchor_pos + r.normalized() * max_dist_from_initial_pos)
		else:
			set_global_pos(mpos)
		update()
		
func _input(event):
	if !enabled:
		return
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
		draw_circle((anchor_pos - get_global_pos()) * 1, 
			max_dist_from_initial_pos, 
			Color(0.1, 0.8, 0.1, 0.3))
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