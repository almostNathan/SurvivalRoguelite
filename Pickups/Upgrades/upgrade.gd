extends "res://Pickups/pickup.gd"

var upgrade_loot : Upgrade

func _ready():
	upgrade_loot = Upgrade.new()
	set_upgrade_stats()

	
func take_upgrade():
	if is_lootable == true:
		is_lootable = false
		return upgrade_loot
		

func set_upgrade_stats():
	upgrade_loot.damage_mult = 1
	upgrade_loot.speed
	upgrade_loot.bounce
	upgrade_loot.projectile
	upgrade_loot.size
