extends BasePlayerMod
class_name DamagePlayerMod

var modified_weapons : Array = []
var damage_modifier = .5

func set_base_data():
	mod_name = "Increase Damage"
	tooltip_text = "Increased Damage Player Mod"
	icon = preload("res://Art/Drops/crit_mod.png")


func equip(player : Player):
	super(player)
	for weapon in player.weapon_inventory:
		modified_weapons.append(weapon)
		apply_effect_to_weapon(weapon)

func refresh():
	for weapon in modified_weapons:
		remove_effect_from_weapon(weapon)
	modified_weapons = []
	for weapon in player.weapon_inventory:
		modified_weapons.append(weapon)
		apply_effect_to_weapon(weapon)

func apply_effect_to_weapon(weapon):
	weapon.modify_damage_mult(damage_modifier)
	
func remove_effect_from_weapon(weapon):
	weapon.modify_damage_mult(-damage_modifier)

func remove_mod():
	print("removing damage player mod")
	for weapon in modified_weapons:
		remove_effect_from_weapon(weapon)
