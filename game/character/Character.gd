extends RigidBody2D

onready var snow = get_node("SnowEmitter")

func _ready():
	var snow_emitter_cld = get_node("SnowEmitterCollider")
	snow_emitter_cld.connect("body_enter", self, "on_ski_enter")
	snow_emitter_cld.connect("body_exit", self, "on_ski_exit")
#	set_process(true)

#func _process(delta):
#	snow.set_emitting(get_colliding_bodies().size() > 0 && get_linear_velocity().length() > 1)
	
func on_ski_enter(body):
	if body != self:
		snow.set_emitting(true)
	
func on_ski_exit(_):
	snow.set_emitting(false)