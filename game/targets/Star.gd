extends Area2D

const Character = preload('res://game/character/Character.gd')
const TakenFXScene = preload('TargetTakenFX.tscn')

const Y_SHIFT = 10
const T = 2

signal star_hit

var t = rand_range(0, 2 * PI)

onready var sprite = get_node('Sprite')

func _ready():
	connect("body_enter", self, "on_body_enter")
	set_process(true)

func _process(delta):
	t += delta
	if t > T:
		t = 0
	var transl = Vector2(0, -(1 + sin(2 * PI * t / T)) * Y_SHIFT)
	sprite.set_pos(transl)
	var tshift = t - T
	var rot = 2.5 * atan(3 * (t - T / 2.0)) + PI
	sprite.set_rot(rot)
	
func on_body_enter(body):
	if !(body extends Character):
		return
	var fx = TakenFXScene.instance()
	fx.set_pos(get_pos())
	get_parent().add_child(fx)
	emit_signal("star_hit")