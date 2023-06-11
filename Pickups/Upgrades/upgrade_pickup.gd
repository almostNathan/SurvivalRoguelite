extends "res://Pickups/pickup.gd"


#Modifier variables
var upgrade : Upgrade

func _ready():
	upgrade = Upgrade.new()
	upgrade.set_base_stats()
	set_upgrade_stats()
	
func set_upgrade_stats():
	pass

func take_upgrade():
	return upgrade
