extends Node2D

const Curve = preload('curve/Curve.gd')
const CurveNode = preload('curve/Curve.tscn')
const ControlPoint = preload('curve/ControlPoint.gd')
const CurveSupport = preload('curve/CurveSupport.gd')
const CharacterNode = preload('character/Character.tscn')
const Utils = preload('res://Utils.gd')
const DragManager = preload('DragManager.gd')

var started = false 
var chara
var orig_targets_root
var cloned_targets_root
var spawn

onready var root = get_node(Utils.name_from_root())
onready var drag_manager = DragManager.new()
onready var score_manager = get_node(Utils.name_from_root('ScoreManager'))

func _ready():
	set_process_input(true)
	set_fixed_process(true)

func _fixed_process(delta):
	if started and chara.get_pos().y > get_viewport_rect().size.height * 1.2:
		var level = get_parent().cur_loaded_level
		game_over(level.get_parent().targets_manager.targets.size())
	
func _input(event):
	if event.is_action_pressed("ui_start") and not started:
		start_level()

func game_over(missed_targets):
	var lvl_num = get_node("..").level_num
	var gameui = get_node("../Level"+str(lvl_num)+"/GameUILayer/GameUI")
	assert(gameui)
	print("Game over")
	gameui.game_over(missed_targets)
	
#	reset_level()
	
func win():
	var lvl_num = get_node("..").level_num
	var gameui = get_node("../Level"+str(lvl_num)+"/GameUILayer/GameUI")
	assert(gameui)
	gameui.win(score_manager.score)
	score_manager.save_score()
	
func start_level():
	if chara:
		return
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
		chara = null
	set_curve_gizmos_visible(true)
	set_control_points_enabled(true)
	set_supports_visible(true)
	reset_targets()
	score_manager.set_score(0)
	set_spawn_visible(true)
	started = false
	
func set_spawn_visible(v):
	if !spawn: return
	if v:
		spawn.show()
	else:
		spawn.hide()
		
func set_control_points_enabled(b):
	var cps = Utils.find_all_nodes(ControlPoint, root)
#	print('found ', cps.size(), ' cps')
	for cp in cps:
		cp.set_process_input(b)
		
func set_curve_gizmos_visible(v):
	var curves = Utils.find_all_nodes(Curve, root)
#	print('found ', curves.size(), ' curves')
	for curve in curves:
		curve.draw_polygon = v
		curve.update()
		
func make_curves_solid():
	var curves = Utils.find_all_nodes(Curve, root)
#	print('found ', curves.size(), ' curves')
	for curve in curves:
		curve.make_solid()
		
func set_supports_visible(v):
	var supports = Utils.find_all_nodes(CurveSupport, root)
	for support in supports:
		support.visible = v
		support.update()

func set_targets_root(node):
	orig_targets_root = node
	cloned_targets_root = node.duplicate()
	
func reset_targets():
	var level = get_parent().cur_loaded_level
	assert(level)
	assert(orig_targets_root)
	level.remove_child(orig_targets_root)
	orig_targets_root.queue_free()
	level.add_child(cloned_targets_root)
	level.get_parent().targets_manager.find_targets()
	set_targets_root(cloned_targets_root)