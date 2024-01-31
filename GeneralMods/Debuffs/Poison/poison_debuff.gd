extends BaseDebuff
class_name PoisonDebuff

@onready var duration_timer = $DurationTimer

var damage_per_second = 5
var duration = 5

func _ready():
	super()
	parent.on_physics_process.connect(_deal_damage_over_time)
	
func _deal_damage_over_time(delta):
	parent.lose_life(damage_per_second * delta)

func _on_duration_timer_timeout():
	queue_free()

func set_duration(new_duration):
	duration_timer.wait_time = new_duration

func set_dps(new_dps):
	damage_per_second = new_dps
