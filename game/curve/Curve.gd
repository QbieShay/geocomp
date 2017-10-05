extends Node

const ControlPointNode = preload('ControlPoint.tscn')
const ControlPoint = preload('ControlPoint.gd')
const BezierColliderNode = preload('BezierCollider.tscn')

export var curve_thickness = 20.0
export var curve_color = Color(1, 1, 1, 1)
export var point_color = Color(1, 1, 0.5, 1)
export var point_in_color = Color(1, 0.5, 1, 1)
export var point_out_color = Color(0.5, 1, 1, 1)
export var draw_polygon = true
export var connect_in_out = false
export var polygon_thickness = 2.0
export var polygon_color = Color(0.3, 1, 0.6)
export var force_equidirectional = true
export var glow_color = Color(1, 0.1, 0.1)

var collider
var curve
# control_points stores [knot#0, in#0, out#0, knot#1, in#1, out#1, ...]
var control_points = []
var created = false
var glowing = false setget set_glowing
var alpha = 0
var alpha_grow = true

func _ready():
	set_process(true)
	
func _process(delta):
	if !glowing:
		return
	if alpha_grow:
		alpha += delta * 1.7
		if alpha >= 1:
			alpha = 1
			alpha_grow = false
	else:
		alpha -= delta * 1.7
		if alpha <= 0:
			alpha = 0
			alpha_grow = true
	update()
		
func init_with_points(n, width = 0):
	assert(n > 1 && !created)
	var span = width / (n - 1) if width > 0 else 200
	curve = Curve2D.new()
	for i in range(0, n):
		var pos = Vector2(span * i, 0)
		var pos_in = Vector2(-span/2, span/2)
		var pos_out = Vector2(span/2, -span/2)
		curve.add_point(pos, pos_in, pos_out)
		var cp = ControlPointNode.instance()
		cp.set_pos(pos)
		control_points.append(cp)
		cp.connect("position_changed", self, "on_position_change", [3 * i])
		add_child(cp)
		cp = ControlPointNode.instance()
		cp.set_pos(pos + pos_in)
		cp.type = ControlPoint.PointType.IN
		control_points.append(cp)
		if i > 0:
			cp.connect("position_changed", self, "on_position_change", [3 * i + 1])
			add_child(cp)
		cp = ControlPointNode.instance()
		cp.set_pos(pos + pos_out)
		cp.type = ControlPoint.PointType.OUT
		control_points.append(cp)
		if i < n - 1:
			cp.connect("position_changed", self, "on_position_change", [3 * i + 2])
			add_child(cp)
	collider = BezierColliderNode.instance()
	collider.set_points(curve.tesselate())
	add_child(collider)
	created = true
	print('bake int: ', curve.get_bake_interval())
	curve.set_bake_interval(1)

func freeze_extremes():
	control_points[0].disconnect("position_changed", self, "on_position_change")
	control_points[-3].disconnect("position_changed", self, "on_position_change")
	
func _draw():
	if !created: 
		return
	# Draw the curve
	var start = Vector2()
	for point in curve.get_baked_points():
		draw_line(start, point, curve_color, curve_thickness)
		if glowing:
			draw_line(start, point, Color(glow_color.r, glow_color.g, glow_color.b, alpha), 2 * curve_thickness)
			#draw_rect(Rect2(Vector2(start) - Vector2(5, 5), Vector2(10, 10)), Color(0.1, 0.9, 0.1, alpha))
		start = point
	
	# Draw the control polygons
	if !draw_polygon:
		return
	var p_out = null
	var invscale = 1 / max(get_global_scale().x, get_global_scale().y)
	for i in range(0, curve.get_point_count()):
		var pos = curve.get_point_pos(i)
		var p_in = pos + curve.get_point_in(i)
		if connect_in_out and p_out != null:
			draw_line(p_out, p_in, polygon_color, polygon_thickness)
		p_out = pos + curve.get_point_out(i)
		
		draw_circle(pos, 5 * invscale, point_color)
		if i > 0:
			draw_circle(p_in, 5 * invscale, point_in_color)
			draw_line(pos, p_in, polygon_color, polygon_thickness)

		if i < curve.get_point_count() - 1:
			draw_circle(p_out, 5 * invscale, point_out_color)
			draw_line(pos, p_out, polygon_color, polygon_thickness)


func on_position_change(idx):
	var pt = control_points[idx]
	var pt_idx = int(idx / 3)
	
	if pt.type == ControlPoint.PointType.KNOT:
		if idx == 0:
			set_pos(pt.get_global_pos())
			return
		var diff = pt.get_pos() - curve.get_point_pos(pt_idx)
		curve.set_point_pos(pt_idx, pt.get_pos())
		# Update in and out points
		control_points[idx + 1].translate(diff)
		control_points[idx + 2].translate(diff)
	elif pt.type == ControlPoint.PointType.IN:
		var knot = control_points[pt_idx * 3]
		curve.set_point_in(pt_idx, pt.get_pos() - knot.get_pos())
	elif pt.type == ControlPoint.PointType.OUT:
		var knot = control_points[pt_idx * 3]
		curve.set_point_out(pt_idx, pt.get_pos() - knot.get_pos())
	if force_equidirectional:
		make_equidirectional(pt, pt_idx)
	update()
	collider.set_points(curve.tesselate())
	
	
func make_equidirectional(pt, pt_idx):
	if pt.type == ControlPoint.PointType.KNOT:
		return
		
	var pt2_idx = -1
	var knot_idx = 3 * pt_idx # Index of corresponding KNOT point
	if pt.type == ControlPoint.PointType.IN:
		if pt_idx == curve.get_point_count() - 1:
			return
		pt2_idx = knot_idx + 2 # Index of corresponding OUT point
	elif pt.type == ControlPoint.PointType.OUT:
		if pt_idx == 0:
			return
		pt2_idx = knot_idx + 1 # Index of corresponding IN point
	else:
		assert(false)
	
	var knot = control_points[knot_idx]
	var knot_pos = knot.get_global_pos()
	var pt2 = control_points[pt2_idx]
	var pt2_pos = pt2.get_global_pos()
	var dir = (pt.get_global_pos() - knot_pos).normalized()
	var dist2 = (pt2_pos - knot_pos).length()
	var pt2_newpos = knot_pos - dir * dist2
	
	pt2.set_global_pos(pt2_newpos)
	if pt2.type == ControlPoint.PointType.IN:
		curve.set_point_in(pt_idx, pt2.get_pos() - knot.get_pos())
	else:
		curve.set_point_out(pt_idx, pt2.get_pos() - knot.get_pos())
		
func set_glowing(g):
	glowing = g
	if !glowing:
		alpha = 0
		alpha_grow = true
		update()