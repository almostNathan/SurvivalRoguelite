extends BaseMod
class_name IncreasedDamageMod

var base_damage_multiplier = .2
var current_damage_multiplier = .2




func _init():
	tooltip_text = "Increased Damage"
	icon = preload("res://Art/Drops/increased_damage.png")

func equip(new_weapon):
	super(new_weapon)
	weapon.modify_damage_mult(current_damage_multiplier)
	refresh()


func remove_mod():
	super()
	weapon.modify_damage_mult(-current_damage_multiplier)
	

func refresh():
	super()
	if weapon != null && need_refresh:
		need_refresh = false
		weapon.modify_damage_mult(-current_damage_multiplier)
		current_damage_multiplier = base_damage_multiplier * current_rank
		weapon.modify_damage_mult(current_damage_multiplier)
	else:
		current_damage_multiplier = base_damage_multiplier * current_rank
	
	



