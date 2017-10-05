extends Node2D

const CurveNode = preload('game/curve/Curve.tscn')
const CharacterNode = preload('game/character/Character.tscn')

func _ready():
	set_process_input(true)
	var curve = CurveNode.instance()
	curve.init_with_points(5)
	add_child(curve)
#	curve = CurveNode.instance()
#	curve.set_pos(Vector2(300, 300))
#	curve.init_with_points(3)
#	add_child(curve)
	
func _input(event):
	if event.is_action_pressed("ui_start"):
		var chara = CharacterNode.instance()
		chara.set_name('Character')
		chara.set_pos(Vector2(200, 0))
		add_child(chara)