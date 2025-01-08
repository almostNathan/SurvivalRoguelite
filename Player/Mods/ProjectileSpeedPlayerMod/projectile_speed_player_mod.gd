extends BasePlayerMod
class_name ProjectileSpeedPlayerMod

var modified_weapons : Array = []
var projectile_speed_modifier = .5

func _init():
	tooltip_text = "Projectile Speed Player Mod"
	icon = preload("res://Art/Drops/projectile_speed_player_mod.png")

func refresh():
	for weapon in modified_weapons:
		remove_effect_from_weapon(weapon)
	modified_weapons = []
	for weapon : BaseWeapon in player.weapon_inventory:
		modified_weapons.append(weapon)
		apply_effect_to_weapon(weapon)


func equip(player : Player):
	super(player)
	for weapon : BaseWeapon in player.weapon_inventory:
		modified_weapons.append(weapon)
		apply_effect_to_weapon(weapon)

func apply_effect_to_weapon(weapon):
	weapon.modify_projectile_speed_mult(projectile_speed_modifier)
	
func remove_effect_from_weapon(weapon):
	weapon.modify_projectile_speed_mult(-projectile_speed_modifier)

func remove_mod():
	for weapon in modified_weapons:
		remove_effect_from_weapon(weapon)
