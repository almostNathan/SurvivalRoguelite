extends BaseDebuff
class_name PoisonDebuff

var damage_per_second = 10

func _ready():
	super()
	parent.on_physics_process.connect(_deal_damage_over_time)
	
func _deal_damage_over_time(delta):
	parent.take_damage(damage_per_second * delta)

func _on_duration_timer_timeout():
	queue_free()

