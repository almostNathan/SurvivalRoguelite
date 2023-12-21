extends Area2D

var magnet_speed = 3000

func _on_body_entered(body):
	if body.has_method("apply_upgrade"):
		body.take_upgrade(self)
		queue_free()
