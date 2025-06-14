extends BasePlayerMod
class_name AttackSpeedPlayerMod

var modified_weapons : Array = []
var attack_speed_modifier = .1

func set_base_data():
	mod_name = "Increased Attack Speed"
	tooltip_text = "Attack Speed Player Mod"
	icon = preload("res://Art/Drops/attackspeed_player_mod.png")

func refresh():
	for weapon in modified_weapons:
		remove_effect_from_weapon(weapon)
	modified_weapons = []
	for weapon : BaseWeapon in player.weapon_inventory:
		modified_weapons.append(weapon)
		apply_effect_to_weapon(weapon)


func equip(new_player : Player):
	super(new_player)
	for weapon : BaseWeapon in player.weapon_inventory:
		modified_weapons.append(weapon)
		apply_effect_to_weapon(weapon)

func apply_effect_to_weapon(weapon):
	weapon.modify_attack_speed_mult(attack_speed_modifier)
	
func remove_effect_from_weapon(weapon):
	weapon.modify_attack_speed_mult(-attack_speed_modifier)

func remove_mod():
	for weapon in modified_weapons:
		remove_effect_from_weapon(weapon)
