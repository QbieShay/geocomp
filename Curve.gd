extends Node

const ControlPointNode = preload('ControlPoint.tscn')
const ControlPoint = preload('ControlPoint.gd')
const BezierColliderNode = preload('BezierCollider.tscn')

var curve
var control_points = []
var created = false

export var curve_thickness = 20.0
export var curve_color = Color(0.5, 0.5, 1, 1)
export var point_color = Color(1, 1, 0.5, 1)
export var point_in_color = Color(1, 0.5, 1, 1)
export var point_out_color = Color(0.5, 1, 1, 1)
export var draw_polygon = true
export var polygon_thickness = 2.0
export var polygon_color = Color(0.3, 1, 0.6)
	
var collider

func init_with_points(n):
	assert(n > 1 && !created)
	curve = Curve2D.new()
	for i in range(0, n):
		var pos = Vector2(200 * i, 0)
		var pos_in = Vector2(50, 100)
		var pos_out = Vector2(100, 100)
		curve.add_point(pos, pos_in, pos_out)
		var cp = ControlPointNode.instance()
		cp.set_global_pos(pos)
		control_points.append(cp)
		cp.connect("position_changed", self, "on_position_change", [3 * i])
		add_child(cp)	
		cp = ControlPointNode.instance()
		cp.set_global_pos(pos + pos_in)
		cp.type = ControlPoint.PointType.IN
		control_points.append(cp)
		cp.connect("position_changed", self, "on_position_change", [3 * i + 1])
		add_child(cp)	
		cp = ControlPointNode.instance()
		cp.set_global_pos(pos + pos_out)
		cp.type = ControlPoint.PointType.OUT
		control_points.append(cp)
		cp.connect("position_changed", self, "on_position_change", [3 * i + 2])
		add_child(cp)
	collider = BezierColliderNode.instance()
	collider.set_points(curve.tesselate())
	add_child(collider)
	created = true
	
func _draw():
	if !created: 
		return
	# Draw the curve
	var start = Vector2()
	for point in curve.get_baked_points():
		draw_line(start, point, curve_color, curve_thickness)
		start = point
	
	# Draw the control polygons
	if !draw_polygon:
		return
	var p_out = null
	for i in range(0, curve.get_point_count()):
		var pos = curve.get_point_pos(i)
		var p_in = pos + curve.get_point_in(i)
		if p_out != null:
			draw_line(p_out, p_in, polygon_color, polygon_thickness)
		p_out = pos + curve.get_point_out(i)
		
		draw_line(pos, p_in, polygon_color, polygon_thickness)
		draw_line(p_in, p_out, polygon_color, polygon_thickness)

		draw_circle(pos, 5, point_color)
		draw_circle(p_in, 5, point_in_color)
		draw_circle(p_out, 5, point_out_color)
		
func on_position_change(idx):
	var pt = control_points[idx]
	var pt_idx = int(idx / 3)
	if pt.type == ControlPoint.PointType.KNOT:
		var diff = pt.get_global_pos() - curve.get_point_pos(pt_idx)
		curve.set_point_pos(pt_idx, pt.get_global_pos())
		# Update in and out points
		control_points[idx + 1].global_translate(diff)
		control_points[idx + 2].global_translate(diff)
	elif pt.type == ControlPoint.PointType.IN:
		var knot = control_points[pt_idx * 3]
		curve.set_point_in(pt_idx, pt.get_global_pos() - knot.get_pos())
	elif pt.type == ControlPoint.PointType.OUT:
		var knot = control_points[pt_idx * 3]
		curve.set_point_out(pt_idx, pt.get_global_pos() - knot.get_pos())
	update()