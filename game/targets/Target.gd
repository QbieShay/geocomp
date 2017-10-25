extends Area2D

const Character = preload('../character/Character.gd')
const TakenFXScene = preload('TargetTakenFX.tscn')

const COLOR = Color(1, 0.32, 0.32)

signal target_hit(distance)

var t = rand_range(0, 2 * PI)

onready var sprite = get_node('Sprite')

func _ready():
	connect("body_enter", self, "on_body_enter")
	set_process(true)
	sprite.set_modulate(COLOR)
	
func _process(delta):
	t += delta * rand_range(0.7, 1.3)
	sprite.set_pos(Vector2(0, 5 * sin(2 * t)))
	sprite.set_rot(0.1 * sin(4 * t))
	
func on_body_enter(body):
	if !(body extends Character):
		return
	var fx = TakenFXScene.instance()
	fx.set_pos(get_pos())
	get_parent().add_child(fx)
	emit_signal("target_hit", abs(body.get_global_pos().y - get_global_pos().y))