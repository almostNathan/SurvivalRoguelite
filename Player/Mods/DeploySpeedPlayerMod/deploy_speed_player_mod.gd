extends BasePlayerMod
class_name DeploySpeedPlayerMod

var modified_weapons : Array = []
var deploy_speed_modifier = .2

func set_base_data():
	mod_name = "Incresed Deploy Speed"
	tooltip_text = "Deploy Speed Player Mod"
	icon = preload("res://Art/Drops/deploy_speed_player_mod.png")

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
	if weapon.has_method("modify_deploy_speed_mult"):
		weapon.modify_deploy_speed_mult(deploy_speed_modifier)
	
func remove_effect_from_weapon(weapon):
	if weapon.has_method("modify_deploy_speed_mult"):
		weapon.modify_deploy_speed_mult(-deploy_speed_modifier)

func remove_mod():
	for weapon in modified_weapons:
		remove_effect_from_weapon(weapon)
