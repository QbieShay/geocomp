extends Area2D

const Character = preload('../character/Character.gd')

signal target_hit(distance)

func _ready():
	connect("body_enter", self, "on_body_enter")
	
func on_body_enter(body):
	if !body extends Character:
		return
	print("Area entered")
	emit_signal("target_hit", abs(body.get_global_pos().y - get_global_pos().y))