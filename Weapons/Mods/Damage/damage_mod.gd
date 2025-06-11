extends BaseMod
class_name DamageMod

var damage_value : float = 10



func set_base_data():
	tooltip_text = "Damage"
	mod_name = "Damage"
	icon = preload("res://Art/Drops/damage_mod.png")

func equip(new_weapon):
	super(new_weapon)
	weapon.on_hit.connect(_on_hit)
	refresh()

func _on_hit(body, _bullet):
	if weapon != null:
		body.add_to_mod_queue(self)

func apply_effect(body):
	mod_hitting.emit(self)
	var weapon_stats = _get_weapon_stats()
	_apply_damage_numbers(body, snapped(damage_value,1))
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


