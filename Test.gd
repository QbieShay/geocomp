extends Node2D

const CurveNode = preload('game/curve/Curve.tscn')
const CharacterNode = preload('game/Character.tscn')

func _ready():
	var curve = CurveNode.instance()
	curve.init_with_points(5)
	add_child(curve)
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("ui_start"):
		var chara = CharacterNode.instance()
		chara.set_pos(Vector2(200, 0))
		add_child(chara)