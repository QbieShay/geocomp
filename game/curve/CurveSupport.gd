extends Area2D

const CurveNode = preload('Curve.tscn')
#const SplineTooltipArea = preload('../ui/gameui/SplineTooltipArea.gd')

var size = Vector2()
var curve
var highlighted = false
var alpha = 0.5

func _ready():
	var shape = get_node('CollisionShape2D')
	size = shape.get_shape().get_extents()
	connect("area_enter", self, "on_area_enter")
	connect("area_exit", self, "on_area_exit")
	set_process(true)
	
func _draw():
	draw_line(-Vector2(size.x, 0), Vector2(size.x, 0), Color(0.8, 0.8, 0.2), 5)
	draw_circle(-Vector2(size.x - 5, 0), 5, Color(0.2, 0.9, 0.5))
	draw_circle(Vector2(size.x - 5, 0), 5, Color(0.2, 0.9, 0.5))
	if highlighted:
		draw_rect(Rect2(-size.x, -size.y, 2 * size.x, 2 * size.y), Color(0.7, 0.8, 0.1, 0.5))
	
func add_curve(n_points):
	if curve and !curve.is_queued_for_deletion():
		del_curve()
	curve = CurveNode.instance()
	curve.init_with_points(n_points)
	add_child(curve)
	
func del_curve():
	curve.queue_free()
	curve = null
	
func on_area_enter(area):
#	if !area extends SplineTooltipArea:
#		return
	print('Enter')
	area.segment = self
	highlighted = true
	
func on_area_exit(area):
#	if !area extends SplineTooltipArea:
#		return
	area.segment = null
	highlighted = false