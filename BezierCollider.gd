extends KinematicBody2D

func set_points(points):
	self.clear_shapes()
	var shape
	for i in range(0, points.size() - 1):
		shape = SegmentShape2D.new()
		shape.set_a(points[i])
		shape.set_b(points[i+1])
		self.add_shape(shape)
	pass
