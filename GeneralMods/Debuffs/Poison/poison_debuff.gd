extends BaseDebuff
class_name PoisonDebuff

@onready var duration_timer = $DurationTimer

var poison_dps = 5.0
var poison_duration = 5.0

func _ready():
	super()
	parent.on_physics_process.connect(_deal_damage_over_time)
	
func _deal_damage_over_time(delta):
	parent.lose_life(weapon, poison_dps * delta)

func _on_duration_timer_timeout():
	queue_free()

func set_duration(new_duration):
	duration_timer.wait_time = new_duration

func set_dps(new_poison_dps):
	poison_dps = new_poison_dps
