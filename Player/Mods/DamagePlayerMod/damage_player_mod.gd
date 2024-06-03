extends BasePlayerMod
class_name DamagePlayerMod

var modified_weapons : Array = []
var damage_modifier = .5

func _init():
	tooltip_text = "player_damage_mod"
	icon = preload("res://Art/Drops/crit_mod.png")


func equip(player : Player):
	for weapon in player.weapon_inventory:
		modified_weapons.append(weapon)
		weapon.modify_damage_mult(damage_modifier)


func remove_mod():
	for weapon in modified_weapons:
		weapon.modify_damage_mult(-damage_modifier)
