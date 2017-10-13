extends Area2D

const CurveNode = preload('Curve.tscn')
const MouseFollowSpline = preload('../../ui/gameui/MouseFollowSpline.gd')

var size = Vector2()
var curve setget set_curve
var highlighted = false setget set_highlighted
var alpha = 0.5
var visible = true
var glowing = false setget set_glowing

func _ready():
	var shape = get_node('CollisionShape2D')
	size = shape.get_shape().get_extents()
	connect("area_enter", self, "on_area_enter")
	connect("area_exit", self, "on_area_exit")
	
func _draw():
	if !visible:
		return
	var scale = get_global_scale()
	if !curve:
		draw_line(-Vector2(size.x, 0), Vector2(size.x, 0), Color(0.8, 0.8, 0.2), 5)
		# Prevent stretching of the circles
		draw_set_transform(Vector2(), 0, Vector2(1 / scale.x, 1 / scale.y))
		draw_circle(-Vector2(size.x * scale.x, 0), 5 , Color(0.2, 0.9, 0.5))
		draw_circle(Vector2(size.x * scale.x, 0), 5, Color(0.2, 0.9, 0.5))
		if highlighted:
			draw_set_transform(Vector2(), 0, Vector2(1, 1))
			draw_rect(Rect2(-size.x, -size.y, 2 * size.x, 2 * size.y), Color(0.7, 0.8, 0.1, 0.5))
#	if glowing:
#		draw_rect(Rect2(-size.x, -0.6 * size.y, 2 * size.x, 1.2 * size.y), Color(0.1, 0.8, 0.89, 0.4))

func add_curve(n_points):
	if curve and !curve.is_queued_for_deletion():
		return false
	self.curve = CurveNode.instance()
	curve.init_with_points(n_points, 2 * size.x - 10)
	curve.set_pos(-Vector2(size.x - 5, 0))
	curve.freeze_extremes()
	add_child(curve)
	return true
	
func del_curve():
	curve.queue_free()
	self.curve = null
	
func on_area_enter(area):
	if !area extends MouseFollowSpline:
		return
	area.segment = self
	self.highlighted = true
	
func on_area_exit(area):
	if !area extends MouseFollowSpline:
		return
	area.segment = null
	self.highlighted = false
	
func set_curve(c):
	curve = c
	update()
	
func set_highlighted(h):
	highlighted = h
	update()
	
func set_glowing(g):
	glowing = g
	update()