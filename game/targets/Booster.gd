extends Area2D

const Character = preload('res://game/character/Character.gd')
const BOOST = 200
const RADIUS = 40

var t = rand_range(0, 2 * PI)

func _ready():
	connect("body_enter", self, "on_body_enter")
	get_node('Sprite').hide()
	set_process(true)
	
func _process(delta):
	t += delta
	update()
	
func _draw():
	draw_set_transform(Vector2(), 0, Vector2(0.5, 1))
	draw_circle(Vector2(), (t - floor(t)) * RADIUS, Color(0.1, 0.9, 0.1, 1 - (t - floor(t))))
	var tp = t - 0.66
	draw_circle(Vector2(), (tp - floor(tp)) * RADIUS, Color(0.1, 1.0, 0.1, 1 - (tp - floor(tp))))
	tp = t - 0.33
	draw_circle(Vector2(), (tp - floor(tp)) * RADIUS, Color(0.1, 1.0, 0.1, 1 - (tp - floor(tp))))
	
func on_body_enter(body):
	if !(body extends Character):
		return
	add_boost(body)
	
func add_boost(body):
	var dir = body.get_linear_velocity().normalized()
	body.apply_impulse(Vector2(), dir * BOOST)
	