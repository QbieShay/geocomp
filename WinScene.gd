extends Control

const Utils = preload('res://Utils.gd')
const TargetTakenFX = preload('res://game/targets/TargetTakenFX.tscn')

const o = 8
const WAIT_TIME = 2.0

var t = 0
var fx_t = 0
var fx_delay = 0.3
var center
var chara

var win

func _ready():
	set_process(true)
	set_fixed_process(true)
	set_process_input(true)
	win = get_node("WinLabel")
	center = win.get_pos()
	chara = get_node("Character")
	chara.set_gravity_scale(0)
	chara.set_linear_velocity(Vector2(100, -100))
	chara.set_linear_damp(0)
	chara.set_angular_velocity(4)
	chara.set_angular_damp(0)

func _process(delta):
	t += delta * rand_range(0.7, 1.3)
	win.set_pos(center + Vector2(0, 20 * sin(o * t)))
	win.set_rotation(0.1 * sin((o - 4) * t))
	process_fx(delta)
	
func _fixed_process(delta):
	var size = get_viewport_rect().size
	var pos = chara.get_global_pos()
	if pos.x > size.width + 100 or pos.y < -100 or chara.get_pos().x < -100 or pos.y > size.height + 100:
		chara.queue_free()
		set_fixed_process(false)
	
func process_fx(delta):
	fx_t += delta
	if fx_t >= fx_delay:
		fx_t = 0
		fx_delay = rand_range(0, 1.5)
		var fx = TargetTakenFX.instance()
		fx.scale(Vector2(5, 5))
		fx.set_pos(Vector2(rand_range(0, get_viewport().get_rect().size.x), rand_range(0, get_viewport().get_rect().size.y)))
		add_child(fx)

func _input(event):
	if t > WAIT_TIME and (event.type == InputEvent.KEY or event.type == InputEvent.MOUSE_BUTTON):
		get_node(Utils.name_from_root("SceneManager")).set_main_scene('res://menu/MainMenu.tscn')