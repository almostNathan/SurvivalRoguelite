extends BaseMod
class_name AddedDamageMod

var base_damage_add = 1
var current_damage_add = 1

func set_base_data():
	mod_name = "Added Damage"
	icon = preload("res://Art/Drops/added_damage_mod.png")


func equip(new_weapon):
	super(new_weapon)
	weapon.modify_damage_add(current_damage_add)
	refresh()

func get_tooltip_description():
	tooltip_description = "[center][b]{name}[/b][/center]\n".format({"name": self.mod_name}) \
		+ "[center]Weapon deals " + str(current_damage_add) + " additional damage[/center]\n"
		
	return tooltip_description
	
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
	
	



