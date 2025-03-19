extends BaseBullet
class_name OrbBullet


func _physics_process(delta):
	var rotation_speed = current_speed/100
	rotate(rotation_speed * delta)
	position = player.position

func _on_body_entered(body):
	if body.has_method("hit") && body.is_in_group("enemy"):
		enemies_hit += 1
		weapon.emit_signal("on_hit", body, self)
