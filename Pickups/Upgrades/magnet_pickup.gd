extends Pickup
class_name MagnetPickup

var magnet_speed = 3500

func _ready():
	pass

func magnet_to_player(body : CharacterBody2D):
	var direction_to_player = (body.position - position).normalized()
	var distance_to_player = position.distance_to(body.position)
	position += direction_to_player * magnet_speed * get_physics_process_delta_time() / distance_to_player
