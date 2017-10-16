extends Sprite

var v

onready var width = get_viewport().get_rect().size.x

func _ready():
	v = rand_range(20, 100)
	set_pos(Vector2(rand_range(-2000, width), rand_height()))
	set_scale(rand_scale())
	set_opacity(rand_range(0.3, 0.6))
	set_process(true)
	
func _process(delta):
	translate(Vector2(v * delta, 0))
	if get_pos().x > width + 300:
		set_pos(Vector2(-300, rand_height()))
		set_scale(rand_scale())
		set_opacity(rand_range(0.1, 0.6))
		
func rand_height():
	return rand_range(-200, get_viewport().get_rect().size.height)
	
func rand_scale():
	var s = rand_range(0.4, 1.2)
	return Vector2(s, s + rand_range(-0.2, 0.2))