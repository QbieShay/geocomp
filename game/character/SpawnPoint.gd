extends CanvasItem

export (Font) var font

var triangle
var colors
var y = 0
var t = 0

func _ready():
	triangle = Vector2Array([
		Vector2(-0.5, -0.5),
		Vector2(0.5, -0.5),
		Vector2(0, 0.5)
	])
	colors = ColorArray([Color(1, 0, 0), Color(1, 0, 0), Color(1, 0, 0)])
	set_process(true)
	
func _process(delta):
	t += delta
	y = 10 * sin(10 * t)
	update()
	
func _draw():
	draw_set_transform(Vector2(), 0, Vector2(1, 1))
	draw_circle(Vector2(), 8, Color(1, 0, 0))
	draw_string(font, Vector2(16, 7), "START", Color(1, 0, 0))
	draw_set_transform(Vector2(0, -50 + y), 0, Vector2(20, 20))
	draw_primitive(triangle, colors, Vector2Array([]))