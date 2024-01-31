extends MagnetPickup
class_name Experience

var exp_value = 10


func _on_body_entered(body):
	if body.has_method("take_experience"):
		body.take_experience(exp_value)
		queue_free()
