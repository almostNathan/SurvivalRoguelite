extends BaseMod
class_name TimeBombMod

var time_bomb_effect = preload("res://GeneralMods/Effects/TimeBomb/time_bomb_effect.tscn")
var damage_value : float

func _init():
	tooltip_text = "Time Bomb"
	icon = preload("res://Art/Drops/time_bomb_mod.png")

func equip(new_weapon):
	super(new_weapon)
	weapon.on_hit.connect(_on_hit)
	refresh()

func _on_hit(body, _bullet):
	body.add_to_mod_queue(self)

func apply_effect(body):
	var time_bomb_effect_instance = time_bomb_effect.instantiate()
	body.add_mod(time_bomb_effect_instance)
	time_bomb_effect_instance.weapon = weapon
	time_bomb_effect_instance.damage = damage_value
	
func refresh():
	if weapon != null:
		damage_value = weapon.base_damage * 2 * current_rank

func remove_mod():
	super()
	weapon.on_hit.disconnect(_on_hit)

