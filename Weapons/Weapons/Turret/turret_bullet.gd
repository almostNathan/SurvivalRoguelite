extends BaseBullet
class_name TurretBullet

func _on_on_screen_enabler_screen_exited():
	pass



func _on_lifespan_timer_timeout():
	queue_free()
