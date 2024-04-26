extends BasePlayerMod
class_name DamagePlayerMod

var modified_weapons : Array = []

func equip(player : Player):
	for weapon in player.weapon_inventory:
		modified_weapons.append(weapon)
		weapon.base_damage *= 2
