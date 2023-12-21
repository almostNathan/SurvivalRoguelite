extends "res://Pickups/pickup.gd"


#Modifier variables
var upgrade : Upgrade

func _ready():
	upgrade = Upgrade.new()
	upgrade.set_base_stats()
	set_upgrade_stats()
	
func set_upgrade_stats():
	pass

func get_upgrade():
	return upgrade

func magnet_to_player(body : CharacterBody2D):
	var direction_to_player = (body.position - position).normalized()
	var distance_to_player = position.distance_to(body.position)
	position += direction_to_player * magnet_speed * get_physics_process_delta_time() / distance_to_player
