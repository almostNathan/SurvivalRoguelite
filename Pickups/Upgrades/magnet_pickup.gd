extends Pickup
class_name MagnetPickup



func _ready():
	pass

func magnet_to_player(body : CharacterBody2D):
	var direction_to_player = (body.position - position).normalized()
	var distance_factor = position.distance_to(body.position) / 100 + .5
	var move_speed = body.speed + 100
	var magnet_speed = clamp((move_speed/distance_factor), 50 , move_speed)
	position += direction_to_player * magnet_speed * get_physics_process_delta_time()
	#position += direction_to_player * magnet_speed * get_physics_process_delta_time() / distance_to_player
