extends BaseMod
class_name TimeBombMod

var time_bomb_effect = preload("res://GeneralMods/Effects/TimeBomb/time_bomb_effect.tscn")
var damage_value : float
var damage_coefficient = 2
var damage_delay = 2

func set_base_data():
	mod_name = "Time Bomb"
	icon = preload("res://Art/Drops/time_bomb_mod.png")

func equip(new_weapon):
	super(new_weapon)
	weapon.on_hit.connect(_on_hit)
	weapon.on_proc_hit.connect(_on_proc_hit)
	refresh()

func get_tooltip_description():
	if is_equipped:
		tooltip_description =  "[center][b]" + mod_name + "[/b][/center]\n" \
			+  "[center]Weapon hits explode dealing %.1f damage after %.1f seconds[/center]" % [damage_value, damage_delay]
	else:
		tooltip_description =  "[center][b]" + mod_name + "[/b][/center]\n" \
			+  "[center]Weapon hits explode dealing %.1f%% of weapon damage after %.1f seconds[/center]" % [damage_coefficient*100, damage_delay]
	return tooltip_description

func _on_hit(body, _bullet):
	if weapon != null:
		body.add_to_mod_queue(self)

func _on_proc_hit(body, _bullet, proc_multiplier):
	if randf() < proc_multiplier:
		body.add_to_mod_queue(self)

func apply_effect(body):
	var time_bomb_effect_instance = time_bomb_effect.instantiate()
	time_bomb_effect_instance.set_delay(damage_delay)
	body.add_mod(time_bomb_effect_instance)
	time_bomb_effect_instance.weapon = weapon
	time_bomb_effect_instance.damage_value = damage_value
	
func refresh():
	if weapon != null:
		damage_value = weapon.current_damage * 2 * current_rank

func remove_mod():
	super()
	weapon.on_hit.disconnect(_on_hit)

