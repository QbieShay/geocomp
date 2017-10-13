extends RigidBody2D

onready var snow = get_node("SnowEmitter")

func _ready():
	set_process(true)

func _process(delta):
	snow.set_emitting(get_colliding_bodies().size() > 0 && get_linear_velocity().length() > 1)