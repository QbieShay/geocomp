extends Area2D

const Character = preload('res://game/character/Character.gd')
const BOOST = 200

func _ready():
	connect("body_enter", self, "on_body_enter")

func on_body_enter(body):
	if !(body extends Character):
		return
	add_boost(body)
	
func add_boost(body):
	var dir = body.get_linear_velocity().normalized()
	body.apply_impulse(Vector2(), dir * BOOST)
	