extends CanvasItem

const COLOR = Color(1, 0.32, 0.32)

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
	colors = ColorArray([COLOR, COLOR, COLOR])
	get_node('Sprite').hide() # Sprite is only needed as editor gizmo
	set_process(true)
	
func _process(delta):
	t += delta
	y = 10 * sin(10 * t)
	update()
	
func _draw():
	draw_set_transform(Vector2(), 0, Vector2(1, 1))
	draw_circle(Vector2(), 8, COLOR)
	draw_string(font, Vector2(16, 7), "START", COLOR)
	draw_set_transform(Vector2(0, -40 + y), 0, Vector2(20, 20))
	draw_primitive(triangle, colors, Vector2Array([]))