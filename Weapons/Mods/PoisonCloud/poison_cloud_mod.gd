extends BaseMod
class_name PoisonCloudMod

var poison_dps : float = 10
var poison_dps_coefficient = .8
var poison_duration : float = 5.0
var proc_chance = .5
var poison_cloud_effect_scene = preload("res://GeneralMods/Effects/PoisonCloud/poison_cloud_effect.tscn")

func set_base_data():
	mod_name = "Poison Cloud on Death"
	icon = preload("res://Art/Drops/poison_cloud_mod.png")

func equip(new_weapon):
	super(new_weapon)
	weapon.on_kill.connect(_on_kill)
	refresh()

func get_tooltip_description():
	if is_equipped:
		tooltip_description =  "[center][b]" + mod_name + "[/b][/center]\n" \
			+ "[center]Kills with this weapon have a %.1f%% chance to cause enemy to explode into a poison cloud\ndealing %.1f damage every second for %.1f seconds[/center]" % [proc_chance*100, poison_dps, poison_duration]
	else:
		tooltip_description =  "[center][b]" + mod_name + "[/b][/center]\n" \
			+ "[center]Kills with this weapon have a %.1f%% chance to cause enemy to explode into a poison cloud\ndealing %.1f%% of weapon damage every second for %.1f seconds[/center]" % [proc_chance*100, poison_dps_coefficient*100, poison_duration]
	return tooltip_description

func _on_kill(body):
	if (randi() < proc_chance):
		var poison_cloud_effect = poison_cloud_effect_scene.instantiate()
		poison_cloud_effect.weapon = weapon
		poison_cloud_effect.poison_dps = poison_dps
		poison_cloud_effect.poison_duration = poison_duration
		body.add_sibling(poison_cloud_effect)
		poison_cloud_effect.global_position = body.global_position

func damage_multiplier(mult_value):
	poison_dps *= mult_value

func refresh():
	if weapon != null:
		poison_dps = weapon.current_damage * poison_dps_coefficient

func damage_add(add_value):
	poison_dps += add_value

func remove_mod():
	super()
	weapon.on_kill.disconnect(_on_kill)

