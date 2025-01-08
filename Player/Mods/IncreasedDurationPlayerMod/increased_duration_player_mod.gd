extends BasePlayerMod
class_name IncreasedDurationPlayerMod

var modified_weapons : Array = []
var duration_modifier = .5

func _init():
	tooltip_text = "Increased Duration Player Mod"
	icon = preload("res://Art/Drops/increased_duration_player_mod.png")


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
	weapon.modify_duration_mult(duration_modifier)
	
func remove_effect_from_weapon(weapon):
	weapon.modify_duration_mult(-duration_modifier)

func remove_mod():
	print("removing damage player mod")
	for weapon in modified_weapons:
		remove_effect_from_weapon(weapon)
