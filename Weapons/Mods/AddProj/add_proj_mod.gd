extends BaseMod
class_name AddProjMod

var projectile_modifier = 1

func set_base_data():
	tooltip_text = "Split Mod"
	mod_name = "Split"
	icon = preload("res://Art/Drops/add_proj_mod.png")

func equip(new_weapon):
	super(new_weapon)
	weapon.projectile_count += projectile_modifier
	refresh()
	
func remove_mod():
	super()
	weapon.projectile_count -= projectile_modifier

func refresh():
	if weapon != null:
		weapon.projectile_count -= projectile_modifier
		projectile_modifier = current_rank
		weapon.projectile_count += projectile_modifier
	else:
		projectile_modifier = current_rank
	
