extends Node2D

const CurveNode = preload('Curve.tscn')

func _ready():
	var curve = CurveNode.instance()
	curve.init_with_points(3)
	add_child(curve)