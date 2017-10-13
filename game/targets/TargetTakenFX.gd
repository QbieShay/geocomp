extends Particles2D

func _ready():
	set_emitting(true)
	var timer = Timer.new()
	timer.connect('timeout', self, 'queue_free')
	timer.set_wait_time(get_emit_timeout())
	timer.start()
	timer.set_one_shot(true)
	add_child(timer)