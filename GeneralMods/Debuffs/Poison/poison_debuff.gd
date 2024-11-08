extends BaseDebuff
class_name PoisonDebuff

@onready var duration_timer = $DurationTimer

var poison_dps = 5.0
var poison_duration = 5.0

func _init():
	debuff_icon = preload("res://Art/Drops/poison_mod.png")

func _ready():
	super()
	parent.on_physics_process.connect(_deal_damage_over_time)
	
func _deal_damage_over_time(delta):
	var weapon_info = {"weapon": weapon, "damage": poison_dps*delta}
	parent.lose_life(weapon_info)

func set_duration(new_duration):
	duration_timer.wait_time = new_duration

func set_dps(new_poison_dps):
	poison_dps = new_poison_dps
