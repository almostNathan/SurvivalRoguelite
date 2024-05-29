extends BaseMod
class_name DamageMod

var damage_value : float = 10



func _init():
	tooltip_text = "Damage"
	icon = preload("res://Art/Drops/damage_mod.png")

func equip(new_weapon):
	super(new_weapon)
	weapon.on_hit.connect(_on_hit)
	refresh()

func _on_hit(body, _bullet):
	body.add_to_mod_queue(self)

func apply_effect(body):
	mod_hitting.emit(self)
	var weapon_stats = _get_weapon_stats()
	_apply_damage_numbers(body)
	body.hit(weapon_stats)

func remove_mod():
	super()
	weapon.on_hit.disconnect(_on_hit)

func damage_multiplier(mult_value):
	damage_value *= mult_value

func refresh():
	if weapon != null:
		damage_value = weapon.current_damage * current_rank

func damage_add(add_value):
	damage_value += add_value

func _get_weapon_stats():
	var weapon_stats = {
		'weapon' : weapon,
		'damage' : snapped(damage_value, 1)
	}
	
	return weapon_stats

func _apply_damage_numbers(body):
	var new_damage_numbers = damage_numbers_scene.instantiate()
	body.add_sibling(new_damage_numbers)
	var style_settings = {
		'color' : Color(1,1,1,1)
	}
	new_damage_numbers.set_style(style_settings)
	new_damage_numbers.set_values_and_animate(snapped(damage_value, 1), body.position, 100, 100)
