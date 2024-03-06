extends BaseBullet
class_name StickBullet

@onready var timer = $Timer
var rotation_speed = 6

func _physics_process(delta):
	rotate(rotation_speed * delta)
	position = player.position


func _on_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if body.has_method("hit") && body.is_in_group("enemy"):
		enemies_hit += 1
		weapon.emit_signal("on_hit", body, self)

