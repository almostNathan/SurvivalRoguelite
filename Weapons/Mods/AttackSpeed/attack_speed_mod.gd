extends BaseMod
class_name AttackSpeedMod

var attack_speed_mult = .15
var base_attack_mult = .15

func set_base_data():
	mod_name = "Attack Speed"
	icon = preload("res://Art/Drops/attack_speed_mod.png")

func equip(new_weapon : BaseWeapon):
	super(new_weapon)
	weapon.modify_attack_speed_mult(attack_speed_mult)

func get_tooltip_description():
	var percent_formatted = "%.1f" % (attack_speed_mult*100)
	tooltip_description = "[center][b]+" + mod_name + "[/b][/center]\n[center]Increase weapon attack speed by " + percent_formatted + "%[/center]\n"
	return tooltip_description

func refresh():
	if weapon != null:
		weapon.modify_attack_speed_mult(attack_speed_mult * -1)
		attack_speed_mult = base_attack_mult * current_rank
		weapon.modify_attack_speed_mult(attack_speed_mult)
	else:
		attack_speed_mult = base_attack_mult * current_rank

func remove_mod():
	super()
	weapon.modify_attack_speed_mult(attack_speed_mult * -1)
