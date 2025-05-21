extends Pickup
class_name MagnetPickup

var collected = false
var target_body : CharacterBody2D
var move_speed = 175.0


func _physics_process(delta):
	if collected:
		var direction_to_player = (target_body.position - position).normalized()	
		var distance_factor = position.distance_to(target_body.position) / 100 + .5
		position += direction_to_player * move_speed * delta
		move_speed += 100 * delta



func magnet_to_player(body : CharacterBody2D, delta):
	collected = true
	target_body = body
	

