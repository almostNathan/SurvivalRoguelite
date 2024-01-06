extends BulletMod
class_name Bounce

func _on_shooting_weapon(bullet):
	super(bullet)
	bullet.on_hit.connect(_on_hit)
	

func _on_hit(body):
	if parent is BaseBullet:
		if parent.delete_bullet == true:
			parent.rotation = parent.position.angle_to_point(body.global_position)-PI
			parent.delete_bullet = false
			parent.remove_child(self)
			queue_free()


