extends AnimatedSprite2D




func _physics_process(_delta):
	if frame_progress == 1:
		queue_free()
