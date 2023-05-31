extends "res://Pickups/pickup.gd"

var upgrade_loot : Upgrade

func _ready():
	upgrade_loot = Upgrade.new()
	upgrade_loot.projectile += 1
	
func take_upgrade():
	return self
