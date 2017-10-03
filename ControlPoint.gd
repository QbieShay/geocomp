extends Node2D

const DragManager = preload('DragManager.gd')

signal position_changed

enum PointType {
	KNOT,
	IN,
	OUT
}

var radius = 10
var dragging = false
var type = PointType.KNOT
onready var drag_manager = DragManager.get_instance(self)

func _ready():
	set_process_input(true)
	set_process(true)
	
func _process(delta):
	if dragging:
		var mpos = get_global_mouse_pos()
		set_global_pos(mpos)
		
func _input(event):
	if event.type != InputEvent.MOUSE_BUTTON:
		return
	if !event.pressed:
		dragging = false
		drag_manager.remove_dragged(self)
		return
	var mpos = get_global_mouse_pos()
	var pos = get_global_pos()
	if (pos - mpos).length_squared() <= radius * radius:
		drag_manager.add_dragged(self)
		dragging = drag_manager.check_dragged(self)

func _draw():
	if type == PointType.KNOT:
		draw_circle(Vector2(), radius, Color(1, 0.6, 0.2))
	elif type == PointType.IN:
		draw_circle(Vector2(), radius, Color(1, 0.5, 1, 1))
	elif type == PointType.OUT:
		draw_circle(Vector2(), radius, Color(0.5, 1, 1, 1))
	
func set_global_pos(p):
	.set_global_pos(p)
	emit_signal("position_changed")