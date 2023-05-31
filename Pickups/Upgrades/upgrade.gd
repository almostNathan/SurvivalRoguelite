extends "res://Pickups/pickup.gd"

var upgrade_loot : Upgrade

func _ready():
	upgrade_loot = Upgrade.new()
	upgrade_loot.size = 3
	
func take_upgrade():
	if is_lootable == true:
		is_lootable = false
		return upgrade_loot
		
