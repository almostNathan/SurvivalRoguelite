extends Area2D

var is_lootable = true
var magnet_speed = 3000

func _on_body_entered(body):
	if is_lootable and body.has_method("toggle_lootable"):
		body.toggle_lootable(self)


func _on_body_exited(body):
	if body.has_method("toggle_lootable"):
		body.untoggle_lootable(self)
	

func magnet_to_player(body : CharacterBody2D):
	var direction_to_player = (body.position - position).normalized()
	var distance_to_player = position.distance_to(body.position)
	print("distance to player {a}".format({"a":distance_to_player}))
	print("direction to player {a}".format({"a":direction_to_player}))
	position += direction_to_player * magnet_speed * get_physics_process_delta_time() / distance_to_player
	
	
	
