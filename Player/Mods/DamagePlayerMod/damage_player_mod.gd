extends BasePlayerMod
class_name DamagePlayerMod

var modified_weapons : Array = []

func _init():
	tooltip_text = "player_damage_mod"
	icon = preload("res://Art/Drops/crit_mod.png")


func equip(player : Player):
	for weapon in player.weapon_inventory:
		modified_weapons.append(weapon)
		weapon.current_damage = weapon.current_damage * 2


func remove_mod():
	for weapon in modified_weapons:
		weapon.current_damage = weapon.base_damage
