extends BaseBullet
class_name LaserBullet




func _physics_process(_delta):
	position = player.position

func _on_body_entered(body):
	if body.has_method("hit") && body.is_in_group("enemy"):
		weapon.emit_signal("on_hit", body, self)


