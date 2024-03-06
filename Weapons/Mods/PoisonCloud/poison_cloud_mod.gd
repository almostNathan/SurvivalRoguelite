extends BulletMod
class_name PoisonCloudMod

var poison_dps : float = 10
var poison_dps_coefficient = .8
var poison_duration : float = 5
var proc_chance = 50
var poison_cloud_effect_scene = preload("res://GeneralMods/Effects/PoisonCloud/poison_cloud_effect.tscn")

func _init():
	tooltip_text = "Poison Cloud on Death"
	icon = preload("res://Art/Drops/poison_cloud_mod.png")

func _ready():
	super()
	parent.on_kill.connect(_on_kill)
	refresh()

func _on_kill(body):
	if (randi() % 100 < proc_chance):
		var poison_cloud_effect = poison_cloud_effect_scene.instantiate()
		poison_cloud_effect.weapon = parent
		poison_cloud_effect.poison_dps = poison_dps
		poison_cloud_effect.poison_duration = poison_duration
		body.add_sibling(poison_cloud_effect)
		poison_cloud_effect.global_position = body.global_position

func rank_up():
	current_rank += 1
	poison_dps = (current_rank * poison_dps) + current_rank

func damage_multiplier(mult_value):
	poison_dps *= mult_value

func refresh():
	poison_dps = parent.current_damage * poison_dps_coefficient

func damage_add(add_value):
	poison_dps += add_value
