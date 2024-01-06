extends BulletMod
class_name PierceMod

func _on_shooting_weapon(bullet):
	super(bullet)
	bullet.on_hit.connect(_on_hit)

func _on_hit(body):
	if weapon.delete_bullet == true:
		weapon.delete_bullet = false
		weapon.remove_child(self)
		queue_free()

