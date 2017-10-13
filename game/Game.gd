extends Node2D

const Curve = preload('curve/Curve.gd')
const CurveNode = preload('curve/Curve.tscn')
const ControlPoint = preload('curve/ControlPoint.gd')
const CurveSupport = preload('curve/CurveSupport.gd')
const CharacterNode = preload('character/Character.tscn')
const Utils = preload('res://Utils.gd')

var started = false 
var chara
var orig_targets_root
var cloned_targets_root
var spawn

onready var root = get_node(Utils.name_from_root())

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	
func _fixed_process(delta):
	if started and chara.get_pos().y > get_viewport_rect().size.height * 1.2:
		game_over()
	
func _input(event):
	if event.is_action_pressed("ui_start") and not started:
		start_level()

func game_over():
	# TODO
	print('GAME OVER!')
	reset_level()
	
func win():
	print('YOU WIN!')
	
func start_level():
		chara = CharacterNode.instance()
		chara.set_name('Character')
		assert(spawn)
		chara.set_pos(spawn.get_pos())
		add_child(chara)
		started = true
		make_curves_solid()
		set_control_points_enabled(false)
		set_curve_gizmos_visible(false)
		set_supports_visible(false)
		set_spawn_visible(false)

func reset_level():
	if chara:
		var wch = weakref(chara)
		if wch.get_ref():
			chara.queue_free()
	set_curve_gizmos_visible(true)
	set_control_points_enabled(true)
	set_supports_visible(true)
	reset_targets()
	set_spawn_visible(true)
	started = false
	
func set_spawn_visible(v):
	if !spawn: return
	if v:
		spawn.show()
	else:
		spawn.hide()
		
func set_control_points_enabled(b):
	var cps = Utils.find_all_targets(ControlPoint, root)
#	print('found ', cps.size(), ' cps')
	for cp in cps:
		cp.set_process_input(b)
		
func set_curve_gizmos_visible(v):
	var curves = Utils.find_all_targets(Curve, root)
#	print('found ', curves.size(), ' curves')
	for curve in curves:
		curve.draw_polygon = v
		curve.update()
		
func make_curves_solid():
	var curves = Utils.find_all_targets(Curve, root)
#	print('found ', curves.size(), ' curves')
	for curve in curves:
		curve.make_solid()
		
func set_supports_visible(v):
	var supports = Utils.find_all_targets(CurveSupport, root)
	for support in supports:
		support.visible = v
		support.update()

func set_targets_root(node):
	orig_targets_root = node
	cloned_targets_root = node.duplicate()
	
func reset_targets():
	var level = get_parent()
	level.remove_child(orig_targets_root)
	orig_targets_root.free()
	level.add_child(cloned_targets_root)
	level.targets_manager.find_targets()
	set_targets_root(cloned_targets_root)