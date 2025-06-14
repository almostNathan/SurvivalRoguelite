extends BasePlayerMod
class_name AreaPlayerMod

var modified_weapons : Array = []
var area_modifier = .5

func set_base_data():
	mod_name = "Increased Area of Effect"
	tooltip_text = "Increase AoE Player Mod"
	icon = preload("res://Art/Drops/area_player_mod.png")

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
	weapon.modify_area_mult(area_modifier)
	
func remove_effect_from_weapon(weapon):
	weapon.modify_area_mult(-area_modifier)

func remove_mod():
	for weapon in modified_weapons:
		remove_effect_from_weapon(weapon)
