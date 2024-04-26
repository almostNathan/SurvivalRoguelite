extends BaseMod
class_name AttackSpeedMod

var attack_speed_mult = .15
var base_attack_mult = .15

func _init():
	tooltip_text = "Attack Speed"
	icon = preload("res://Art/Drops/attack_speed_mod.png")

func equip(new_weapon):
	super(new_weapon)
	weapon.modify_attack_speed_mult(attack_speed_mult)

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

