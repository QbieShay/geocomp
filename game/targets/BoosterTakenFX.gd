extends Node

const T = 0.8

var t = 0

func _ready():
	set_process(true)
	
func _process(delta):
	t += delta
	if t > T:
		queue_free()
		set_process(false)
	update()
	
func _draw(): 
	draw_circle(Vector2(), 70 * t / T, Color(0.1, 0.8, 0.8, T - t))