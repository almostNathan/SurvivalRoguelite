extends BaseBullet
class_name ScytheBullet

@onready var timer = $Timer
var rotation_speed = 5

func _physics_process(delta):
	rotate(rotation_speed * delta)
	position = player.position

func _on_timer_timeout():
	queue_free()
