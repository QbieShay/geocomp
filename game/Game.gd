extends Node2D

const Curve = preload('curve/Curve.gd')
const CurveNode = preload('curve/Curve.tscn')
const ControlPoint = preload('curve/ControlPoint.gd')
const CurveSupport = preload('curve/CurveSupport.gd')
const CharacterNode = preload('character/Character.tscn')
const Utils = preload('res://Utils.gd')

var started = false 

func _ready():
	set_process_input(true)
#	var curve = CurveNode.instance()
#	curve.init_with_points(5)
#	add_child(curve)
#	curve = CurveNode.instance()
#	curve.set_pos(Vector2(300, 300))
#	curve.init_with_points(3)
#	add_child(curve)
	
func _input(event):
	if event.is_action_pressed("ui_start") and not started:
		var chara = CharacterNode.instance()
		chara.set_name('Character')
		chara.set_pos(Vector2(200, 0))
		add_child(chara)
		started = true
		disable_control_points()
		hide_curve_gizmos()
		hide_supports()

func disable_control_points():
	var cps = Utils.find_all_targets(ControlPoint, get_node('.'))
#	print('found ', cps.size(), ' cps')
	for cp in cps:
		cp.set_process_input(false)
		
func hide_curve_gizmos():
	var curves = Utils.find_all_targets(Curve, get_node('.'))
#	print('found ', curves.size(), ' curves')
	for curve in curves:
		curve.draw_polygon = false
		curve.update()
		
func hide_supports():
	var supports = Utils.find_all_targets(CurveSupport, get_node('.'))
	for support in supports:
		support.visible = false
		support.update()