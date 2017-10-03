extends Node

var curve

func _ready():
	curve = Curve2D.new()
	curve.add_point(Vector2(1000, 1000), Vector2(0, 0), Vector2(500, -1000))
	curve.add_point(Vector2(2000, 1000), Vector2(-500, 1000), Vector2(0, 0))
	
func _draw():
	# Draw the curve
	var start = Vector2()
	for point in curve.get_baked_points():
		draw_line(start, point, Color(0.5, 0.5, 1, 1), 10)
		start = point
	
	# Draw the control polygons
	var p_out = null
	for i in range(0, curve.get_point_count()):
		var pos = curve.get_point_pos(i)
		var p_in = pos + curve.get_point_in(i)
		if p_out != null:
			draw_line(p_out, p_in, Color(0.3, 1, 0.6), 2)
		p_out = pos + curve.get_point_out(i)
		
		draw_line(pos, p_in, Color(0.3, 1, 0.6), 2)
		draw_line(p_in, p_out, Color(0.3, 1, 0.6), 2)

		draw_circle(pos, 20, Color(1, 1, 0.5, 1))
		draw_circle(p_in, 15, Color(1, 0.5, 1, 1))
		draw_circle(p_out, 15, Color(0.5, 1, 1, 1))