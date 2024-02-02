extends BaseDebuff
class_name BurnDebuff

@onready var duration_timer = $DurationTimer

var burn_dps = 5
var duration = 5

func _ready():
	super()
	parent.on_physics_process.connect(_deal_damage_over_time)
	
func _deal_damage_over_time(delta):
	parent.lose_life(weapon, burn_dps * delta)

func _on_duration_timer_timeout():
	queue_free()

func set_duration(new_duration):
	duration_timer.wait_time = new_duration

func set_dps(new_dps):
	burn_dps = new_dps
