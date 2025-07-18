extends BaseMod
class_name ExplodeOnDeathMod

var damage_value : float = 10
var damage_coefficient = .5
var splash_effect_scene = preload("res://GeneralMods/Effects/Splash/splash_effect.tscn")

func set_base_data():
	mod_name = "Explode on Death"
	icon = preload("res://Art/Drops/explode_on_death_mod.png")

func equip(new_weapon):
	super(new_weapon)
	weapon.on_kill.connect(_on_kill)
	refresh()

func get_tooltip_description():
	if is_equipped:
		tooltip_description =  "[center][b]" + mod_name + "[/b][/center]\n" \
			+ "[center]Kills with this weapon cause enemy to explode for "+ str(damage_value) +" damage[/center]"
	else:
		var formatted_damage_coefficient = '%.1f%%' % (damage_coefficient * 100)
		tooltip_description =  "[center][b]" + mod_name + "[/b][/center]\n" \
			+ "[center]Kills with this weapon cause enemy to explode for "+ formatted_damage_coefficient +" of weapon damage[/center]"
	return tooltip_description

func _on_kill(body):
	var splash_effect = splash_effect_scene.instantiate()
	splash_effect.weapon = weapon
	splash_effect.damage_value = damage_value
	body.add_sibling(splash_effect)
	splash_effect.global_position = body.global_position

func rank_up():
	current_rank += 1
	damage_value = (current_rank * damage_value) + current_rank

func damage_multiplier(mult_value):
	damage_value *= mult_value

func refresh():
	if weapon != null:
		damage_value = weapon.current_damage * damage_coefficient * current_rank

func damage_add(add_value):
	damage_value += add_value

func remove_mod():
	super()
	weapon.on_kill.disconnect(_on_kill)
