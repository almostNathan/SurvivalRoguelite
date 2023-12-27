extends MagnetPickup
class_name Experience

var experience = 10


func _on_body_entered(body):
	if body.has_method("take_experience"):
		body.take_experience(experience)
		queue_free()
