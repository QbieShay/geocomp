extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func set_points(points):
	self.clear_shapes()
	var shape
	for i in range( 0, points-2 ):
		shape = SegmentShape2D.new()
		shape.set_a(points[i])
		shape.set_b(points[i+1])
		self.add_shape( shape )
	pass

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
