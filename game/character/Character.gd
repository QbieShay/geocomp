extends RigidBody2D

onready var snow = get_node("SnowEmitter")

func _ready():
	var snow_emitter_cld = get_node("SnowEmitterCollider")
	snow_emitter_cld.connect("body_enter", self, "on_ski_enter")
	snow_emitter_cld.connect("body_exit", self, "on_ski_exit")
	
func on_ski_enter(body):
	if body != self:
		snow.set_emitting(true)
	
func on_ski_exit(_):
	snow.set_emitting(false)