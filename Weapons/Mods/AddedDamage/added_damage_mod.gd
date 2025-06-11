extends BaseMod
class_name AddedDamageMod

var base_damage_add = 1
var current_damage_add = 1

func set_base_data():
	tooltip_text = "Added Damage"
	mod_name = "Added Damage"
	icon = preload("res://Art/Drops/added_damage_mod.png")


func equip(new_weapon):
	super(new_weapon)
	weapon.modify_damage_add(current_damage_add)
	refresh()


func remove_mod():
	super()
	weapon.modify_damage_add(-current_damage_add)
	

func refresh():
	super()
	if weapon != null && need_refresh:
		need_refresh = false
		weapon.modify_damage_add(-current_damage_add)
		current_damage_add = base_damage_add * current_rank
		weapon.modify_damage_add(current_damage_add)
	else:
		current_damage_add = base_damage_add * current_rank
	
	



